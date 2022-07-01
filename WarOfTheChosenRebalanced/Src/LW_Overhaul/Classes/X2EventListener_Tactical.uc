// X2EventListener_Tactical.uc
// 
// A listener template that allows LW2 to override game behaviour related to
// tactical missions. It's a dumping ground for tactical stuff that doesn't
// fit with more specific listener classes.
//
class X2EventListener_Tactical extends X2EventListener config(LW_Overhaul);

var config int LISTENER_PRIORITY;
var config array<float> SOUND_RANGE_DIFFICULTY_MODIFIER;
var config array<int> RED_ALERT_DETECTION_DIFFICULTY_MODIFIER;
var config array<int> YELLOW_ALERT_DETECTION_DIFFICULTY_MODIFIER;

var config int NUM_TURNS_FOR_WILL_LOSS;
var config int NUM_TURNS_FOR_TIRED_WILL_LOSS;

// Camel case for consistency with base game's will roll data config vars
var const config WillEventRollData PerTurnWillRollData;

var config array<int> MISSION_DIFFICULTY_THRESHOLDS;

var localized string HIT_CHANCE_MSG;
var localized string CRIT_CHANCE_MSG;
var localized string DODGE_CHANCE_MSG;
var localized string MISS_CHANCE_MSG;

var config array<name> STEALTH_MISSION_NAMES;

struct UnitLoadout
{
	var int MinFL;
	var name LoadoutName;
};

struct UnitLoadoutData
{
	var name TemplateName;
	var array<UnitLoadout> UnitLoadoutSets;
};


var config array<UnitLoadoutData> LOADOUT_ASSIGNMENTS;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateYellowAlertListeners());
	Templates.AddItem(CreateMiscellaneousListeners());
	Templates.AddItem(CreateDifficultMissionAPListener());
	Templates.AddItem(CreateVeryDifficultMissionAPListener());
	Templates.AddItem(CreateUIFocusOverride());
	Templates.AddItem(ChainActivationListeners());
	Templates.AddItem(ConcealmentListeners());

	return Templates;
}

