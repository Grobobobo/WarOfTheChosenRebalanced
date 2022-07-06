//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_SkirmisherAbilitySet_LW.uc
//  AUTHOR:  martox
//  PURPOSE: New Skirmisher abilities for LWOTC.
//---------------------------------------------------------------------------------------
class X2Ability_SkirmisherAbilitySet_LW extends X2Ability_SkirmisherAbilitySet config(LW_FactionBalance);

var config int RECKONING_LW_COOLDOWN;
var config int RECKONING_LW_SLASH_COOLDOWN;
var config int MANUAL_OVERRIDE_COOLDOWN;
var config int REFLEX_COOLDOWN;
var config int SKIRMISHER_INTERRUPT_COOLDOWN;
var config int BATTLEFIELD_AWARENESS_COOLDOWN;

var config int				HEATSINK_MAX_CHARGES;
var config int				HEATSINK_LOSE_PER_TURN;
var config int				HEATSINK_LOSE_PER_GRAPPLE;
var config float			HEATSINK_LOSS_CHANCE_PER_LEVEL;
var config int				HEATSINK_GAIN_DIRECT_SHOT;
var config int				HEATSINK_GAIN_REACTION_SHOT;

//var config array<name>		HEATSINK_CONSUME_GRAPPLE_ABILITIES;
//var config array<name>		HEATSINK_UPDATE_GRAPPLE_ABILITIES;

// var config int				HEATSINK_DAMAGE_BONUS;
// var config int				HEATSINK_DAMAGE_BONUS_CHARGE_DIVISOR;
var config float			HEATSINK_CRIT_CHANCE_BONUS;
var config float			HEATSINK_AIM_BONUS;

var name					HEATSINK_CURRENT_NAME;
var name					HEATSINK_MAX_NAME;

var localized string		strHeatsink1Name;
var localized string		strHeatsink1Desc;
var localized string		strHeatsink2Name;
var localized string		strHeatsink2Desc;
var localized string		strHeatsink3Name;
var localized string		strHeatsink3Desc;

var localized string		strHeatLevelName;
var localized string		strHeatLevelDesc;

// Ability Variables
var config int				FIRE_FURY_MOBILITY_BONUS;
var config int				FIRE_FURY_MOBILITY_BONUS_CHARGE_DIVISOR;
var config int				OVERCLOCKING_MAX_HEAT_BONUS;
var config int				HEAT_LEVEL_THRESHOLD_I;
var config int				HEAT_LEVEL_THRESHOLD_II;
var config int				HEAT_LEVEL_THRESHOLD_III;
var config float			THERMAL_REGULATORS_RETAIN_HEAT_CHANCE_I;
var config float			THERMAL_REGULATORS_RETAIN_HEAT_CHANCE_II;
var config float			THERMAL_REGULATORS_RETAIN_HEAT_CHANCE_III;

var config int RIP_AND_TEAR_RUPTURE;
var config float HEATSINK_LOSS_ON_DAMAGE;
var config float BATTLEFIELD_AWARENESS_DODGE_PER_HEAT;

var config array<name> HEATSINK_CONSUME_GRAPPLE_ABILITIES;
var config float RECKONING_BONUS_DAMAGE_PER_HEAT;


var config int COMBAT_PRESENCE_COOLDOWN_REDUCTION_DIVISOR;
var config int MANUAL_OVERRIDE_COOLDOWN_REDUCTION_DIVISOR;



