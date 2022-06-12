//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_OfficerAbilitySet
//  AUTHOR:  Amineri / John Lumpkin (Pavonis Interactive)
//  PURPOSE: Defines officer ability templates
//--------------------------------------------------------------------------------------- 
class X2Ability_OfficerAbilitySet_PassiveAuras extends XMBAbility config (LW_OfficerPack);

var config int DEFILADE_DEF;
var config int DEFILADE_WILL;
var config int DEFILADE_CRIT_DEF;

//var config float DEFILADE_TILE_RANGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	`LWTrace("  >> X2Ability_OfficerAbilitySet_PassiveAuras.CreateTemplates()");
	
	//base CommandAura abilities
	Templates.AddItem(AddDefiladeAbility());
	Templates.AddItem(AddFireDisciplineAbility());
	Templates.AddItem(AddLeadByExampleAbility());
	Templates.AddItem(AddCombinedArmsAbility());

	//Additional CommandAura abilities
	Templates.AddItem(LeadByExamplePassive());
	Templates.AddItem(LeadByExampleLeader());
	Templates.AddItem(CombinedArmsPassive());
	Templates.AddItem(DefiladePassive());
	Templates.AddItem(FireDisciplinePassive());
	
	return Templates;
}

static function X2AbilityTemplate AddDefiladeAbility()
{
	local X2AbilityTemplate                     Template;
	local X2AbilityTrigger_EventListener        EventListener;
	local X2Condition_UnitProperty              EnemyCondition;
	local X2Effect_ToHitModifier		DefiladeEffect;
	local X2Effect_RemoveEffects RemoveEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'Defilade');
	Template.IconImage = "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityHitTheDirt"; 
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);


	EnemyCondition = new class'X2Condition_UnitProperty';
	EnemyCondition.ExcludeAlive = false;
	EnemyCondition.ExcludeDead = true;
	EnemyCondition.ExcludeHostileToSource = true;
	EnemyCondition.ExcludeFriendlyToSource = false;
	EnemyCondition.FailOnNonUnits = true;
	// EnemyCondition.RequireWithinRange = true;
	// EnemyCondition.WithinRange = default.DEFILADE_TILE_RANGE *  class'XComWorldData'.const.WORLD_StepSize; // same as Solace for now

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitMoveFinished';
	EventListener.ListenerData.Filter = eFilter_None;
	EventListener.ListenerData.EventFn = DefiladeCleanseListener;
	Template.AbilityTriggers.AddItem(EventListener);

	//Remove the ZOC Effect in case it already exists, becuse eDupe_Refresh only refreshes duration and not the entire effect data.
	//It's important in case of multiple units with Zone of control.
	RemoveEffect = new class'X2Effect_RemoveEffects';
	RemoveEffect.EffectNamesToRemove.AddItem('Defilade_LWEffect');
	//RemoveEffect.TargetConditions.AddItem(EnemyCondition);
	RemoveEffect.bDoNotVisualize = true;
	RemoveEffect.bCleanse = true;
	Template.AddTargetEffect(RemoveEffect);


	DefiladeEffect = new class'X2Effect_ToHitModifier';
	DefiladeEffect.EffectName = 'Defilade_LWEffect';
	DefiladeEffect.bApplyAsTarget = true;
	DefiladeEffect.AddEffectHitModifier(eHit_Crit, -default.DEFILADE_CRIT_DEF, Template.LocFriendlyName);
	DefiladeEffect.DuplicateResponse = eDupe_Ignore;
	DefiladeEffect.TargetConditions.AddItem(EnemyCondition);
	DefiladeEffect.TargetConditions.AddItem(default.GameplayVisibilityCondition);
	DefiladeEffect.BuildPersistentEffect(1, true, true, true);
	DefiladeEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	DefiladeEffect.bRemoveWhenSourceDies = true;
	Template.AddTargetEffect(DefiladeEffect);

	// ToHitModifier = new class'X2Effect_ToHitModifier';
	// ToHitModifier.BuildPersistentEffect(1, true, true, true);
	// ToHitModifier.AddEffectHitModifier(eHit_Crit, -default.DEFILADE_CRIT_DEF, Template.LocFriendlyName);
	// Template.AddTargetEffect(ToHitModifier);


	Template.AdditionalAbilities.AddItem('DefiladePassive');

	Template.bSkipFireAction = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


static function EventListenerReturn DefiladeCleanseListener(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit TargetUnit;
	local XComGameState_Ability SourceAbilityState;

	SourceAbilityState = XComGameState_Ability(CallbackData);	

	TargetUnit = XComGameState_Unit(EventData);

	SourceAbilityState.AbilityTriggerAgainstSingleTarget(TargetUnit.GetReference(), false);
	

	return ELR_NoInterrupt;
}

static function X2AbilityTemplate DefiladePassive()
{
	return PurePassive('DefiladePassive', "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityHitTheDirt", , class'X2Ability_OfficerAbilitySet'.default.OfficerSourceName);
}