static function CHEventListenerTemplate CreateYellowAlertListeners()
{
	local CHEventListenerTemplate Template;

	`LWTrace("Registering evac event listeners");

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'YellowAlertListeners');
	Template.AddCHEvent('ShouldCivilianRun', ShouldCivilianRunFromOtherUnit, ELD_Immediate);

	Template.RegisterInTactical = true;

	return Template;
}

static function CHEventListenerTemplate CreateMiscellaneousListeners()
{
	local CHEventListenerTemplate Template;

	`LWTrace("Registering miscellaneous tactical event listeners");

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'MiscellaneousTacticalListeners');
	//Template.AddCHEvent('GetEvacPlacementDelay', OnPlacedDelayedEvacZone, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('KilledbyExplosion', OnKilledbyExplosion, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('CleanupTacticalMission', OnCleanupTacticalMission, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('AbilityActivated', OnAbilityActivated, ELD_OnStateSubmitted, GetListenerPriority());
	Template.AddCHEvent('UnitChangedTeam', ClearUnitStateValues, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('PlayerTurnEnded', RollForPerTurnWillLoss, ELD_OnStateSubmitted, GetListenerPriority());
	Template.AddCHEvent('OverrideR3Button', BindR3ToPlaceDelayedEvacZone, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('PostInventoryLoadoutApplied', DynamicallyApplyLoadouts, ELD_Immediate, GetListenerPriority());

	//Make Overwatch not broken when dealing damage
	Template.AddCHEvent('OverrideDamageRemovesReserveActionPoints', OverrideReserveActionPoints, ELD_Immediate, GetListenerPriority());

	
	// This seems to be causing stutter in the game, so commenting out for now.
	// if (XCom_Perfect_Information_UIScreenListener.default.ENABLE_PERFECT_INFORMATION)
	// {
	// 	Template.AddCHEvent('AbilityActivated', AddPerfectInfoFlyover, ELD_OnStateSubmitted, GetListenerPriority());
	// }

	Template.RegisterInTactical = true;

	return Template;
}

static function X2AbilityPointTemplate CreateDifficultMissionAPListener()
{
	local X2AbilityPointTemplate Template;

	`CREATE_X2TEMPLATE(class'X2AbilityPointTemplate', Template, 'DifficultMissionCompleted');
	Template.AddEvent('EndBattle', CheckForDifficultMissionCompleted);

	return Template;
}

static function X2AbilityPointTemplate CreateVeryDifficultMissionAPListener()
{
	local X2AbilityPointTemplate Template;

	`CREATE_X2TEMPLATE(class'X2AbilityPointTemplate', Template, 'VeryDifficultMissionCompleted');
	Template.AddEvent('EndBattle', CheckForVeryDifficultMissionCompleted);

	return Template;
}

static protected function int GetListenerPriority()
{
	return default.LISTENER_PRIORITY != -1 ? default.LISTENER_PRIORITY : class'XComGameState_LWListenerManager'.default.DEFAULT_LISTENER_PRIORITY;
}


static function EventListenerReturn DisableSeesAlertedAlliesAlert(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComLWTuple Tuple;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	if (Tuple.Id != 'OverrideSeesAlertedAllies')
		return ELR_NoInterrupt;

	// Copying original LW2 behaviour for now, which is to disable this alert
	// when yellow alert is enabled.
	Tuple.Data[2].i = eAC_None;
	return ELR_NoInterrupt;
}


static function EventListenerReturn ShouldCivilianRunFromOtherUnit(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit OtherUnitState;
	local bool DoesAIAttackCivilians;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	// Sanity check. This should not happen.
	if (Tuple.Id != 'ShouldCivilianRun')
	{
		`REDSCREEN("Received unexpected event ID in ShouldCivilianRunFromOtherUnit() event handler");
		return ELR_NoInterrupt;
	}

	OtherUnitState = XComGameState_Unit(Tuple.Data[0].o);
	DoesAIAttackCivilians = Tuple.Data[1].b;

	// Civilians shouldn't run from the aliens/ADVENT unless Team Alien
	// is attacking neutrals.
	Tuple.Data[2].b = !(!DoesAIAttackCivilians && OtherUnitState.GetTeam() == eTeam_Alien); 

	return ELR_NoInterrupt;
}

// Returns a modifier that should be applied to the sound range for a weapon/ability combo
//
// Implementation copied from X2DLCInfo_LW_Overhaul in the original LW2.
static function int ModifySoundRange(XComGameState_Item Weapon, XComGameState_Ability Ability)
{
	local array<X2WeaponUpgradeTemplate> WeaponUpgrades;
	local float SoundRangeModifier;
	local int k;
	local X2WeaponTemplate WeaponTemplate;
	local X2MultiWeaponTemplate MultiWeaponTemplate;
	local X2AbilityTemplate AbilityTemplate;
	local X2Effect AbilityEffect;
	local bool UseAltWeaponSoundRange;
	local XComGameState_HeadquartersXCom 	XComHQ;

	SoundRangeModifier = 0.0;
	WeaponTemplate = X2WeaponTemplate(Weapon.GetMyTemplate());

	// Is it a multiweapon?
	MultiWeaponTemplate = X2MultiWeaponTemplate(WeaponTemplate);

	if (MultiWeaponTemplate != none)
	{
		AbilityTemplate = Ability.GetMyTemplate();
		foreach AbilityTemplate.AbilityTargetEffects(AbilityEffect)
		{
			if (AbilityEffect.IsA('X2Effect_ApplyAltWeaponDamage'))
			{
				UseAltWeaponSoundRange = true;
				break;
			}
		}

		foreach AbilityTemplate.AbilityMultiTargetEffects(AbilityEffect)
		{
			if (AbilityEffect.IsA('X2Effect_ApplyAltWeaponDamage'))
			{
				UseAltWeaponSoundRange = true;
				break;
			}
		}

		if (UseAltWeaponSoundRange)
		{
			// This ability is using the secondary effect of a multi-weapon. We need to apply a mod to use the alt sound
			// range in place of the primary range.
			SoundRangeModifier += (MultiWeaponTemplate.iAltSoundRange - MultiWeaponTemplate.iSoundRange);
		}
	}

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	if (WeaponTemplate != none)
	{
		WeaponUpgrades = Weapon.GetMyWeaponUpgradeTemplates();
		for (k = 0; k < WeaponUpgrades.Length; k++)
		{
			switch (WeaponUpgrades[k].DataName)
			{
				case 'FreeKillUpgrade_Bsc':
					SoundRangeModifier = -(class'X2Item_DefaultWeaponMods_LW'.default.BASIC_SUPPRESSOR_SOUND_REDUCTION_METERS 
						+ (XComHQ.bEmpoweredUpgrades ? class'X2Item_DefaultWeaponMods_LW'.default.SUPPRESSOR_SOUND_REDUCTION_EMPOWER_BONUS : 0));
					break;
				case 'FreeKillUpgrade_Adv':
					SoundRangeModifier = -(class'X2Item_DefaultWeaponMods_LW'.default.ADVANCED_SUPPRESSOR_SOUND_REDUCTION_METERS
						+ (XComHQ.bEmpoweredUpgrades ? class'X2Item_DefaultWeaponMods_LW'.default.SUPPRESSOR_SOUND_REDUCTION_EMPOWER_BONUS : 0));
					break;
				case 'FreeKillUpgrade_Sup':
					SoundRangeModifier = -(class'X2Item_DefaultWeaponMods_LW'.default.ELITE_SUPPRESSOR_SOUND_REDUCTION_METERS
						+ (XComHQ.bEmpoweredUpgrades ? class'X2Item_DefaultWeaponMods_LW'.default.SUPPRESSOR_SOUND_REDUCTION_EMPOWER_BONUS : 0));
					break;
				default: break;
			}
		}
	}

	SoundRangeModifier += default.SOUND_RANGE_DIFFICULTY_MODIFIER[`TACTICALDIFFICULTYSETTING];

	return int (FMax (SoundRangeModifier, 0.0));
}

// Prevent Needle grenades from blowing up the corpse.
static function EventListenerReturn OnKilledByExplosion(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComLWTuple				OverrideTuple;
	local XComGameState_Unit		Killer, Target;

	OverrideTuple = XComLWTuple(EventData);
	`assert(OverrideTuple != none);

	Target = XComGameState_Unit(EventSource);
	`assert(Target != none);
	`assert(OverrideTuple.Id == 'OverrideKilledbyExplosion');

	Killer = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(OverrideTuple.Data[1].i));

	if (OverrideTuple.Data[0].b && Killer.HasSoldierAbility('NeedleGrenades', true))
	{
		OverrideTuple.Data[0].b = false;
	}

	return ELR_NoInterrupt;
}

// Additional tactical mission cleanup, including Field Surgeon, turret wreck
// recovery and transferring Full Override MECs to havens.
static function EventListenerReturn OnCleanupTacticalMission(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
    local XComGameState_BattleData BattleData;
    local XComGameState_Unit Unit;
    local XComGameStateHistory History;
	local XComGameState_Effect EffectState;
	local StateObjectReference EffectRef;
	local bool AwardWrecks;

    History = `XCOMHISTORY;
    BattleData = XComGameState_BattleData(EventData);
    BattleData = XComGameState_BattleData(NewGameState.GetGameStateForObjectID(BattleData.ObjectID));

	// If we completed this mission with corpse recovery, you get the wreck/loot from any turret
	// left on the map as well as any Mastered unit that survived but is not eligible to be
	// transferred to a haven.
	AwardWrecks = BattleData.AllTacticalObjectivesCompleted();

    if (AwardWrecks)
    {
        // If we have completed the tactical objectives (e.g. sweep) we are collecting corpses.
        // Generate wrecks for each of the turrets left on the map that XCOM didn't kill before
        // ending the mission.
        foreach History.IterateByClassType(class'XComGameState_Unit', Unit)
        {
            if (Unit.IsTurret() && !Unit.IsDead())
            {
                // We can't call the RollForAutoLoot() function here because we have a pending
                // gamestate with a modified BattleData already. Just add a corpse to the list
                // of pending auto loot.
                BattleData.AutoLootBucket.AddItem('CorpseAdventTurret');
            }
        }
    }

	// Handle effects that can only be performed at mission end:
	//
	// Handle full override mecs. Look for units with a full override effect that are not dead
	// or captured. This is done here instead of in an OnEffectRemoved hook, because effect removal
	// isn't fired when the mission ends on a sweep, just when they evac. Other effect cleanup
	// typically happens in UnitEndedTacticalPlay, but since we need to update the haven gamestate
	// we can't use that: we don't get a reference to the current XComGameState being submitted.
	// This works because the X2Effect_TransferMecToOutpost code sets up its own UnitRemovedFromPlay
	// event listener, overriding the standard one in XComGameState_Effect, so the effect won't get
	// removed when the unit is removed from play and we'll see it here.
	//
	// Handle Field Surgeon. We can't let the effect get stripped on evac via OnEffectRemoved because
	// the surgeon themself may die later in the mission. We need to wait til mission end and figure out
	// which effects to apply.
	//
	// Also handle units that are still living but are affected by mind-control - if this is a corpse
	// recovering mission, roll their auto-loot so that corpses etc. are granted despite them not actually
	// being killed.

	foreach History.IterateByClassType(class'XComGameState_Unit', Unit)
	{
		// LWOTC: Manual cleanup for haven advisers and any other soldiers that are
		// "spawned from the Avenger". Bit of a hack to avoid further changes to the
		// highlander. This just duplicates code that's in
		// X2TacticalGameRuleSet.CleanupTacticalMission().
		if (Unit.bSpawnedFromAvenger)
		{
			if (BattleData.AllTacticalObjectivesCompleted() || BattleData.AllTriadObjectivesCompleted())
			{
				Unit = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', Unit.ObjectID));
				Unit.RemoveUnitFromPlay();
				Unit.bBleedingOut = false;
				Unit.bUnconscious = false;

				if (Unit.IsDead())
				{
					Unit.bBodyRecovered = true;
				}
			}
			else if (!BattleData.AllTacticalObjectivesCompleted() && !BattleData.AllTriadObjectivesCompleted())
			{
				// Missions that don't result in recovery of XCOM bodies should ensure that
				// mind controlled soldiers are captured.
				if (Unit.IsMindControlled())
				{
					Unit = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', Unit.ObjectID));
					Unit.bCaptured = true;
				}
			}
		}

		if(Unit.IsAlive() && !Unit.bCaptured)
		{
			foreach Unit.AffectedByEffects(EffectRef)
			{
				EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
				if (EffectState.GetX2Effect().EffectName == class'X2Effect_FieldSurgeon'.default.EffectName)
				{
					X2Effect_FieldSurgeon(EffectState.GetX2Effect()).ApplyFieldSurgeon(EffectState, Unit, NewGameState);
				}
				else if (EffectState.GetX2Effect().EffectName == class'X2Effect_GreaterPadding'.default.EffectName)
				{
					X2Effect_GreaterPadding(EffectState.GetX2Effect()).ApplyGreaterPadding(EffectState, Unit, NewGameState);
				}
					
				else if (EffectState.GetX2Effect().EffectName == class'X2Effect_MindControl'.default.EffectName && AwardWrecks)
				{
					Unit.RollForAutoLoot(NewGameState);

					// Super hacks for andromedon, since only the robot drops a corpse.
					if (Unit.GetMyTemplateName() == 'Andromedon')
					{
						BattleData.AutoLootBucket.AddItem('CorpseAndromedon');
					}
				}
			}
		}
	}

    return ELR_NoInterrupt;
}


// Make sure reinforcements arrive in red alert if any aliens on the map are
// already in red alert.
static function EventListenerReturn AddPerfectInfoFlyover(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
	local XComGameState NewGameState;
	local AvailableTarget Target;
	local XComGameState_Unit UnitState;
	local XComGameState_Ability AbilityState;
	local XComGameStateContext_Ability Context;
	local X2AbilityToHitCalc_StandardAim ToHitCalc;
	local XComGameState_LastShotBreakdown LastShotBreakdown;

	//ActivatedAbilityStateContext = XComGameStateContext_Ability(GameState.GetContext());
	AbilityState = XComGameState_Ability(EventData);
	UnitState = XComGameState_Unit(EventSource);
	ToHitCalc = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
	if (ToHitCalc == None)
	{
		// Ignore any abilities that don't use StandardAim
		return ELR_NoInterrupt;
	}

	Context = XComGameStateContext_Ability(GameState.GetContext());

	if (Context.InterruptionStatus != eInterruptionStatus_Interrupt)
	{
		// We want to use the shot breakdown from the last interrupt state
		// (because Steady Weapon loses its buff just before the resume state)
		// but we only want one flyover. If we add the flyover to the interrupt
		// state, it will be copied to the resume state and *both* will execute
		// and you'll see the flyover twice.
		//
		// However, we do want to add the visualization for eInterruptionStatus_None.
		GameState.GetContext().PostBuildVisualizationFn.AddItem(PIFlyover_BuildVisualization);
	}

	if (Context.InterruptionStatus == eInterruptionStatus_Resume)
	{
		// Don't build the shot breakdown info for resumed contexts, primarily because
		// Steady Weapon loses its buff by this point.
		return ELR_NoInterrupt;
	}

	// Add the ID of the last shotbreakdown to the unit state so that the
	// flyover visualisation actually has a reference it can use to get the
	// shot breakdown info it needs.
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Record Last Shot Breakdown");
	LastShotBreakdown = XComGameState_LastShotBreakdown(NewGameState.CreateNewStateObject(class'XComGameState_LastShotBreakdown'));
	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	UnitState.SetUnitFloatValue('LW_LastShotBreakdownId', LastShotBreakdown.ObjectID, eCleanup_BeginTactical);
	
	// Calculate the shotbreakdown from this interrupt state and save it
	// to game state, from where the flyover visualisation can pick it up.
	Target.PrimaryTarget = Context.InputContext.PrimaryTarget;
	ToHitCalc.GetShotBreakdown(AbilityState, Target, LastShotBreakdown.ShotBreakdown);
	
	`TACTICALRULES.SubmitGameState(NewGameState);
	return ELR_NoInterrupt;
}

static function PIFlyover_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory				History;
	local XComGameStateContext_Ability		Context;
	local VisualizationActionMetadata		EmptyTrack, BuildTrack;
	local XComGameState_Unit				UnitState, ShooterState;
	local X2Action_PlaySoundAndFlyOver		MessageAction;
	local ShotBreakdown						TargetBreakdown;
	local XComGameState_LastShotBreakdown	LastShotBreakdown;
	local UnitValue							ShotBreakdownValue;

	History = `XCOMHISTORY;
	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());

	ShooterState = XComGameState_Unit(History.GetGameStateForObjectID(Context.InputContext.SourceObject.ObjectID));
	if (!ShooterState.GetUnitValue('LW_LastShotBreakdownId', ShotBreakdownValue))
	{
		return;
	}
	LastShotBreakdown = XComGameState_LastShotBreakdown(History.GetGameStateForObjectID(int(ShotBreakdownValue.fValue)));
	TargetBreakdown = LastShotBreakdown.ShotBreakdown;

	BuildTrack = EmptyTrack;
	UnitState = XComGameState_Unit(History.GetGameStateForObjectID(Context.InputContext.PrimaryTarget.ObjectID));
	BuildTrack.StateObject_NewState = UnitState;
	BuildTrack.StateObject_OldState = UnitState;
	BuildTrack.VisualizeActor = UnitState.GetVisualizer();
	MessageAction = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(BuildTrack, Context, false, BuildTrack.LastActionAdded));
	MessageAction.SetSoundAndFlyOverParameters(None, GetHitChanceText(TargetBreakdown), '', eColor_Gray,, 5.0f);
}