static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates; 

	Templates.AddItem(AddBattlemaster());
	//from Alterd-Rushnano
	Templates.AddItem(AddSkirmisherFleche());
	Templates.AddItem(AddSkirmisherSlash());
	Templates.AddItem(AddReckoning_LW());
	Templates.AddItem(AddManualOverride_LW());
	Templates.AddItem(AddReflexTrigger());
	Templates.AddItem(AddParkour());
	Templates.AddItem(AddPackMaster());
	Templates.AddItem(Interrupt_LW());
	Templates.AddItem(BattlefieldAwareness());
	Templates.AddItem(BattlefieldAwarenessPassive());
	Templates.AddItem(BattlefieldAwarenessCooldown());

	Templates.AddItem(BattlefieldAwareness2());

	Templates.AddItem(Heatsink_LW());
	Templates.AddItem(FireAndFury_LW());
	Templates.AddItem(ThermalRegulators_LW());
	Templates.AddItem(Ignite_LW());
	Templates.AddItem(OverClocking_LW());
	Templates.AddItem(RipAndTear_LW());

	return Templates;
}

static function X2AbilityTemplate AddBattlemaster()
{
	local X2AbilityTemplate       Template;

	Template = PurePassive('Battlemaster', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Justice", false, 'eAbilitySource_Perk', false);
	Template.AdditionalAbilities.AddItem('Justice');
	Template.AdditionalAbilities.AddItem('SkirmisherVengeance');
	Template.bCrossClassEligible = false;
	return Template;
}

static function X2AbilityTemplate AddReckoning_LW()
{
	local X2AbilityTemplate	Template;

	Template = PurePassive('Reckoning_LW', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Reckoning");
	Template.AdditionalAbilities.AddItem('SkirmisherFleche');
	//Template.AdditionalAbilities.AddItem('SkirmisherSlash');

	return Template;
}

static function X2AbilityTemplate AddSkirmisherFleche()
{
	local X2AbilityTemplate				Template;
//	local X2AbilityCost_ActionPoints	ActionPointCost;
	local X2AbilityCooldown				Cooldown;
//	local int i;
	local X2AbilityTarget_MovingMelee	MeleeTarget;
	Template = class'X2Ability_RangerAbilitySet'.static.AddSwordSliceAbility('SkirmisherFleche');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Skirmisher_LW.perk_SkirmisherStrike";
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.CinescriptCameraType = "Skirmisher_Melee";
	
	// for (i = 0; i < Template.AbilityCosts.Length; ++i)
	// {
	// 	ActionPointCost = X2AbilityCost_ActionPoints(Template.AbilityCosts[i]);
	// 	if (ActionPointCost != none)
	// 		ActionPointCost.bConsumeAllPoints = false;
	// }
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.RECKONING_LW_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	MeleeTarget.MovementRangeAdjustment = 0;
	Template.AbilityTargetStyle = MeleeTarget;


	return Template;
}


static function X2AbilityTemplate AddSkirmisherSlash()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityToHitCalc_StandardMelee  StandardMelee;
	//local X2AbilityCooldown					Cooldown;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local array<name>                       SkipExclusions;
	local X2Condition_UnitProperty			AdjacencyCondition;	
	local X2AbilityCost_ActionPoints		ActionPointCost;
	`CREATE_X2ABILITY_TEMPLATE(Template, 'SkirmisherSlash');

	// Standard melee attack setup
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_swordSlash";
	Template.bHideOnClassUnlock = false;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_SQUADDIE_PRIORITY;
	Template.AbilityConfirmSound = "TacticalUI_SwordConfirm";
	Template.bCrossClassEligible = false;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.DisplayTargetHitChance = true;
	Template.bShowActivation = true;
	Template.bSkipFireAction = false;

	// Costs one action and doesn't end turn
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);


	/*
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.RECKONING_LW_SLASH_COOLDOWN;
	Template.AbilityCooldown = Cooldown;
	*/

	// Targetted melee attack against a single target
	StandardMelee = new class'X2AbilityToHitCalc_StandardMelee';
	Template.AbilityToHitCalc = StandardMelee;
	Template.AbilityTargetStyle = default.SimpleSingleMeleeTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Target must be alive and adjacent
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);
	AdjacencyCondition = new class'X2Condition_UnitProperty';
	AdjacencyCondition.RequireWithinRange = true;
	AdjacencyCondition.WithinRange = 144; //1.5 tiles in Unreal units, allows attacks on the diag
	Template.AbilityTargetConditions.AddItem(AdjacencyCondition);

	// Shooter Conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName); //okay when disoriented
	Template.AddShooterEffectExclusions(SkipExclusions);
	
	// Damage Effect
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);
	Template.bAllowBonusWeaponEffects = true;
	
	// VGamepliz matters
	Template.SourceMissSpeech = 'SwordMiss';
	Template.bSkipMoveStop = true;

	// Typical melee visualizations
	Template.CinescriptCameraType = "Ranger_Reaper";
	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	// Standard interactions with Shadow, Chosen, and the Lost
	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;

	return Template;
}

static function X2AbilityTemplate AddManualOverride_LW()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityCooldown					Cooldown;
	local X2Condition_UnitProperty      	TargetCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ManualOverride_LW');

	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_ManualOverride";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	TargetCondition = new class'X2Condition_UnitProperty';
	TargetCondition.ExcludeHostileToSource = true;
	TargetCondition.ExcludeFriendlyToSource = false;
	TargetCondition.RequireSquadmates = true;
	TargetCondition.FailOnNonUnits = true;
	TargetCondition.ExcludeDead = true;
	TargetCondition.ExcludeRobotic = false;
	TargetCondition.ExcludeUnableToAct = true;
	Template.AbilityTargetConditions.AddItem(TargetCondition);
	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	
	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.MANUAL_OVERRIDE_COOLDOWN;
	Template.AbilityCooldown = Cooldown;
	
	Template.AddTargetEffect(new class'X2Effect_ManualOverride_LW');

	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
//BEGIN AUTOGENERATED CODE: Template Overrides 'ManualOverride'
	Template.AbilityConfirmSound = "Manual_Override_Activate";
	Template.ActivationSpeech = 'ManualOverride';
//END AUTOGENERATED CODE: Template Overrides 'ManualOverride'

	return Template;
}

// Creates a new ability that triggers at the start of each turn, but
// only if Reflex triggered in the previous enemy turn. If that happens,
// the ability clears the unit value that Reflex uses to track how many
// times it has activated during the mission. This ability then goes on
// cooldown.
static function X2AbilityTemplate AddReflexTrigger()
{
	local X2AbilityTemplate					Template;
	local X2Effect_ResetReflex				ResetEffect;
	local X2Condition_UnitValue				ReflexTriggeredCondition;
	local X2AbilityTrigger_EventListener	EventListener;
	local X2AbilityCooldown					Cooldown;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'SkirmisherReflexTrigger');

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_standard";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.REFLEX_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'PlayerTurnBegun';
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	EventListener.ListenerData.Filter = eFilter_Player;
	Template.AbilityTriggers.AddItem(EventListener);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	ReflexTriggeredCondition = new class'X2Condition_UnitValue';
	ReflexTriggeredCondition.AddCheckValue(class'X2Effect_SkirmisherReflex'.default.TotalEarnedValue, 1.0);
	Template.AbilityShooterConditions.AddItem(ReflexTriggeredCondition);

	ResetEffect = new class'X2Effect_ResetReflex';
	// ResetEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
	// ResetEffect.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(ResetEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.bSkipFireAction = true;

	return Template;
}

// X2AbilityCooldown_Grapple checks for this ability
// Borrowed from NotSoLoneWolf
static function X2AbilityTemplate AddParkour()
{
	local X2AbilityTemplate Template;

	Template = PurePassive('Parkour_LW', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_parkour", false, 'eAbilitySource_Perk');
	Template.bCrossClassEligible = false;
	return Template;
}



//this ability grants the unit +1 charge for each Item in a utility slot AND the grenade slot
static function X2AbilityTemplate AddPackMaster()
{
	local X2AbilityTemplate						Template;
	local X2Effect_PackMaster_LW				FullKitEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'PackMaster_LW');
	Template.IconImage = "img:///UILibrary_LW_PerkPack.LW_AbilityFullKit";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	FullKitEffect = new class 'X2Effect_PackMaster_LW';
	FullKitEffect.BuildPersistentEffect (1, true, false);
	FullKitEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(FullKitEffect);
	Template.bCrossClassEligible = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate Interrupt_LW()
{
	local X2AbilityTemplate				Template;
	local X2AbilityCost_ActionPoints	ActionPointCost;
	local X2Effect_SkirmisherInterrupt_LW			BattlelordEffect;
	local X2Condition_UnitEffects	SuppressedCondition;
	local X2AbilityCooldown	Cooldown;
	`CREATE_X2ABILITY_TEMPLATE(Template, 'SkirmisherInterrupt_LW');

	
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_Interrupt";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.OVERWATCH_PRIORITY;
	Template.Hostility = eHostility_Neutral;

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.SKIRMISHER_INTERRUPT_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	ActionPointCost.AllowedTypes.RemoveItem(class'X2CharacterTemplateManager'.default.SkirmisherInterruptActionPoint);
	Template.AbilityCosts.AddItem(ActionPointCost);

	BattlelordEffect = new class'X2Effect_SkirmisherInterrupt_LW';
	BattlelordEffect.BuildPersistentEffect(1, false, , , eGameRule_PlayerTurnBegin);
	BattlelordEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true, , Template.AbilitySourceName);
	Template.AddTargetEffect(BattlelordEffect);

	SuppressedCondition = new class'X2Condition_UnitEffects';
	SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
	SuppressedCondition.AddExcludeEffect(class'X2Effect_SkirmisherInterrupt_LW'.default.EffectName, 'AA_AbilityUnavailable');
	SuppressedCondition.AddExcludeEffect(class'X2Effect_Battlelord'.default.EffectName, 'AA_AbilityUnavailable');
	Template.AbilityShooterConditions.AddItem(SuppressedCondition);


	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.AbilityConfirmSound = "Unreal2DSounds_OverWatch";

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.CinescriptCameraType = "Overwatch";

//BEGIN AUTOGENERATED CODE: Template Overrides 'Battlelord'
	Template.ActivationSpeech = 'Interrupt';
//END AUTOGENERATED CODE: Template Overrides 'Battlelord'

	return Template;
}

