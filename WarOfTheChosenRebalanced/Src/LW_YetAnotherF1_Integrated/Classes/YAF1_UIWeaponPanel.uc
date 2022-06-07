// shows a weapon with stats, either in compact form or with preview image
// it is recommended to only use the preview image for primary weapons,
// since all others tend to not have images available for tactical

class YAF1_UIWeaponPanel extends UIPanel config(UI);

var UIPanel ImageParent;
var array<UIImage> ImageStack; // image stack
var UIText WeaponTextSmall;
var UIPanel TextBG;
var UIBGBox WeaponFrame;

var UIPanel TitlePanel;
var UIPanel DividerLine;
var UIText WeaponTextBig;

var YAF1_UIStatPanel WeaponStats;

var array<UIText> Texts;

var int iIconSize;

var int iImageHeight;

var bool bCensored;


var config string strDamageImage;
var config string strCritImage;
var config string strShredImage;
var config string strPierceImage;
var config string strRuptureImage;
var config string strClipSizeImage;

var config string strRangeImage;
var config string strRadiusImage;


struct WeaponCatLocBind
{
	var name WeaponCat;
	var name TemplateName;
};

var config array<WeaponCatLocBind> WeaponCatFallbacks;
var config array<name> ClaymoreAbilities;


var localized string m_strInfinitySymbol;

delegate OnSizeRealized(YAF1_UIWeaponPanel ChangedPanel);

// initialize this always with the height you want it to have if it used the big view. Width is always 2xinitHeight, even for small panels that are way less high
simulated function YAF1_UIWeaponPanel InitWeaponPanel(delegate<OnSizeRealized> SizeRealizedDelegate, optional int initHeight = 128)
{
	local array<string> str;
	InitPanel();

	SetWidth(initHeight * 2);
	
	iImageHeight = initHeight;

	ImageParent = Spawn(class'UIPanel', self).InitPanel().SetSize(iImageHeight * 2, iImageHeight);
	// hack: pre-spawn images now so that the text + bg overlaps them
	str.Length = 9;
	SetImages(str);

	WeaponFrame = Spawn(class'UIBGBox', ImageParent).InitBG('', 0, 0, ImageParent.Width, ImageParent.Height);
	WeaponFrame.SetOutline(true);
	TextBG = Spawn(class'UIPanel', ImageParent).InitPanel('', class'UIUtilities_Controls'.const.MC_X2BackgroundSimple);
	TextBG.SetPosition(0, ImageParent.Height - 25).SetSize(100, 25);
	WeaponTextSmall = Spawn(class'UIText', ImageParent).InitText();
	WeaponTextSmall.SetPosition(4, ImageParent.Height - 27);

	TitlePanel = Spawn(class'UIPanel', self).InitPanel();
	TitlePanel.SetSize(Width, 25);
	WeaponTextBig = Spawn(class'UIText', TitlePanel).InitText();
	WeaponTextBig.SetPosition(5, 0);
	DividerLine = class'UIUtilities_Controls'.static.CreateDividerLineBeneathControl(WeaponTextBig, TitlePanel);

	WeaponStats = Spawn(class'YAF1_UIStatPanel', self).InitStatPanel(iIconSize, , Width);
	WeaponStats.SetY(Height + 15);
	WeaponStats.SizeChanged = RealizeLayout;
	
	OnSizeRealized = SizeRealizedDelegate;

	return self;	
}


