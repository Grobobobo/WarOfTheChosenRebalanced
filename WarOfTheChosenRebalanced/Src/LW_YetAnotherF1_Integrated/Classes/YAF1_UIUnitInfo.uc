// persistent screen to show unit stats
// this screen always exists in tactical, and is not destroyed by popping it off the screen stack
// it can be "recycled" forever
// warning: this class is layout-intensive. FXS code would have most of this in flash and only game data in code, but that's not possible for us
class YAF1_UIUnitInfo extends UIScreen;

var UIPanel Container;
var UIBGBox PanelBG;
var UIBGBox FullBG;

// class image
var UIImage SCImage;

// panel to show icons and stats
var YAF1_UIStatPanel StatPanel;

var UIX2PanelHeader TitleHeader;

// Panel that shows the "no info available" text
var UIText NoInfoText;

// we re-use the existing tooltips. this has the significant advantage that overrides work, like "Show More Buff details"
// also, less duplicate code
var UIPanel AbilityEffectContainer;
var int ContainerRestPos;
var UIMask AbilityEffectMask;
var UIScrollBar Scrollbar;

// these tooltips can only show either the currently active unit or a targeted unit -- which is exactly what we need!
var YAF1_UITooltipGroup_TopStacking_FixPosition BuffDebuffStack;
var UITacticalHUD_BuffsTooltip Buffs, Debuffs;

var UIText AbilitiesHeader;
// this shows the active AbilitySummary
var UIEffectList Abilities;

var UIText PassivesHeader;
// this shows the active ePerkBuff_Passive
var UIEffectList Passives;

var YAF1_UIWeaponPanel PrimaryWeaponPanel;
var array<YAF1_UIWeaponPanel> AdditionalPanels;

// Ammo and Upgrades list
var UIPanel WeaponTooltipContainer;
var UITacticalHUD_WeaponTooltip WeaponTooltip;
var UIPanel Connector1, Connector2, Connector3;


// these images exist to allow the user to switch between red and blue layout
// people might like the blue layout better because red is hard on the eyes, or something
// one of them is clickable and half transparent
var UIImage AdventLayoutImage;
var UIImage XComLayoutImage;

var int iStatIconSize;
var int horizontalMargin;
var int horizontalPadding;
var int weaponPanelPadding;
var int bottomMargin;

struct StatIconBind
{
	var ECharStatType Stat;
	var string Icon;
};

var config array<StatIconBind> StatIcons;

var config string LockedStatIcon;

var config array<name> DefaultHidden;
var config array<name> DefaultShown;


var config array<name> UseSecondaryAsPrimary;


var config bool bUseFallbackIcons;
var config string strFallbackIcon;
var config string strLockedIcon;

var XComGameState_BaseObject TargetState;

var localized string m_strSoldierInfo, m_strEnemyInfo;
var localized string m_strNotAUnit, m_strNoInfoAvailable;

var localized string m_strPassives;

var localized array<string> LockedTitles;
var localized array<string> LockedDescriptions;

var localized string m_strCensoredStat;

var localized string m_strAlphabet;

var bool bCensored;
var bool bFriendly;
var bool bActuallyFriendly;
//var bool bNeedsRealizeLayout;

var YAF1_InfoScreenStyleTemplate Style;

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	local int topRunningY, bottomRunningY;
	local int columnWidth;

	super.InitScreen(InitController, InitMovie, InitName);

	columnWidth = ((Width - horizontalPadding) / 2) - horizontalMargin;

	Container = Spawn(class'UIPanel', self).InitPanel('theContainer');
	Container.Width = Width;
	Container.Height = Height;
	Container.SetPosition((Movie.UI_RES_X - Container.Width) / 2, (Movie.UI_RES_Y - Container.Height) / 2);
	
	// opaque black bg for style
	FullBG = Spawn(class'UIBGBox', Container);
	FullBG.InitBG('', 0, 0, Container.Width, Container.Height);

	PanelBG = Spawn(class'UIBGBox', Container);
	PanelBG.LibID = class'UIUtilities_Controls'.const.MC_X2Background;
	PanelBG.InitBG('theBG', 0, 0, Container.Width, Container.Height);

	topRunningY = 10;

	SCImage = Spawn(class'UIImage', Container).InitImage();
	SCImage.SetSize(80, 80);
	SCImage.SetPosition(10, topRunningY);

	TitleHeader = Spawn(class'UIX2PanelHeader', Container);
	TitleHeader.InitPanelHeader('', "", "");
	TitleHeader.SetPosition(10, topRunningY);
	TitleHeader.SetHeaderWidth(Container.Width- TitleHeader.X - 10);
	topRunningY += TitleHeader.Height;

	NoInfoText = Spawn(class'UIText', Container);
	NoInfoText.InitText('', "", false, OnNoInfoTextSizeRealized);
	NoInfoText.SetWidth(Container.Width - 40);
	NoInfoText.SetX(20);

	StatPanel = Spawn(class'YAF1_UIStatPanel', Container).InitStatPanel(iStatIconSize, 8);
	StatPanel.SetPosition(horizontalMargin, topRunningY);

	topRunningY += StatPanel.Height + 20;

	bottomRunningY = Container.Height - bottomMargin;

	// spawn weapons etc here
	PrimaryWeaponPanel = Spawn(class'YAF1_UIWeaponPanel', Container).InitWeaponPanel(WeaponPanelSizeRealized);
	bottomRunningY -= PrimaryWeaponPanel.Height;
	