static function X2AbilityTemplate BattlefieldAwareness()
{
	local X2AbilityTemplate						Template;
	local X2AbilityTrigger_EventListener		EventListenerTrigger;
	local X2Effect_BattlefieldAwareness	Effect;
	local X2Condition_UnitEffects EffectsCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'BattlefieldAwareness');
//BEGIN AUTOGENERATED CODE: Template Overrides 'FullThrottle'
	Template.IconImage = "img:///UILibrary_XPerkIconPack_LW.UIPerk_panic_move";
//END AUTOGENERATED CODE: Template Overrides 'FullThrottle'
	Template.bShowActivation = true;
	EffectsCondition = new class'X2Condition_UnitEffects';
	EffectsCondition.AddExcludeEffect(class'X2Effect_BattlefieldAwarenessCooldown'.default.EffectName, 'AA_AbilityUnavailable');
	Template.AbilityShooterConditions.AddItem(EffectsCondition);


	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	
	EventListenerTrigger = new class'X2AbilityTrigger_EventListener';
	EventListenerTrigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListenerTrigger.ListenerData.EventID = 'KillMail';
	EventListenerTrigger.ListenerData.Filter = eFilter_Unit;
	EventListenerTrigger.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListenerTrigger);

	Effect = new class'X2Effect_BattlefieldAwareness';
	Effect.EffectName = 'BattlefieldAwareness';
	Effect.BuildPersistentEffect(1,false,true,,eGameRule_PlayerTurnBegin);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Effect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(Effect);

	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.AdditionalAbilities.AddItem('BattlefieldAwarenessPassive');
	Template.AdditionalAbilities.AddItem('BattlefieldAwarenessCooldown');
	

	return Template;
}



