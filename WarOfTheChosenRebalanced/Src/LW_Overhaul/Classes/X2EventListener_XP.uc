// X2EventListener_XP.uc
// 
// A listener template that handles XP management in LW2.
//
class X2EventListener_XP extends X2EventListener config(LW_Overhaul);

struct ClassMissionExperienceWeighting
{
	var name SoldierClass;
	var float MissionExperienceWeight;
};

var config float DEFAULT_MISSION_EXPERIENCE_WEIGHT;
var config array<ClassMissionExperienceWeighting> CLASS_MISSION_EXPERIENCE_WEIGHTS;

var config float MAX_RATIO_MISSION_XP_ON_FAILED_MISSION;
var config int SQUAD_SIZE_MIN_FOR_XP_CALCS;
var config float TOP_RANK_XP_TRANSFER_FRACTION;

var config int LISTENER_PRIORITY;

var config array<name> CLASSES_INELIGIBLE_FOR_MISSION_XP;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateListeners());

	return Templates;
}

static function CHEventListenerTemplate CreateListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'XPListeners');
	//xp system modifications -- handles assigning of mission "encounters" as well as adding to effective kills based on the value
	Template.AddCHEvent('OnDistributeTacticalGameEndXp', OnAddMissionEncountersToUnits, ELD_OnStateSubmitted, GetListenerPriority());
	Template.AddCHEvent('OverrideTotalNumKills', OnGetNumKillsForMissionEncounters, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('OverrideKillXp', OnRewardKillXp, ELD_Immediate, GetListenerPriority());
	Template.RegisterInTactical = true;
	Template.RegisterInStrategy = true;

	return Template;
}

static protected function int GetListenerPriority()
{
	return default.LISTENER_PRIORITY != -1 ? default.LISTENER_PRIORITY : class'XComGameState_LWListenerManager'.default.DEFAULT_LISTENER_PRIORITY;
}