// Return with chance string
static function string GetHitChanceText(ShotBreakdown TargetBreakdown)
{
	local string HitText;
	local string GrazeText;
	local string CritText;
	local string ReturnText;
	local int SomeDamageHitChance;

	HitText = class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(class'XLocalizedData'.default.HitLabel);
	CritText = class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(class'XLocalizedData'.default.CritLabel);
	GrazeText = class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(
		class'X2TacticalGameRulesetDataStructures'.default.m_aAbilityHitResultStrings[eHit_Graze]);

	SomeDamageHitChance = TargetBreakdown.ResultTable[eHit_Success] + TargetBreakdown.ResultTable[eHit_Crit] + TargetBreakdown.ResultTable[eHit_Graze];

	ReturnText = (ReturnText @ HitText @ SomeDamageHitChance $ "% ");

	//Add Dodge Chance to ReturnText
	ReturnText = (ReturnText @ GrazeText @ TargetBreakdown.ResultTable[eHit_Graze] $ "% ");

	//Add Crit Chance to ReturnText
	ReturnText = (ReturnText @ CritText @ TargetBreakdown.ResultTable[eHit_Crit] $ "% ");

	return ReturnText;
}

// Make sure reinforcements arrive in red alert if any aliens on the map are
// already in red alert.
//
// This listener also increases the detection radius for enemy units when they
// enter yellow or red alert and clears the effect that restores their sight
// radius (since that effect breaks the Low Visibility sit rep).
//
// Note that the implementation is based on the Compound Rescure mission's
// security levels, but it could probably also be implemented by adding a
// persistent stat change to the units.
static function EventListenerReturn OnAbilityActivated(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
    local XComGameState_Ability ActivatedAbilityState;
	local XComGameState_LWReinforcements Reinforcements;
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;

	//ActivatedAbilityStateContext = XComGameStateContext_Ability(GameState.GetContext());
	ActivatedAbilityState = XComGameState_Ability(EventData);
	UnitState = XComGameState_Unit(EventSource);
	if (ActivatedAbilityState.GetMyTemplate().DataName == 'RedAlert')
	{
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("On Red Alert Activated");

		Reinforcements = XComGameState_LWReinforcements(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LWReinforcements', true));
		if (Reinforcements != none && !Reinforcements.RedAlertTriggered)
		{
			Reinforcements = XComGameState_LWReinforcements(NewGameState.ModifyStateObject(class'XComGameState_LWReinforcements', Reinforcements.ObjectID));
			Reinforcements.RedAlertTriggered = true;
		}

		// Clear the stat restoration effect that gets applied when units enter
		// red or yellow alert, since it overrides the sight radius changes applied
		// by the Low Visibility sit rep.
		RemoveSightRadiusRestorationEffect(UnitState, NewGameState);

		`TACTICALRULES.SubmitGameState(NewGameState);
	}
	else if (ActivatedAbilityState.GetMyTemplate().DataName == 'YellowAlert')
	{

		// Clear the stat restoration effect that gets applied when units enter
		// red or yellow alert, since it overrides the sight radius changes applied
		// by the Low Visibility sit rep.
		RemoveSightRadiusRestorationEffect(UnitState, NewGameState);

		`TACTICALRULES.SubmitGameState(NewGameState);
	}
	return ELR_NoInterrupt;
}

private static function RemoveSightRadiusRestorationEffect(XComGameState_Unit UnitState, XComGameState NewGameState)
{
	local X2Effect_PersistentStatChangeRestoreDefault CurrentEffect;
	local XComGameStateHistory History;
	local XComGameState_Effect EffectState;
	local StateObjectReference EffectRef;

	History = `XCOMHISTORY;
	foreach UnitState.AffectedByEffects(EffectRef)
	{
		EffectState = XComGameState_Effect(History.GetGameStateForObjectID(EffectRef.ObjectID));
		CurrentEffect = X2Effect_PersistentStatChangeRestoreDefault(EffectState.GetX2Effect());
		if (CurrentEffect != none && CurrentEffect.StatTypesToRestore.Find(eStat_SightRadius) != INDEX_NONE)
		{
			EffectState.RemoveEffect(NewGameState, NewGameState, true);
			break;
		}
	}
}

// This listener clears the `eCleanup_BeginTurn` unit values on units that
// swap teams. This fixes a problem where those unit values don't get cleared
// when team swapping happens after the turn begins.
static protected function EventListenerReturn ClearUnitStateValues(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(EventData);
	if (UnitState == none) return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(UnitState.ObjectID));
	UnitState.CleanupUnitValues(eCleanup_BeginTurn);

	return ELR_NoInterrupt;
}

static protected function EventListenerReturn RollForPerTurnWillLoss(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local XComGameStateHistory History;
	local XComGameState_Player PlayerState;
	local XComGameStateContext_WillRoll WillRollContext;
	local XComGameState_HeadquartersXCom XComHQ;
	local StateObjectReference SquadRef;
	local XComGameState_Unit SquadUnit;
	local WillEventRollData WillRollData;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class' XComGameState_HeadquartersXCom'));
	PlayerState = XComGameState_Player(EventData);

	// We only want to lose Will every n turns, so skip other turns
	if (PlayerState.GetTeam() != eTeam_XCom)
		return ELR_NoInterrupt;

	// Remove Will from all squad members
	foreach XComHQ.Squad(SquadRef)
	{
		SquadUnit = XComGameState_Unit(History.GetGameStateForObjectID(SquadRef.ObjectID));

		// Check whether this unit should lose Will this turn (depends on whether
		// they are Tired or not)
		if ((SquadUnit.GetMentalState() != eMentalState_Tired && PlayerState.PlayerTurnCount % default.NUM_TURNS_FOR_WILL_LOSS != 0) ||
			(SquadUnit.GetMentalState() == eMentalState_Tired && PlayerState.PlayerTurnCount % default.NUM_TURNS_FOR_TIRED_WILL_LOSS != 0))
		{
			continue;
		}

		WillRollData = default.PerTurnWillRollData;
		if(SquadUnit.HasSoldierAbility('IronWill') && WillRollData.MinimumWillLoss > 0)
		{
			WillRollData.MinimumWillLoss -= 1;
		}

		// Unit should lose Will this turn, so do it
		if (class'XComGameStateContext_WillRoll'.static.ShouldPerformWillRoll(WillRollData, SquadUnit))
		{
			`LWTrace("Performing Will roll at end of turn");
			WillRollContext = class'XComGameStateContext_WillRoll'.static.CreateWillRollContext(SquadUnit, 'PlayerTurnEnd',, false);
			WillRollContext.DoWillRoll(WillRollData);
			WillRollContext.Submit();
		}
	}

	return ELR_NoInterrupt;
}

