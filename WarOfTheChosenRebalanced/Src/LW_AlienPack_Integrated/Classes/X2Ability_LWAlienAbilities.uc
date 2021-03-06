//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_LWAlienAbilities
//  AUTHOR:  Amineri / John Lumpkin (Pavonis Interactive)
//  PURPOSE: Defines alienpack ability templates
//---------------------------------------------------------------------------------------

class X2Ability_LWAlienAbilities extends X2Ability config(LW_AlienPack);

var config float WARCRY_RADIUS_METERS;
var config int WARCRY_DURATION;
var config int WARCRY_COOLDOWN;
var config int WARCRY_ACTIONCOST;
var config int WARCRY_MUTON_OFFENSE_BONUS;
var config int WARCRY_MUTON_WILL_BONUS;
var config int WARCRY_MUTON_MOBILITY_BONUS;
var config int WARCRY_OTHER_OFFENSE_BONUS;
var config int WARCRY_OTHER_WILL_BONUS;
var config int WARCRY_OTHER_MOBILITY_BONUS;
var config int BAYONET_COOLDOWN;
var config int BAYONETCHARGE_PENALTY_DURATION;
var config int BAYONETCHARGE_DEFENSE_PENALTY;
var config array <string> WARCRY_MUTON_BONUS;
var config array <string> WARCRY_OTHER_BONUS;
var config float MASS_MINDSPIN_TILES_RADIUS;

var config int PERSONAL_SHIELD_COOLDOWN;
var config int PERSONAL_SHIELD_DURATION;
var config int PERSONAL_SHIELD_HP;
var config int PERSONAL_SHIELD_ACTION_COST;

var config float MASS_MINDSPIN_LW_CONE_END_DIAMETER;
var config float MASS_MINDSPIN_LW_CONE_LENGTH;

var config int MASS_REANIMATION_LW_MIN_ACTION_COST;
var config int MASS_REANIMATION_LW_LOCAL_COOLDOWN;
var config int MASS_REANIMATION_LW_GLOBAL_COOLDOWN;
var config int MASS_REANIMATION_LW_RADIUS_METERS;
var config int MASS_REANIMATION_LW_RANGE_METERS;

var config int DRONE_REPAIR_ACTION_COST;
var config int DRONE_STUN_HIT_MODIFIER;
var config int DRONE_STUN_ACTION_POINT_DAMAGE;
var config int STUNNER_COOLDOWN;

var config int CHRYSSALID_SOLDIER_SLASH_BONUS_DAMAGE;
var config int HIVE_QUEEN_SLASH_BONUS_DAMAGE;

var config int REPAIR_SERVOS_BONUS_ARMOR;
var config int REPAIR_SERVOS_DURATION;

var const config int HOLYWARRIOR_M4_MOBILITY;
var const config int HOLYWARRIOR_M4_OFFENSE;
var const config int HOLYWARRIOR_M4_CRIT;
var const config int HOLYWARRIOR_M4_HP;
var const config int HOLYWARRIOR_M5_MOBILITY;
var const config int HOLYWARRIOR_M5_OFFENSE;
var const config int HOLYWARRIOR_M5_CRIT;
var const config int HOLYWARRIOR_M5_HP;

var config int ENERGY_SHIELD_MK4_HP;
var config int ENERGY_SHIELD_MK5_HP;

var config int SIDEWINDER_FOCUS1MOBILITY;
var config int SIDEWINDER_FOCUS1AIM;
var config int SIDEWINDER_FOCUS1CRIT;

var config int SIDEWINDER_FOCUS2MOBILITY;
var config int SIDEWINDER_FOCUS2AIM;
var config int SIDEWINDER_FOCUS2CRIT;

var config int SIDEWINDER_FOCUS3MOBILITY;
var config int SIDEWINDER_FOCUS3AIM;
var config int SIDEWINDER_FOCUS3CRIT;

var config float SHOGGOTH_SPAWN_CHANCE_PER_HIT;

var localized string strBayonetChargePenalty;

var localized string HunterMarkAdventEffectName;
var localized string HunterMarkAdventEffectDesc;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	`LWTrace("  >> X2Ability_LWAlienAbilities.CreateTemplates()");
	
	Templates.AddItem(CreateMutonM2_LWAbility_Beastmaster());
	Templates.AddItem(CreateMutonM2_LWAbility_WarCry());
	Templates.AddItem(CreateMutonM2_LWAbility_BayonetCharge());
	Templates.AddItem(CreateDroneShockAbility());
	Templates.AddItem(CreateDroneRepairAbility());
	Templates.AddItem(AddDroneMeleeStun());
	Templates.AddItem(CreateAdventGrenadeLauncherAbility());
	Templates.AddItem(CreateMassMindSpinAbility());
	Templates.AddItem(CreatePersonalShieldAbility());
	Templates.AddItem(CreateMassReanimateAbility());
	Templates.AddItem(CreateReadyForAnythingAbility());
	Templates.AddItem(ReadyForAnythingFlyover());
	Templates.AddItem(CreateChryssalidSoldierSlashAbility());
	Templates.AddItem(CreateHiveQueenSlashAbility());
	Templates.AddItem(AddRepairServosAbility());
	Templates.AddItem(CreateDroneHealAbility());

	
	Templates.AddItem(AddFireOnDeathAbility());
	Templates.AddItem(PurePassive('RepairServosPassive', "img:///UILibrary_LWAlienPack.LW_AbilityDamageControl", true, 'eAbilitySource_Perk'));


	Templates.AddItem(class'X2Ability_AdvPriest'.static.CreateHolyWarrior('HolyWarriorM4', default.HOLYWARRIOR_M4_MOBILITY, default.HOLYWARRIOR_M4_OFFENSE, default.HOLYWARRIOR_M4_CRIT, default.HOLYWARRIOR_M4_HP));
	Templates.AddItem(class'X2Ability_AdvPriest'.static.CreateHolyWarrior('HolyWarriorM5', default.HOLYWARRIOR_M5_MOBILITY, default.HOLYWARRIOR_M5_OFFENSE, default.HOLYWARRIOR_M5_CRIT, default.HOLYWARRIOR_M5_HP));

	Templates.AddItem(CreateEnergyShieldAbility('EnergyShieldMk4',default.ENERGY_SHIELD_MK4_HP));
	Templates.AddItem(CreateEnergyShieldAbility('EnergyShieldMk5',default.ENERGY_SHIELD_MK5_HP));

	
	Templates.AddItem(PurePassive('BindM2Damage', "img:///UILibrary_XPerkIconPack_LW.UIPerk_enemy_command", true, 'eAbilitySource_Perk'));
	Templates.AddItem(PurePassive('BindM3Damage', "img:///UILibrary_XPerkIconPack_LW.UIPerk_enemy_command_chevron", true, 'eAbilitySource_Perk'));
	Templates.AddItem(PurePassive('BindM4Damage', "img:///UILibrary_XPerkIconPack_LW.UIPerk_enemy_command_chevron_x2", true, 'eAbilitySource_Perk'));
	Templates.AddItem(PurePassive('BindM5Damage', "img:///UILibrary_XPerkIconPack_LW.UIPerk_enemy_command_chevron_x3", true, 'eAbilitySource_Perk'));
	Templates.AddItem(PurePassive('BindM6Damage', "img:///UILibrary_XPerkIconPack_LW.UIPerk_enemy_command_chevron_x3", true, 'eAbilitySource_Perk'));
	Templates.AddItem(AddNewKillSiredZombies());
	Templates.AddItem(CreateSwitchToRobot_LeaderAbility());
	Templates.AddItem(CreateImmunities_LeaderAbility());
	Templates.AddItem(AddArtillery());
	Templates.AddItem(PsiSpit_LW());
	Templates.AddItem(VorpalCharge());
	Templates.AddItem(SideWinderFocus());
	Templates.AddItem(CreateHunterMarkAdvent());
	Templates.AddItem(CreateStunLanceCharge());
	Templates.AddItem(CreateChangeForm_Shoggoth_Ability());
	return Templates;
}

static function X2AbilityTemplate AddRepairServosAbility()
{
	local X2AbilityTemplate						Template;
	local X2AbilityTrigger_EventListener		EventListener;
	local X2Effect_RepairServos				RepairServosEffect;
	local X2Condition_UnitEffects ExcludeEffects;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'RepairServos');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityDamageControl";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowActivation = true;
	Template.bSkipFireAction = true;
	//Template.bIsPassive = true;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	// Trigger on Damage
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'UnitTakeEffectDamage';
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_Unit;
	Template.AbilityTriggers.AddItem(EventListener);

	ExcludeEffects = new class'X2Condition_UnitEffects';
	ExcludeEffects.AddExcludeEffect('RepairServos', 'AA_RepairServosActivated');
	Template.AbilityShooterConditions.AddItem(ExcludeEffects);

	RepairServosEffect = new class'X2Effect_RepairServos';
	RepairServosEffect.RepairServosBonusArmor = default.REPAIR_SERVOS_BONUS_ARMOR;
	RepairServosEffect.BuildPersistentEffect(default.REPAIR_SERVOS_DURATION,false,true,,eGameRule_PlayerTurnBegin);
	RepairServosEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	RepairServosEffect.DuplicateResponse = eDupe_Refresh;
	RepairServosEffect.EffectName = 'RepairServos';
	Template.AddTargetEffect(RepairServosEffect);

	//Template.CustomFireAnim = 'HL_RepairServos';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;

	Template.AdditionalAbilities.AddItem('RepairServosPassive');

	return Template;
}
static function X2AbilityTemplate CreateMutonM2_LWAbility_BeastMaster()
{
	local X2AbilityTemplate					Template;
	local X2AbilityTargetStyle				TargetStyle;
	local X2AbilityTrigger					Trigger;
	local X2Effect_BeastMaster_LW			BeastMasterEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'Beastmaster_LW');
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.IconImage = "img:///Texture2D'UILibrary_LWAlienPack.LWCenturion_AbilityBeastmaster64'";
	Template.AbilityToHitCalc = default.DeadEye;
	TargetStyle = new class 'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;
	Trigger = new class 'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	BeastMasterEffect = new class'X2Effect_BeastMaster_LW';
	BeastMasterEffect.BuildPersistentEffect (1, true, false);
		//BuildPersistentEffect(int _iNumTurns, optional bool _bInfiniteDuration, optional bool _bRemoveWhenSourceDies, optional bool _bIgnorePlayerCheckOnTick, optional XComGameStateContext_TacticalGameRule.GameRuleStateChange _WatchRule)
	BeastMasterEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
		//SetDisplayInfo(X2TacticalGameRulesetDataStructures.EPerkBuffCategory BuffCat, string strName, string strDesc, string strIconLabel, optional bool DisplayInUI, optional string strStatusIcon, optional name opAbilitySource)

	Template.AddTargetEffect(BeastMasterEffect);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

static function X2AbilityTemplate CreateMutonM2_LWAbility_BayonetCharge()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityToHitCalc_StandardMelee	StandardMelee;
	local X2Effect_ApplyWeaponDamage		WeaponDamageEffect;
	
	local X2Effect_ImmediateAbilityActivation ImpairingAbilityEffect;
	local X2Effect_PersistentStatChange		StatEffect;
	local XGParamTag						kTag;
	local string							strPenalty;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'BayonetCharge');
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///Texture2D'UILibrary_LWAlienPack.LWCenturion_AbilityBayonetCharge64'";

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bfreeCost = false;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	StatEffect = new class'X2Effect_PersistentStatChange';

	kTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	if (kTag != none)
	{
		kTag.IntValue0 = default.BAYONETCHARGE_PENALTY_DURATION;
		kTag.IntValue1 = default.BAYONETCHARGE_DEFENSE_PENALTY;
		strPenalty = `XEXPAND.ExpandString(default.strBayonetChargePenalty);
	} else {
		strPenalty = "Placeholder Centurion penalty (no XGParamTag)";
	}
	StatEffect.BuildPersistentEffect(default.BAYONETCHARGE_PENALTY_DURATION, false, true, false, eGameRule_PlayerTurnEnd);
	//StatEffect.SetDisplayInfo (ePerkBuff_Penalty, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName); // adjust
	StatEffect.SetDisplayInfo (ePerkBuff_Penalty, Template.LocFriendlyName, strPenalty, Template.IconImage,,, Template.AbilitySourceName); // adjust
	StatEffect.DuplicateResponse = eDupe_Refresh;
	StatEffect.AddPersistentStatChange (eStat_Defense, float (default.BAYONETCHARGE_DEFENSE_PENALTY));
	Template.AddShooterEffect(StatEffect);

	StandardMelee = new class'X2AbilityToHitCalc_StandardMelee';
	Template.AbilityToHitCalc = StandardMelee;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_MovingMelee';
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	//Effect on a successful melee attack is triggering the Apply Impairing Effect Ability
	ImpairingAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	ImpairingAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	ImpairingAbilityEffect.EffectName = 'ImmediateStunImpair';
	ImpairingAbilityEffect.AbilityName = class'X2Ability_Impairing'.default.ImpairingAbilityName;
	ImpairingAbilityEffect.bRemoveWhenTargetDies = true;
	ImpairingAbilityEffect.VisualizationFn = class'X2Ability_Impairing'.static.ImpairingAbilityEffectTriggeredVisualization;
	Template.AddTargetEffect(ImpairingAbilityEffect);

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);
	Template.bAllowBonusWeaponEffects = true;
	Template.bSkipMoveStop = true;

	Template.BuildNewGameStateFn = BayonetCharge_BuildGameState;
	Template.BuildInterruptGameStateFn = class'X2Ability_DefaultAbilitySet'.static.MoveAbility_BuildInterruptGameState;

	Template.CinescriptCameraType = "Muton_Punch";
	
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;

	return Template;

}

