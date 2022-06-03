//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_UniversalSoldierAbilities.uc
//  AUTHOR:  Grobobobo
//  PURPOSE: Defines shared abilities that are available on all XCOM soldiers
//---------------------------------------------------------------------------------------

class X2Ability_UniversalSoldierAbilities extends X2Ability_DefaultAbilitySet config (LW_SoldierSkills);

var config int GETUP_DISORIENT_CHANCE;
var config float STOCKSTRIKE_MAXHPDAMAGE;
var config int REBEL_HP_UPGRADE_T1_AMOUNT;
var config int REBEL_HP_UPGRADE_T2_AMOUNT;
var config int QUICK_RELOAD_COOLDOWN;
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	`LWTrace("  >> X2Ability_PerkPackAbilitySet.UniversalSoldierAbilities()");
	Templates.AddItem(CreateStockStrike());
	Templates.AddItem(CreateGetUp());
	Templates.AddItem(AddRebelHPUpgrade('RebelHPUpgrade_T1', default.REBEL_HP_UPGRADE_T1_AMOUNT));
	Templates.AddItem(AddRebelHPUpgrade('RebelHPUpgrade_T2', default.REBEL_HP_UPGRADE_T2_AMOUNT));
	Templates.AddItem(AddRebelGrenadeUpgrade());
	Templates.AddItem(QuickReloadAbility());
	Templates.AddItem(AddReinforcedUnderlay2());
	Templates.AddItem(AddReinforcedUnderlay1());
	Templates.AddItem(AddHunkerDownAbilityNoAnim());
	Templates.AddItem(AddReloadnoAnimAbility());
	Templates.AddItem(OutOfAmmoFlyover());
	Templates.AddItem(AmmoTextStatus());
	
	return Templates;
}

static function X2AbilityTemplate CreateStockStrike()
{
	local X2AbilityTemplate						Template;
	local X2AbilityCost_ActionPoints			ActionPointCost;
	local X2Condition_UnitProperty				AdjacencyCondition;	
	local X2Condition_TargetHasOneOfTheEffects	NeedOneOfTheEffects;
	local X2Effect_Stunned						StunnedEffect;
	local X2Effect_StockStrikeDamage			DamageEffect;
	local array<name> SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MC_Stock_Strike');

	Template.AbilitySourceName = 'eAbilitySource_Commander';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_coupdegrace";
	Template.DisplayTargetHitChance = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.MUST_RELOAD_PRIORITY;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityTargetStyle = default.SimpleSingleMeleeTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	NeedOneOfTheEffects=new class'X2Condition_TargetHasOneOfTheEffects';
	NeedOneOfTheEffects.EffectNames.AddItem(class'X2Effect_MindControl'.default.EffectName);
	Template.AbilityTargetConditions.AddItem(NeedOneOfTheEffects);

	// Target Conditions
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);

	AdjacencyCondition = new class'X2Condition_UnitProperty';
	AdjacencyCondition.RequireWithinRange = true;
	AdjacencyCondition.WithinRange = 144; //1.5 tiles in Unreal units, allows attacks on the diag
	AdjacencyCondition.ExcludeCivilian = true;
	AdjacencyCondition.ExcludeFriendlyToSource = true;
	Template.AbilityTargetConditions.AddItem(AdjacencyCondition);

	// Shooter Conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName); //okay when disoriented
	Template.AddShooterEffectExclusions(SkipExclusions);
	
	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, 100, false);
	Template.AddTargetEffect(StunnedEffect);
	
	DamageEffect = new class'X2Effect_StockStrikeDamage';
	DamageEffect.Stockstrike_MaxHpDamage = default.STOCKSTRIKE_MAXHPDAMAGE;
	Template.AddTargetEffect(DamageEffect);

	Template.CustomFireAnim = 'FF_Melee';

	Template.CinescriptCameraType = "Ranger_Reaper";
	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;

	return Template;
}

static function X2AbilityTemplate CreateGetUp()
{
	local X2AbilityTemplate				Template;
	local X2Condition_UnitProperty		TargetCondition;
	local X2Condition_UnitEffects		EffectsCondition;
	local X2Effect_RemoveEffects		RemoveEffects;
	local X2Effect_Persistent			DisorientedEffect;
	local X2AbilityCost_ActionPoints	ActionPointCost;
	local array<name> SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GetUp');

	Template.AbilitySourceName = 'eAbilitySource_Commander';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_chosenrevive";
	Template.DisplayTargetHitChance = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.MUST_RELOAD_PRIORITY;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_Single';

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 2;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Shooter Condition
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	TargetCondition = new class'X2Condition_UnitProperty';
	TargetCondition.ExcludeDead = false;
	TargetCondition.ExcludeAlive = false;
	TargetCondition.ExcludeHostileToSource = true;
	TargetCondition.ExcludeFriendlyToSource = false;
	TargetCondition.ExcludeCivilian=true;
	TargetCondition.FailOnNonUnits = true;
	TargetCondition.RequireWithinRange = true;
	TargetCondition.WithinRange = class 'X2Ability_DefaultAbilitySet'.default.REVIVE_RANGE_UNITS;
	Template.AbilityTargetConditions.AddItem(TargetCondition);

	EffectsCondition = new class'X2Condition_UnitEffects';
	EffectsCondition.AddRequireEffect(class'X2StatusEffects'.default.UnconsciousName, 'AA_MissingRequiredEffect');
	EffectsCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.BeingCarriedEffectName, 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(EffectsCondition);

	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2StatusEffects'.default.UnconsciousName);
	Template.AddTargetEffect(RemoveEffects);

	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect(, , false);
	DisorientedEffect.bRemoveWhenSourceDies = false;
	DisorientedEffect.ApplyChance = default.GETUP_DISORIENT_CHANCE;
	Template.AddTargetEffect(DisorientedEffect);

	Template.ActivationSpeech = 'HealingAlly';

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.bShowPostActivation = true;
//BEGIN AUTOGENERATED CODE: Template Overrides 'Revive'
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.CustomFireAnim = 'HL_Revive';
//END AUTOGENERATED CODE: Template Overrides 'Revive'

	return Template;
}


static function X2AbilityTemplate AddRebelHPUpgrade(name TemplateName, int HPamount)
{
	local X2AbilityTemplate						Template;
	local X2Effect_PersistentStatChange			StatEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest";
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	Template.Hostility = eHostility_Neutral;
	Template.AbilitySourceName = 'eAbilitySource_Perk';

	StatEffect = new class'X2Effect_PersistentStatChange';
	StatEffect.AddPersistentStatChange(eStat_HP, float(HPamount));
	StatEffect.BuildPersistentEffect(1, true, false, false);
	StatEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(StatEffect);
	Template.bCrossClassEligible = false;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, eStat_HP, HPamount);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate AddRebelGrenadeUpgrade()
{
	local X2AbilityTemplate						Template;
	local X2Effect_TemporaryItem				TemporaryItemEffect;
	local X2AbilityTrigger_UnitPostBeginPlay	Trigger;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'RebelGrenadeUpgrade');

	Template.IconImage = "img:///UILibrary_LW_PerkPack.LW_AbilityDenseSmoke";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bIsPassive = true;
	Template.bCrossClassEligible = true;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Trigger.Priority -= 40; // delayed so that any other abilities that add items happen first
	Template.AbilityTriggers.AddItem(Trigger);

	TemporaryItemEffect = new class'X2Effect_TemporaryItem';
	TemporaryItemEffect.EffectName = 'MagGrenadeEffect';
	TemporaryItemEffect.ItemName = 'MagGrenade_LW';
	TemporaryItemEffect.bReplaceExistingItemOnly = true;
	TemporaryItemEffect.ExistingItemName = 'FragGrenade';
	TemporaryItemEffect.ForceCheckAbilities.AddItem('LaunchGrenade');
	TemporaryItemEffect.bIgnoreItemEquipRestrictions = true;
	TemporaryItemEffect.BuildPersistentEffect(1, true, false);
	//TemporaryItemEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	TemporaryItemEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(TemporaryItemEffect);

	TemporaryItemEffect = new class'X2Effect_TemporaryItem';
	TemporaryItemEffect.EffectName = 'PlasmaGrenadeEffect';
	TemporaryItemEffect.ItemName = 'PlasmaGrenade';
	TemporaryItemEffect.bReplaceExistingItemOnly = true;
	TemporaryItemEffect.ExistingItemName = 'MagGrenade_LW';
	TemporaryItemEffect.ForceCheckAbilities.AddItem('LaunchGrenade');
	TemporaryItemEffect.bIgnoreItemEquipRestrictions = true;
	TemporaryItemEffect.BuildPersistentEffect(1, true, false);
	//TemporaryItemEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	TemporaryItemEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(TemporaryItemEffect);

	TemporaryItemEffect = new class'X2Effect_TemporaryItem';
	TemporaryItemEffect.EffectName = 'SmokeBombEffect';
	TemporaryItemEffect.ItemName = 'SmokeGrenadeMk2';
	TemporaryItemEffect.bReplaceExistingItemOnly = true;
	TemporaryItemEffect.ExistingItemName = 'SmokeGrenade';
	TemporaryItemEffect.ForceCheckAbilities.AddItem('LaunchGrenade');
	TemporaryItemEffect.bIgnoreItemEquipRestrictions = true;
	TemporaryItemEffect.BuildPersistentEffect(1, true, false);
	//TemporaryItemEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	TemporaryItemEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(TemporaryItemEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate QuickReloadAbility()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Condition_UnitProperty          ShooterPropertyCondition;
	local X2Condition_AbilitySourceWeapon   WeaponCondition;
	local X2AbilityTrigger_PlayerInput      InputTrigger;
	local array<name>                       SkipExclusions;
	local X2AbilityCooldown					Cooldown;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'QuickReload');

	Template.bDontDisplayInAbilitySummary = true;
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;	
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.QUICK_RELOAD_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	ShooterPropertyCondition = new class'X2Condition_UnitProperty';
	ShooterPropertyCondition.ExcludeDead = true;                    //Can't reload while dead
	Template.AbilityShooterConditions.AddItem(ShooterPropertyCondition);
	WeaponCondition = new class'X2Condition_AbilitySourceWeapon';
	WeaponCondition.WantsReload = true;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);
	Template.DefaultKeyBinding = class'UIUtilities_Input'.const.FXS_KEY_R;

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityTargetStyle = default.SelfTarget;

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_reload";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.RELOAD_PRIORITY;
	Template.bNoConfirmationWithHotKey = true;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;

	Template.ActivationSpeech = 'Reloading';

	Template.BuildNewGameStateFn = ReloadAbility_LW_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_DefaultAbilitySet'.static.ReloadAbility_BuildVisualization;


	Template.Hostility = eHostility_Neutral;

	Template.CinescriptCameraType="GenericAccentCam";

	return Template;
}

simulated function XComGameState ReloadAbility_LW_BuildGameState(XComGameStateContext Context)
{
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Ability AbilityState;
	local XComGameState_Item WeaponState, NewWeaponState;
	local array<X2WeaponUpgradeTemplate> WeaponUpgrades;
	local bool bFreeReload;
	local int i;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);	
	AbilityContext = XComGameStateContext_Ability(Context);	
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID( AbilityContext.InputContext.AbilityRef.ObjectID ));

	WeaponState = AbilityState.GetSourceWeapon();
	NewWeaponState = XComGameState_Item(NewGameState.ModifyStateObject(class'XComGameState_Item', WeaponState.ObjectID));

	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));	

	//  check for free reload upgrade
	bFreeReload = false;
	WeaponUpgrades = WeaponState.GetMyWeaponUpgradeTemplates();
	for (i = 0; i < WeaponUpgrades.Length; ++i)
	{
		if (WeaponUpgrades[i].FreeReloadCostFn != none && WeaponUpgrades[i].FreeReloadCostFn(WeaponUpgrades[i], AbilityState, UnitState))
		{
			bFreeReload = true;
			break;
		}
	}
	if (!bFreeReload)
		AbilityState.GetMyTemplate().ApplyCost(AbilityContext, AbilityState, UnitState, NewWeaponState, NewGameState);	

	//  refill the weapon's ammo	
	NewWeaponState.Ammo += 2;
	
	return NewGameState;	
}



static function X2AbilityTemplate AddReinforcedUnderlay1()
{
	local X2AbilityTemplate						Template;
	local X2AbilityTargetStyle                  TargetStyle;
	local X2AbilityTrigger						Trigger;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ReinforcedUnderlay1');

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ShieldHP, 1);
	Template.AddTargetEffect(PersistentStatChangeEffect);
	Template.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, 1);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}

	static function X2AbilityTemplate AddReinforcedUnderlay2()
{
	local X2AbilityTemplate						Template;
	local X2AbilityTargetStyle                  TargetStyle;
	local X2AbilityTrigger						Trigger;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ReinforcedUnderlay2');

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ShieldHP, 1);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, 1);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//  NOTE: No visualization on purpose!

	return Template;
}


static function X2AbilityTemplate AddHunkerDownAbilityNoAnim(name TemplateName = 'HunkerDownNoAnim')
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Condition_UnitProperty          PropertyCondition;
	local X2Effect_PersistentStatChange     PersistentStatChangeEffect;
	local X2AbilityTrigger_PlayerInput      InputTrigger;
	local array<name>                       SkipExclusions;
	local X2Effect_RemoveEffects			RemoveEffects;
	
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_takecover";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.HUNKER_DOWN_PRIORITY;
	Template.bDisplayInUITooltip = false;

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = HunkerDownAbility_BuildVisualization;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bConsumeAllPoints = true;
	ActionPointCost.AllowedTypes.AddItem(class'X2CharacterTemplateManager'.default.DeepCoverActionPoint);
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	PropertyCondition = new class'X2Condition_UnitProperty';	
	PropertyCondition.ExcludeDead = true;                           // Can't hunkerdown while dead
	PropertyCondition.ExcludeFriendlyToSource = false;              // Self targeted
	PropertyCondition.ExcludeNoCover = true;                        // Unit must be in cover.
	Template.AbilityShooterConditions.AddItem(PropertyCondition);

	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	Template.AddShooterEffectExclusions(SkipExclusions);
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	Template.AbilityTargetStyle = default.SelfTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.EffectName = 'HunkerDownNoAnim';
	PersistentStatChangeEffect.BuildPersistentEffect(1 /* Turns */,,,,eGameRule_PlayerTurnBegin);
	PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Dodge, default.HUNKERDOWN_DODGE);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Defense, default.HUNKERDOWN_DEFENSE);
	PersistentStatChangeEffect.DuplicateResponse = eDupe_Refresh;
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.AddTargetEffect(class'X2Ability_SharpshooterAbilitySet'.static.SharpshooterAimEffect());

	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddTargetEffect(RemoveEffects);

	Template.CustomFireAnim = 'HL_Idle';
	Template.CustomSelfFireAnim = 'HL_Idle';

	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.NonAggressiveChosenActivationIncreasePerUse;

	Template.Hostility = eHostility_Defensive;
	Template.OverrideAbilityAvailabilityFn = HunkerDown_OverrideAbilityAvailability;
	Template.ConcealmentRule = eConceal_AlwaysEvenWithObjective;

	Template.bDontDisplayInAbilitySummary = true;

	return Template;
}

static function X2AbilityTemplate AddReloadnoAnimAbility(name TemplateName = 'ReloadNoAnim')
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Condition_UnitProperty          ShooterPropertyCondition;
	local X2Condition_AbilitySourceWeapon   WeaponCondition;
	local X2AbilityTrigger_PlayerInput      InputTrigger;
	local array<name>                       SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	Template.bDontDisplayInAbilitySummary = true;
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	ShooterPropertyCondition = new class'X2Condition_UnitProperty';	
	ShooterPropertyCondition.ExcludeDead = true;                    //Can't reload while dead
	Template.AbilityShooterConditions.AddItem(ShooterPropertyCondition);
	WeaponCondition = new class'X2Condition_AbilitySourceWeapon';
	WeaponCondition.WantsReload = true;
	Template.AbilityShooterConditions.AddItem(WeaponCondition);
	Template.DefaultKeyBinding = class'UIUtilities_Input'.const.FXS_KEY_R;

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	Template.AbilityToHitCalc = default.DeadEye;
	
	Template.AbilityTargetStyle = default.SelfTarget;
	
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_reload";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.RELOAD_PRIORITY;
	Template.bNoConfirmationWithHotKey = true;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;
	Template.bShowActivation = true;
	Template.bSkipFireAction = true;

	//Template.ActivationSpeech = 'Reloading';

	Template.BuildNewGameStateFn = ReloadAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.Hostility = eHostility_Neutral;

	Template.CinescriptCameraType = "GenericAccentCam";
	Template.OverrideAbilityAvailabilityFn = Reload_OverrideAbilityAvailability;

	return Template;	
}

function Reload_OverrideAbilityAvailability(out AvailableAction Action, XComGameState_Ability AbilityState, XComGameState_Unit OwnerState)
{
	if (Action.AvailableCode == 'AA_Success')
	{
		if (AbilityState.GetSourceWeapon().Ammo == 0)
			Action.ShotHUDPriority = class'UIUtilities_Tactical'.const.MUST_RELOAD_PRIORITY;
	}
}

simulated function XComGameState ReloadAbility_BuildGameState( XComGameStateContext Context )
{
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Ability AbilityState;
	local XComGameState_Item WeaponState, NewWeaponState;
	local array<X2WeaponUpgradeTemplate> WeaponUpgrades;
	local bool bFreeReload;
	local int i;

	NewGameState = `XCOMHISTORY.CreateNewGameState(true, Context);	
	AbilityContext = XComGameStateContext_Ability(Context);	
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID( AbilityContext.InputContext.AbilityRef.ObjectID ));

	WeaponState = AbilityState.GetSourceWeapon();
	NewWeaponState = XComGameState_Item(NewGameState.ModifyStateObject(class'XComGameState_Item', WeaponState.ObjectID));

	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));	

	//  check for free reload upgrade
	bFreeReload = false;
	WeaponUpgrades = WeaponState.GetMyWeaponUpgradeTemplates();
	for (i = 0; i < WeaponUpgrades.Length; ++i)
	{
		if (WeaponUpgrades[i].FreeReloadCostFn != none && WeaponUpgrades[i].FreeReloadCostFn(WeaponUpgrades[i], AbilityState, UnitState))
		{
			bFreeReload = true;
			break;
		}
	}
	if (!bFreeReload)
		AbilityState.GetMyTemplate().ApplyCost(AbilityContext, AbilityState, UnitState, NewWeaponState, NewGameState);	

	//  refill the weapon's ammo	
	NewWeaponState.Ammo = NewWeaponState.GetClipSize();
	
	return NewGameState;	
}

