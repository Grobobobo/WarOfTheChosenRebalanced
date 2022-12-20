//---------------------------------------------------------------------------------------
 //  FILE:    UIArmory_LoadoutItemTooltip.uc
 //  AUTHOR:  Brit Steiner --  7/25/2014
 //  PURPOSE: Tooltip for item stats displayed in the inventory screen. 
 //---------------------------------------------------------------------------------------
 //  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
 //---------------------------------------------------------------------------------------

class UIArmory_LoadoutItemTooltip_GTO extends UITooltip;

var int PADDING_LEFT;
var int PADDING_RIGHT;
var int PADDING_TOP;
var int PADDING_BOTTOM;
var int CENTER_PADDING;

var int BasicWidth;
var int UpgradeWidth;

var UIScrollingText TitleControl;
var public UIStatList StatListBasic; 
//var public UIStatList StatListUpgrades; 
var public UIPanel StatArea;
var public UIPanel TacticalArea; 
var public UIMask TacticalMask;
var public UITacticalInfoList AbilityItemList, TacticalItemList; 
var public UIMask TacticalAreaMask; 

var X2ItemTemplate CurrentTemplate;

simulated function UIPanel InitLoadoutItemTooltip(optional name InitName, optional name InitLibID)
{
	local UIPanel Line; 

	InitPanel(InitName, InitLibID);

	Hide();

	width = BasicWidth + UpgradeWidth; 

	//-----------------------

	//Spawn(class'UIPanel', self).InitPanel('BGBox', class'UIUtilities_Controls'.const.MC_X2Background).SetSize(width, height);

	TitleControl = Spawn(class'UIScrollingText', self);
	TitleControl.InitScrollingText('ScrollingText', "", width - PADDING_LEFT - PADDING_RIGHT, PADDING_LEFT, PADDING_TOP); 
	
	Line = class'UIUtilities_Controls'.static.CreateDividerLineBeneathControl( TitleControl, none, 2 );

	//-----------------------

	StatArea = Spawn(class'UIPanel', self); 
	StatArea.InitPanel('StatArea').SetPosition(0, Line.Y + 4).SetSize(width, height-Line.Y-4);  // plus 4 to give it a little breathing room away from the line

	StatListBasic = Spawn(class'UIStatList', StatArea);
	StatListBasic.InitStatList('StatListLeft',, 0, 0, width, StatArea.height);
	StatListBasic.OnSizeRealized = OnStatListSizeRealized;
	
	//-----------------------

	TacticalArea = Spawn(class'UIPanel', self); 
	TacticalArea.bAnimateOnInit = false;
	TacticalArea.InitPanel('TacticalArea');

	TacticalMask = Spawn(class'UIMask', self).InitMask('TacticalMask', TacticalArea);
	TacticalMask.SetPosition(TacticalArea.X, TacticalArea.Y); 
	TacticalMask.SetWidth(width);

	AbilityItemList = Spawn(class'UITacticalInfoList', TacticalArea);
	AbilityItemList.InitTacticalInfoList('AbilityItemList',
		, 
		class'XLocalizedData'.default.TacticalTextAbilitiesHeader,
		PADDING_LEFT, 
		PADDING_TOP, 
		width-PADDING_LEFT-PADDING_RIGHT);
	AbilityItemList.OnSizeRealized = OnAbilityListSizeRealized;

	TacticalItemList = Spawn(class'UITacticalInfoList', TacticalArea);
	TacticalItemList.InitTacticalInfoList('TacticalItemList',
		, 
		class'XLocalizedData'.default.TacticalTextDescHeader,
		PADDING_LEFT, 
		PADDING_TOP, 
		width-PADDING_LEFT-PADDING_RIGHT);
	TacticalItemList.OnSizeRealized = OnTacticalListSizeRealized;

	return self; 
}

simulated function ShowTooltip()
{
	super.ShowTooltip();

	RefreshData();

	if(bIsVisible)
	{
		//Must call this separately, because if the lists do not actually change size, than the 
		//scrolling never updates on the text size realized callback chain.
		ResetScroll();
		AnimateIn(0);
	}
}

simulated function RefreshData()
{
	
	if( CurrentTemplate == none )
	{
		HideTooltip();
		return; 
	}
	
	TitleControl.SetSubTitle( class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS( CurrentTemplate.FriendlyName ) );
	
	TacticalItemList.RefreshData( GetUISummary_TacticalText() );
	AbilityItemList.RefreshData( GetUISummary_TacticalTextAbilities() );
	StatListBasic.RefreshData( GetUISummary_ItemBasicStats(), false ); 
}