static function X2AbilityTemplate BattlefieldAwarenessPassive()
{
	local X2AbilityTemplate		Template;

	Template = PurePassive('BattlefieldAwarenessPassive', "img:///UILibrary_XPerkIconPack_LW.UIPerk_panic_move", , 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate BattlefieldAwareness2()
{
	local X2AbilityTemplate		Template;

	Template = PurePassive('BattlefieldAwareness2', "img:///UILibrary_XPerkIconPack_LW.UIPerk_panic_move", , 'eAbilitySource_Perk');

	return Template;
}

static function X2AbilityTemplate BattlefieldAwarenessCooldown()
{
	local X2AbilityTemplate						Template;
	local X2AbilityTrigger_EventListener		EventListenerTrigger;
	local X2Effect_BattlefieldAwarenessCooldown	BattlefieldAwarenessCooldown;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'BattlefieldAwarenessCooldown');
//BEGIN AUTOGENERATED CODE: Template Overrides 'FullThrottle'
	Template.IconImage = "img:///UILibrary_XPerkIconPack_LW.UIPerk_panic_move";
//END AUTOGENERATED CODE: Template Overrides 'FullThrottle'
	Template.bShowActivation = true;

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	
	EventListenerTrigger = new class'X2AbilityTrigger_EventListener';
	EventListenerTrigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListenerTrigger.ListenerData.EventID = 'BattlefieldAwarenessTriggered';
	EventListenerTrigger.ListenerData.Filter = eFilter_Unit;
	EventListenerTrigger.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListenerTrigger);

	BattlefieldAwarenessCooldown = new class 'X2Effect_BattlefieldAwarenessCooldown';
    BattlefieldAwarenessCooldown.BuildPersistentEffect(default.BATTLEFIELD_AWARENESS_COOLDOWN,false,true,,eGameRule_PlayerTurnEnd);
	BattlefieldAwarenessCooldown.SetDisplayInfo(ePerkBuff_Penalty, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(BattlefieldAwarenessCooldown);

	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


// Heatsink - Base Class Proficiency Ability
static function X2AbilityTemplate Heatsink_LW()
{
	
	local X2AbilityTemplate										Template;
	local X2Effect_SetUnitValue									SetMaxValue;
	local X2Effect_Persistent									HeatLossEffect, IconEffect3;
	local X2Effect_HeatListener_LW						HeatListenerEffect;
	
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'Heatsink_LW');
	Template.IconImage = "img:///UILibrary_WOTC_APA_Skirmisher_LW.perk_Heatsink";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
		

	// Set Maximum Heat Level
	SetMaxValue = new class'X2Effect_SetUnitValue';
	SetMaxValue.UnitName = default.HEATSINK_MAX_NAME;
	SetMaxValue.NewValueToSet = default.HEATSINK_MAX_CHARGES;
	SetMaxValue.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(SetMaxValue);
	

	// Persistent effect that handles removing Heat at the beginning of each turn
	HeatLossEffect = new class'X2Effect_Persistent';
	HeatLossEffect.BuildPersistentEffect(1, true, false, false, eGameRule_PlayerTurnBegin);
	HeatLossEffect.EffectTickedFn = Heatsink_TurnStartHeatLoss_EffectTicked;
	HeatLossEffect.EffectName = 'WOTC_APA_Heatsink_TurnStartHeatLoss';
	HeatLossEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(HeatLossEffect);


	// Persistent effect that handles adding Heat from primary weapon shots
	HeatListenerEffect = new class'X2Effect_HeatListener_LW';
	HeatListenerEffect.BuildPersistentEffect(1, true, false);
	HeatListenerEffect.EffectName = 'WOTC_APA_Heatsink_UpdateHeatListener';
	HeatListenerEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
	HeatListenerEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(HeatListenerEffect);


	IconEffect3 = new class'X2Effect_Persistent';
	IconEffect3.BuildPersistentEffect (1, true, false, false);
	IconEffect3.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), "img:///UILibrary_WOTC_APA_Skirmisher_LW.perk_Heatsink3", true,, Template.AbilitySourceName);
	Template.AddTargetEffect(IconEffect3);


	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// Remove [default: 1] Heat level on the PlayerTurnBegin tick each turn