static function EventListenerReturn OnAddMissionEncountersToUnits(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
	local XComGameState_BattleData BattleState;
	local XComGameState_MissionSite MissionState;
	local XComGameStateHistory History;
	local XComGameState_XpManager XpManager;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState NewGameState;
	local StateObjectReference UnitRef;
	local XComGameState_Unit UnitState;
	local array<XComGameState_Unit> UnitStates;
	local UnitValue Value, TestValue;
	local float MissionWeight, UnitShare, UnitShareDivisor;

	`LWTRACE ("OnAddMissionEncountersToUnits triggered");

	XComHQ = XComGameState_HeadquartersXCom(EventData);
	if(XComHQ == none)
		return ELR_NoInterrupt;

	XpManager = XComGameState_XpManager(EventSource);
	if(XpManager == none)
	{
		`REDSCREEN("OnAddMissionEncountersToUnits event triggered with invalid event source.");
		return ELR_NoInterrupt;
	}

	History = `XCOMHISTORY;

	BattleState = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	if (BattleState.m_iMissionID != XComHQ.MissionRef.ObjectID)
	{
		`REDSCREEN("LongWar: Mismatch in BattleState and XComHQ MissionRef when assigning XP");
		return ELR_NoInterrupt;
	}

	MissionState = XComGameState_MissionSite(History.GetGameStateForObjectID(BattleState.m_iMissionID));
	if(MissionState == none)
		return ELR_NoInterrupt;

	MissionWeight = GetMissionWeight(History, XComHQ, BattleState, MissionState);

	//Build NewGameState change container
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Add Mission Encounter Values");
	foreach XComHQ.Squad(UnitRef)
	{
		if (UnitRef.ObjectID == 0)
			continue;

		UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', UnitRef.ObjectID));
		if (UnitState.IsSoldier() && default.CLASSES_INELIGIBLE_FOR_MISSION_XP.Find(UnitState.GetSoldierClassTemplateName()) == INDEX_NONE)
		{
			NewGameState.AddStateObject(UnitState);
			UnitStates.AddItem(UnitState);
		}
		else
		{
			NewGameState.PurgeGameStateForObjectID(UnitState.ObjectID);
		}
	}



	UnitShareDivisor = UnitStates.Length;

	// Count top rank
	foreach UnitStates(UnitState)
	{
		// Max rank is actually 9 due to the wonky implementation of GetMaxRank(),
		// while MSGTs have a rank of 8. That's why we subtract 1.
		if (UnitState.IsSoldier() && !UnitState.IsDead() && !UnitState.bCaptured &&
			UnitState.GetRank() >= (`GET_MAX_RANK - 1))
		{
			UnitShareDivisor -= default.TOP_RANK_XP_TRANSFER_FRACTION;
		}
	}

	UnitShareDivisor = Max (UnitShareDivisor, default.SQUAD_SIZE_MIN_FOR_XP_CALCS);

	if (UnitShareDivisor < 1) 
		UnitShareDivisor = 1;

	UnitShare = MissionWeight / UnitShareDivisor;

	foreach UnitStates(UnitState)
	{

		// Zero out any previous value from an earlier iteration: GetUnitValue will return without zeroing
		// the out param if the value doesn't exist on the unit. If this is the first mission this unit went
		// on they will "inherit" the total XP of the unit immediately before them in the squad unless this
		// is cleared.
		Value.fValue = 0;
		UnitState.GetUnitValue('MissionExperience', Value);
		UnitState.SetUnitFloatValue('MissionExperience', UnitShare + Value.fValue, eCleanup_Never);
		UnitState.GetUnitValue('MissionExperience', TestValue);
		`LWTRACE("MissionXP: PreXp=" $ Value.fValue $ ", PostXP=" $ TestValue.fValue $ ", UnitShare=" $ UnitShare $ ", Unit=" $ UnitState.GetFullName());

	}
	`GAMERULES.SubmitGameState(NewGameState);
	return ELR_NoInterrupt;
}

/* Finds the number of aliens that should be used in determining distributed mission xp.
 * If the mission was a failure then it will scale the amount down by the ratio of the
 * number of aliens killed to the number originally on the mission, and a further configurable
 * amount.
 */
static function float GetMissionWeight(XComGameStateHistory History, XComGameState_HeadquartersXCom XComHQ, XComGameState_BattleData BattleState, XComGameState_MissionSite MissionState)
{
	local X2MissionSourceTemplate MissionSource;
	local bool PlayerWonMission;
	local float fTotal;
	local int AliensSeen, AliensKilled, OrigMissionAliens;

	AliensKilled = class'UIMissionSummary'.static.GetNumEnemiesKilled(AliensSeen);
	OrigMissionAliens = class'Utilities_LW'.static.GetNumEnemiesOnMission(MissionState);

	PlayerWonMission = true;
	MissionSource = MissionState.GetMissionSource();
	if(MissionSource.WasMissionSuccessfulFn != none)
	{
		PlayerWonMission = MissionSource.WasMissionSuccessfulFn(BattleState);
	}

	fTotal = float (OrigMissionAliens);

	if (!PlayerWonMission)
	{
		fTotal *= default.MAX_RATIO_MISSION_XP_ON_FAILED_MISSION * FMin (1.0, float (AliensKilled) / float(OrigMissionAliens));
	}

	return fTotal;
}

static function EventListenerReturn OnGetNumKillsForMissionEncounters(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit UnitState;
	local UnitValue MissionExperienceValue, OfficerBonusKillsValue;
	local float MissionExperienceWeighting;
	local int WeightedBonusKills, idx, TrialByFireKills;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
	{
		`REDSCREEN("OnGetNumKillsForMissionEncounters event triggered with invalid event source.");
		return ELR_NoInterrupt;
	}

	if (Tuple.Data[0].kind != XComLWTVInt)
		return ELR_NoInterrupt;

	UnitState.GetUnitValue('MissionExperience', MissionExperienceValue);

	idx = default.CLASS_MISSION_EXPERIENCE_WEIGHTS.Find('SoldierClass', UnitState.GetSoldierClassTemplateName());
	if (idx != -1)
		MissionExperienceWeighting = default.CLASS_MISSION_EXPERIENCE_WEIGHTS[idx].MissionExperienceWeight;
	else
		MissionExperienceWeighting = default.DEFAULT_MISSION_EXPERIENCE_WEIGHT;

	// XP from going on missions
	WeightedBonusKills = Round(MissionExperienceValue.fValue * MissionExperienceWeighting);

	// XP from Trial By Fire
	OfficerBonusKillsValue.fValue = 0;
	UnitState.GetUnitValue ('OfficerBonusKills', OfficerBonusKillsValue);
	TrialByFireKills = int(OfficerBonusKillsValue.fValue);

	// Just add the extra LW2 XP
	Tuple.Data[0].i = WeightedBonusKills + TrialByFireKills + Tuple.Data[0].i;

	return ELR_NoInterrupt;
}

/* Triggered by XpKillShot event so that we can increment the kill xp for the
	killer as long as the total gained kill xp does not exceed the number of
	enemy units that were initially spawned.
*/
static function EventListenerReturn OnRewardKillXp(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit NewUnitStateKiller;
	local XComGameState_Unit UnitKilled;
	local XComLWTuple Tuple;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	UnitKilled = XComGameState_Unit(EventSource);
	if (UnitKilled == none)
		return ELR_NoInterrupt;

	// Grab the current unit state from NewGameState.
	NewUnitStateKiller = XComGameState_Unit(Tuple.Data[4].o);
	NewUnitStateKiller = XComGameState_Unit(NewGameState.GetGameStateForObjectID(NewUnitStateKiller.ObjectID));

	// Ensure we don't award xp kills beyond what was originally on the mission
	if (!class'Utilities_LW'.static.KillXpIsCapped())
	{
		// Accept the standard XP amounts and just track mission kill XP.
		NewUnitStateKiller.SetUnitFloatValue(
			'MissionKillXp',
			class'Utilities_LW'.static.GetUnitValue(NewUnitStateKiller, 'MissionKillXp') + UnitKilled.GetMyTemplate().KillContribution,
			eCleanup_BeginTactical);
	}
	else
	{
		// Clear all the XP values as we've hit the mission XP cap and can't
		// award any more XP to XCOM.
		Tuple.Data[0].f = 0.0;
		Tuple.Data[1].f = 0.0;
		Tuple.Data[2].f = 0.0;
		Tuple.Data[3].i = 0;
	}

	return ELR_NoInterrupt;
}