simulated function array<UISummary_TacaticalText> GetUISummary_TacticalText()
{
	local bool bIsIn3D;
	local int FontSize;
	local string TacticalText;
	local EUIState ColorState;
	local UISummary_TacaticalText Data; 
	local array<UISummary_TacaticalText> Items;

	ColorState = eUIState_Normal;
	bIsIn3D = `SCREENSTACK.GetCurrentScreen().bIsIn3D;
	FontSize = bIsIn3D ? class'UIUtilities_Text'.const.BODY_FONT_SIZE_3D : class'UIUtilities_Text'.const.BODY_FONT_SIZE_2D;

	if(CurrentTemplate != none)
		TacticalText = CurrentTemplate.GetItemTacticalText();

	if( TacticalText == "" )
	{
		ColorState = eUIState_Bad;
		TacticalText = "DEBUG: @Design: Missing TacticalText in '" $ CurrentTemplate.DataName $ "' template."; 
	}

	Data.Description = class'UIUtilities_Text'.static.GetColoredText(TacticalText, ColorState, FontSize);
	Items.AddItem(Data);

	return Items;  
}

simulated function array<UISummary_TacaticalText> GetUISummary_TacticalTextAbilities()
{
	local bool bIsIn3D;
	local X2EquipmentTemplate       EquipmentTemplate; 
	local X2AbilityTemplateManager  AbilityTemplateManager;
	local X2AbilityTemplate         AbilityTemplate; 
	local name                      AbilityName;
	local UISummary_Ability        UISummaryAbility; 
	local UISummary_TacaticalText  Data; 
	local array<UISummary_TacaticalText> Items; 

	EquipmentTemplate = X2EquipmentTemplate(CurrentTemplate);
	if( EquipmentTemplate == none ) return Items;  //Empty.

	bIsIn3D = `SCREENSTACK.GetCurrentScreen().bIsIn3D;

	AbilityTemplateManager = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();
	foreach EquipmentTemplate.Abilities(AbilityName)
	{
		AbilityTemplate = AbilityTemplateManager.FindAbilityTemplate(AbilityName);
		if( AbilityTemplate != none  && AbilityTemplate.bDisplayInUITacticalText )
		{
			UISummaryAbility = AbilityTemplate.GetUISummary_Ability();
			Data.Name = class'UIUtilities_Text'.static.AddFontInfo(UISummaryAbility.Name, bIsIn3D, true, true);
			Data.Description = class'UIUtilities_Text'.static.AddFontInfo(UISummaryAbility.Description, bIsIn3D, false);
			Data.Icon = UISummaryAbility.Icon;
			Items.AddItem(Data);
		}
	}

	return Items; 
}

simulated function array<UISummary_ItemStat> GetUISummary_ItemBasicStats()
{
	local array<UISummary_ItemStat> Result;

	// TODO: @gameplay: Other stat functions and types 
	if (CurrentTemplate.IsA('X2WeaponTemplate'))
	{
		Result = GetUISummary_WeaponStats();
	}
	else
	{
		Result = GetUISummary_DefaultStats();
	}
	
	return Result;
}