//	SecondaryWeaponPanel = Spawn(class'YAF1_UIWeaponPanel', Container).InitWeaponPanel(WeaponPanelSizeRealized);
//	ArmorPanel = Spawn(class'YAF1_UIWeaponPanel', Container).InitWeaponPanel(WeaponPanelSizeRealized);

	PrimaryWeaponPanel.SetPosition(horizontalMargin, bottomRunningY);
//	SecondaryWeaponPanel.SetPosition(PrimaryWeaponPanel.X + PrimaryWeaponPanel.Width + weaponPanelPadding, PrimaryWeaponPanel.Y);
//	ArmorPanel.SetPosition(SecondaryWeaponPanel.X + SecondaryWeaponPanel.Width + weaponPanelPadding, PrimaryWeaponPanel.Y);


	// we use tooltips for this
	// less duplicate code, and other mod's overrides work transparently (Show More Buff Details <3)
	
	ContainerRestPos = topRunningY;

	AbilityEffectContainer = Spawn(class'UIPanel', Container).InitPanel();
	AbilityEffectContainer.SetPosition(0, topRunningY);
	AbilityEffectContainer.Width = Container.Width;
	AbilityEffectContainer.Height = bottomRunningY - topRunningY;

	AbilityEffectMask = Spawn(class'UIMask', Container).InitMask('', AbilityEffectContainer).FitMask(AbilityEffectContainer);

	Scrollbar = Spawn(class'UIScrollbar', Container).InitScrollbar();
	Scrollbar.SnapToControl(AbilityEffectMask, -20);

	XComLayoutImage = Spawn(class'UIImage', Container).InitImage('', "img:///YAF1_Content.target_xcom");
	XComLayoutImage.SetPosition(Container.Width - 48 - 20, Container.Height - 24 - 10);
	XComLayoutImage.SetSize(24, 24);
	XComLayoutImage.OnClickedDelegate = OnToggleButtonClicked;
	AdventLayoutImage = Spawn(class'UIImage', Container).InitImage('', "img:///YAF1_Content.target_adv");
	AdventLayoutImage.SetPosition(Container.Width - 24 - 20, Container.Height - 24 - 10);
	AdventLayoutImage.SetSize(24, 24);
	AdventLayoutImage.OnClickedDelegate = OnToggleButtonClicked;

	PassivesHeader = Spawn(class'UIText', AbilityEffectContainer).InitText('Title2');
	PassivesHeader.SetPosition(10 + (Width + horizontalPadding) / 2, 2);
	PassivesHeader.SetHTMLText(class'UIUtilities_Text'.static.StyleText(m_strPassives, eUITextStyle_Tooltip_StatLabel));

	Passives = Spawn(class'UIEffectList', AbilityEffectContainer);
	Passives.bAnimateOnInit = false;
	// 40 is hardcoded padding + header height in effect tooltip
	Passives.InitEffectList('', '', 10 + (Width + horizontalPadding) / 2, 40, columnWidth - 20, 9999, 9999, 9999, RealizeLayout);

	BuffDebuffStack = new class'YAF1_UITooltipGroup_TopStacking_FixPosition';
	BuffDebuffStack.startY = 0;
	BuffDebuffStack.fixX = (Width + horizontalPadding) / 2;
	BuffDebuffStack.OnRepositioned = RealizeLayout;

	Buffs = Spawn(class'UITacticalHUD_BuffsTooltip', AbilityEffectContainer);
	Buffs.MaxHeight = 9999;
	Buffs.Width = Width - horizontalMargin - BuffDebuffStack.fixX;
	Buffs.InitBonusesAndPenalties('TooltipEnemyBonuses',,true, true, , , true);
	Buffs.ItemList.bAnimateOnInit = false;
//	Buffs.BGBox.SetColor("00FF00");
	
	Debuffs = Spawn(class'UITacticalHUD_BuffsTooltip', AbilityEffectContainer);
	Debuffs.MaxHeight = 9999;
	Debuffs.Width = Width - horizontalMargin - BuffDebuffStack.fixX;
	Debuffs.InitBonusesAndPenalties('TooltipEnemyPenalties',,false, true, , , true);
	Debuffs.ItemList.bAnimateOnInit = false;
//	Debuffs.BGBox.SetColor("00FF00");

	BuffDebuffStack.Add(Buffs);
	BuffDebuffStack.Add(Debuffs);


	AbilitiesHeader = Spawn(class'UIText', AbilityEffectContainer).InitText('Title');
	AbilitiesHeader.SetPosition(40, 2);
	AbilitiesHeader.SetHTMLText(class'UIUtilities_Text'.static.StyleText(class'XLocalizedData'.default.TacticalTextAbilitiesHeader, eUITextStyle_Tooltip_StatLabel));

	Abilities = Spawn(class'UIEffectList', AbilityEffectContainer);
	Abilities.bAnimateOnInit = false;
	// 40 is hardcoded padding + header height in effect tooltip
	Abilities.InitEffectList('', '', horizontalMargin + 10, 40, columnWidth - 20, 9999, 9999, 9999, RealizeLayout);

	// UITooltips dislike positioning -- position with a parent panel
	WeaponTooltipContainer = Spawn(class'UIPanel', Container).InitPanel();
	WeaponTooltipContainer.SetPosition(-10, Container.Height - 30);

	WeaponTooltip = Spawn(class'UITacticalHUD_WeaponTooltip', WeaponTooltipContainer);
	WeaponTooltip.Width = ((Movie.UI_RES_X - Container.Width) / 2) - 20;
	WeaponTooltip.InitWeaponStats();
	WeaponTooltip.AmmoInfoList.OnTextSizeRealized = WeaponTooltipSizeRealized;
	WeaponTooltip.UpgradeInfoList.OnTextSizeRealized = WeaponTooltipSizeRealized;
	WeaponTooltip.ShowTooltip();

	Connector1 = Spawn(class'UIPanel', Container).InitPanel('', class'UIUtilities_Controls'.const.MC_GenericPixel);
	Connector2 = Spawn(class'UIPanel', Container).InitPanel('', class'UIUtilities_Controls'.const.MC_GenericPixel);
	Connector3 = Spawn(class'UIPanel', Container).InitPanel('', class'UIUtilities_Controls'.const.MC_GenericPixel);
}