simulated function XComGameState BayonetCharge_BuildGameState(XComGameStateContext context)
{
	local XComGameState NewGameState;

	NewGameState = class'X2Ability_DefaultAbilitySet'.static.MoveAbility_BuildGameState(context);
	TypicalAbility_FillOutGameState(NewGameState);
	return NewGameState;
}


static function X2AbilityTemplate CreateMutonM2_LWAbility_WarCry()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityCooldown					Cooldown;
	local X2Condition_UnitProperty			MultiTargetProperty;
	local X2Effect_WarCry					StatEffect;
	local X2AbilityTargetStyle				TargetStyle;
	local X2AbilityMultiTarget_Radius		RadiusMultiTarget;
	local int								i;
	local string							AlienName;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'WarCry');
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.IconImage = "img:///Texture2D'UILibrary_LWAlienPack.LWCenturion_AbilityWarCry64'";
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = default.WARCRY_ACTIONCOST;
	ActionPointCost.bfreeCost = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.WARCRY_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = default.Deadeye;

	TargetStyle = new class 'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = default.WARCRY_RADIUS_METERS;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.AddShooterEffectExclusions();

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

	StatEffect = new class'X2Effect_WarCry';

	StatEffect.BuildPersistentEffect(default.WARCRY_DURATION, false, true, false, eGameRule_PlayerTurnEnd);
	//StatEffect.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName); // adjust
	StatEffect.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, class'X2Effect_WarCry'.default.strWarCryFriendlyDesc, Template.IconImage,,, Template.AbilitySourceName);

	StatEffect.DuplicateResponse = eDupe_Refresh;

	ForEach default.WARCRY_MUTON_BONUS (AlienName, i)
	{
		StatEffect.AddCharacterNameHigh (name(AlienName));
	}
	ForEach default.WARCRY_OTHER_BONUS (AlienName, i)
	{
		StatEffect.AddCharacterNameLow (name(AlienName));
	}

	StatEffect.AddPersistentStatChange (eStat_Offense, float (default.WARCRY_MUTON_OFFENSE_BONUS), true);
	StatEffect.AddPersistentStatChange (eStat_Mobility, float (default.WARCRY_MUTON_MOBILITY_BONUS), true);
	StatEffect.AddPersistentStatChange (eStat_Will, float (default.WARCRY_MUTON_WILL_BONUS), true);

	StatEffect.AddPersistentStatChange (eStat_Offense, float (default.WARCRY_OTHER_OFFENSE_BONUS), false);
	StatEffect.AddPersistentStatChange (eStat_Mobility, float (default.WARCRY_OTHER_MOBILITY_BONUS), false);
	StatEffect.AddPersistentStatChange (eStat_Will, float (default.WARCRY_OTHER_WILL_BONUS), false);

	//Template.AddShooterEffect(StatEffect); This would make Centurion gain bonuses from own War Cry
	Template.AddMultiTargetEffect(StatEffect);

	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = WarCry_BuildVisualization;
	return Template;
}

function WarCry_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory				History;
	local XComGameStateContext_Ability		context;
	local StateObjectReference				InteractingUnitRef;
	local VisualizationActionMetadata		EmptyTrack, BuildTrack, TargetTrack;
	local X2Action_PlayAnimation			PlayAnimationAction;
	local X2Action_PlaySoundAndFlyOver		SoundAndFlyover, SoundAndFlyoverTarget;
	local XComGameState_Ability				Ability;
	local XComGameState_Effect				EffectState;
	local XComGameState_Unit				UnitState;

	History = `XCOMHISTORY;
	context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	Ability = XComGameState_Ability(History.GetGameStateForObjectID(context.InputContext.AbilityRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
	InteractingUnitRef = context.InputContext.SourceObject;
	BuildTrack = EmptyTrack;
	BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	SoundAndFlyover = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, context, false, BuildTrack.LastActionAdded));
	SoundAndFlyover.SetSoundAndFlyOverParameters(none, Ability.GetMyTemplate().LocFlyOverText, 'None', eColor_Alien);

	PlayAnimationAction = X2Action_PlayAnimation(class'X2Action_PlayAnimation'.static.AddToVisualizationTree(BuildTrack, context, false, BuildTrack.LastActionAdded));
	PlayAnimationAction.Params.AnimName = 'HL_WarCry';
	PlayAnimationAction.bFinishAnimationWait = true;

	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Effect', EffectState)
	{
		if (EffectState.GetX2Effect().EffectName == class'X2Effect_WarCry'.default.EffectName)
		{
				TargetTrack = EmptyTrack;
				UnitState = XComGameState_Unit(VisualizeGameState.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
				if ((UnitState != none) && (EffectState.StatChanges.Length > 0))
				{
					TargetTrack.StateObject_NewState = UnitState;
					TargetTrack.StateObject_OldState = History.GetGameStateForObjectID(UnitState.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
					TargetTrack.VisualizeActor = UnitState.GetVisualizer();
					SoundandFlyoverTarget = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(TargetTrack, context, false, TargetTrack.LastActionAdded));
					SoundandFlyoverTarget.SetSoundAndFlyOverParameters(none, Ability.GetMyTemplate().LocFlyOverText, 'None', eColor_Alien);
				}
		}
	}

}


static function X2AbilityTemplate CreateDroneShockAbility()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2Effect_ApplyWeaponDamage		PhysicalDamageEffect;
	local X2Effect_Persistent               DisorientedEffect;
	local X2Condition_Visibility            VisibilityCondition;
	local X2AbilityTarget_Single            SingleTarget;
	local array<name>                       SkipExclusions;
	local X2AbilityCost_Ammo				AmmoCost;
	`CREATE_X2ABILITY_TEMPLATE(Template, 'LWDroneShock');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_lightningfield";
	Template.Hostility = eHostility_Offensive;
	Template.AbilitySourceName = 'eAbilitySource_Standard';

	// Activated by a button press; additionally, tells the AI this is an activatable
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	// Targeting Details
	// Can only shoot visible enemies
	VisibilityCondition = new class'X2Condition_Visibility';
	VisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(VisibilityCondition);
	// Can't target dead; Can't target friendlies
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);
	// Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	// Only at single targets that are in range.
	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	// Action Point
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);


	//  Put holo target effect first because if the target dies from this shot, it will be too late to notify the effect.
	Template.AddTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.HoloTargetEffect());

	// Impairing effects need to come before the damage. This is needed for proper visualization ordering.
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect();
	DisorientedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(DisorientedEffect);

	//ALTERNATIVE : add the impairing as a bonus weapon effect so it can be different on different tier weapons -- see sword disorient/burning effects for examples
	Template.bAllowBonusWeaponEffects = true;

	// Damage Effect
	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(PhysicalDamageEffect);

	// Hit Calculation (Different weapons now have different calculations for range)
	Template.AbilityToHitCalc = default.SimpleStandardAim;
	Template.AbilityToHitOwnerOnMissCalc = default.SimpleStandardAim;

	// Targeting Method
	Template.TargetingMethod = class'X2TargetingMethod_OverTheShoulder';
	Template.bUsesFiringCamera = true;
	Template.CinescriptCameraType = "StandardGunFiring";

	Template.AssociatedPassives.AddItem('HoloTargeting');

	Template.CustomFireAnim = 'NO_ArcStun';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

	return Template;
}