function bool Heatsink_TurnStartHeatLoss_EffectTicked(X2Effect_Persistent PersistentEffect, const out EffectAppliedData ApplyEffectParameters, XComGameState_Effect kNewEffectState, XComGameState NewGameState, bool FirstApplication)
{
	local XComGameState_Unit									SourceUnit, NewSourceUnit;
	local UnitValue												CurrentHeat;
	local float													RandRoll, Chance;
	local int													HeatLoss;
	
	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.TargetStateObjectRef.ObjectID));
	if (SourceUnit != none)
	{
		SourceUnit.GetUnitValue(default.HEATSINK_CURRENT_NAME, CurrentHeat);
		if (CurrentHeat.fValue > 0)
		{
			Chance = default.HEATSINK_LOSS_CHANCE_PER_LEVEL;

			// Chance to prevent Heat loss is reduced if the unit has the Thermal Regulators ability
			if (SourceUnit.HasSoldierAbility('WOTC_APA_ThermalRegulators'))
			{
				if (CurrentHeat.fValue >= default.HEAT_LEVEL_THRESHOLD_I)
					Chance += default.THERMAL_REGULATORS_RETAIN_HEAT_CHANCE_I;

				if (CurrentHeat.fValue >= default.HEAT_LEVEL_THRESHOLD_II)
					Chance += default.THERMAL_REGULATORS_RETAIN_HEAT_CHANCE_II;

				if (CurrentHeat.fValue >= default.HEAT_LEVEL_THRESHOLD_III)
					Chance += default.THERMAL_REGULATORS_RETAIN_HEAT_CHANCE_III;
			}

			// Multiply by current Heat levels and roll to lose heat
			Chance *= CurrentHeat.fValue;

			// Loop for any chances greater than 100% to remove heat more than once
			while (Chance > 0)
			{
				if (Chance < 100)
				{
					RandRoll = `SYNC_RAND(100);
					if (RandRoll < Chance)
					{
						HeatLoss += default.HEATSINK_LOSE_PER_TURN;
					}
				}
				else
				{
					HeatLoss += default.HEATSINK_LOSE_PER_TURN;
				}
				
				Chance -= 100;
			}

			if (Heatloss == 0)
				return false;

			// Apply the Heat loss
			NewSourceUnit = XComGameState_Unit(NewGameState.ModifyStateObject(SourceUnit.Class, SourceUnit.ObjectID));
			NewSourceUnit.SetUnitFloatValue(default.HEATSINK_CURRENT_NAME, CurrentHeat.fValue - Heatloss, eCleanup_BeginTactical);
			
			// Trigger the updating of Heat effects if the unit has an ability that applies a conditional stat change based on Heat
			if (SourceUnit.HasSoldierAbility('FireAndFury_LW'))
			{
				`XEVENTMGR.TriggerEvent('WOTC_APA_Skirmisher_UpdateHeatEffects', NewSourceUnit, NewSourceUnit, NewGameState);
	}	}	}

	return false;	// do not end the effect
}