simulated function PopulateData(XComGameState_Item ItemState, bool bAllowLargeView, bool inCensored)
{
	local X2ItemTemplate Template;
	local int i;
	local string FriendlyName, FallbackName;

	if (ItemState == none)
	{
		Hide();
		return;
	}

	bCensored = inCensored;
	
	Show();
	// some weapons don't allow the large view because they don't have an image
	SetView(bAllowLargeView && ItemState.ShouldDisplayWeaponAndAmmo());

	Template = ItemState.GetMyTemplate();

	if (X2ArmorTemplate(Template) != none)
		PopulateArmorInfo(ItemState, X2ArmorTemplate(Template), FallbackName);
	else if (X2GrenadeLauncherTemplate(Template) != none)
		PopulateGrenadeLauncherInfo(ItemState, X2GrenadeLauncherTemplate(Template), FallbackName);
	else if (X2GremlinTemplate(Template) != none)
		PopulateGremlinInfo(ItemState, X2GremlinTemplate(Template), FallbackName);
	else if (X2WeaponTemplate(Template) != none)
		PopulateWeaponInfo(ItemState, X2WeaponTemplate(Template), FallbackName);
	else if (X2AmmoTemplate(Template) != none)
		PopulateUIMarkups(ItemState, X2EquipmentTemplate(Template), FallbackName);


	
	FriendlyName = Template.GetItemFriendlyName(ItemState.ObjectID);
	// HAX: this is an error message. See X2ItemTemplate.GetItemFriendlyName
	if (InStr(FriendlyName, "Error!") != INDEX_NONE)
	{
		FriendlyName = FallbackName;
	}
	if (FriendlyName == "")
	{
		if (X2WeaponTemplate(Template) != none)
		{
			i = WeaponCatFallbacks.Find('WeaponCat', X2WeaponTemplate(Template).WeaponCat);
			if (i != INDEX_NONE)
			{
				FriendlyName = X2EquipmentTemplate(class'X2ItemTemplateManager'.static.GetItemTemplateManager().FindItemTemplate(WeaponCatFallbacks[i].TemplateName)).GetItemFriendlyName(ItemState.ObjectID);
			}
		}
	}
	if (FriendlyName == "")
	{
		// this is some non-standard equipment that doesn't have localization. it is probably not intended to use or show
		Hide();
		return;
	}

	WeaponTextSmall.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.RandomCensoredTitle()) : (FriendlyName), , 20), SmallTextSizeRealized);
	WeaponTextBig.SetHtmlText(class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.RandomCensoredTitle()) : (FriendlyName), eUIState_Header, 25));
}

simulated function PopulateWeaponUpgradeData(X2WeaponUpgradeTemplate Template, bool inCensored)
{
	// TODO
}

// GetUISummary_ItemBasicStats