static function X2DataTemplate CreateDroneRepairAbility()
{
	local X2AbilityTemplate							Template;
	local X2AbilityCost_ActionPoints				ActionPointCost;
	local X2Effect_RemoveEffectsByDamageType		RemoveEffects;
	local X2Condition_UnitProperty					UnitPropertyCondition;
	local X2Effect_SimpleHeal						RepairEffect;
	local X2Condition_Visibility					TargetVisibilityCondition;
	local X2AbilityTarget_Single					SingleTarget;
	local X2AbilityCooldown_LocalAndGlobal			Cooldown;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'LWDroneRepair');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityDroneRepair"; //from old EW Repair Servos icon
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Only at single targets that are in range.
	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = default.DRONE_REPAIR_ACTION_COST;
	ActionPointCost.bfreeCost = true;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = 3;
	Cooldown.NumGlobalTurns = 1;
	Template.AbilityCooldown = Cooldown;


	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	Template.bCrossClassEligible = false;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.bShowActivation = true;
	Template.DisplayTargetHitChance = false;

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeFullHealth = true;
	UnitPropertyCondition.ExcludeOrganic = true;
	UnitPropertyCondition.ExcludeRobotic = false;
	UnitPropertyCondition.FailOnNonUnits = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	RepairEffect = new class'X2Effect_SimpleHeal';
	Template.AddTargetEffect(RepairEffect);

	RemoveEffects = new class'X2Effect_RemoveEffectsByDamageType';
	RemoveEffects.DamageTypesToRemove.AddItem('Fire');
	RemoveEffects.DamageTypesToRemove.AddItem('Acid');
	Template.AddTargetEffect(RemoveEffects);

	Template.CustomFireAnim = 'NO_Repair';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


static function X2DataTemplate CreateDroneHealAbility()
{
	local X2AbilityTemplate							Template;
	local X2AbilityCost_ActionPoints				ActionPointCost;
	local X2Effect_RemoveEffectsByDamageType		RemoveEffects;
	local X2Condition_UnitProperty					UnitPropertyCondition;
	local X2Effect_SimpleHeal						RepairEffect;
	local X2Condition_Visibility					TargetVisibilityCondition;
	local X2AbilityTarget_Single					SingleTarget;
	local X2AbilityCooldown_LocalAndGlobal			Cooldown;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'LWDroneHeal');
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityDroneRepair"; //from old EW Repair Servos icon
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// Only at single targets that are in range.
	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.OnlyIncludeTargetsInsideWeaponRange = true;
	Template.AbilityTargetStyle = SingleTarget;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = default.DRONE_REPAIR_ACTION_COST;
	ActionPointCost.bfreeCost = true;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = 3;
	Cooldown.NumGlobalTurns = 1;
	Template.AbilityCooldown = Cooldown;


	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	Template.bCrossClassEligible = false;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.bShowActivation = true;
	Template.DisplayTargetHitChance = false;

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeFullHealth = true;
	UnitPropertyCondition.ExcludeOrganic = false;
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	RepairEffect = new class'X2Effect_SimpleHeal';
	Template.AddTargetEffect(RepairEffect);

	RemoveEffects = new class'X2Effect_RemoveEffectsByDamageType';
	RemoveEffects.DamageTypesToRemove.AddItem('Fire');
	RemoveEffects.DamageTypesToRemove.AddItem('Poison');
	RemoveEffects.DamageTypesToRemove.AddItem('PathogenicPoison');
	RemoveEffects.DamageTypesToRemove.AddItem('Acid');
	RemoveEffects.DamageTypesToRemove.AddItem('Bleeding');
	Template.AddTargetEffect(RemoveEffects);

	Template.CustomFireAnim = 'NO_Repair';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


static function X2AbilityTemplate AddDroneMeleeStun()
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityToHitCalc_StandardMelee HitCalc;
	//local X2Effect_ApplyWeaponDamage PhysicalDamageEffect;
	local X2Effect_Stunned				    StunnedEffect;
	local X2Condition_UnitProperty			AdjacencyCondition;
	local X2AbilityCooldown Cooldown;
	local X2Condition_UnitImmunities UnitImmunityCondition;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LWDroneMeleeStun');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_stun";

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.Hostility = eHostility_Offensive;

	Template.bShowActivation = true;
	//Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	//Template.bDontDisplayInAbilitySummary = true;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	UnitImmunityCondition.AddExcludeDamageType('stun');
	Template.AbilityTargetConditions.AddItem(UnitImmunityCondition);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.STUNNER_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	HitCalc = new class'X2AbilityToHitCalc_StandardMelee';
	HitCalc.BuiltInHitMod = default.DRONE_STUN_HIT_MODIFIER;
	Template.AbilityToHitCalc = HitCalc;

	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(default.DRONE_STUN_ACTION_POINT_DAMAGE, 100);
	StunnedEffect.bRemoveWhenSourceDies = false;
	Template.AddTargetEffect(StunnedEffect);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	// Target Conditions
	Template.AbilityTargetConditions.AddItem(default.LivingHostileUnitOnlyProperty); // changed to disallow environmental objects, since nothing will happen
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);
	AdjacencyCondition = new class'X2Condition_UnitProperty';
	AdjacencyCondition.RequireWithinRange = true;
	AdjacencyCondition.ExcludeStunned = true;
	AdjacencyCondition.WithinRange = 144; //1.5 tiles in Unreal units, allows attacks on the diag
	Template.AbilityTargetConditions.AddItem(AdjacencyCondition);

	// Damage Effect
	//PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	//Template.AddTargetEffect(PhysicalDamageEffect);

	Template.AbilityTargetStyle = default.SimpleSingleMeleeTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.CustomFireAnim = 'NO_Flash';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