// // Reinforced Cabling - Passive: Reduces grapple abilities cooldowns and removes the shared cooldown among grapple abilities.
// static function X2AbilityTemplate WOTC_APA_ReinforcedCabling()
// {

// 	local X2AbilityTemplate			Template;

// 	Template = CreatePassiveAbility('WOTC_APA_ReinforcedCabling', "img:///UILibrary_WOTC_APA_Skirmisher_LW.perk_ReinforcedCabling", 'WOTC_APA_Skirmisher_NoSharedGrappleCooldownEffect');
	
// 	return Template;
// }


// Fire and Fury - Passive: Grants bonus mobility based on stored Heat. All stat changes are handled in the HeatListener effect.
static function X2AbilityTemplate FireAndFury_LW()
{

	local X2AbilityTemplate										Template;
//	local X2Effect_IncrementUnitValue							ModifyUnitValue;


	Template = CreatePassiveAbility('FireAndFury_LW', "img:///UILibrary_WOTC_APA_Skirmisher_LW.perk_FireAndFury");


	return Template;
}

static function X2AbilityTemplate OverClocking_LW()
{

	local X2AbilityTemplate										Template;
	local X2Effect_IncrementUnitValue							ModifyUnitValue;


	Template = CreatePassiveAbility('OverClocking_LW', "img:///UILibrary_WOTC_APA_Class_Pack_LW.perk_ExplosiveAction");
	

	// Setup increased max Heat level
	ModifyUnitValue = new class'X2Effect_IncrementUnitValue';
	ModifyUnitValue.UnitName = default.HEATSINK_MAX_NAME;
	ModifyUnitValue.NewValueToSet = default.OVERCLOCKING_MAX_HEAT_BONUS;
	ModifyUnitValue.CleanupType = eCleanup_BeginTactical;
	Template.AddTargetEffect(ModifyUnitValue);


	return Template;
}