simulated function array<UISummary_ItemStat> GetUISummary_WeaponStats()
{
	local array<UISummary_ItemStat> Stats; 
	local UISummary_ItemStat		Item;
	local UIStatMarkup				StatMarkup;
	local WeaponDamageValue         DamageValue;
	local EUISummary_WeaponStats    UpgradeStats;
	local X2WeaponTemplate WeaponTemplate;
	local delegate<X2StrategyGameRulesetDataStructures.SpecialRequirementsDelegate> ShouldStatDisplayFn;
	local int Index;

	// Variables for Issue #237
	local int PreInt, PostInt;
	local EUIState ColorState;

	// Safety check: you need to be a weapon to use this. 
	WeaponTemplate = X2WeaponTemplate(CurrentTemplate);
	if( WeaponTemplate == none ) 
		return Stats; 
		
	// Issue #237 start
	// Damage-----------------------------------------------------------------------
	if (!WeaponTemplate.bHideDamageStat)
	{
		Item.Label = class'XLocalizedData'.default.DamageLabel;
		DamageValue = WeaponTemplate.BaseDamage;
		if (DamageValue.Damage == 0 && (UpgradeStats.bIsDamageModified || UpgradeStats.bIsSpreadModified))
		{

			Item.Value = AddStatModifier(false, "", UpgradeStats.DamageValue.Damage, eUIState_Good);
			
			Stats.AddItem(Item);
		}
		else if (DamageValue.Damage > 0)
		{
			// Trying to set this up in a single line of code is obnoxious, so I'm splitting it up
			PreInt = DamageValue.Damage;
			PostInt = DamageValue.Damage;
			ColorState = eUIState_Normal;
			if (DamageValue.Spread > 0 || DamageValue.PlusOne > 0)
			{
				PreInt -= DamageValue.Spread;
				PostInt += DamageValue.Spread + ((DamageValue.PlusOne > 0) ? 1 : 0);
			}
			if (UpgradeStats.bIsDamageModified)
			{
				PreInt += UpgradeStats.DamageValue.Damage;
				PostInt += UpgradeStats.DamageValue.Damage;
			}
			if (UpgradeStats.bIsSpreadModified)
			{
				PreInt -= UpgradeStats.DamageValue.Spread;
				PostInt += UpgradeStats.DamageValue.Spread;
			}

			// Call it good if the ending average is better than the starting value, bad otherwise
			if (((PreInt + PostInt) / 2) > DamageValue.Damage)
			{
				ColorState = eUIState_Good;
			}
			else if (((PreInt + PostInt) / 2) < DamageValue.Damage)
			{
				ColorState = eUIState_Bad;
			}

			if (PreInt != PostInt)
			{
				if (ColorState != eUIState_Normal)
				{
					Item.Value = AddStatModifierSpread(false, "", PreInt, PostInt, ColorState);
				}
				else
				{
					Item.Value = string(PreInt) $ "-" $ string(PostInt);
				}
			}
			else
			{
				if (ColorState != eUIState_Normal)
				{
					Item.Value = AddStatModifier(false, "", PreInt, ColorState);
				}
				else
				{
					Item.Value = string(PreInt);
				}
			}

			Stats.AddItem(Item);
		}
	}
	//TODO: Item.ValueState = bIsDamageModified ? eUIState_Good : eUIState_Normal;

	// Crit Damage-----------------------------------------------------------------------
	if (!WeaponTemplate.bHideDamageStat)
	{
		Item.Label = class'XLocalizedData'.default.CriticalDamageLabel;
		DamageValue = WeaponTemplate.BaseDamage;
		if (DamageValue.Crit == 0 && UpgradeStats.bIsCritDamageModified)
		{
			Item.Value = AddStatModifier(false, "", UpgradeStats.DamageValue.Crit, eUIState_Good);
			Stats.AddItem(Item);
		}
		else if (DamageValue.Crit > 0)
		{
			Item.Value = string(DamageValue.Crit);

			if (UpgradeStats.bIsCritDamageModified)
			{
				Item.Value $= AddStatModifier(false, "", UpgradeStats.DamageValue.Crit, eUIState_Good);
			}
			Stats.AddItem(Item);
		}
	}
	// Issue #237 end

	// Clip Size --------------------------------------------------------------------
	if (CurrentTemplate.ItemCat == 'weapon' && !WeaponTemplate.bHideClipSizeStat)
	{
		Item.Label = class'XLocalizedData'.default.ClipSizeLabel;
		if (PopulateWeaponStat(WeaponTemplate.iClipSize, UpgradeStats.bIsClipSizeModified, UpgradeStats.ClipSize, Item))
			Stats.AddItem(Item);
	}

	// Crit -------------------------------------------------------------------------
	Item.Label = class'XLocalizedData'.default.CriticalChanceLabel;
	if (PopulateWeaponStat(WeaponTemplate.CritChance, UpgradeStats.bIsCritModified, UpgradeStats.Crit, Item, true))
		Stats.AddItem(Item);

	// Ensure that any items which are excluded from stat boosts show values that show up in the Soldier Header
	if (class'UISoldierHeader'.default.EquipmentExcludedFromStatBoosts.Find(CurrentTemplate.DataName) == INDEX_NONE)
	{
		// Aim -------------------------------------------------------------------------
		Item.Label = class'XLocalizedData'.default.AimLabel;
		if (PopulateWeaponStat(WeaponTemplate.Aim, UpgradeStats.bIsAimModified, UpgradeStats.Aim, Item, true))
			Stats.AddItem(Item);
	}

	// Issue #237 start
	// Pierce -------------------------------------------------------------------------
	Item.Label = class'XLocalizedData'.default.PierceLabel;
	if (PopulateWeaponStat(WeaponTemplate.BaseDamage.Pierce, UpgradeStats.bIsPierceModified, UpgradeStats.DamageValue.Pierce, Item, false))
		Stats.AddItem(Item);
	// Pierce -------------------------------------------------------------------------
	Item.Label = class'XLocalizedData'.default.RuptureLabel;
	if (PopulateWeaponStat(WeaponTemplate.BaseDamage.Rupture, UpgradeStats.bIsRuptureModified, UpgradeStats.DamageValue.Rupture, Item, false))
		Stats.AddItem(Item);
	// Shred -------------------------------------------------------------------------
	Item.Label = class'XLocalizedData'.default.ShredLabel;
	if (PopulateWeaponStat(WeaponTemplate.BaseDamage.Shred, UpgradeStats.bIsShredModified, UpgradeStats.DamageValue.Shred, Item, false))
		Stats.AddItem(Item);
	// Issue #237 end

	// Free Fire
	Item.Label = class'XLocalizedData'.default.FreeFireLabel;
	if (PopulateWeaponStat(0, UpgradeStats.bIsFreeFirePctModified, UpgradeStats.FreeFirePct, Item, true))
		Stats.AddItem(Item);

	// Free Reloads
	Item.Label = class'XLocalizedData'.default.FreeReloadLabel;
	if (PopulateWeaponStat(0, UpgradeStats.bIsFreeReloadsModified, UpgradeStats.FreeReloads, Item))
		Stats.AddItem(Item);

	// Miss Damage
	Item.Label = class'XLocalizedData'.default.MissDamageLabel;
	if (PopulateWeaponStat(0, UpgradeStats.bIsMissDamageModified, UpgradeStats.MissDamage, Item))
		Stats.AddItem(Item);

	// Free Kill
	Item.Label = class'XLocalizedData'.default.FreeKillLabel;
	if (PopulateWeaponStat(0, UpgradeStats.bIsFreeKillPctModified, UpgradeStats.FreeKillPct, Item, true))
		Stats.AddItem(Item);

	// Add any extra stats and benefits
	for (Index = 0; Index < WeaponTemplate.UIStatMarkups.Length; ++Index)
	{
		StatMarkup = WeaponTemplate.UIStatMarkups[Index];
		ShouldStatDisplayFn = StatMarkup.ShouldStatDisplayFn;
		if (ShouldStatDisplayFn != None && !ShouldStatDisplayFn())
		{
			continue;
		}

		if ((StatMarkup.StatModifier != 0 || StatMarkup.bForceShow)
			// Start Issue #237: Employ a heuristic to filter out the new stats we 
			// already got above in our patch. This isn't 100% accurate, but
			// more of a compatibility fix for stats that people have a reasonable
			// motivation to add manually due to the base game not handling them.
			// (Also, we accidentally doubled the UI shred display for grenades. Whoops.)
			&& StatMarkup.StatLabel != class'XLocalizedData'.default.ShredLabel
    		&& StatMarkup.StatLabel != class'XLocalizedData'.default.PierceLabel
			&& StatMarkup.StatLabel != class'XLocalizedData'.default.RuptureLabel
			// End Issue #237
			)
		{
			Item.Label = StatMarkup.StatLabel;
			Item.Value = string(StatMarkup.StatModifier) $ StatMarkup.StatUnit;
			Stats.AddItem(Item);
		}
	}

	return Stats;
}