//this ability links up grenades to an equipped grenade launcher
static function X2AbilityTemplate CreateAdventGrenadeLauncherAbility()
{
	local X2AbilityTemplate					Template;
	local X2Effect_AdventGrenadeLauncher	AdvGLEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AdventGrenadeLauncher');

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_grenade_flash";  // shouldn't ever display
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;

	AdvGLEffect = new class'X2Effect_AdventGrenadeLauncher';
	Template.AddTargetEffect(AdvGLEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}


static function X2DataTemplate CreateMassMindspinAbility()
{
	local X2AbilityTemplate							Template;
	local X2AbilityCost_ActionPoints				ActionPointCost;
	local X2AbilityCooldown_LocalAndGlobal			Cooldown;
	local X2Condition_UnitProperty					UnitPropertyCondition;
	//local X2Condition_Visibility        TargetVisibilityCondition;
	local X2Condition_UnitImmunities				UnitImmunityCondition;
	local X2Effect_PersistentStatChange				DisorientedEffect;
	local X2Effect_Panicked							PanickedEffect;
	local X2Effect_MindControl						MindControlEffect;
	local X2Effect_RemoveEffects					MindControlRemoveEffects;
	local X2Condition_UnitEffects					ExcludeEffects;
	local X2AbilityMultiTarget_Cone					ConeMultiTarget;
	local X2AbilityTarget_Cursor					CursorTarget;
	local X2AbilityToHitCalc_StatCheck_UnitVsUnit	ToHitCalc;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MassMindspin');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_sectoid_mindspin";
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Offensive;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.CLASS_LIEUTENANT_PRIORITY;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	ToHitCalc = new class'X2AbilityToHitCalc_StatCheck_UnitVsUnit';
	Template.AbilityToHitCalc = ToHitCalc;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = 3;
	Cooldown.NumGlobalTurns = 1;
	Template.AbilityCooldown = Cooldown;

	ConeMultiTarget = new class'X2AbilityMultiTarget_Cone';
	ConeMultiTarget.bExcludeSelfAsTargetIfWithinRadius = true;
	ConeMultiTarget.ConeEndDiameter = 12 * default.MASS_MINDSPIN_LW_CONE_END_DIAMETER;
	ConeMultiTarget.fTargetRadius = 99.0;
	ConeMultiTarget.ConeLength=default.MASS_MINDSPIN_LW_CONE_LENGTH;
	ConeMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = ConeMultiTarget;

	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToWeaponRange=false;
	Template.AbilityTargetStyle = CursorTarget;
	Template.TargetingMethod = class'X2TargetingMethod_MassMindspin';

	//Template.AbilityMultiTargetConditions.AddItem(default.LivingHostileTargetProperty);
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.ExcludeAlive=false;
	UnitPropertyCondition.ExcludeDead=true;
	UnitPropertyCondition.ExcludeFriendlyToSource=true;
	UnitPropertyCondition.ExcludeHostileToSource=false;
	UnitPropertyCondition.TreatMindControlledSquadmateAsHostile=false;
	Template.AbilityMultiTargetConditions.AddItem(UnitPropertyCondition);
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	//TargetVisibilityCondition = new class'X2Condition_Visibility';
	//TargetVisibilityCondition.bRequireGameplayVisible = true;
	//Template.AbilityMultiTargetConditions.AddItem(TargetVisibilityCondition);

	ExcludeEffects = new class'X2Condition_UnitEffects';
	ExcludeEffects.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_UnitIsImmune');
	ExcludeEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.StunnedName, 'AA_UnitIsStunned');
	ExcludeEffects.AddExcludeEffect(class'X2Effect_MindControl'.default.EffectName, 'AA_UnitIsMindControlled');
	Template.AbilityMultiTargetConditions.AddItem(ExcludeEffects);

	UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	UnitImmunityCondition.AddExcludeDamageType('Mental');
	UnitImmunityCondition.bOnlyOnCharacterTemplate = true;
	Template.AbilityMultiTargetConditions.AddItem(UnitImmunityCondition);

	//  Disorient effect for 1 unblocked psi hit
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect();
	DisorientedEffect.iNumTurns = class'X2Ability_Sectoid'.default.SECTOID_MINDSPIN_DISORIENTED_DURATION;
	DisorientedEffect.MinStatContestResult = 1;
	DisorientedEffect.MaxStatContestResult = 1;
	Template.AddMultiTargetEffect(DisorientedEffect);
	//  Disorient effect for 2 unblocked psi hits
	DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect();
	DisorientedEffect.iNumTurns = class'X2Ability_Sectoid'.default.SECTOID_MINDSPIN_DISORIENTED_DURATION + 1;
	DisorientedEffect.MinStatContestResult = 2;
	DisorientedEffect.MaxStatContestResult = 2;
	Template.AddMultiTargetEffect(DisorientedEffect);

	PanickedEffect = class'X2StatusEffects'.static.CreatePanickedStatusEffect();
	PanickedEffect.MinStatContestResult = 3;
	PanickedEffect.MaxStatContestResult = 4;
	Template.AddMultiTargetEffect(PanickedEffect);

	MindControlEffect = class'X2StatusEffects'.static.CreateMindControlStatusEffect(class'X2Ability_Sectoid'.default.SECTOID_MINDSPIN_CONTROL_DURATION);
	MindControlEffect.MinStatContestResult = 5;
	MindControlEffect.MaxStatContestResult = 0;
	Template.AddMultiTargetEffect(MindControlEffect);

	MindControlRemoveEffects = class'X2StatusEffects'.static.CreateMindControlRemoveEffects();
	MindControlRemoveEffects.MinStatContestResult = 5;
	MindControlRemoveEffects.MaxStatContestResult = 0;
	MindControlRemoveEffects.DamageTypes.AddItem('Mental');
	Template.AddMultiTargetEffect(MindControlRemoveEffects);

	// Unlike in other cases, in TypicalAbility_BuildVisualization, the MissSpeech is used on the Target!
	Template.TargetMissSpeech = 'SoldierResistsMindControl';

	Template.CustomFireAnim = 'HL_Psi_ProjectileMedium';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "Sectoid_Mindspin";

	// This action is considered 'hostile' and can be interrupted!
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

	//Need FX on targets

	return Template;
}

static function X2DataTemplate CreateMassReanimateAbility()
{
	local X2AbilityTemplate					Template;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2AbilityCooldown_LocalAndGlobal	Cooldown;
	local X2AbilityMultiTarget_Radius		RadiusMultiTarget;
	local X2AbilityTarget_Cursor			CursorTarget;
	local X2Condition_UnitProperty			UnitPropertyCondition;
	local X2Condition_UnitValue				UnitValue;
	local X2Effect_SpawnPsiZombie			SpawnZombieEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MassReanimation_LW');
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityMassreanimate";
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.Hostility = eHostility_Neutral;

	//should no longer be needed with custom anim
	//Template.bShowActivation = true;
	//Template.bSkipFireAction = true;

	//attempted new targeting method
	CursorTarget = new class'X2AbilityTarget_Cursor';
	CursorTarget.bRestrictToSquadsightRange = true;
	CursorTarget.FixedAbilityRange = default.MASS_REANIMATION_LW_RANGE_METERS;
	Template.AbilityTargetStyle = CursorTarget;

	//Template.AbilityTargetStyle = default.SelfTarget;

	Template.AbilityToHitCalc = default.Deadeye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = default.MASS_REANIMATION_LW_MIN_ACTION_COST;
	ActionPointCost.bConsumeAllPoints =false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = default.MASS_REANIMATION_LW_LOCAL_COOLDOWN;
	Cooldown.NumGlobalTurns = default.MASS_REANIMATION_LW_GLOBAL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = default.MASS_REANIMATION_LW_RADIUS_METERS;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = true;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = true;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.TargetingMethod = class'X2TargetingMethod_MassPsiReanimation';

	SpawnZombieEffect = new class'X2Effect_SpawnPsiZombie';
	SpawnZombieEffect.AnimationName = 'HL_GetUp_Multi';
	SpawnZombieEffect.BuildPersistentEffect(1);
	SpawnZombieEffect.StartAnimationMinDelaySec = class'X2Ability_GateKeeper'.default.MASS_REANIMATION_ANIMATION_MIN_DELAY_SEC;
	SpawnZombieEffect.StartAnimationMaxDelaySec = class'X2Ability_GateKeeper'.default.MASS_REANIMATION_ANIMATION_MAX_DELAY_SEC;

	// The unit must be organic, dead, and not an alien
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = false;
	UnitPropertyCondition.ExcludeAlive = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.ExcludeOrganic = false;
	UnitPropertyCondition.ExcludeAlien = true;
	UnitPropertyCondition.ExcludeCivilian = false;
	UnitPropertyCondition.ExcludeCosmetic = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeHostileToSource = false;
	UnitPropertyCondition.FailOnNonUnits = true;
	SpawnZombieEffect.TargetConditions.AddItem(UnitPropertyCondition);

	// This effect is only valid if the target has not yet been turned into a zombie
	UnitValue = new class'X2Condition_UnitValue';
	UnitValue.AddCheckValue(class'X2Effect_SpawnPsiZombie'.default.TurnedZombieName, 1, eCheck_LessThan);
	SpawnZombieEffect.TargetConditions.AddItem(UnitValue);

	Template.AddMultiTargetEffect(SpawnZombieEffect);

	//Template.bSkipPerkActivationActions = true;
	Template.CustomFireAnim = 'HL_Psi_MassReanimate';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = AnimaInversion_BuildVisualization_SC;
	Template.CinescriptCameraType = "Sectoid_PsiReanimation";

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

	return Template;
}

simulated function AnimaInversion_BuildVisualization_SC(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability Context;
	local StateObjectReference InteractingUnitRef;
	local VisualizationActionMetadata EmptyTrack;
	local VisualizationActionMetadata GatekeeperTrack, BuildTrack, ZombieTrack;
	local XComGameState_Unit SpawnedUnit, DeadUnit;
	local UnitValue SpawnedUnitValue;
	local X2Effect_SpawnPsiZombie SpawnPsiZombieEffect;
	local int i, j;
	local name SpawnPsiZombieEffectResult;
	local X2VisualizerInterface TargetVisualizerInterface;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	GatekeeperTrack = EmptyTrack;
	GatekeeperTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	GatekeeperTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	GatekeeperTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	class'X2Action_AbilityPerkStart'.static.AddToVisualizationTree(GatekeeperTrack, Context, false, GatekeeperTrack.LastActionAdded);
	class'X2Action_ExitCover'.static.AddToVisualizationTree(GatekeeperTrack, Context, false, GatekeeperTrack.LastActionAdded);
	class'X2Action_Fire'.static.AddToVisualizationTree(GatekeeperTrack, Context, false, GatekeeperTrack.LastActionAdded);
	class'X2Action_EnterCover'.static.AddToVisualizationTree(GatekeeperTrack, Context, false, GatekeeperTrack.LastActionAdded);
	class'X2Action_AbilityPerkEnd'.static.AddToVisualizationTree(GatekeeperTrack, Context, false, GatekeeperTrack.LastActionAdded);

	// Configure the visualization track for the multi targets
	//******************************************************************************************
	for( i = 0; i < Context.InputContext.MultiTargets.Length; ++i )
	{
		InteractingUnitRef = Context.InputContext.MultiTargets[i];
		BuildTrack = EmptyTrack;
		BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
		BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
		BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

		//class'X2Action_WaitForAbilityEffect'.static.AddToVisualizationTree(BuildTrack, Context, false, BuildTrack.LastActionAdded);

		for( j = 0; j < Context.ResultContext.MultiTargetEffectResults[i].Effects.Length; ++j )
		{
			SpawnPsiZombieEffect = X2Effect_SpawnPsiZombie(Context.ResultContext.MultiTargetEffectResults[i].Effects[j]);
			SpawnPsiZombieEffectResult = 'AA_UnknownError';

			if( SpawnPsiZombieEffect != none )
			{
				SpawnPsiZombieEffectResult = Context.ResultContext.MultiTargetEffectResults[i].ApplyResults[j];
			}
			else
			{
				Context.ResultContext.MultiTargetEffectResults[i].Effects[j].AddX2ActionsForVisualization(VisualizeGameState, BuildTrack, Context.ResultContext.MultiTargetEffectResults[i].ApplyResults[j]);
			}
		}

		TargetVisualizerInterface = X2VisualizerInterface(BuildTrack.VisualizeActor);
		if( TargetVisualizerInterface != none )
		{
			//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
			TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, BuildTrack);
		}

		if( SpawnPsiZombieEffectResult == 'AA_Success' )
		{
			DeadUnit = XComGameState_Unit(VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID));
			`assert(DeadUnit != none);
			DeadUnit.GetUnitValue(class'X2Effect_SpawnUnit'.default.SpawnedUnitValueName, SpawnedUnitValue);

			ZombieTrack = EmptyTrack;
			ZombieTrack.StateObject_OldState = History.GetGameStateForObjectID(SpawnedUnitValue.fValue, eReturnType_Reference, VisualizeGameState.HistoryIndex);
			ZombieTrack.StateObject_NewState = ZombieTrack.StateObject_OldState;
			SpawnedUnit = XComGameState_Unit(ZombieTrack.StateObject_NewState);
			`assert(SpawnedUnit != none);
			ZombieTrack.VisualizeActor = History.GetVisualizer(SpawnedUnit.ObjectID);

			SpawnPsiZombieEffect.AddSpawnVisualizationsToTracks(Context, SpawnedUnit, ZombieTrack, DeadUnit, BuildTrack);
		}
	}
}