simulated function CloseScreen()
{
	super.CloseScreen();
	Hide();
}


simulated function PopulateData(StateObjectReference Target)
{
	local XComGameStateHistory History;

	local XComGameState_Unit UnitState;
	local XGUnit Unit;

	local string DescText;
	local LWTuple Tuple;
	local LWTValue Value, EmptyValue;
	
	local int i, j;
	local int BaseStat, CurrStat, Diff;

	local array<StringPair>	StatData;
	local StringPair Pair;
	
	local X2Effect_Persistent Effect;
	local array<X2Effect_Persistent> EffectTemplates;
	local XComGameState_Effect EffectState;
	local array<XComGameState_Effect> EffectStates;

	local ECharStatType StatType;
	local string StatString, DiffString;
	local bool MayCensorStat;
	local X2SoldierClassTemplate SCTemplate;

	local ArmorMitigationResults Armor;

	local XGUnit RestoreUnit;
	local XComTacticalController TC;
	
	local array<UISummary_UnitEffect> PassiveAbilities, ActiveAbilities;
	local UISummary_UnitEffect TempEffect;
	local array<UISummary_Ability> UnitAbilitiesAsAbilities;

	local bool bAllowBigItem;
	local XComGameState_Item BigItem;
	local array<XComGameState_Item> SmallItems, UtilityItems;

	Show();

	History = `XCOMHISTORY;
	TargetState = History.GetGameStateForObjectID(Target.ObjectID);

	if (CheckNotAUnitState(TargetState))
	{
		return;
	}

	Unit = XGUnit(History.GetVisualizer(Target.ObjectID));
	// even though we shouldn't interrupt anything, let's be safe
	UnitState = Unit.GetVisualizedGameState();
	SCTemplate = UnitState.GetSoldierClassTemplate();

	DescText = UnitState.GetMyTemplate().strAcquiredText;
	// HAX: It's used by SparkSoldier, and doesn't contain any relevant tactical info. Noticed that way too late
	// for now, just adding a check here
	if (UnitState.GetMyTemplateName() == 'SparkSoldier')
	{
		DescText = "";
	}
	if (DescText == "")
	{
		DescText = Unit.IsFriendly(PC) ? m_strSoldierInfo : m_strEnemyInfo;
	}

	// allow mods to change the description
	Tuple = new class'LWTuple';
	Tuple.Id = 'YAF1_OverrideUnitDesc';

	Value = EmptyValue;
	Value.kind = LWTVObject;
	Value.o = UnitState;
	Tuple.Data.AddItem(Value);

	Value = EmptyValue;
	Value.kind = LWTVString;
	Value.s = DescText;
	Tuple.Data.AddItem(Value);

	`XEVENTMGR.TriggerEvent('YAF1_OverrideUnitDesc', Tuple, self);

	DescText = Tuple.Data[1].s;


	TitleHeader.SetText(UnitState.GetName(eNameType_FullNick), DescText);

	SetLayout(Unit.IsFriendly(PC), UnitState.IsSoldier());

	if (SCTemplate != none)
	{
		SCImage.LoadImage(SCTemplate.IconImage);
	}

	
	for (i = 0; i < UnitState.AffectedByEffects.Length; i++)
	{
		EffectState = XComGameState_Effect(History.GetGameStateForObjectID(UnitState.AffectedByEffects[i].ObjectID));
		Effect = EffectState.GetX2Effect();
		// optimization: classes need to be subclasses, otherwise they don't implement this function
		if (Effect != none && Effect.Class.Name != 'X2Effect_Persistent')
		{
			EffectStates.AddItem(EffectState);
			EffectTemplates.AddItem(Effect);
		}
	}


	// populate stats
	for (i = 0; i < StatIcons.Length; i++)
	{
		StatType = StatIcons[i].Stat;
		if (StatType == eStat_HP)
		{
			MayCensorStat = false;
			// for hp, show current and max stat
			BaseStat = UnitState.GetMaxStat(StatType);
			CurrStat = UnitState.GetCurrentStat(StatType);
			StatString = class'UIUtilities_Text'.static.GetColoredText(CurrStat $ "/" $ BaseStat, CurrStat < BaseStat ? eUIState_Bad : eUIState_Header, 20);
		}
		else
		{
			if (StatType == eStat_ArmorMitigation)
			{
				MayCensorStat = false;
				BaseStat = UnitState.GetBaseStat(StatType);
				// can be modified by shred etc, not a proper stat
				CurrStat = UnitState.GetArmorMitigation(Armor);
			}
			else
			{
				MayCensorStat = StatType != eStat_Defense;
				BaseStat = UnitState.GetBaseStat(StatType);
				CurrStat = UnitState.GetCurrentStat(StatType);
				for (j = 0; j < EffectTemplates.Length; j++)
				{
					EffectTemplates[j].ModifyUISummaryUnitStats(EffectStates[j], UnitState, StatType, CurrStat);
				}
			}
			Diff = CurrStat - BaseStat;
			StatString = class'UIUtilities_Text'.static.GetColoredText(string(BaseStat), eUIState_Header, 20);
			if (Diff != 0)
			{
				DiffString = class'UIUtilities_Text'.static.GetColoredText(Diff > 0 ? ("+" $ Diff) : ("-" $ int(Abs(Diff))), Diff > 0 ? eUIState_Good : eUIState_Bad, 20);
				StatString $= DiffString;
			}
		}
		Pair.A = (bCensored && MayCensorStat) ? LockedStatIcon : StatIcons[i].Icon;
		Pair.B = (bCensored && MayCensorStat) ? (class'UIUtilities_Text'.static.GetColoredText(CensoredStat(), eUIState_Header, 20)) : StatString;
		StatData.AddItem(Pair);
	}
	StatData.Sort(ByCensored);
	StatPanel.SetData(StatData);

	// Need this code here for the weapon tooltip. Most of it used after the tooltips though!
	// Andromedon Robots don't have a meaningful primary. show their secondary (fist) instead, but without large image because it would fall back to the sword
	if (UseSecondaryAsPrimary.Find(UnitState.GetMyTemplateName()) != INDEX_NONE)
	{
		BigItem = UnitState.GetItemInSlot(eInvSlot_SecondaryWeapon);
	}
	else
	{
		bAllowBigItem = true;
		BigItem = UnitState.GetItemInSlot(eInvSlot_PrimaryWeapon);
		SmallItems.AddItem(UnitState.GetItemInSlot(eInvSlot_SecondaryWeapon));
	}
	SmallItems.AddItem(UnitState.GetItemInSlot(eInvSlot_Armor));

	// support for utility pistols
	// TODO: add grenades, skulljack etc?
	UtilityItems = UnitState.GetAllItemsInSlot(eInvSlot_Utility);
	for (i = 0; i < UtilityItems.Length; i++)
	{
		if (UtilityItems[i].GetMyTemplate().IsA('X2WeaponTemplate') && X2WeaponTemplate(UtilityItems[i].GetMyTemplate()).WeaponCat == 'pistol')
		{
			SmallItems.AddItem(UtilityItems[i]);
		}
	}

	TC = XComTacticalController(PC);
	RestoreUnit = TC.ControllingUnitVisualizer;
	TC.ControllingUnitVisualizer = Unit;

	// Refresh buffs, they use this as the input
	Buffs.ShowTooltip();
	Debuffs.ShowTooltip();
	// Bug: It's possible that if the only thing that changes is that the data array gets shorter, previous entries unchanged
	// an update callback won't actually fire. to circumvent that, let's call the realize functions manually
	Buffs.ItemList.OnItemChanged(none);
	Debuffs.ItemList.OnItemChanged(none);

	if (bCensored || !bAllowBigItem || (!BigItem.HasLoadedAmmo() && BigItem.GetMyWeaponUpgradeTemplateNames().Length == 0))
	{
		WeaponTooltip.HideTooltip();
	}
	else
	{
		WeaponTooltip.ShowTooltip();
	}
//	WeaponTooltip.AmmoInfoList.OnChildTextRealized();
//	WeaponTooltip.UpgradeInfoList.OnChildTextRealized();

	TC.ControllingUnitVisualizer = RestoreUnit;
	
	PassiveAbilities = UnitState.GetUISummary_UnitEffectsByCategory(ePerkBuff_Passive);
	UnitAbilitiesAsAbilities = GetAbilities(UnitState);

	for (i = 0; i < UnitAbilitiesAsAbilities.Length; i++)
	{
		TempEffect.Name = bCensored ? RandomCensoredTitle() : UnitAbilitiesAsAbilities[i].Name;
		TempEffect.Icon = bCensored ? strLockedIcon : UnitAbilitiesAsAbilities[i].Icon;
		TempEffect.Description = bCensored ? RandomCensoredDescription() : UnitAbilitiesAsAbilities[i].Description;
		ActiveAbilities.AddItem(TempEffect);
	}
	
	for (i = 0; i < PassiveAbilities.Length; i++)
	{
		PassiveAbilities[i].Name = bCensored ? RandomCensoredTitle() : PassiveAbilities[i].Name;
		PassiveAbilities[i].Icon = bCensored ? strLockedIcon : PassiveAbilities[i].Icon;
		PassiveAbilities[i].Description = bCensored ? RandomCensoredDescription() : PassiveAbilities[i].Description;
	}

	if (bUseFallbackIcons)
	{
		FixBrokenIcons(ActiveAbilities);
		FixBrokenIcons(PassiveAbilities);
	}

	Abilities.RefreshData(ActiveAbilities);
	Abilities.OnItemChanged(none);

	Passives.RefreshData(PassiveAbilities);
	Passives.OnItemChanged(none);

	PrimaryWeaponPanel.PopulateData(BigItem, bAllowBigItem, bCensored);
	// Secondaries shouldn't have an image because they don't exist outside of strategy
	SpawnWeaponPanels(SmallItems.Length);
	for (i = 0; i < SmallItems.Length; i++)
	{
		AdditionalPanels[i].PopulateData(SmallItems[i], false, bCensored);
	}

	RealizeLayout();

}