static protected function EventListenerReturn CheckForDifficultMissionCompleted(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name Event,
	Object CallbackData)
{
	return CheckForMissionCompleted(
		'DifficultMissionCompleted',
		default.MISSION_DIFFICULTY_THRESHOLDS[0],
		default.MISSION_DIFFICULTY_THRESHOLDS[1] - 1,
		GameState);
}

static protected function EventListenerReturn CheckForVeryDifficultMissionCompleted(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name Event,
	Object CallbackData)
{
	return CheckForMissionCompleted(
		'VeryDifficultMissionCompleted',
		default.MISSION_DIFFICULTY_THRESHOLDS[1],
		999,
		GameState);
}

static protected function EventListenerReturn CheckForMissionCompleted(
	name APTemplateName,
	int MinDifficulty,
	int MaxDifficulty,
	XComGameState GameState)
{
	local XComGameStateContext_AbilityPointEvent EventContext;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_BattleData BattleData;
	local X2AbilityPointTemplate APTemplate;
	local X2SitRepEffectTemplate SitRepEffectTemplate;
	local int Difficulty, Roll;

	BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	APTemplate = class'X2EventListener_AbilityPoints'.static.GetAbilityPointTemplate(APTemplateName);

	if (APTemplate == none || BattleData == none)
		return ELR_NoInterrupt;

	// Only trigger an AP award if the tactical game has ended with a player win
	if (!`TACTICALRULES.HasTacticalGameEnded() && BattleData.bLocalPlayerWon && !BattleData.bMissionAborted)
		return ELR_NoInterrupt;

	// Is the mission difficulty right for this AP award?
	Difficulty = 0;
	foreach class'X2SitRepTemplateManager'.static.IterateEffects(class'X2SitRepEffectTemplate', SitRepEffectTemplate, BattleData.ActiveSitReps)
	{
		Difficulty += SitRepEffectTemplate.DifficultyModifier;
	}

	if (Difficulty < MinDifficulty || Difficulty > MaxDifficulty)
		return ELR_NoInterrupt;

	Roll = class'Engine'.static.GetEngine().SyncRand(100, "RollForAbilityPoint");
	if (Roll < APTemplate.Chance)
	{
		XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

		EventContext = XComGameStateContext_AbilityPointEvent(class'XComGameStateContext_AbilityPointEvent'.static.CreateXComGameStateContext());
		EventContext.AbilityPointTemplateName = APTemplate.DataName;

		// The AP event system requires a unit, so just given it the first member
		// of the squad. TODO: Could feasibly make this the officer or highest-ranked
		// soldier to make it look a little less weird. Alternatively, could make
		// a highlander change to eliminate this requirement.
		EventContext.AssociatedUnitRef = XComHQ.Squad[0];
		EventContext.TriggerHistoryIndex = GameState.GetContext().GetFirstStateInEventChain().HistoryIndex;

		`TACTICALRULES.SubmitGameStateContext(EventContext);
	}
}