static function X2AbilityTemplate Ignite_LW()
{

	local X2AbilityTemplate										Template;
	local array<name> SkipExclusions;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2Effect_Ignite_LW	ModifyUnitValue;

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template = CreateSelfActiveAbility('Ignite_LW', "img:///UILibrary_XPerkIconPack_LW.UIPerk_fire_blossom", false, SkipExclusions);
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bfreeCost = false;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Template.ActivationSpeech = 'Battlelord';
	Template.bSkipFireAction=true;

	// Setup increased max Heat level
	ModifyUnitValue = new class'X2Effect_Ignite_LW';
	Template.AddTargetEffect(ModifyUnitValue);


	return Template;
}


// Thermal Regulators Blades - Passive: 
static function X2AbilityTemplate ThermalRegulators_LW()
{

	local X2AbilityTemplate			Template;

	Template = CreatePassiveAbility('ThermalRegulators_LW', "img:///UILibrary_WOTC_APA_Skirmisher_LW.perk_ThermalRegulators");
	
	return Template;
}

// // Superheated Blades - Passive: 
// static function X2AbilityTemplate WOTC_APA_HeatedBlades()
// {

// 	local X2AbilityTemplate										Template;
// 	local X2Effect_WOTC_APA_HeatedBlades						PierceEffect;


// 	Template = CreatePassiveAbility('WOTC_APA_HeatedBlades', "img:///UILibrary_WOTC_APA_Skirmisher_LW.perk_HeatedBlades");
	

// 	PierceEffect = new class'X2Effect_WOTC_APA_HeatedBlades';
// 	PierceEffect.BuildPersistentEffect(1, true, false, false);
// 	PierceEffect.EffectName = 'WOTC_APA_HeatedBladesPierceEffect';
// 	PierceEffect.DuplicateResponse = eDupe_Ignore;
// 	Template.AddTargetEffect(PierceEffect);


// 	return Template;
// }


// Rip and Tear - Passive: 
static function X2AbilityTemplate RipAndTear_LW()
{

	local X2AbilityTemplate										Template;
	//local X2Effect_RipAndTear_LW							ShredEffect;


	Template = CreatePassiveAbility('RipAndTear_LW', "img:///UILibrary_WOTC_APA_Skirmisher_LW.perk_RipAndTear");
	
	
	// ShredEffect = new class'X2Effect_RipAndTear_LW';
	// ShredEffect.BuildPersistentEffect(1, true, false, false);
	// ShredEffect.EffectName = 'RipAndTearShredEffect_LW';
	// ShredEffect.DuplicateResponse = eDupe_Ignore;
	// Template.AddTargetEffect(ShredEffect);


	return Template;
}