//COL 1 Fire Discipline 
static function X2AbilityTemplate AddFireDisciplineAbility()
{
	local X2AbilityTemplate                 Template;
	local X2Effect_FireDiscipline				FireDisciplineEffect;
	local X2AbilityTrigger_EventListener 	EventListener;
	local X2Condition_UnitProperty			TargetProperty;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'FireDiscipline');
	Template.IconImage = "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityFireDiscipline"; 
	Template.AbilitySourceName = class'X2Ability_OfficerAbilitySet'.default.OfficerSourceName; 
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;

	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = true;
	TargetProperty.ExcludeFriendlyToSource = false;
	TargetProperty.RequireSquadmates = true;
	TargetProperty.ExcludePanicked = true;
	TargetProperty.ExcludeRobotic = true;
	TargetProperty.ExcludeStunned = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'OnUnitBeginPlay';
	EventListener.ListenerData.EventFn = AuraOnUnitBeginPlay;
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_None;
	Template.AbilityTriggers.AddItem(EventListener);

	FireDisciplineEffect = new class'X2Effect_FireDiscipline';
	FireDisciplineEffect.BuildPersistentEffect (1, true, false);
	FireDisciplineEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	Template.AddTargetEffect(FireDisciplineEffect);

	Template.AdditionalAbilities.AddItem('FireDisciplinePassive');

	Template.bSkipFireAction = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

static function X2AbilityTemplate FireDisciplinePassive()
{
	return PurePassive('FireDisciplinePassive', "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityFireDiscipline", , class'X2Ability_OfficerAbilitySet'.default.OfficerSourceName);
}


//FC 1
//Lead By Example grants bonus stats for soldiers with lower stats nearby
// if officer aim/will/hack > soldier aim/will/hack, soldier gains (officer - soldier)/2  (round up)
static function X2AbilityTemplate AddLeadByExampleAbility()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityTarget_Single            SingleTarget;
	local X2Effect_LeadByExample			Effect;
	local X2Condition_UnitProperty			TargetProperty;
	local X2Condition_Visibility			TargetVisibilityCondition;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local array<name>                       SkipExclusions;
	local X2AbilityTrigger_Event	        Trigger;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LeadByExample');
	Template.IconImage = "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityLeadByExample"; 
	Template.AbilitySourceName = class'X2Ability_OfficerAbilitySet'.default.OfficerSourceName; 
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.bConsumeAllPoints = false;   
	ActionPointCost.bFreeCost = true;           
	Template.AbilityCosts.AddItem(ActionPointCost);

	Template.AbilityToHitCalc = default.DeadEye;
	//Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_LWCommandRange';

	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeAlive = false;
    TargetProperty.ExcludeDead = true;
    TargetProperty.ExcludeHostileToSource = true;
    TargetProperty.ExcludeFriendlyToSource = false;
    TargetProperty.RequireSquadmates = true;
    TargetProperty.ExcludePanicked = true;
	TargetProperty.ExcludeRobotic = true;
	TargetProperty.ExcludeStunned = true;
	TargetProperty.TreatMindControlledSquadmateAsHostile = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireLOS = false;
	TargetVisibilityCondition.bRequireGameplayVisible = false;
	TargetVisibilityCondition.bAllowSquadsight = false;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);	

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	//Template.AbilityTargetStyle = default.SimpleSingleTarget;

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = false;
	SingleTarget.bAllowInteractiveObjects = false;
	SingleTarget.bAllowDestructibleObjects = false;
	SingleTarget.bIncludeSelf = false;
	SingleTarget.bShowAOE = false;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_Single';

	//Trigger on movement - interrupt the move
	Trigger = new class'X2AbilityTrigger_Event';
	Trigger.EventObserverClass = class'X2TacticalGameRuleset_MovementObserver';
	//Trigger.MethodName = 'InterruptGameState';  // updates as each unit moves each tile
	Trigger.MethodName = 'PostBuildGameState';  // updates after unit finishes movement
	Template.AbilityTriggers.AddItem(Trigger);

	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.OVERWATCH_PRIORITY+1;

	Effect = new class'X2Effect_LeadByExample';
	Effect.BuildPersistentEffect(1, true, false);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(Effect);

	Template.AdditionalAbilities.AddItem('LeadByExamplePassive');
	Template.AdditionalAbilities.AddItem('LeadByExampleLeader');

	Template.bSkipFireAction = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

static function X2AbilityTemplate LeadByExamplePassive()
{
	return PurePassive('LeadByExamplePassive', "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityLeadByExample", , class'X2Ability_OfficerAbilitySet'.default.OfficerSourceName);
}