simulated function array<UISummary_ItemStat> GetUISummary_DefaultStats()
{
	local array<UISummary_ItemStat> Stats; 
	local UISummary_ItemStat		Item; 
	local int Index;
	local X2EquipmentTemplate EquipmentTemplate;
	local delegate<X2StrategyGameRulesetDataStructures.SpecialRequirementsDelegate> ShouldStatDisplayFn;

	EquipmentTemplate = X2EquipmentTemplate(CurrentTemplate);

	if( EquipmentTemplate != None )
	{


		for( Index = 0; Index < EquipmentTemplate.UIStatMarkups.Length; ++Index )
		{
			ShouldStatDisplayFn = EquipmentTemplate.UIStatMarkups[Index].ShouldStatDisplayFn;
			if (ShouldStatDisplayFn != None && !ShouldStatDisplayFn())
			{
				continue;
			}

			if( EquipmentTemplate.UIStatMarkups[Index].StatModifier != 0 || EquipmentTemplate.UIStatMarkups[Index].bForceShow )
			{
				// Start with the value from the stat markup
				Item.Label = EquipmentTemplate.UIStatMarkups[Index].StatLabel;
				Item.Value = string(EquipmentTemplate.UIStatMarkups[Index].StatModifier);

				Stats.AddItem(Item);
			}
		}
	}

	return Stats; 
}