simulated function PopulateWeaponInfo(XComGameState_Item ItemState, X2WeaponTemplate Template, out string fallbackTitle)
{
	local int i;
	local StateObjectReference EmptyRef, AbilityRef;
	local XComGameStateHistory History;
	local XComGameState_Unit OwnerUnit;
	local XComGameState_Ability SourceAbilityState;
	local X2Effect_Shredder DummyShredder;

	local WeaponDamageValue MinDamagePreview, MaxDamagePreview;
	local int dummy_AllowsShield;

	local WeaponDamageValue BaseDamageValue, Bonus;
	local int MinValue, MaxValue;
	local StringPair Pair;
	local array<StringPair> Data;
	
	History = `XCOMHISTORY;	
	OwnerUnit = XComGameState_Unit(History.GetGameStateForObjectID(ItemState.OwnerStateObject.ObjectID));

	if (Template.WeaponCat == 'claymore')
	{
		// Grab the throw claymore ability
		for (i = 0; i < ClaymoreAbilities.Length; i++)
		{
			AbilityRef = OwnerUnit.FindAbility(ClaymoreAbilities[i]);
			if (AbilityRef.ObjectID > 0)
			{
				SourceAbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityRef.ObjectID));
				SourceAbilityState.GetDamagePreview(EmptyRef, MinDamagePreview, MaxDamagePreview, dummy_AllowsShield);
				break;
			}
		}
		MinValue = MinDamagePreview.Damage;
		MaxValue = MaxDamagePreview.Damage;

		Pair.A = bCensored ? class'YAF1_UIUnitInfo'.default.LockedStatIcon : strDamageImage;
		Pair.B = class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.CensoredStat()) : ((MinValue != MaxValue) ? (MinValue $ "-" $ MaxValue) : string(MinValue)), eUIState_Header, 20);
		Data.AddItem(Pair);

		MinValue = MinDamagePreview.Shred;
		Pair.A = bCensored ? class'YAF1_UIUnitInfo'.default.LockedStatIcon : strShredImage;
		Pair.B = class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.CensoredStat()) : (string(MinValue)), eUIState_Header, 20);
		Data.AddItem(Pair);
	}
	else
	{
		ItemState.GetBaseWeaponDamageValue(none, BaseDamageValue);

		MinValue = BaseDamageValue.Damage - BaseDamageValue.Spread;
		MaxValue = BaseDamageValue.Damage + BaseDamageValue.Spread;
		if (BaseDamageValue.PlusOne > 0)
		{
			MaxValue++;
		}
		Pair.A = bCensored ? class'YAF1_UIUnitInfo'.default.LockedStatIcon : strDamageImage;
		Pair.B = class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.CensoredStat()) : ((MinValue != MaxValue) ? (MinValue $ "-" $ MaxValue) : string(MinValue)), eUIState_Header, 20);
		Data.AddItem(Pair);
	
		MinValue = BaseDamageValue.Crit;
		Pair.A = bCensored ? class'YAF1_UIUnitInfo'.default.LockedStatIcon :  strCritImage;
		Pair.B = class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.CensoredStat()) : (string(MinValue)), eUIState_Header, 20);
		Data.AddItem(Pair);

		
		Pair.A = strClipSizeImage;
		if (ItemState.HasInfiniteAmmo() || ItemState.GetClipSize() < 1)
		{
			Pair.B = class'UIUtilities_Text'.static.GetColoredText("N/A", eUIState_Header, 20);
		}
		else
		{
			Pair.B = class'UIUtilities_Text'.static.GetColoredText(ItemState.Ammo $ "/" $ ItemState.GetClipSize(), eUIState_Header, 20);
		}
		Data.AddItem(Pair);
		
		MinValue = BaseDamageValue.Shred;
		// shredder usually applies only to primary weapon attacks, although it's strictly ability-based
		if (ItemState.InventorySlot == eInvSlot_PrimaryWeapon)
		{
			// grab a random ability so that we can pass it to X2Effect_Shredder
			for (i = 0; i < OwnerUnit.Abilities.Length; i++)
			{
				SourceAbilityState = XComGameState_Ability(History.GetGameStateForObjectID(OwnerUnit.Abilities[i].ObjectID));
				if (SourceAbilityState.SourceWeapon == ItemState.GetReference())
				{
					DummyShredder = new class'X2Effect_Shredder';
					Bonus = DummyShredder.GetBonusEffectDamageValue(SourceAbilityState, OwnerUnit, ItemState, EmptyRef);
					break;
				}
			}
			if (MinValue > 0 || Bonus.Shred > 0)
			{
				Pair.A = bCensored ? class'YAF1_UIUnitInfo'.default.LockedStatIcon : strShredImage;
				Pair.B = class'UIUtilities_Text'.static.GetColoredText(string(MinValue), eUIState_Header, 20);
				if (Bonus.Shred > 0)
				{
					Pair.B $= class'UIUtilities_Text'.static.GetColoredText("+" $ string(Bonus.Shred), eUIState_Good, 20);
				}
				if (bCensored)
				{
					Pair.B = class'UIUtilities_Text'.static.GetColoredText(class'YAF1_UIUnitInfo'.static.CensoredStat(), eUIState_Header, 20);
				}
				Data.AddItem(Pair);
			}
		}
	}
	
	MinValue = BaseDamageValue.Pierce;
	if (MinValue != 0)
	{
		Pair.A = bCensored ? class'YAF1_UIUnitInfo'.default.LockedStatIcon : strPierceImage;
		Pair.B = class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.CensoredStat()) : (string(MinValue)), eUIState_Header, 20);
		Data.AddItem(Pair);
	}
	
	MinValue = BaseDamageValue.Rupture;
	if (MinValue > 0)
	{
		Pair.A = bCensored ? class'YAF1_UIUnitInfo'.default.LockedStatIcon : strRuptureImage;
		Pair.B = class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.CensoredStat()) : (string(MinValue)), eUIState_Header, 20);
		Data.AddItem(Pair);
	}

	if (Template.WeaponCat == 'psiamp')
	{
		AddModifier(Template.GetUIStatMarkup(eStat_PsiOffense, ItemState), GetImagePathForStat(eStat_PsiOffense), Data);
	}

	WeaponStats.SetData(Data);

	SetImages(ItemState.GetWeaponPanelImages());
}

simulated function PopulateGremlinInfo(XComGameState_Item ItemState, X2GremlinTemplate Template, out string fallbackTitle)
{
	local array<StringPair> Data;
	
	AddModifier(Template.HackingAttemptBonus, GetImagePathForStat(eStat_Hacking), Data);
	AddModifier(Template.HealingBonus, GetImagePathForStat(eStat_HP), Data);
	AddModifier(Template.AidProtocolBonus, GetImagePathForStat(eStat_Defense), Data);

	WeaponStats.SetData(Data);
}

simulated function PopulateGrenadeLauncherInfo(XComGameState_Item ItemState, X2GrenadeLauncherTemplate Template, out string fallbackTitle)
{
	local array<StringPair> Data;

	AddModifier(Template.IncreaseGrenadeRange, strRangeImage, Data);
	AddModifier(Template.IncreaseGrenadeRadius, strRadiusImage, Data);

	WeaponStats.SetData(Data);
}

simulated function PopulateArmorInfo(XComGameState_Item ItemState, X2ArmorTemplate Template, out string fallbackTitle)
{
	local array<StringPair> Data;

	AddModifier(Template.GetUIStatMarkup(eStat_HP, ItemState), GetImagePathForStat(eStat_HP), Data);
	AddModifier(Template.GetUIStatMarkup(eStat_Mobility, ItemState), GetImagePathForStat(eStat_Mobility), Data);
	AddModifier(Template.GetUIStatMarkup(eStat_Dodge, ItemState), GetImagePathForStat(eStat_Dodge), Data);
	AddModifier(Template.GetUIStatMarkup(eStat_ArmorMitigation, ItemState), GetImagePathForStat(eStat_ArmorMitigation), Data);

	WeaponStats.SetData(Data);
	
	fallbackTitle = class'XLocalizedData'.default.ArmorLabel;
}

simulated function AddModifier(int value, string imgPath, out array<StringPair> Data)
{
	local StringPair Pair;
	local string sign;
	local EUIState UIState;

	if (value == 0 || bCensored)
	{
		sign = "+";
		UIState = eUIState_Header;
	}
	else if (value > 0)
	{
		sign = "+";
		UIState = eUIState_Good;
	}
	else
	{
		sign = "-";
		UIState = eUIState_Bad;
	}

	Pair.A = bCensored ? class'YAF1_UIUnitInfo'.default.LockedStatIcon : imgPath;
	Pair.B = class'UIUtilities_Text'.static.GetColoredText(bCensored ? (class'YAF1_UIUnitInfo'.static.CensoredStat()) : (sign $ string(int(Abs(value)))), UIState, 20);
	Data.AddItem(Pair);
}

simulated function string GetImagePathForStat(ECharStatType stat)
{
	local int i;

	i = class'YAF1_UIUnitInfo'.default.StatIcons.Find('Stat', stat);
	if (i != INDEX_NONE)
	{
		return class'YAF1_UIUnitInfo'.default.StatIcons[i].Icon;
	}
	return "";
}

simulated function PopulateUIMarkups(XComGameState_Item ItemState, X2EquipmentTemplate Template, out string fallbackTitle)
{

}

simulated function SmallTextSizeRealized()
{
	TextBG.SetWidth(WeaponTextSmall.Width + 15);
}

// transform this panel
function SetView(bool bLargeView)
{
	ImageParent.SetVisible(bLargeView);
	TitlePanel.SetVisible(!bLargeView);
	RealizeLayout();
}

simulated function SetImages(array<string> arrImgs)
{
	local int i;
	for (i = 0; i < arrImgs.Length; i++)
	{
		if (i >= ImageStack.Length)
		{
			ImageStack.AddItem(UIImage(Spawn(class'UIImage', ImageParent).InitImage().SetSize(ImageParent.Width, ImageParent.Height)));
		}
		ImageStack[i].Show();
		ImageStack[i].LoadImage(arrImgs[i]);
	}
	for (i = arrImgs.Length; i < ImageStack.Length; i++)
	{
		ImageStack[i].Hide();
	}
	
}

simulated function RealizeLayout()
{
	local int runningY;

	runningY = 0;

	TitlePanel.SetY(runningY);
	if (TitlePanel.bIsVisible)
		runningY += TitlePanel.Height + 5;

	ImageParent.SetY(runningY);
	if (ImageParent.bIsVisible)
		runningY += ImageParent.Height + 5;

	WeaponStats.SetY(runningY);
	// always visible
		runningY += WeaponStats.Height;

	Height = runningY;
	OnSizeRealized(self);
}

simulated function float GetConnectorX()
{
	return 2;
}

simulated function float GetConnectorY()
{
	return ImageParent.Height - 13;
}

simulated function UIPanel SetColor(string clr)
{
	WeaponFrame.SetOutline(true, clr);
	WeaponStats.SetColor(clr);
	TextBG.SetColor(clr);

	return self;
}


defaultproperties
{
	iIconSize=24	
}