function int ByCensored(StringPair A, StringPair B)
{
	if (A.A == LockedStatIcon && B.A != LockedStatIcon)
	{
		return -1;
	}
	return 0;
}

simulated function SpawnWeaponPanels(int num)
{
	local YAF1_UIWeaponPanel WeaponPanel;
	local int i;

	while (AdditionalPanels.Length < num)
	{
		WeaponPanel = Spawn(class'YAF1_UIWeaponPanel', Container).InitWeaponPanel(WeaponPanelSizeRealized);
		AdditionalPanels.AddItem(WeaponPanel);
	}

	for (i = 0; i < AdditionalPanels.Length; i++)
	{
		if (i < num)
		{
			AdditionalPanels[i].Show();
		}
		else
		{
			AdditionalPanels[i].Hide();
		}
	}
}	

simulated function FixBrokenIcons(out array<UISummary_UnitEffect> Data)
{
	local int i;

	for (i = 0; i < Data.Length; i++)
	{
		if (DynamicLoadObject(Repl(Data[i].Icon, "img:///", "", false), class'Texture2D') == none)
		{
			Data[i].Icon = strFallbackIcon;
		}
	}
}

simulated function array<UISummary_Ability> GetAbilities(XComGameState_Unit _UnitState)
{
	local array<UISummary_Ability> AbilitySummary;
	local UISummary_Ability Data;
	local GameRulesCache_Unit UnitCache;
	local AvailableAction Action;
	local array<AvailableAction> Actions;
	local XComGameState_Ability AbilityState;
	local int i, outCmdAbility;
	local UITacticalHUD_AbilityContainer AbilityContainer;
	
	// passives are shown via ePerkBuff_Passive. Actives are normally shown via the Ability HUD, even if unavailable (most of the time)
	// because of that, we just use the GameRulesCache_Unit and take the code from the AbilityHUD
	// this prevents dummy abilities from showing most of the time and is also quite performant
	// if any abilities aren't shown even though they should, the author should add passive display info or adjust eAbilityIconBehaviorHUD
	if (`TACTICALRULES.GetGameRulesCache_Unit(_UnitState.GetReference(), UnitCache))
	{
		for (i = 0; i < UnitCache.AvailableActions.Length; i++)
		{
			Action = UnitCache.AvailableActions[i];
			ModifyActionBehavior(Action);
			if (class'UITacticalHUD_AbilityContainer'.static.ShouldShowAbilityIcon(Action, outCmdAbility))
			{
				Actions.AddItem(Action);
			}
			else
			{
				
			}
		}
	}
	AbilityContainer = `PRES.m_kTacticalHUD.m_kAbilityHUD;
	Actions.Sort(AbilityContainer.SortAbilities);

	for (i = 0; i < Actions.Length; i++)
	{
		AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(Actions[i].AbilityObjectRef.ObjectID));
		//Data = AbilityState.GetUISummary_Ability();
		// icon doesn't apply for grenades
		Data.Name = AbilityState.GetMyFriendlyName();
		Data.Description = AbilityState.GetMyHelpText();
		Data.Icon = AbilityState.GetMyIconImage();
		AbilitySummary.AddItem(Data);
	}
	
	return AbilitySummary;
}