static protected function EventListenerReturn BindR3ToPlaceDelayedEvacZone(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	// Bind R3 controller button to this LW2/LWOTC ability
	Tuple.Data[1].n = 'PlaceDelayedEvacZone';

	return ELR_NoInterrupt;
}


static protected function EventListenerReturn DynamicallyApplyLoadouts(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit UnitState;
	local int FindIndex;
	local XComGameState_BattleData	BattleData;
	local int i;
	local array<XComGameState_Item> Items;
	local XComGameState_Item Item;
	local UnitValue DynamicallyAppliedLoadout;
	local string LoadoutStr;
	local int iRand;
	UnitState = XComGameState_Unit(EventSource);

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));


	FindIndex = default.LOADOUT_ASSIGNMENTS.Find('TemplateName',UnitState.GetMyTemplateName());
	if(FindIndex != INDEX_NONE)
	{


		if(default.LOADOUT_ASSIGNMENTS[FindIndex].UnitLoadoutSets.Length >0)
		{
			for (i = default.LOADOUT_ASSIGNMENTS[FindIndex].UnitLoadoutSets.Length - 1; i>= 0; i--)
			{
				if(default.LOADOUT_ASSIGNMENTS[FindIndex].UnitLoadoutSets[i].MinFL <= BattleData.GetForceLevel())
				{
					UnitState.GetUnitValue('DynamicallyAppliedLoadout',DynamicallyAppliedLoadout );
					if(!UnitState.HasLoadout(default.LOADOUT_ASSIGNMENTS[FindIndex].UnitLoadoutSets[i].LoadoutName) && DynamicallyAppliedLoadout.fValue < 1.0f)
					{
						//Clear the loadout before assigning the new one
						Items = UnitState.GetAllInventoryItems(NewGameState);
						foreach Items(Item)
						{
							UnitState.RemoveItemFromInventory(Item,NewGameState);
						}
						UnitState.SetUnitFloatValue('DynamicallyAppliedLoadout', 2.0f);
						UnitState.ApplyInventoryLoadout(NewGameState,default.LOADOUT_ASSIGNMENTS[FindIndex].UnitLoadoutSets[i].LoadoutName);
						if(!UnitState.HasLoadout(default.LOADOUT_ASSIGNMENTS[FindIndex].UnitLoadoutSets[i].LoadoutName))
						{
							`REDSCREEN("GTO: attempted to dynamically assign "$ default.LOADOUT_ASSIGNMENTS[FindIndex].UnitLoadoutSets[i].LoadoutName $ "To " $ UnitState.GetMyTemplateName() $ " But something went wrong");
						}
					}
					break;
				}
			}
		}
	}
	else if(UnitState.GetMyTemplateName() == 'CivilianMilitia')
	{
		UnitState.GetUnitValue('DynamicallyAppliedLoadout',DynamicallyAppliedLoadout );

		if(DynamicallyAppliedLoadout.fValue < 1.0f)
		{
			//Clear the loadout before assigning the new one
			Items = UnitState.GetAllInventoryItems(NewGameState);
			foreach Items(Item)
			{
				UnitState.RemoveItemFromInventory(Item,NewGameState);
			}
			UnitState.SetUnitFloatValue('DynamicallyAppliedLoadout', 2.0f);

			LoadoutStr = "MilitiaSoldier";

			if (IsProvingGroundProjectResearched('MilitiaBeam'))
			{
				LoadoutStr $= "5";
			}
			else if (IsProvingGroundProjectResearched('MilitiaCoil'))
			{
				LoadoutStr $= "4";
			}
			else if (IsProvingGroundProjectResearched('MilitiaMag'))
			{
				LoadoutStr $= "3";
			}
			else if (IsProvingGroundProjectResearched('MilitiaLaser'))
			{
				LoadoutStr $= "2";
			}
			iRand = `SYNC_RAND_STATIC(100);
			if (iRand < 15)
			{
				LoadoutStr $= "SMG";
			}
			else if (iRand < 30)
			{
				LoadoutStr $= "Shotgun";
			}
			else if (iRand < 45)
			{
				LoadoutStr $= "Bullpup";
			}
				
			UnitState.ApplyInventoryLoadout(NewGameState,name(LoadoutStr));

			if(!UnitState.HasLoadout(name(LoadoutStr)))
			{
				`REDSCREEN("GTO: attempted to dynamically assign "$ LoadoutStr $ "To " $ UnitState.GetMyTemplateName() $ " But something went wrong");
			}
		
		}
	}
	return ELR_NoInterrupt;
}

static function bool IsProvingGroundProjectResearched(name TechName)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local array<StateObjectReference>  CompletedProjects;
	local StateObjectReference TechReference;
	local XComGameState_Tech TechState;

	XComHQ = `XCOMHQ;

	CompletedProjects = XComHQ.GetCompletedProvingGroundTechs();

	foreach CompletedProjects(TechReference)
	{
		TechState = XComGameState_Tech(`XCOMHISTORY.GetGameStateForObjectID(TechReference.ObjectID));
		if (TechState.GetMyTemplateName() == TechName)
		{
			return true;
		}
	}

	return false;

}

static function CHEventListenerTemplate CreateUIFocusOverride()
{
	local CHEventListenerTemplate Template;

	`LWTrace("Registering evac event listeners");

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'FocusUIListeners');
	//Needed because chain lightning uses focus for its targeting now
	Template.AddCHEvent('OverrideUnitFocusUI', HideFocusOnAssaults, ELD_Immediate, GetListenerPriority());

	Template.RegisterInTactical = true;

	return Template;
}

static function CHEventListenerTemplate ChainActivationListeners()
{
	local CHEventListenerTemplate Template;

	`LWTrace("Registering evac event listeners");

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'ChainActivationListeners');
	Template.AddCHEvent('OverrideSeesAlertedAllies', ActivatePodSeenAllies, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('OverrideEnemyFactionsAlertsOutsideVision', MakeSureAItoAIWorks, ELD_Immediate, GetListenerPriority());
	//Template.AddCHEvent('UnitMoveFinished', ChainActivate, ELD_OnStateSubmitted, GetListenerPriority());

	Template.RegisterInTactical = true;

	return Template;
}


static function CHEventListenerTemplate ConcealmentListeners()
{
	local CHEventListenerTemplate Template;

	`LWTrace("Registering evac event listeners");

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'ConcealmentListeners');
	Template.AddCHEvent('PlayerTurnBegun', BreakSquadConcealment, ELD_OnStateSubmitted, GetListenerPriority());

	Template.RegisterInTactical = true;

	return Template;
}


static protected function EventListenerReturn HideFocusOnAssaults(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit Unit;
	local UnitValue						CurrentHeatLevel, MaxHeatLevel;
	local int							CurrentHeat, MaxHeat;
	local string						TooltipLong, TooltipShort, Icon;
	local string						BarColor;


	Unit = XComGameState_Unit(EventSource);
	if(Unit == none)
		return ELR_NoInterrupt;

  Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;
  	if (Unit.GetSoldierClassTemplate() != none && Unit.GetSoldierClassTemplate().DataName == 'LWS_Assault' || Unit.GetSoldierClassTemplate().DataName == 'LWS_Specialist')
	{
		// Hide focus on assaults
		Tuple.Data[0].b = false;
	}
	else if (Unit.HasSoldierAbility('Heatsink_LW'))
	{
		BarColor = "bf1e2e"; // Red from Skirmisher's Faction Logo --> Brighter red: ff0909
		TooltipLong = class'X2Ability_SkirmisherAbilitySet_LW'.default.strHeatLevelDesc;
		TooltipShort = class'X2Ability_SkirmisherAbilitySet_LW'.default.strHeatLevelName;
		Icon = "img:///UILibrary_WOTC_APA_Skirmisher_LW.FocusIcon_Skirmisher";

		Unit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_MAX_NAME, MaxHeatLevel);
		MaxHeat = MaxHeatLevel.fValue;

		Unit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, CurrentHeatLevel);
		CurrentHeat = CurrentHeatLevel.fValue;
						
		Tuple.Data[0].b = true;
		Tuple.Data[1].i = CurrentHeat;
		Tuple.Data[2].i = MaxHeat;
		Tuple.Data[3].s = BarColor;
		Tuple.Data[4].s = Icon;
		Tuple.Data[5].s = TooltipLong;
		Tuple.Data[6].s = TooltipShort;
	}

	return ELR_NoInterrupt;
}

static function EventListenerReturn ActivatePodSeenAllies(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComLWTuple Tuple;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	if (Tuple.Id != 'OverrideSeesAlertedAllies')
		return ELR_NoInterrupt;

	// Copying original LW2 behaviour for now, which is to disable this alert
	// when yellow alert is enabled.
	if(	XComGameState_Unit(Tuple.Data[0].o).GetCurrentStat(eStat_AlertLevel) > 1 || XComGameState_Unit(Tuple.Data[1].o).GetCurrentStat(eStat_AlertLevel) > 1) 
	{			
		Tuple.Data[2].i = eAC_SeesSpottedUnit;
	}

	return ELR_NoInterrupt;
}


static function EventListenerReturn MakeSureAItoAIWorks(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComLWTuple Tuple;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;


	if (Tuple.Id != 'OverrideEnemyFactionsAlertsOutsideVision')
		return ELR_NoInterrupt;

	switch( Tuple.Data[1].i )
	{
	case eAC_MapwideAlert_Hostile:
	case eAC_MapwideAlert_Peaceful:
	case eAC_AlertedByCommLink:
	case eAC_AlertedByYell:
	case eAC_TakingFire:
	case eAC_TookDamage:
	case eAC_DetectedAllyTakingDamage:
	case eAC_SeesSpottedUnit:
		Tuple.Data[0].b = true;
		break;
	}
	
	return ELR_NoInterrupt;
}

static function EventListenerReturn ChainActivate(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_AIUnitData AIUnit, NewAIUnitData;
	local XComGameStateHistory History;
	local XComGameState_Unit AlertedUnit, MovedUnit;
	local int AlertDataIndex;
	//local int MovedUnitDataID;
	local AlertAbilityInfo AlertInfo;
	local XcomGameState NewGameState;
	local XComGameState_AIGroup AIGroupState;
	local X2Condition_Visibility VisibiliyCondition;
	local array<X2Condition> ActivationVisibilityCondition;
	local X2EventManager EventManager;

	History = `XCOMHISTORY;


	VisibiliyCondition = new class'X2Condition_Visibility';
	VisibiliyCondition.bRequireGameplayVisible=true;

	ActivationVisibilityCondition.AddItem(VisibiliyCondition);
	foreach History.IterateByClassType(class'XComGameState_AIUnitData', AIUnit)
	{
		AlertedUnit = XComGameState_Unit(History.GetGameStateForObjectID(AIUnit.m_iUnitObjectID));
		//If the unactivated unit  saw an activated moved unit

		MovedUnit = XComGameState_Unit(EventData);
		if( MovedUnit == none || AlertedUnit == none || AlertedUnit.IsDead() )
		{
			return ELR_NoInterrupt;
		}
	
		if (MovedUnit.GetCurrentStat(eStat_AlertLevel) > 1 && AlertedUnit.GetCurrentStat(eStat_AlertLevel) < 2)
		{


			if((class'X2TacticalVisibilityHelpers'.static.CanUnitSeeLocation(AIUnit.m_iUnitObjectID, MovedUnit.TileLocation, ActivationVisibilityCondition) || AIUnit.IsKnowledgeAboutUnitAbsolute(MovedUnit.ObjectID, AlertDataIndex)) && AlertedUnit.TileDistanceBetween(MovedUnit) <= 18)
			{
				AlertInfo.AlertUnitSourceID = MovedUnit.ObjectID;
				AlertInfo.AnalyzingHistoryIndex = GameState.HistoryIndex;
				AlertInfo.AlertTileLocation = MovedUnit.TileLocation;

				NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState(string(GetFuncName()));

		
	
				NewAIUnitData = XComGameState_AIUnitData(NewGameState.ModifyStateObject(class'XComGameState_AIUnitData', AIUnit.ObjectID));
				if( NewAIUnitData.AddAlertData(AIUnit.m_iUnitObjectID, eAC_TakingFire, AlertInfo, NewGameState) )
				{
					EventManager = `XEVENTMGR;

					EventManager.TriggerEvent('AlertDataTriggerAlertAbility', , AlertedUnit, NewGameState);
	
					AIGroupState = AlertedUnit.GetGroupMembership();
					if(AIGroupState != none && !AIGroupState.bProcessedScamper && AlertedUnit.bTriggerRevealAI)
					{
						AIGroupState = XComGameState_AIGroup(NewGameState.ModifyStateObject(class'XComGameState_AIGroup', AIGroupState.ObjectID));
						AIGroupState.InitiateReflexMoveActivate(AlertedUnit, eAC_TakingFire);

					}
					`TACTICALRULES.SubmitGameState(NewGameState);
				}
				else
				{
					NewGameState.PurgeGameStateForObjectID(NewAIUnitData.ObjectID);
					History.CleanupPendingGameState(NewGameState);
				}
			}

		}
			/*
		//If the unactivated moved unit saw an activated unit
		else if(MovedUnit.GetCurrentStat(eStat_AlertLevel) < 2 && AlertedUnit.GetCurrentStat(eStat_AlertLevel) > 1)
		{
			MovedUnitDataID = MovedUnit.GetAIUnitDataID();

			if (MovedUnitDataID > 0 && !MovedUnit.IsDead())
			{
				MovedUnitData = XComGameState_AIUnitData(History.GetGameStateForObjectID(MovedUnitDataID));

				if(class'X2TacticalVisibilityHelpers'.static.CanUnitSeeLocation(MovedUnitData.m_iUnitObjectID, AlertedUnit.TileLocation, ActivationVisibilityCondition) || MovedUnitData.IsKnowledgeAboutUnitAbsolute(AlertedUnit.ObjectID, AlertDataIndex))
				{

					AlertInfo.AlertUnitSourceID = AlertedUnit.ObjectID;
					AlertInfo.AnalyzingHistoryIndex = GameState.HistoryIndex;
					AlertInfo.AlertTileLocation = AlertedUnit.TileLocation;



					NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState(string(GetFuncName()));
					NewAIUnitData = XComGameState_AIUnitData(NewGameState.ModifyStateObject(class'XComGameState_AIUnitData', MovedUnitData.ObjectID));
					if( NewAIUnitData.AddAlertData(MovedUnitData.m_iUnitObjectID, eAC_SeesSpottedUnit, AlertInfo, NewGameState) )
					{
						AIGroupState = MovedUnit.GetGroupMembership();
						if(AIGroupState != none && !AIGroupState.bProcessedScamper && MovedUnit.bTriggerRevealAI)
						{
							AIGroupState = XComGameState_AIGroup(NewGameState.ModifyStateObject(class'XComGameState_AIGroup', AIGroupState.ObjectID));
							AIGroupState.InitiateReflexMoveActivate(MovedUnit, eAC_SeesSpottedUnit);

						}
						`TACTICALRULES.SubmitGameState(NewGameState);
					}
					else
					{
						NewGameState.PurgeGameStateForObjectID(NewAIUnitData.ObjectID);
						History.CleanupPendingGameState(NewGameState);
					}
				}
			}
		}
			*/
	}



}