static function X2DataTemplate CreatePersonalShieldAbility()
{
	local X2AbilityTemplate							Template;
	local X2AbilityCooldown							Cooldown;
	local X2AbilityCost_ActionPoints				ActionPointCost;
	local array<name>								SkipExclusions;
	local X2Effect_EnergyShield						PersonalShieldEffect;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'PersonalShield');

	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityPersonalShields"; // from old EW icon for Bioelectric skin
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bCrossClassEligible = false;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.bShowActivation = true;
	//Template.bSkipFireAction = true;
	Template.DisplayTargetHitChance = false;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName); //okay when disoriented
	Template.AddShooterEffectExclusions(SkipExclusions);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = default.PERSONAL_SHIELD_ACTION_COST;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.PERSONAL_SHIELD_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	PersonalShieldEffect = new class'X2Effect_EnergyShield';
	PersonalShieldEffect.BuildPersistentEffect(default.PERSONAL_SHIELD_DURATION, false, true, false, eGameRule_PlayerTurnEnd);
	PersonalShieldEffect.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	PersonalShieldEffect.AddPersistentStatChange(eStat_ShieldHP, default.PERSONAL_SHIELD_HP);
	PersonalShieldEffect.EffectName='PersonalShield';
	Template.AddTargetEffect(PersonalShieldEffect);

	Template.CustomFireAnim = 'HL_SignalPositive';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "AdvShieldBearer_EnergyShieldArmor"; //??

	return Template;
}


static function X2DataTemplate CreateReadyForAnythingAbility()
{
	local X2AbilityTemplate							Template;
	local X2Effect_ReadyForAnything					ActionPointEffect;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'ReadyForAnything');

	Template.IconImage = "img:///UILibrary_LWAlienPack.LW_AbilityReadyForAnything";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowActivation = false;
	Template.bIsPassive = true;
	Template.bDisplayInUITooltip = true;
	Template.bDisplayInUITacticalText = true;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	ActionPointEffect = new class'X2Effect_ReadyForAnything';
	ActionPointEffect.BuildPersistentEffect (1, true, false);
	ActionPointEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	Template.AddTargetEffect(ActionPointEffect);

	//Template.AdditionalAbilities.AddItem('ReadyForAnythingFlyover');

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;


	return Template;
}

static function X2DataTemplate ReadyForAnythingFlyover()
{
	local X2AbilityTemplate					Template;
	local X2AbilityTrigger_EventListener	EventListener;

	`CREATE_X2ABILITY_TEMPLATE (Template, 'ReadyForAnythingFlyover');

	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.bShowActivation = true;
	Template.bSkipFireAction = true;
	Template.bDontDisplayInAbilitySummary = true;

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.EventID = 'ReadyForAnythingTriggered';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);

	Template.CinescriptCameraType = "Overwatch";

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = ReadyforAnything_BuildVisualization;

	return Template;
}

simulated function ReadyForAnything_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory			History;
	local XComGameStateContext_Ability	Context;
	local VisualizationActionMetadata	EmptyTrack;
	local VisualizationActionMetadata	BuildTrack;
	local X2Action_PlaySoundAndFlyOver	SoundAndFlyOver;
	local StateObjectReference			InteractingUnitRef;
	local XComGameState_Ability			Ability;

	History = `XCOMHISTORY;
	context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;
	Ability = XComGameState_Ability(History.GetGameStateForObjectID(context.InputContext.AbilityRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1));
	BuildTrack = EmptyTrack;
	BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	BuildTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, Context, false, BuildTrack.LastActionAdded));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(SoundCue'SoundUI.OverWatchCue', Ability.GetMyTemplate().LocFlyOverText, '', eColor_Alien, "img:///UILibrary_PerkIcons.UIPerk_overwatch");
}

static function X2AbilityTemplate CreateChryssalidSoldierSlashAbility()
{
	local X2AbilityTemplate Template;
	local X2Effect_HiveQueenSlash	DamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ChryssalidSoldierSlash');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_chryssalid_slash";

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	DamageEffect = new class'X2Effect_HiveQueenSlash';
	DamageEffect.BonusDamage = default.CHRYSSALID_SOLDIER_SLASH_BONUS_DAMAGE;
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, 'eAbilitySource_Perk');
	Template.AddTargetEffect(DamageEffect);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;

	return Template;
}

static function X2AbilityTemplate CreateHiveQueenSlashAbility()
{
	local X2AbilityTemplate Template;
	local X2Effect_HiveQueenSlash	DamageEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HiveQueenSlash');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_chryssalid_slash";

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bIsPassive = true;
	DamageEffect = new class'X2Effect_HiveQueenSlash';
	DamageEffect.BonusDamage = default.HIVE_QUEEN_SLASH_BONUS_DAMAGE;
	DamageEffect.BuildPersistentEffect(1, true, false, false);
	DamageEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, 'eAbilitySource_Perk');
	Template.AddTargetEffect(DamageEffect);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;

	return Template;
}


static function X2AbilityTemplate AddFireOnDeathAbility()
{
	local X2AbilityTemplate						Template;
	local X2AbilityMultiTarget_Radius			RadiusMultiTarget;
	local X2Effect_Burning						BurningEffect;
	local X2AbilityTrigger_EventListener		Trigger;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'FireOnDeath');
	Template.IconImage = "img:///UILibrary_LW_Overhaul.LW_AbilityIgnition";
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bSkipFireAction = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;

	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.fTargetRadius = 1.5f;
	RadiusMultiTarget.bUseWeaponRadius = false;
	RadiusMultiTarget.bUseSourceWeaponLocation = false;
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAddPrimaryTargetAsMultiTarget = true;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = false;
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Trigger = New class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.EventID = 'UnitDied';
	Trigger.ListenerData.Filter = eFilter_Unit;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self_VisualizeInGameState;
	Template.AbilityTriggers.AddItem(Trigger);

	Template.AddMultiTargetEffect(new class'X2Effect_ApplyFireToWorld');

	BurningEffect = class'X2StatusEffects'.static.CreateBurningStatusEffect(1, 0);
	BurningEffect.ApplyChance = 25;
	Template.AddMultiTargetEffect(BurningEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

static function X2DataTemplate CreateEnergyShieldAbility(name TemplateName, int ShieldPoints)
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCharges Charges;
	local X2AbilityCost_Charges ChargeCost;
	local X2AbilityCooldown_LocalAndGlobal Cooldown;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2AbilityTrigger_PlayerInput InputTrigger;
	local X2Effect_PersistentStatChange ShieldedEffect;
	local X2AbilityMultiTarget_Radius MultiTarget;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_adventshieldbearer_energyshield";

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.Hostility = eHostility_Defensive;

	// This ability is a free action
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Charges = new class 'X2AbilityCharges';
	Charges.InitialCharges = 1;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	Template.AbilityCosts.AddItem(ChargeCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = class'X2Ability_AdventShieldbearer'.default.ENERGY_SHIELD_COOLDOWN;
	Cooldown.NumGlobalTurns = class'X2Ability_AdventShieldbearer'.default.ENERGY_SHIELD_GLOBAL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

	//Can't use while dead
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	// Add dead eye to guarantee
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;

	// Multi target
	MultiTarget = new class'X2AbilityMultiTarget_Radius';
	MultiTarget.fTargetRadius = class'X2Ability_AdventShieldbearer'.default.ENERGY_SHIELD_RANGE_METERS;
	MultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = MultiTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	// The Targets must be within the AOE, LOS, and friendly
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeHostileToSource = true;
	UnitPropertyCondition.ExcludeCivilian = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	Template.AbilityMultiTargetConditions.AddItem(UnitPropertyCondition);

	// Friendlies in the radius receives a shield receives a shield
	ShieldedEffect = class'X2Ability_AdventShieldbearer'.static.CreateShieldedEffect(Template.LocFriendlyName, Template.GetMyLongDescription(), ShieldPoints);

	Template.AddShooterEffect(ShieldedEffect);
	Template.AddMultiTargetEffect(ShieldedEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_AdventShieldbearer'.static.Shielded_BuildVisualization;
	Template.CinescriptCameraType = "AdvShieldBearer_EnergyShieldArmor";

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;
	
	return Template;
}


static function X2AbilityTemplate CreateDevastatingPunchAbility(Name AbilityName, WeaponDamageValue DamageValue, int MovementRangeAdjustment=1)
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityToHitCalc_StandardMelee MeleeHitCalc;
	local X2Effect_ApplyWeaponDamage PhysicalDamageEffect;
	local X2Effect_ImmediateAbilityActivation BrainDamageAbilityEffect;
	local X2AbilityTarget_MovingMelee MeleeTarget;
	local X2Effect_Knockback KnockbackEffect;
	local array<name> SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, AbilityName);
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_muton_punch";
	Template.Hostility = eHostility_Offensive;
	Template.AbilitySourceName = 'eAbilitySource_Standard';

	Template.AdditionalAbilities.AddItem(class'X2Ability_Impairing'.default.ImpairingAbilityName);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	MeleeHitCalc = new class'X2AbilityToHitCalc_StandardMelee';
	Template.AbilityToHitCalc = MeleeHitCalc;

	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	MeleeTarget.MovementRangeAdjustment = MovementRangeAdjustment;
	Template.AbilityTargetStyle = MeleeTarget;
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_PlayerInput');
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	
	// May punch if the unit is burning or disoriented
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	Template.AbilityTargetConditions.AddItem(new class'X2Condition_BerserkerDevastatingPunch');	
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue = DamageValue;
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	PhysicalDamageEffect.HideVisualizationOfResultsAdditional.AddItem('AA_HitResultFailure');
	Template.AddTargetEffect(PhysicalDamageEffect);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue = class'X2Item_DefaultWeapons'.default.BERSERKER_MELEEATTACK_MISSDAMAGE;
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	PhysicalDamageEffect.bApplyOnHit = False;
	PhysicalDamageEffect.bApplyOnMiss = True;
	PhysicalDamageEffect.bIgnoreBaseDamage = True;
	PhysicalDamageEffect.HideVisualizationOfResultsAdditional.AddItem('AA_HitResultFailure');
	Template.AddTargetEffect(PhysicalDamageEffect);

	//Impairing effects need to come after the damage. This is needed for proper visualization ordering.
	//Effect on a successful melee attack is triggering the BrainDamage Ability
	BrainDamageAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	BrainDamageAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	BrainDamageAbilityEffect.EffectName = 'ImmediateBrainDamage';
	// NOTICE: For now StunLancer, Muton, and Berserker all use this ability. This may change.
	BrainDamageAbilityEffect.AbilityName = class'X2Ability_Impairing'.default.ImpairingAbilityName;
	BrainDamageAbilityEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
	BrainDamageAbilityEffect.bRemoveWhenTargetDies = true;
	BrainDamageAbilityEffect.VisualizationFn = class'X2Ability_Impairing'.static.ImpairingAbilityEffectTriggeredVisualization;
	Template.AddTargetEffect(BrainDamageAbilityEffect);

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 5; //Knockback 5 meters
	Template.AddTargetEffect(KnockbackEffect);

	Template.CustomFireAnim = 'FF_Melee';
	Template.bSkipMoveStop = true;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.bOverrideMeleeDeath = true;
	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_Berserker'.static.DevastatingPunchAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;
	Template.CinescriptCameraType = "Berserker_DevastatingPunch";
	
	return Template;
}