simulated function ModifyActionBehavior(out AvailableAction Action)
{
	local XComGameState_Ability AbilityState;
	local X2AbilityTemplate Template;

	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(Action.AbilityObjectRef.ObjectID));
	Template = AbilityState.GetMyTemplate();

	// don't show overwatch
	if (Template.CinescriptCameraType == "Overwatch" || Template.DataName == 'HunkerDown'
	// no evac-like abilities
		|| Template.ShotHUDPriority == class'UIUtilities_Tactical'.const.PLACE_EVAC_PRIORITY
	// no hidden abilities
		|| DefaultHidden.Find(Template.DataName) != INDEX_NONE
	// no interact abilities
		|| Template.IconImage == "img:///UILibrary_PerkIcons.UIPerk_interact")
	{
		Action.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
		return;
	}

	if (DefaultShown.Find(Template.DataName) != INDEX_NONE)
	{
		Action.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	}
}

simulated function WeaponPanelSizeRealized(YAF1_UIWeaponPanel ChangedPanel)
{
	local int _y, _x, i;
	// this panel should always be visible, at least it shouldn't be invisible when other panels are visible
	PrimaryWeaponPanel.SetY(Container.Height - PrimaryWeaponPanel.Height - bottomMargin);
	_x = PrimaryWeaponPanel.X + PrimaryWeaponPanel.Width + weaponPanelPadding;
	_y = 0;
	

	for (i = 0; i < AdditionalPanels.Length; i++)
	{
		if (AdditionalPanels[i].bIsVisible)
		{
			if (_y + AdditionalPanels[i].Height > PrimaryWeaponPanel.Height)
			{
				_y = 0;
				_x += PrimaryWeaponPanel.Width + weaponPanelPadding;
			}
			AdditionalPanels[i].SetPosition(_x, PrimaryWeaponPanel.Y + _y);
			_y += AdditionalPanels[i].Height + 5;
		}
	}

	RealizeLayout();
}

simulated function WeaponTooltipSizeRealized()
{
	WeaponTooltip.OnChildPanelSizeRealized();
	RealizeWeaponTooltip();
}

simulated function RealizeLayout()
{
	//bNeedsRealizeLayout = true;
	RealizeLayoutInternal();
}