static function X2AbilityTemplate OutOfAmmoFlyover()
{
	local X2AbilityTemplate					Template;
	//local X2Effect_Persistent				AmmoEffect;
	//local X2Effect_RemoveEffects			RemoveEffect;
	local X2AbilityTrigger_EventListener	EventListener;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'OutOfAmmoFlyover');
	Template.IconImage = "img:///UILibrary_XPerkIconPack_LW.UIPerk_ammo_box";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowActivation = false;
	Template.bShowPostActivation = true;
	Template.bSkipFireAction = true;
	//Template.bIsPassive = true;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'AbilityActivated';
	EventListener.ListenerData.EventFn = AbilityTriggerEventListener_OutOfAmmo;
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.Priority = 40;
	Template.AbilityTriggers.AddItem(EventListener);

	// UnitValueEffect = new class'X2Effect_SetUnitValue';
	// UnitValueEffect.UnitName = 'QuickRetreatTimes';
	// UnitValueEffect.CleanupType = eCleanup_BeginTurn;
	// UnitValueEffect.NewValueToSet = 1;
	// Template.AddTargetEffect(UnitValueEffect);


	// UnitValue = new class'X2Condition_UnitValue';
	// UnitValue.AddCheckValue('QuickRetreatTimes', 1, eCheck_LessThan);
	// Template.AbilityTargetConditions.AddItem(UnitValue);


	Template.bCrossClassEligible = false;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;
	//Template.AdditionalAbilities.AddItem('AmmoTextStatus');

	return Template;
}