static function X2AbilityTemplate CreateSlashAbility(Name AbilityName, WeaponDamageValue Damage)
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityToHitCalc_StandardMelee MeleeHitCalc;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Effect_ApplyWeaponDamage PhysicalDamageEffect;
	local X2Effect_ParthenogenicPoison ParthenogenicPoisonEffect;
	local X2AbilityTarget_MovingMelee MeleeTarget;
	local array<name> SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, AbilityName);
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_chryssalid_slash";
	Template.Hostility = eHostility_Offensive;
	Template.AbilitySourceName = 'eAbilitySource_Standard';

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	MeleeHitCalc = new class'X2AbilityToHitCalc_StandardMelee';
	Template.AbilityToHitCalc = MeleeHitCalc;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	
	// May slash if the unit is burning or disoriented
	SkipExclusions.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false; // Disable this to allow civilians to be attacked.
	UnitPropertyCondition.ExcludeSquadmates = true;		   // Don't attack other AI units.
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
	
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);

	ParthenogenicPoisonEffect = new class'X2Effect_ParthenogenicPoison';
	ParthenogenicPoisonEffect.BuildPersistentEffect(class'X2Ability_Chryssalid'.default.POISON_DURATION, true, false, false, eGameRule_PlayerTurnEnd);
	ParthenogenicPoisonEffect.SetDisplayInfo(ePerkBuff_Penalty, class'X2Ability_Chryssalid'.default.ParthenogenicPoisonFriendlyName, class'X2Ability_Chryssalid'.default.ParthenogenicPoisonFriendlyName, Template.IconImage, true);
	ParthenogenicPoisonEffect.DuplicateResponse = eDupe_Ignore;
	ParthenogenicPoisonEffect.SetPoisonDamageDamage();

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.ExcludeAlive = false;
	UnitPropertyCondition.ExcludeDead = false;
	UnitPropertyCondition.FailOnNonUnits = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	ParthenogenicPoisonEffect.TargetConditions.AddItem(UnitPropertyCondition);
	Template.AddTargetEffect(ParthenogenicPoisonEffect);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue = Damage;
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	Template.AddTargetEffect(PhysicalDamageEffect);

	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	MeleeTarget.MovementRangeAdjustment = 0;
	Template.AbilityTargetStyle = MeleeTarget;
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_PlayerInput');
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');

	Template.CustomFireAnim = 'FF_Melee';
	Template.bSkipMoveStop = true;
	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;
	Template.CinescriptCameraType = "Chryssalid_PoisonousClaws";

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.MeleeLostSpawnIncreasePerUse;
	Template.bFrameEvenWhenUnitIsHidden = true;

	return Template;
}


static function X2AbilityTemplate CreateLostHPBuff()
{
	local X2AbilityTemplate					Template;
	local X2Effect_PctHpBuff				StatEffect;
	local X2AbilityTarget_Self	TargetStyle;
	`CREATE_X2ABILITY_TEMPLATE(Template, 'LostHpPctBuff');
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.IconImage = "img:///Texture2D'UILibrary_LWAlienPack.LWCenturion_AbilityWarCry64'";
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.Deadeye;

	TargetStyle = new class 'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	StatEffect = new class'X2Effect_PctHpBuff';

	StatEffect.Pctbuff = 1.67f;

	StatEffect.BuildPersistentEffect(1, true, true, false, eGameRule_PlayerTurnEnd);
	StatEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, class'X2Effect_WarCry'.default.strWarCryFriendlyDesc, Template.IconImage,false,, Template.AbilitySourceName);
	StatEffect.DuplicateResponse = eDupe_Refresh;

	Template.AddTargetEffect(StatEffect);

	Template.bSkipFireAction = true;
	Template.bShowActivation = false;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


static function X2AbilityTemplate AddNewKillSiredZombies()
{
	return class'X2Ability_Sectoid'.static.AddKillLinkedUnits('KillSiredZombies', class'X2Ability_Sectoid'.default.SireZombieLinkName, class'X2Action_ZombieSireDeath', false);
}


static function X2AbilityTemplate CreateSwitchToRobot_LeaderAbility()
{
	local X2AbilityTemplate Template;
	local X2AbilityTrigger_EventListener EventListener;
	local X2Condition_UnitValue UnitValue;
	local X2Effect_SetUnitValue SetUnitValEffect;
	local X2Effect_SwitchToRobot_Leader SwitchToRobotEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'SwitchToRobot_Leader');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_andromedon_robotbattlesuit"; // TODO: This needs to be changed

	Template.bDontDisplayInAbilitySummary = true;
	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	// This ability is only valid if there has not been another death explosion on the unit
	UnitValue = new class'X2Condition_UnitValue';
	UnitValue.AddCheckValue('InRobotMode', 1, eCheck_LessThan);
	Template.AbilityShooterConditions.AddItem(UnitValue);

	// This ability fires when the Andromedon dies
	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitDied';
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self_VisualizeInGameState;
	EventListener.ListenerData.Priority = 45; //This ability must get triggered after the rest of the on-death listeners (namely, after mind-control effects get removed)
	Template.AbilityTriggers.AddItem(EventListener);

	// Targets the Andromedon unit so it can be replaced by the andromedon robot;
	Template.AbilityTargetStyle = default.SelfTarget;

	// Add dead eye to guarantee the explosion occurs
	Template.AbilityToHitCalc = default.DeadEye;

	// The target will now be turned into a robot
	SwitchToRobotEffect = new class'X2Effect_SwitchToRobot_Leader';
	SwitchToRobotEffect.BuildPersistentEffect(1);
	Template.AddTargetEffect(SwitchToRobotEffect);

	// Once this ability is fired, set the InRobotMode Unit Value so it will not happen again
	SetUnitValEffect = new class'X2Effect_SetUnitValue';
	SetUnitValEffect.UnitName = 'InRobotMode';
	SetUnitValEffect.NewValueToSet = 1;
	SetUnitValEffect.CleanupType = eCleanup_Never;
	Template.AddTargetEffect(SetUnitValEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = SwitchToRobot_Leader_BuildVisualization;
	Template.MergeVisualizationFn = SwitchToRobot_Leader_VisualizationMerge;
	Template.FrameAbilityCameraType = eCameraFraming_Never;

	return Template;
}


simulated function SwitchToRobot_Leader_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateContext_Ability Context;
	local XComGameStateHistory History;
	local VisualizationActionMetadata EmptyTrack, SpawnedUnitTrack, DeadUnitTrack;
	local XComGameState_Unit SpawnedUnit, DeadUnit;
	local UnitValue SpawnedUnitValue;
	local X2Effect_SwitchToRobot_Leader SwitchToRobotEffect;
	local XComGameState_Ability AbilityState;
	local X2AbilityTemplate AbilityTemplate;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	History = `XCOMHISTORY;

	DeadUnit = XComGameState_Unit(VisualizeGameState.GetGameStateForObjectID(Context.InputContext.PrimaryTarget.ObjectID));
	`assert(DeadUnit != none);

	DeadUnit.GetUnitValue(class'X2Effect_SpawnUnit'.default.SpawnedUnitValueName, SpawnedUnitValue);

	// The Spawned unit should appear and play its change animation
	DeadUnitTrack = EmptyTrack;
	DeadUnitTrack.StateObject_OldState = DeadUnit;
	DeadUnitTrack.StateObject_NewState = DeadUnitTrack.StateObject_OldState;
	DeadUnitTrack.VisualizeActor = History.GetVisualizer(DeadUnit.ObjectID);

	// The Spawned unit should appear and play its change animation
	SpawnedUnitTrack = EmptyTrack;
	SpawnedUnitTrack.StateObject_OldState = History.GetGameStateForObjectID(SpawnedUnitValue.fValue, eReturnType_Reference, VisualizeGameState.HistoryIndex);
	SpawnedUnitTrack.StateObject_NewState = SpawnedUnitTrack.StateObject_OldState;
	SpawnedUnit = XComGameState_Unit(SpawnedUnitTrack.StateObject_NewState);
	`assert(SpawnedUnit != none);
	SpawnedUnitTrack.VisualizeActor = History.GetVisualizer(SpawnedUnit.ObjectID);

	// Only first target effect is X2Effect_SwitchToRobot
	SwitchToRobotEffect = X2Effect_SwitchToRobot_Leader(Context.ResultContext.TargetEffectResults.Effects[0]);

	if( SwitchToRobotEffect == none )
	{
		// This can happen due to replays. In replays, when moving Context visualizations forward the Context has not
		// been fully filled in.
		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(Context.InputContext.AbilityRef.ObjectID));
		AbilityTemplate = AbilityState.GetMyTemplate();
		SwitchToRobotEffect = X2Effect_SwitchToRobot_Leader(AbilityTemplate.AbilityTargetEffects[0]);
	}

	if( SwitchToRobotEffect == none )
	{
		`RedScreenOnce("SwitchToRobot_BuildVisualization: Missing X2Effect_SwitchToRobot -dslonneger @gameplay");
	}
	else
	{
		SwitchToRobotEffect.AddSpawnVisualizationsToTracks(Context, SpawnedUnit, SpawnedUnitTrack, DeadUnit, DeadUnitTrack);
	}
}

static function SwitchToRobot_Leader_VisualizationMerge(X2Action BuildTree, out X2Action VisualizationTree)
{
	local X2Action DeathAction;		
	local X2Action BuildTreeStartNode, BuildTreeEndNode;	
	local XComGameStateVisualizationMgr LocalVisualizationMgr;

	LocalVisualizationMgr = `XCOMVISUALIZATIONMGR;

	DeathAction = LocalVisualizationMgr.GetNodeOfType(VisualizationTree, class'X2Action_AndromedonDeathAction', none, BuildTree.Metadata.StateObjectRef.ObjectID);
	if (DeathAction == none)
	{
		//Fall back to regular death action if we need to
		DeathAction = LocalVisualizationMgr.GetNodeOfType(VisualizationTree, class'X2Action_Death', none, BuildTree.Metadata.StateObjectRef.ObjectID);
	}
	BuildTreeStartNode = LocalVisualizationMgr.GetNodeOfType(BuildTree, class'X2Action_MarkerTreeInsertBegin');	
	BuildTreeEndNode = LocalVisualizationMgr.GetNodeOfType(BuildTree, class'X2Action_MarkerTreeInsertEnd');	
	LocalVisualizationMgr.InsertSubtree(BuildTreeStartNode, BuildTreeEndNode, DeathAction);
}