static function X2AbilityTemplate LeadByExampleLeader()
{
	local X2AbilityTemplate                 Template;
	local X2Effect_LeadByExample			Effect;
	local X2AbilityMultiTarget_AllAllies	MultiTargetStyle;
	local X2Condition_UnitProperty			MultiTargetProperty;
	local X2AbilityTrigger_EventListener    EventTrigger;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LeadByExampleLeader');
	Template.IconImage = "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityLeadByExample"; 
	Template.AbilitySourceName = class'X2Ability_OfficerAbilitySet'.default.OfficerSourceName; 
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;

	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	// will also automatically trigger at the end of a move if it is possible
	EventTrigger = new class'X2AbilityTrigger_EventListener';
	EventTrigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventTrigger.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_SelfWithAdditionalTargets;
	EventTrigger.ListenerData.EventID = 'UnitMoveFinished';
	EventTrigger.ListenerData.Filter = eFilter_Unit;
	Template.AbilityTriggers.AddItem(EventTrigger);

	MultiTargetProperty = new class'X2Condition_UnitProperty';
	MultiTargetProperty.ExcludeAlive = false;
    MultiTargetProperty.ExcludeDead = true;
    MultiTargetProperty.ExcludeHostileToSource = true;
    MultiTargetProperty.ExcludeFriendlyToSource = false;
    MultiTargetProperty.RequireSquadmates = true;
    MultiTargetProperty.ExcludePanicked = true;
	MultiTargetProperty.ExcludeRobotic = true;
	MultiTargetProperty.ExcludeStunned = true;
	Template.AbilityMultiTargetConditions.AddItem(MultiTargetProperty);

	Template.AbilityTargetStyle = default.SelfTarget;
	MultiTargetStyle = new class'X2AbilityMultiTarget_AllAllies';
	MultiTargetStyle.bAddPrimaryTargetAsMultiTarget = false;
	Template.AbilityMultiTargetStyle = MultiTargetStyle;

	Effect = new class'X2Effect_LeadByExample';
	Effect.BuildPersistentEffect(1, true, false);
	Effect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddMultiTargetEffect(Effect);

	Template.bSkipFireAction = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

//static function EventListenerReturn ActivateLeadByExample(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
//{
	//local XComGameState_Unit MovingUnitState;
	//local AvailableAction Action;
//
	//MovingUnitState = XComGameState_Unit(EventSource);
	//if (MovingUnitState == none)
	//{
		//`RedScreen("LW Officer Pack (LeadByExample) : Event trigger with no moving unit");
		//return ELR_NoInterrupt;
	//}
//
	//// grab the available action information for the specified unit
	//if(!`TACTICALRULES.GetGameRulesCache_Unit(MovingUnitState.GetReference(), OutCacheData))
	//{
		//`RedScreen("SeqAct_ActivateAbility: Couldn't find available action info for unit: " $ Unit.GetFullName());
		//return;
	//}
	//Action.AbilityObjectRef = MovingUnitState.FindAbility('LeadByExampleLeader');
	//if (Action.AbilityObjectRef.ObjectID != 0)
	//{
		//Action.AvailableCode = 'AA_Success';
		//class'XComGameStateContext_Ability'.static.ActivateAbility(Action);
	//}
	//return ELR_NoInterrupt;
//}

//FC 2
//Combined Arms grants +1 damage to all units in command aura range
static function X2AbilityTemplate AddCombinedArmsAbility()
{
	local X2AbilityTemplate                 Template;
	local X2Effect_CombinedArms				CombinedArmsEffect;	
	local X2AbilityTrigger_EventListener 	EventListener;
	local X2Condition_UnitProperty			TargetProperty;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'CombinedArms');
	Template.IconImage = "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityCombinedArms"; 
	Template.AbilitySourceName = class'X2Ability_OfficerAbilitySet'.default.OfficerSourceName; 
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.DisplayTargetHitChance = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	TargetProperty = new class'X2Condition_UnitProperty';
	TargetProperty.ExcludeDead = true;
	TargetProperty.ExcludeHostileToSource = true;
	TargetProperty.ExcludeFriendlyToSource = false;
	TargetProperty.RequireSquadmates = true;
	TargetProperty.ExcludePanicked = true;
	TargetProperty.ExcludeRobotic = true;
	TargetProperty.ExcludeStunned = true;
	Template.AbilityTargetConditions.AddItem(TargetProperty);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'OnUnitBeginPlay';
	EventListener.ListenerData.EventFn = AuraOnUnitBeginPlay;
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_None;
	Template.AbilityTriggers.AddItem(EventListener);

	CombinedArmsEffect = new class'X2Effect_CombinedArms';
	CombinedArmsEffect.BuildPersistentEffect (1, true, false);
	CombinedArmsEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	Template.AddTargetEffect(CombinedArmsEffect);

	Template.AdditionalAbilities.AddItem('CombinedArmsPassive');

	Template.bSkipFireAction = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

static function X2AbilityTemplate CombinedArmsPassive()
{
	return PurePassive('CombinedArmsPassive', "img:///UILibrary_LW_OfficerPack.LWOfficers_AbilityCombinedArms", , class'X2Ability_OfficerAbilitySet'.default.OfficerSourceName);
}

static function EventListenerReturn AuraOnUnitBeginPlay(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit UnitState;
	local XComGameState_Ability SourceAbilityState;

	SourceAbilityState = XComGameState_Ability(CallbackData);	
	UnitState = XComGameState_Unit(EventData);

	if (SourceAbilityState != None  && UnitState != none) {
		SourceAbilityState.AbilityTriggerAgainstSingleTarget(UnitState.GetReference(), false);
	}

	return ELR_NoInterrupt;
}