static function EventListenerReturn AbilityTriggerEventListener_OutOfAmmo(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name EventID,
	Object CallbackData)
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Unit SourceUnit;
	local XComGameState_Ability AbilityState,TextAbilityState;
	local XComGameState_Item	PrimaryWeaponState;
	local XComGameStateHistory History;
	local X2AbilityTemplate AbilityTemplate;
	local X2AbilityCost Cost;

	AbilityState = XComGameState_Ability(EventData);
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	if (AbilityContext != none && AbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt && AbilityState.GetMyTemplate().Hostility == eHostility_Offensive)
	{
		SourceUnit = XComGameState_Unit(GameState.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
		TextAbilityState = XComGameState_Ability(History.GetGameStateForObjectID(SourceUnit.FindAbility('OutOfAmmoFlyover', AbilityContext.InputContext.ItemObject).ObjectID));
		
		if (TextAbilityState != none)
		{
			if(AbilityContext.InputContext.SourceObject.ObjectID == TextAbilityState.OwnerStateObject.ObjectID)
			{
				PrimaryWeaponState = TextAbilityState.GetSourceWeapon();
				if(PrimaryWeaponState != none)
				{
					if(PrimaryWeaponState.InventorySlot == eInvSlot_PrimaryWeapon &&
					SourceUnit.GetTeam() != eTeam_XCOM &&
					PrimaryWeaponState.Ammo == 0)
					{
						//Check if the ability state costs ammo, so using it caused the unit to be out of ammo
						AbilityTemplate = AbilityState.GetMyTemplate();
						foreach AbilityTemplate.AbilityCosts(Cost)
						{
							if(X2AbilityCost_Ammo(Cost) != none)
							{
								if(X2AbilityCost_Ammo(Cost).iAmmo > 0)
								{
									TextAbilityState.AbilityTriggerEventListener_Self(EventData, EventSource, GameState, EventID, CallbackData);
									break;
								}
							}
						}

					}
				}
			}


		}
	}
	return ELR_NoInterrupt;
 
}