// resize container, scroll etc, also color panels
simulated function RealizeLayoutInternal()
{
	local float lowestPanel;
	local float diff;
	local float PassivesHeight;

	//bNeedsRealizeLayout = false;

	// re-color -- items may have created new list items
	SetColors();

	if (Abilities.Height > 0)
	{
		AbilitiesHeader.Show();
		Abilities.Show();
	}
	else
	{
		AbilitiesHeader.Hide();
		Abilities.Hide();
	}

	PassivesHeight = 0;
	if (Passives.Height > 0)
	{
		PassivesHeader.Show();
		Passives.Show();
		PassivesHeight = Passives.Y + Passives.Height;
	}
	else
	{
		PassivesHeader.Hide();
		Passives.Hide();
	}

	BuffDebuffStack.startY = PassivesHeight;
	// warning: infinite recursion
	BuffDebuffStack.bDisableReposition = true;
	BuffDebuffStack.Notify();
	BuffDebuffStack.bDisableReposition = false;
	
	lowestPanel = 0;
	lowestPanel = Max(lowestPanel, Buffs.Y + Buffs.Height);
	lowestPanel = Max(lowestPanel, Debuffs.Y + Debuffs.Height);
	lowestPanel = Max(lowestPanel, Abilities.Y + Abilities.Height);
	AbilityEffectContainer.Height = lowestPanel;
	// restore it to resting position. was working before because this function hammered multiple times
	// and relied on the scrollbar immediately setting the container back to 0
	// if the scrollbar doesn't do that (smooth scrolling), we have a few layout issues
	AbilityEffectContainer.SetY(ContainerRestPos);
	
	AbilityEffectMask.SetHeight(PrimaryWeaponPanel.Y - AbilityEffectContainer.Y - 10);

	RealizeWeaponTooltip();

	diff = AbilityEffectMask.Height - AbilityEffectContainer.Height;
	Scrollbar.NotifyValueChange(AbilityEffectContainer.SetY, ContainerRestPos, ContainerRestPos + Min(diff, 0));
	Scrollbar.SetThumbAtPercent(0.0);
	Scrollbar.SnapToControl(AbilityEffectMask, -20);
	if (diff >= 0)
	{
		Scrollbar.Hide();
	}
	else
	{
		Scrollbar.Show();
	}
}

simulated function RealizeWeaponTooltip()
{
	local float ConnX, ConnY;

	Connector1.SetVisible(WeaponTooltip.bIsVisible);
	Connector2.SetVisible(WeaponTooltip.bIsVisible);
	Connector3.SetVisible(WeaponTooltip.bIsVisible);

	if (WeaponTooltip.bIsVisible && Connector1 != none)
	{
		Connector1.SetSize(WeaponTooltip.Width - WeaponTooltip.PADDING_LEFT + 5, 2);
		Connector1.SetPosition(-Connector1.Width - 5, WeaponTooltipContainer.Y - WeaponTooltip.Container.Height + 38);

		ConnX = PrimaryWeaponPanel.GetConnectorX() + PrimaryWeaponPanel.X;
		ConnY = PrimaryWeaponPanel.GetConnectorY() + PrimaryWeaponPanel.Y;

		Connector3.SetSize(ConnX + 5, 2);
		Connector3.SetPosition(ConnX - Connector3.Width, ConnY);

		Connector2.SetSize(2, Connector3.Y - Connector1.Y);
		Connector2.SetPosition(-5, ConnY - Connector2.Height);
	}
}

simulated function ColorPanel(UIPanel Panel, string _clr, string _textclr, string _headerclr)
{
	local int i;
	if (UIIcon(Panel) != none)
	{
		UIIcon(Panel).SetBGColor(_clr);
	}
	else if (UIText(Panel) != none)
	{
		Panel.SetColor((Panel.MCName == 'Title' || Panel.MCName == 'Title2') ? _headerclr : _textclr);
	}
	else if (UIScrollingText(Panel) != none || UIScrollbar(Panel) != none)
	{
		Panel.SetColor(_headerclr);
	}
	else
	{
		for (i = 0; i < Panel.ChildPanels.Length; i++)
		{
			ColorPanel(Panel.ChildPanels[i], _clr, _textclr, _headerclr);
		}
	}
}


simulated function Show()
{
	super.Show();
	Movie.InsertHighestDepthScreen(self);
	InputState = eInputState_Consume;
}

simulated function Hide()
{
	super.Hide();
	Movie.RemoveHighestDepthScreen(self);
	InputState = eInputState_None;
}