static function X2AbilityTemplate CreateImmunities_LeaderAbility()
{
	local X2AbilityTemplate Template;
	local X2AbilityTrigger_UnitPostBeginPlay Trigger;
	local X2Effect_DamageImmunity DamageImmunity;
	local X2Effect_OverrideDeathAction DeathActionEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'AndromedonImmunities_Leader');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_absorption_fields"; // TODO: This needs to be changed

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;

	Template.AbilityTargetStyle = default.SelfTarget;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	// Build the immunities
	DamageImmunity = new class'X2Effect_DamageImmunity';
	DamageImmunity.BuildPersistentEffect(1, true, true, true);
	DamageImmunity.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,,Template.AbilitySourceName);
	DamageImmunity.ImmuneTypes.AddItem('Fire');
	DamageImmunity.ImmuneTypes.AddItem('Poison');
	DamageImmunity.ImmuneTypes.AddItem('Acid');
	DamageImmunity.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.KnockbackDamageType);
	DamageImmunity.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.ParthenogenicPoisonType);

	Template.AddTargetEffect(DamageImmunity);

	DeathActionEffect = new class'X2Effect_OverrideDeathAction';
	DeathActionEffect.DeathActionClass = class'X2Action_AndromedonLeaderDeathAction';
	Template.AddTargetEffect(DeathActionEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}


static function X2AbilityTemplate AddArtillery()
{
	return PurePassive('Artillery_LW', "img:///UILibrary_LW_PerkPack.LW_AbilityBombard",true, 'eAbilitySource_Perk');
}

static function X2DataTemplate PsiSpit_LW()
{
	local X2AbilityTemplate             Template;
	local X2AbilityCost_ActionPoints    ActionPointCost;
	local X2AbilityCooldown_LocalAndGlobal Cooldown;
	local X2Condition_UnitProperty      UnitPropertyCondition;
	local X2Condition_Visibility        TargetVisibilityCondition;
	local X2Condition_UnitEffects		ExcludeEffects;
	local X2AbilityTarget_Single        SingleTarget;
	local X2AbilityTrigger_PlayerInput  InputTrigger;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local X2Effect_ModifyTemplarFocus FocusEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'PsiSpit_LW');
	
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_harborwave";

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = 1;
	Cooldown.NumGlobalTurns = 0;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityToHitCalc = default.DeadEye;

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	Template.AbilityShooterConditions.AddItem(UnitPropertyCondition);

	Template.AddShooterEffectExclusions();

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
	
	TargetVisibilityCondition = new class'X2Condition_Visibility';	
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);

	ExcludeEffects = new class'X2Condition_UnitEffects';
	ExcludeEffects.AddExcludeEffect(class'X2Ability_CarryUnit'.default.CarryUnitEffectName, 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(ExcludeEffects);


	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);

	Template.AddTargetEffect(class'X2StatusEffects'.static.CreatePoisonedStatusEffect());

	FocusEffect = new class'X2Effect_ModifyTemplarFocus';
	Template.AddShooterEffect(FocusEffect);

	SingleTarget = new class'X2AbilityTarget_Single';
	Template.AbilityTargetStyle = SingleTarget;

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);


	//Template.CustomFireAnim = 'HL_Psi_ProjectileMedium';
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.CinescriptCameraType = "Viper_PoisonSpit";

	// This action is considered 'hostile' and can be interrupted!
	Template.Hostility = eHostility_Offensive;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	
	return Template;
}