// ---------------------------------------------------------------------------------
// --------------------  ABILITY  FRAMEWORK  HELPER  FUNCTIONS  --------------------
// ---------------------------------------------------------------------------------


// Helper function to setup basic framework for passive abilities
static function X2AbilityTemplate CreatePassiveAbility(name AbilityName, optional string IconString, optional name IconEffectName = AbilityName, optional bool bDisplayIcon = true)
{
	
	local X2AbilityTemplate					Template;
	local X2Effect_Persistent				IconEffect;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, AbilityName);
	Template.IconImage = IconString;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bCrossClassEligible = false;
	Template.bUniqueSource = true;
	Template.bIsPassive = true;

	// Dummy effect to show a passive icon in the tactical UI for the SourceUnit
	IconEffect = new class'X2Effect_Persistent';
	IconEffect.BuildPersistentEffect(1, true, false);
	IconEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, bDisplayIcon,, Template.AbilitySourceName);
	IconEffect.EffectName = IconEffectName;
	Template.AddTargetEffect(IconEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


// Helper function to setup basic framework for self-targeted activatible abilities
static function X2AbilityTemplate CreateSelfActiveAbility(name AbilityName, optional string IconString, optional bool bLimitWhenImpaired = true, optional array<name> SkipExclusions)
{
	
	local X2AbilityTemplate					Template;
	

	`CREATE_X2ABILITY_TEMPLATE (Template, AbilityName);
	Template.IconImage = IconString;
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityConfirmSound = "TacticalUI_ActivateAbility";
	Template.DisplayTargetHitChance = false;
	Template.bLimitTargetIcons = true;
	Template.bShowActivation = true;
	Template.bCrossClassEligible = false;
	Template.bUniqueSource = true;

	// Unit cannot be disoriented, confused, dazed, stunned, burning, bound, or carrying a unit
	if (bLimitWhenImpaired)
	{
		Template.AddShooterEffectExclusions(SkipExclusions);
	}

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}



// -------------------------------------------------------------------------------------
// --------------------  ABILITY  VISUALIZATION  HELPER  FUNCTIONS  --------------------
// -------------------------------------------------------------------------------------


// Plays flyover message on the SourceUnit with ability's LocFlyOverText when the ability is activated
simulated function BasicSourceFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory					History;
	local XComGameStateContext_Ability			AbilityContext;
	local XComGameState_Ability					AbilityState;
	local X2AbilityTemplate						AbilityTemplate;
	local StateObjectReference					SourceUnitRef;
	local VisualizationActionMetadata			ActionMetadata;
	local X2Action_PlaySoundAndFlyOver			SoundAndFlyOver;
	
	History = `XCOMHISTORY;

	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	SourceUnitRef = AbilityContext.InputContext.SourceObject;
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	AbilityTemplate = AbilityState.GetMyTemplate();
	
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(SourceUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(SourceUnitRef.ObjectID);
	if (ActionMetadata.StateObject_NewState == none)
		ActionMetadata.StateObject_NewState = ActionMetadata.StateObject_OldState;
	ActionMetadata.VisualizeActor = History.GetVisualizer(SourceUnitRef.ObjectID);
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocFlyOverText, '', eColor_Good, AbilityTemplate.IconImage, `DEFAULTFLYOVERLOOKATTIME * 2);
}





DefaultProperties
{
	HEATSINK_CURRENT_NAME = "WOTC_APA_Skirmisher_CurrentHeatLevel"
	HEATSINK_MAX_NAME = "WOTC_APA_Skirmisher_MaxHeatLevel"
}