simulated function bool PopulateWeaponStat(int Value, bool bIsStatModified, int UpgradeValue, out UISummary_ItemStat Item, optional bool bIsPercent)
{
	if (Value > 0)
	{
		if (bIsStatModified)
		{
			Item.Value = AddStatModifier(false, "", UpgradeValue, eUIState_Good, "", true);
			Item.Value $= string(Value) $ (bIsPercent ? "%" : "");
		}
		else
		{
			Item.Value = string(Value) $ (bIsPercent ? "%" : "");
		}
		return true;
	}
	else if (bIsStatModified)
	{
		Item.Value = AddStatModifier(false, "", UpgradeValue, eUIState_Good, (bIsPercent ? "%" : ""), false);
		return true;
	}

	return false;
}

simulated function string AddStatModifier(bool bAddCommaSeparator, string Label, int Value, optional int ColorState = eUIState_Normal, optional string PostFix, optional bool bSymbolOnRight)
{
	local string Result;
	if(bAddCommaSeparator) Result $= ", ";
	Result $= Label;
	if(bSymbolOnRight)
		Result @= Value $ (Value >= 0 ? "+" : "");	//Issue #1101 - Weapon Upgrade with negative stat modifier shows as "--x"
	else
		Result @= (Value >= 0 ? "+" : "") $ Value;	//Issue #1101 - Weapon Upgrade with negative stat modifier shows as "--x"
	Result = class'UIUtilities_Text'.static.GetColoredText(Result $ PostFix, ColorState);
	Result = class'UIUtilities_Text'.static.FormatCommaSeparatedNouns(Result);
	return Result;
}

// Issue #237 start
simulated function string AddStatModifierSpread(bool bAddCommaSeparator, string Label, int FirstValue, int SecondValue, optional int ColorState = eUIState_Normal, optional string PostFix, optional bool bSymbolOnRight)
{
	local string Result;
	local bool bFirstValueNegative;

	if (FirstValue < 0)
	{
		bFirstValueNegative = true;
	}
	if(bAddCommaSeparator)
	{
		Result $= ", ";
	}

	// Second value will always be greater than first value, so if the first value is positive, we don't need to check the second.
	Result $= Label;
	if(bSymbolOnRight)
	{
		Result @= FirstValue $ (bFirstValueNegative ? "-" : "+") $ "-" $ SecondValue $ (bFirstValueNegative && (SecondValue < 0)) ? "-" : "+";
	}
	else
	{
		Result @= (bFirstValueNegative ? "-" : "+") $ FirstValue $ "-" $ SecondValue;
	}

	Result = class'UIUtilities_Text'.static.GetColoredText(Result $ PostFix, ColorState);
	Result = class'UIUtilities_Text'.static.FormatCommaSeparatedNouns(Result);
	return Result;
}


simulated function OnStatListSizeRealized()
{
	OnAbilityListSizeRealized();
}

simulated function OnAbilityListSizeRealized()
{
	AbilityItemList.SetY(0);
	AbilityItemList.RealizeLocation();

	OnTacticalListSizeRealized();
}


simulated function OnTacticalListSizeRealized()
{
	TacticalItemList.SetY(AbilityItemList.Height);
	TacticalItemList.RealizeLocation();

	ResetScroll();
}

simulated function ResetScroll()
{
	local int TacticalStartY, TacticalTextHeight;

	TacticalArea.ClearScroll();

	TacticalStartY = StatArea.Y + StatListBasic.Height + PADDING_BOTTOM;
	TacticalArea.SetY(TacticalStartY - 5);
	TacticalMask.SetY(TacticalStartY - 5);

	TacticalArea.MC.SetNum("_alpha", 100);

	TacticalTextHeight = Height - TacticalMask.Y - PADDING_BOTTOM;
	TacticalMask.SetHeight(TacticalTextHeight);
	TacticalArea.Height = AbilityItemList.Height + TacticalItemList.Height;
	TacticalArea.AnimateScroll(TacticalArea.Height, TacticalMask.Height);
}
simulated function array<UISummary_ItemStat> AddUpgradeHeader( array<UISummary_ItemStat> Stats )
{
	local UISummary_ItemStat Item; 
	
	if( Stats.length > 0 )
	{
		Item.Label = class'XLocalizedData'.default.UpgradesHeader; 
		Item.Value = " "; //Sending in a space, so it doesn't format as a subheader. 
		Stats.InsertItem(0, Item); 
	}

	return Stats;
}

simulated function Remove()
{
	super.Remove();
}


//Defaults: ------------------------------------------------------------------------------
defaultproperties
{
	height = 524;

	PADDING_LEFT	= 14;
	PADDING_RIGHT	= 14;
	PADDING_TOP		= 10;
	PADDING_BOTTOM	= 10;

	BasicWidth		= 292; 
	UpgradeWidth	= 292;  

	bFollowMouse = false;
	bUsePartialPath = true;
}