static function X2AbilityTemplate VorpalCharge()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2Condition_UnitProperty          TargetPropertyCondition;
	local X2Condition_UnitProperty          ShooterPropertyCondition;
	local X2AbilityTarget_MovingMelee       MeleeTarget;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	
	local X2AbilityCooldown                 Cooldown;
	local X2AbilityCost_Focus				FocusCost;
	`CREATE_X2ABILITY_TEMPLATE(Template, 'VorpalCharge');

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///UILibrary_XPerkIconPack_LW.UIPerk_lightning_knife";

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	FocusCost = new class'X2AbilityCost_Focus';
	FocusCost.FocusAmount = 1;
	FocusCost.ConsumeAllFocus = true;
	Template.AbilityCosts.AddItem(FocusCost);

	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	Template.AbilityTargetStyle = MeleeTarget;

	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';

	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_PlayerInput');
	Template.AbilityTriggers.AddItem(new class'X2AbilityTrigger_EndOfMove');


	// Target Conditions
	//
	TargetPropertyCondition = new class'X2Condition_UnitProperty';	
	TargetPropertyCondition.ExcludeDead = true;                     //Can't target dead
	TargetPropertyCondition.ExcludeFriendlyToSource = true;         //Can't target friendlies
	Template.AbilityTargetConditions.AddItem(TargetPropertyCondition);
	Template.AbilityTargetConditions.AddItem(default.MeleeVisibilityCondition);

	// Shooter Conditions
	//
	ShooterPropertyCondition = new class'X2Condition_UnitProperty';	
	ShooterPropertyCondition.ExcludeDead = true;                    //Can't shoot while dead
	Template.AbilityShooterConditions.AddItem(ShooterPropertyCondition);

	Template.AddShooterEffectExclusions();

	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_StandardMelee';

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 1;
	Template.AbilityCooldown = Cooldown;

	// Damage Effect
	//
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(WeaponDamageEffect);

	Template.PostActivationEvents.AddItem('PartingSilkActivated');

	Template.bSkipMoveStop = true;
	Template.bShowActivation = true;

	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}


static function X2AbilityTemplate SideWinderFocus()
{
	local X2AbilityTemplate		Template;
	local X2Effect_TemplarFocus	FocusEffect;
	local array<StatChange>		StatChanges;
	local StatChange			NewStatChange;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'SidewinderFocus');

//BEGIN AUTOGENERATED CODE: Template Overrides 'TemplarFocus'
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_InnerFocus";
	Template.AbilitySourceName = 'eAbilitySource_Psionic';
//END AUTOGENERATED CODE: Template Overrides 'TemplarFocus'
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bIsPassive = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	FocusEffect = new class'X2Effect_TemplarFocus';
	FocusEffect.BuildPersistentEffect(1, true, false);
	FocusEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true, , Template.AbilitySourceName);
	FocusEffect.EffectSyncVisualizationFn = class'X2Ability_TemplarAbilitySet'.static.FocusEffectVisualization;
	FocusEffect.VisualizationFn = class'X2Ability_TemplarAbilitySet'.static.FocusEffectVisualization;

	//	focus 0
	StatChanges.Length = 0;
	FocusEffect.AddNextFocusLevel(StatChanges, 0, 0);
	//	focus 1
	StatChanges.Length = 0;
	NewStatChange.StatType = eStat_Mobility;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS1MOBILITY;
	StatChanges.AddItem(NewStatChange);
	NewStatChange.StatType = eStat_Offense;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS1AIM;
	StatChanges.AddItem(NewStatChange);
	NewStatChange.StatType = eStat_CritChance;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS1CRIT;
	StatChanges.AddItem(NewStatChange);
	FocusEffect.AddNextFocusLevel(StatChanges, 0, 0);
	//	focus 2
	StatChanges.Length = 0;
	NewStatChange.StatType = eStat_Mobility;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS2MOBILITY;
	StatChanges.AddItem(NewStatChange);
	NewStatChange.StatType = eStat_Offense;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS2AIM;
	StatChanges.AddItem(NewStatChange);
	NewStatChange.StatType = eStat_CritChance;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS2CRIT;
	StatChanges.AddItem(NewStatChange);
	FocusEffect.AddNextFocusLevel(StatChanges, 0, 0);
	//	focus 3
	StatChanges.Length = 0;
	NewStatChange.StatType = eStat_Mobility;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS3MOBILITY;
	StatChanges.AddItem(NewStatChange);
	NewStatChange.StatType = eStat_Offense;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS3AIM;
	StatChanges.AddItem(NewStatChange);
	NewStatChange.StatType = eStat_CritChance;
	NewStatChange.StatAmount = default.SIDEWINDER_FOCUS3CRIT;
	StatChanges.AddItem(NewStatChange);
	FocusEffect.AddNextFocusLevel(StatChanges, 0, 0);

	Template.AddTargetEffect(FocusEffect);

	Template.AdditionalAbilities.AddItem('FocusKillTracker');

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.bSkipFireAction = true;

	return Template;
}


static function X2AbilityTemplate CreateHunterMarkAdvent()
{
	local X2AbilityTemplate             Template;
	local X2Effect_Persistent           PersistentEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HunterMarkAdvent');

	Template.IconImage = "img:///LWAdventPathfinderCaptain_UI.Perks.UIPerk_advent_HunterShot";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bIsPassive = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	//  This is a dummy effect so that an icon shows up in the UI.
	//  Shot and Suppression abilities make use of HoloTargetEffect().
	PersistentEffect = new class'X2Effect_Persistent';
	PersistentEffect.BuildPersistentEffect(1, true, true);
	PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,,Template.AbilitySourceName);
	Template.AddTargetEffect(PersistentEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	// Note: no visualization on purpose!

	Template.bCrossClassEligible = true;

	return Template;
}

static function X2Effect_HunterMarkAdvent HunterMarkAdventEffect()
{
	local X2Effect_HunterMarkAdvent           Effect;
	local X2Condition_AbilityProperty         AbilityCondition;
	local X2AbilityTag                        AbilityTag;

	Effect = new class'X2Effect_HunterMarkAdvent';
	Effect.BuildPersistentEffect(3, false, false, false, eGameRule_PlayerTurnBegin);
	Effect.bRemoveWhenTargetDies = true;
	Effect.bUseSourcePlayerState = true;
	Effect.VFXTemplateName = "LWPerk_HunterMarkAdvent.fX.P_HunterMark";
	Effect.VFXSocket = 'FX_Chest';

	AbilityTag = X2AbilityTag(`XEXPANDCONTEXT.FindTag("Ability"));
	AbilityTag.ParseObj = Effect;

	Effect.SetDisplayInfo(ePerkBuff_Penalty, default.HunterMarkAdventEffectName, `XEXPAND.ExpandString(default.HunterMarkAdventEffectDesc), "img:///WoTCAdventPathfinderCaptain_UI.Perks.UIPerk_advent_HunterShot", true);

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('HunterMarkAdvent');
	Effect.TargetConditions.AddItem(AbilityCondition);

	// bsg-dforrest (7.27.17): need to clear out ParseObject
	AbilityTag.ParseObj = none;
	// bsg-dforrest (7.27.17): end

	return Effect;
}


static function X2AbilityTemplate CreateStunLanceCharge()
{
	local X2AbilityTemplate             Template;
	local X2Condition_UnitEffectsWithAbilitySource MarkCondition;
	local array<name> SkipExclusions;


	Template = class'X2Ability_Stunlancer'.static.CreateStunLanceAbility('StunLanceCharge');

	MarkCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	MarkCondition.AddRequireEffect('HunterMarkAdvent_LW', 'AA_UnitIsImmune');
	Template.AbilityTargetConditions.AddItem(MarkCondition);
	Template.bShowActivation = true;

	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	return Template;
}


static function X2AbilityTemplate CreateChangeForm_Shoggoth_Ability()
{
	local X2AbilityTemplate Template;
	local X2AbilityTrigger_EventListener Trigger;
	local X2Effect_RemoveEffects RemoveEffects;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ChangeForm_Shoggoth');

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.none";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	// This ability fires can when the unit takes damage
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.EventID = 'UnitTakeEffectDamage';
	Trigger.ListenerData.EventFn = ShoggothListener;
	Trigger.ListenerData.Filter = eFilter_Unit;
	Template.AbilityTriggers.AddItem(Trigger);

	Template.AddTargetEffect(new class'X2Effect_SpawnShoggoth');

	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem('ChangeFormCheckEffect');
	Template.AddTargetEffect(RemoveEffects);

	Template.AddMultiTargetEffect(new class'X2Effect_BreakUnitConcealment');

	Template.bSkipFireAction = true;
	Template.FrameAbilityCameraType = eCameraFraming_Always;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = ChangeForm_Shoggoth_BuildVisualization;
	Template.CinescriptCameraType = "Faceless_ChangeForm";

	return Template;
}


static function EventListenerReturn ShoggothListener(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameState_Ability AbilityState;
	local int Roll;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Ability TriggerAbilityState;
	local XComGameState_Unit  TargetUnit;
	local float Chance;

	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());

	TriggerAbilityState = XComGameState_Ability(CallbackData);

	TargetUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID,,GameState.GetContext().GetFirstStateInEventChain().HistoryIndex - 1));

	AbilityState = XComGameState_Ability(CallbackData);

	Roll = `SYNC_RAND_STATIC(100);

	Chance = default.SHOGGOTH_SPAWN_CHANCE_PER_HIT * TargetUnit.GetCurrentStat(eStat_HP) / TargetUnit.GetMaxStat(eStat_HP);

	if( Roll < default.SHOGGOTH_SPAWN_CHANCE_PER_HIT)
	{
		return AbilityState.AbilityTriggerEventListener_Self(EventData, EventSource, GameState, Event, CallbackData);
	}
}



simulated function ChangeForm_Shoggoth_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability Context;
	local StateObjectReference InteractingUnitRef;
	local VisualizationActionMetadata EmptyTrack;
	local VisualizationActionMetadata CivilianTrack, FacelessTrack;
	local X2Action_MoveTurn MoveTurnAction;
	local XComGameState_Unit MovedUnitState;
	local XComGameState_Unit CivilianUnit, SpawnedUnit;
	local UnitValue SpawnedUnitValue;
	local X2Effect_SpawnShoggoth SpawnFacelessEffect;
	
	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	CivilianTrack = EmptyTrack;
	History.GetCurrentAndPreviousGameStatesForObjectID(InteractingUnitRef.ObjectID,
													   CivilianTrack.StateObject_OldState, CivilianTrack.StateObject_NewState,
													   eReturnType_Reference,
													   VisualizeGameState.HistoryIndex);
	CivilianTrack.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);
	CivilianUnit = XComGameState_Unit(CivilianTrack.StateObject_NewState);

	if( Context.InputContext.MultiTargets.Length > 0 )
	{
		// Turn to face the moved unit
		MovedUnitState = XComGameState_Unit(History.GetGameStateForObjectID(Context.InputContext.MultiTargets[0].ObjectID));

		MoveTurnAction = X2Action_MoveTurn(class'X2Action_MoveTurn'.static.AddToVisualizationTree(CivilianTrack, Context));
		MoveTurnAction.m_vFacePoint = `XWORLD.GetPositionFromTileCoordinates(MovedUnitState.TileLocation);
	}

	// Play the civilian and Faceless change form actions
	CivilianUnit.GetUnitValue(class'X2Effect_SpawnUnit'.default.SpawnedUnitValueName, SpawnedUnitValue);

	FacelessTrack = EmptyTrack;
	FacelessTrack.StateObject_OldState = History.GetGameStateForObjectID(SpawnedUnitValue.fValue, eReturnType_Reference, VisualizeGameState.HistoryIndex);
	FacelessTrack.StateObject_NewState = FacelessTrack.StateObject_OldState;
	SpawnedUnit = XComGameState_Unit(FacelessTrack.StateObject_NewState);
	`assert(SpawnedUnit != none);
	FacelessTrack.VisualizeActor = History.GetVisualizer(SpawnedUnit.ObjectID);

	// Only one target effect and it is X2Effect_SpawnFaceless
	SpawnFacelessEffect = X2Effect_SpawnShoggoth(Context.ResultContext.TargetEffectResults.Effects[0]);

	if( SpawnFacelessEffect == none )
	{
		`RedScreenOnce("ChangeForm_BuildVisualization: Missing X2Effect_SpawnShoggoth -dslonneger @gameplay");
		return;
	}

	SpawnFacelessEffect.AddSpawnVisualizationsToTracks(Context, SpawnedUnit, FacelessTrack, CivilianUnit, CivilianTrack);
}