// It is possible to somehow target a device, even though we prevent F1 from being available when doing that, you can still tab through units
// This checks if we should show full info or instead show a "No Info Availabe" message. Additionally, this handles mod support for mods that
// want to suppress some info.
simulated function bool CheckNotAUnitState(XComGameState_BaseObject Target)
{
	local LWTuple Tuple;
	local bool InfoVisible;
	local bool CompleteHidden;

	// allow mods to change the show/hide behavior
	Tuple = new class'LWTuple';
	Tuple.Id = 'YAF1_OverrideShowInfo';
	Tuple.Data.Add(4);

	// The targeted unit.
	Tuple.Data[0].kind = LWTVObject;
	Tuple.Data[0].o = Target;
	// Whether the info should be available.
	Tuple.Data[1].kind = LWTVBool;
	Tuple.Data[1].b = XComGameState_Unit(Target) != none;
	// What to show as a description
	Tuple.Data[2].kind = LWTVString;
	Tuple.Data[2].s = XComGameState_Unit(Target) != none ? XComGameState_Unit(Target).GetName(eNameType_FullNick) : m_strNotAUnit;
	// What to show as a reason
	Tuple.Data[3].kind = LWTVString;
	Tuple.Data[3].s = m_strNoInfoAvailable;

	`XEVENTMGR.TriggerEvent('YAF1_OverrideShowInfo', Tuple);

	InfoVisible = Tuple.Data[1].b;

	bCensored = !InfoVisible && XComGameState_Unit(Target) != none;
	CompleteHidden = !InfoVisible && XComGameState_Unit(Target) == none;

	// You shouldn't be able to target friendly devices with the same ability that allows you to target friendly units,
	// so we're fine assuming that any device must be hostile.
	if (CompleteHidden)
		SetLayout(false, false);

	StatPanel.SetVisible(!CompleteHidden);
	AbilityEffectContainer.SetVisible(!CompleteHidden);
	PrimaryWeaponPanel.SetVisible(!CompleteHidden);
	NoInfoText.SetVisible(CompleteHidden || bCensored);

	if (CompleteHidden)
	{
		SpawnWeaponPanels(0);
		TitleHeader.SetText(Tuple.Data[2].s);
		TitleHeader.MC.FunctionVoid("realize");
		NoInfoText.SetWidth(Container.Width - 40);
		NoInfoText.SetX(20);
		NoInfoText.SetCenteredText("<font size='80' face='$TitleFont' align='CENTER'>" $ Tuple.Data[3].s $ "</font>", , OnNoInfoTextSizeRealized);
	}
	else if (bCensored)
	{
		NoInfoText.SetWidth(Container.Width / 2 - horizontalPadding - horizontalMargin);
		NoInfoText.SetX(Container.Width / 2 + horizontalPadding);
		NoInfoText.SetY(70);
		NoInfoText.SetCenteredText("<font size='40' face='$TitleFont' align='CENTER'>" $ Tuple.Data[3].s $ "</font>", , NoOp);
	}
	
	RealizeLayout();

	return CompleteHidden;
}

simulated function OnNoInfoTextSizeRealized()
{
	NoInfoText.SetY((Container.Height - NoInfoText.Height) / 2);
}

simulated function NoOp()
{

}

// sets the screen layout and style appropriate for the team. true means friendly unit, false means hostile unit
simulated function SetLayout(bool _bFriendly, bool IsSoldier)
{
	bActuallyFriendly = _bFriendly;

	Style = class'YAF1_DefaultScreenStyles'.static.ChooseScreenStyleTemplate(TargetState);

	SetupToggleButtons();

	if (IsSoldier)
	{
		SCImage.Show();
		TitleHeader.SetX(10 + SCImage.Width + 10);
		TitleHeader.SetWidth(Container.Width - TitleHeader.X - 10);
	}
	else
	{
		SCImage.Hide();
		TitleHeader.SetX(10);
		TitleHeader.SetWidth(Container.Width - 20);
	}

	TitleHeader.MC.FunctionVoid("realize");


}

simulated function SetColors()
{
	local string clr, textclr, headerclr;
	local int i;

	if (Style == none) return;

	clr = Style.PrimaryColor;
	textclr = Style.TextColor;
	headerclr = Style.HeaderColor;
	
	// COLOR THEM ALL
	ColorPanel(Buffs, Style.BuffIconColor, textclr, headerclr);
	ColorPanel(Debuffs, Style.DebuffIconColor, textclr, headerclr);
	
	ColorPanel(AbilitiesHeader, clr, textclr, headerclr);
	ColorPanel(Abilities, Style.AbilityIconColor, textclr, headerclr);
	
	ColorPanel(PassivesHeader, clr, textclr, headerclr);
	ColorPanel(Passives, Style.PassiveIconColor, textclr, headerclr);

	ColorPanel(WeaponTooltip, clr, textclr, headerclr);
	
	TitleHeader.SetColor(clr);
	NoInfoText.SetColor(clr);

	AS_SetMCColor(PanelBG.MCPath$".topLines", clr);
	AS_SetMCColor(PanelBG.MCPath$".bottomLines", clr);

	StatPanel.SetColor(clr);

	Connector1.SetColor(clr);
	Connector2.SetColor(clr);
	Connector3.SetColor(clr);

	PrimaryWeaponPanel.SetColor(clr);

	for (i = 0; i < AdditionalPanels.Length; i++)
	{
		AdditionalPanels[i].SetColor(clr);
	}

}

// taken from CH. same functionality, no requirement
// warning: this function is deprecated and only used in lack of better alternatives
// it doesn't route through the UIMCcontroller and performs badly due to that
simulated function AS_SetMCColor(string ClipPath, string HexColor)
{
	Movie.ActionScriptVoid("Colors.setColor");
}

simulated function SetupToggleButtons()
{
	XComLayoutImage.SetVisible(!bActuallyFriendly);
	AdventLayoutImage.SetVisible(!bActuallyFriendly);

	if (Style.DataName == class'YAF1_DefaultScreenStyles'.default.FriendlyTemplate)
	{
		XComLayoutImage.SetAlpha(100);
		XComLayoutImage.IgnoreMouseEvents();
		AdventLayoutImage.SetAlpha(50);
		AdventLayoutImage.ProcessMouseEvents();
	}
	else
	{
		AdventLayoutImage.SetAlpha(100);
		AdventLayoutImage.IgnoreMouseEvents();
		XComLayoutImage.SetAlpha(50);
		XComLayoutImage.ProcessMouseEvents();
	}
}

simulated function OnToggleButtonClicked(UIImage ClickedImage)
{
	local bool bFriendlyClicked;
	bFriendlyClicked = ClickedImage == XComLayoutImage;

	class'YAF1_Config'.default.bDisableStyles = bFriendlyClicked;

	class'YAF1_Config'.static.StaticSaveConfig();

	SetLayout(bActuallyFriendly, XComGameState_Unit(TargetState) != none && XComGameState_Unit(TargetState).IsSoldier());
	SetColors();
}

event Tick(float DeltaTime)
{
	BuffDebuffStack.CheckNotify();
/*	if (bNeedsRealizeLayout)
	{
		RealizeLayoutInternal();
	}
*/
}


simulated function bool OnUnrealCommand(int cmd, int arg)
{
	local bool bHandled;
	local X2TargetingMethod TargetingMethod;
	local XComTacticalInput TI;
	local StateObjectReference TargetRef;

	if( !CheckInputIsReleaseOrDirectionRepeat(cmd, arg) )
		return false;

	bHandled = true;

	TI = XComTacticalInput(PC.PlayerInput);
	TargetingMethod = XComPresentationLayer(Movie.Pres).m_kTacticalHUD.m_kAbilityHUD.TargetingMethod;

	switch( cmd )
	{
		// a lot of keys can close it
		case class'UIUtilities_Input'.const.FXS_BUTTON_A:
		case class'UIUtilities_Input'.const.FXS_KEY_ENTER:
		case class'UIUtilities_Input'.const.FXS_KEY_SPACEBAR:
		case class'UIUtilities_Input'.const.FXS_BUTTON_B:
		case class'UIUtilities_Input'.const.FXS_KEY_ESCAPE:
		case class'UIUtilities_Input'.const.FXS_R_MOUSE_DOWN:
			CloseScreen();
			break;
		// HACK: camera shift is scroll in tactical, so use C and F
		case class'UIUtilities_Input'.const.FXS_KEY_F:
		case class'UIUtilities_Input'.const.FXS_DPAD_UP:
		case class'UIUtilities_Input'.const.FXS_ARROW_UP:
		case class'UIUtilities_Input'.const.FXS_VIRTUAL_LSTICK_UP:
			if(Scrollbar != none)
				Scrollbar.OnMouseScrollEvent(1);
			break;
		case class'UIUtilities_Input'.const.FXS_KEY_C:
		case class'UIUtilities_Input'.const.FXS_DPAD_DOWN:
		case class'UIUtilities_Input'.const.FXS_ARROW_DOWN:
		case class'UIUtilities_Input'.const.FXS_VIRTUAL_LSTICK_DOWN:
			if(Scrollbar != none)
				Scrollbar.OnMouseScrollEvent(-1);
			break;
		case class'UIUtilities_Input'.const.FXS_KEY_TAB:
		case class'UIUtilities_Input'.const.FXS_BUTTON_RBUMPER:
			if( TargetingMethod != none )
			{
				TargetingMethod.NextTarget();
				TargetRef.ObjectID = TargetingMethod.GetTargetedObjectID();
			}
			else if (TI.NextUnit())
			{
				TargetRef.ObjectID = XComTacticalController(PC).ControllingUnit.ObjectID;
			}
			else
			{
				bHandled = false;
			}
			break;
		case class'UIUtilities_Input'.const.FXS_KEY_LEFT_SHIFT:
		case class'UIUtilities_Input'.const.FXS_BUTTON_LBUMPER:
			if( TargetingMethod != none )
			{
				TargetingMethod.PrevTarget();
				TargetRef.ObjectID = TargetingMethod.GetTargetedObjectID();
			}
			else if (TI.PrevUnit())
			{
				TargetRef.ObjectID = XComTacticalController(PC).ControllingUnit.ObjectID;
			}
			else
			{
				bHandled = false;
			}
			break;
		case class'UIUtilities_Input'.const.FXS_BUTTON_X:
			if (XComLayoutImage.bIsVisible && XComLayoutImage.bProcessesMouseEvents)
			{
				XComLayoutImage.OnClickedDelegate(XComLayoutImage);
			}
			else if (AdventLayoutImage.bIsVisible && AdventLayoutImage.bProcessesMouseEvents)
			{
				AdventLayoutImage.OnClickedDelegate(AdventLayoutImage);
			}
			break;
		default:
			bHandled = false;
			break;
	}

	if (TargetRef.ObjectID > 0 && TargetRef.ObjectID != TargetState.ObjectID)
	{
		PopulateData(TargetRef);
	}
	// don't route through the navigator
	return bHandled;
}

static function string RandomCensoredTitle()
{
	return ScrambleString(default.LockedTitles[Rand(default.LockedTitles.Length)]);
}

static function string RandomCensoredDescription()
{
	return ScrambleString(default.LockedDescriptions[Rand(default.LockedDescriptions.Length)]);
}

static function string CensoredStat()
{
	return ScrambleString(default.m_strCensoredStat);
}

static function string ScrambleString(string str)
{
	local string ret;
	local int i, strlen, alphabetLen, roll;

	strlen = Len(str);
	alphabetLen = Len(default.m_strAlphabet);
	ret = "";
	for (i = 0; i < strlen; i++)
	{
		if (Mid(str, i, 1) != "X")
		{
			ret $= Mid(str, i, 1);
		}
		else
		{
			roll = Rand(alphabetLen);
			ret $= Mid(default.m_strAlphabet, roll, 1);
		}
	}
	return ret;
}


defaultproperties
{
	Width=1300
	Height=800

	iStatIconSize=24
	horizontalMargin=32
	horizontalPadding=48
	weaponPanelPadding=24
	bottomMargin=15

	bConsumeMouseEvents=true
	
	bIsPermanent=true
	bIsVisible=false
}
