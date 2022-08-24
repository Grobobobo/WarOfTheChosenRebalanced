//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_LW_DefaultAbilitySet.uc
//  AUTHOR:  tracktwo (Pavonis Interactive)
//  PURPOSE: General new abilities for LW2
//---------------------------------------------------------------------------------------

class X2Ability_LW_DefaultAbilitySet extends X2Ability config(LW_Overhaul);

var config int REACTION_FIRE_ANTI_COVER_BONUS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	`Log("LW_DefaultAbilitySet.CreateTemplates --------------------------------");

	Templates.AddItem(CreateInteractSmashNGrabAbility());
	Templates.AddItem(CreateMindControlCleanse());
	Templates.AddItem(CreateReactionFireAgainstCoverBonus());
	Templates.AddItem(CreateSmokeFlankingCritProtection());
	Templates.AddItem(CreateFlashbangResistancePassive());

	return Templates;
}

static function X2AbilityTemplate CreateInteractSmashNGrabAbility()
{
	local X2AbilityTemplate Template;
	local X2Condition_UnitDoesNotHaveItem ItemCondition;
	
	`Log("TRACE: Creating SmashNGrab ability");
	Template = class'X2Ability_DefaultAbilitySet'.static.AddInteractAbility('Interact_SmashNGrab');

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
	Template.ConcealmentRule = eConceal_Never;

	
	`Log("TRACE: Adding a condition");
	ItemCondition = new class'X2Condition_UnitDoesNotHaveItem';
	ItemCondition.ItemTemplateName='SmashNGrabQuestItem';
	Template.AbilityShooterConditions.AddItem(ItemCondition);

	// Reaper should always lose Shadow when opening a Smash and Grab crate
	// to avoid cheesing the mission, especially for XP.
	Template.SuperConcealmentLoss = 100;

	`Log("TRACE: All done!");
	return Template;
}

// Passive ability that cleanses units of various debilitating effects
// when mind control wears off (just as happens when a unit is first
// mind controlled). This is basically to fix various issues with the
// interaction of the stunned effect with mind control.
static function X2AbilityTemplate CreateMindControlCleanse()
{
	local X2AbilityTemplate Template;
	local X2AbilityTrigger_EventListener EventListener;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MindControlCleanse');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_solace";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowActivation = false;
	Template.bSkipFireAction = true;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	// Trigger when mind control is lost
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'MindControlLost';
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_Unit;
	Template.AbilityTriggers.AddItem(EventListener);

	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateMindControlRemoveEffects());
	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateStunRecoverEffect());

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;

	return Template;
}

static function X2AbilityTemplate CreateReactionFireAgainstCoverBonus()
{
	local X2AbilityTemplate					Template;
	local X2Effect_ReactionFireAntiCover	AntiCoverEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ReactionFireAgainstCoverBonus');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_standard";
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	AntiCoverEffect = new class'X2Effect_ReactionFireAntiCover';
	AntiCoverEffect.BuildPersistentEffect(1, true);
	AntiCoverEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false);
	AntiCoverEffect.AimBonus = default.REACTION_FIRE_ANTI_COVER_BONUS;
	AntiCoverEffect.DuplicateResponse = eDupe_Ignore;
	Template.AddTargetEffect(AntiCoverEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate CreateSmokeFlankingCritProtection()
{
	local X2AbilityTemplate Template;
	local X2Effect_SmokeFlankingCritProtection SmokeAntiCritEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'SmokeFlankingCritProtection');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_standard";
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	SmokeAntiCritEffect = new class'X2Effect_SmokeFlankingCritProtection';
	SmokeAntiCritEffect.BuildPersistentEffect(1, true);
	SmokeAntiCritEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, false);
	Template.AddTargetEffect(SmokeAntiCritEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate CreateFlashbangResistancePassive()
{
	local X2AbilityTemplate		Template;

	Template = PurePassive('FlashbangResistancePassive', "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_mindshield", , 'eAbilitySource_Perk');
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;

	return Template;
}