static function EventListenerReturn BreakSquadConcealment(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Player Player;
	local XComGameState_MissionSite MissionState;
	
	MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(`XCOMHQ.MissionRef.ObjectID));
	Player = XComGameState_Player(EventData);
	if(Player.GetTeam() != eTeam_XCom || default.STEALTH_MISSION_NAMES.Find(MissionState.GeneratedMission.Mission.MissionName) != INDEX_NONE)
	{	
		return ELR_NoInterrupt;
	}

	if(Player.PlayerTurnCount == 2)
	{
		Player.SetSquadConcealment(false);

		AlertIfPlayerRevealed(GameState);
	}
	return ELR_NoInterrupt;
}


static function  AlertIfPlayerRevealed(XComGameState newGameState) {
    local XComGameStateHistory History;
    local XComGameState_Unit UnitState;
    
    History = `XCOMHISTORY;
    foreach History.IterateByClassType(class'XComGameState_Unit', UnitState)
    {
        if (!UnitState.ControllingPlayerIsAI()  
            && !UnitState.bRemovedFromPlay
            && UnitState.IsAlive()
            && !UnitState.IsConcealed())
        {
            AlertAllUnits(UnitState, newGameState);
            break;
        }
    }
}		

static function AlertAllUnits(XComGameState_Unit Unit, XComGameState newGameState)
{
    local XComGameStateHistory History;
    local XComGameState_AIGroup AIGroupState;
    local array<int> LivingUnits;
    local XComGameState_Unit Member;
    local int Id;
    local bool UnitSeen;

    History = `XCOMHISTORY;

    if (class'X2TacticalVisibilityHelpers'.static.GetNumVisibleEnemyTargetsToSource(Unit.ObjectID) > 0)
    {
        UnitSeen = true;
    }
    else {
        UnitSeen = false;
    }

    foreach History.IterateByClassType(class'XComGameState_AIGroup', AIGroupState)
    {
		if(AIGroupState.TeamName != eTeam_XCom && AIGroupState.TeamName != eTeam_Neutral && !AIGroupState.GetGroupLeader().GetMyTemplate().bIsCivilian)
		{
			AIGroupState.ApplyAlertAbilityToGroup(eAC_SeesSpottedUnit);
			AIGroupState.InitiateReflexMoveActivate(Unit, eAC_SeesSpottedUnit);
			
			if (UnitSeen == true)
			{
				AIGroupState.GetLivingMembers(LivingUnits);
				foreach LivingUnits(Id)
				{
					Member = XComGameState_Unit(History.GetGameStateForObjectID(Id));
					class'XComGameState_Unit'.static.UnitAGainsKnowledgeOfUnitB(Member, Unit, newGameState, eAC_SeesSpottedUnit, false);
				}
			}	
		}
    }
}


static function EventListenerReturn OverrideReserveActionPoints(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit UnitState, SourceUnit;
	local name ActionPointName;
	local bool IsSuppression;
	local DamageResult Result;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;

	UnitState = XcomGameState_Unit(EventSource);
	Tuple = XComLWTuple(EventData);

	if (Tuple == none)
		return ELR_NoInterrupt;


	Result = UnitState.DamageResults[UnitState.DamageResults.Length-1];

	AbilityContext = XComGameStateContext_Ability(Result.Context);


	if(UnitState.AffectedByEffectNames.Find(class'X2StatusEffects'.default.BurningName) != -1)
	{
		Tuple.Data[0].b = true;
		return ELR_NoInterrupt;
	}

	//Check if the source unit has an ability that allows breaking overwatches
	if(AbilityContext != none)
	{
		SourceUnit = XComGameState_Unit(History.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
		if(SourceUnit.HasSoldierAbility('Impact') && Result.DamageAmount > 0)
		{
			Tuple.Data[0].b = true;
			return ELR_NoInterrupt;
		}
	}

	foreach UnitState.ReserveActionPoints(ActionPointName)
	{
		if(ActionPointName == 'Suppression')
		{
			IsSuppression = true;
			break;
		}
	}


	if(IsSuppression && !UnitState.HasSoldierAbility('SteadFast'))
	{
		Tuple.Data[0].b = true;
	}
	else
	{
		Tuple.Data[0].b = false;
	}

	return ELR_NoInterrupt;
}		