static function X2AbilityTemplate AmmoTextStatus()
{
	local X2AbilityTemplate					Template;
	local X2Effect_Persistent				AmmoEffect;
	local X2Effect_RemoveEffects			RemoveEffect;
	local X2AbilityTrigger_EventListener	EventListener;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AmmoTextStatus');
	Template.IconImage = "img:///UILibrary_XPerkIconPack_LW.UIPerk_ammo_box";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowActivation = false;
	Template.bShowPostActivation = false;
	//Template.bShowPostActivation = true;
	Template.bSkipFireAction = true;
	//Template.bIsPassive = true;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'AbilityActivated';
	EventListener.ListenerData.EventFn = AbilityTriggerEventListener_AmmoState;
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.Priority = 40;
	Template.AbilityTriggers.AddItem(EventListener);

	RemoveEffect = new class'X2Effect_RemoveEffects';
	RemoveEffect.EffectNamesToRemove.AddItem('AmmoStateEffect');
	Template.AddTargetEffect(RemoveEffect);

	AmmoEffect = new class'X2Effect_Persistent';
	AmmoEffect.BuildPersistentEffect(1, true, false, false);
	AmmoEffect.EffectName = 'AmmoStateEffect';
	AmmoEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,, Template.AbilitySourceName);
	AmmoEffect.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(AmmoEffect);

	Template.bCrossClassEligible = false;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.DefaultSourceItemSlot = eInvSlot_PrimaryWeapon;

	return Template;
}

static function EventListenerReturn AbilityTriggerEventListener_AmmoState(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name EventID,
	Object CallbackData)
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Unit SourceUnit;
	local XComGameState_Ability AbilityState,TextAbilityState;
	local XComGameState_Item	PrimaryWeaponState;
	local XComGameStateHistory History;
	local X2AbilityTemplate AbilityTemplate;

	AbilityState = XComGameState_Ability(EventData);
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	if (AbilityContext != none && AbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt && AbilityState.GetMyTemplate().Hostility == eHostility_Offensive)
	{
		SourceUnit = XComGameState_Unit(GameState.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
		TextAbilityState = XComGameState_Ability(History.GetGameStateForObjectID(SourceUnit.FindAbility('AmmoTextStatus', AbilityContext.InputContext.ItemObject).ObjectID));
		
		if (TextAbilityState != none)
		{
			PrimaryWeaponState = TextAbilityState.GetSourceWeapon();
			if(PrimaryWeaponState != none)
			{
				if(SourceUnit.GetTeam() != eTeam_XCOM)
				{
					TextAbilityState.AbilityTriggerEventListener_Self(EventData, EventSource, GameState, EventID, CallbackData);
				}
			}
		}
	}
	return ELR_NoInterrupt;
 
}
