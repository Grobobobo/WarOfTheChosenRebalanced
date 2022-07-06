//---------------------------------------------------------------------------------------
//  FILE:    X2LWMissionSourcesModTemplate.uc
//  AUTHOR:  Peter Ledbrook
//  PURPOSE: Modifies existing mission source templates.
//---------------------------------------------------------------------------------------
class X2LWMissionSourcesModTemplate extends X2LWTemplateModTemplate config(LW_Overhaul);

static function UpdateMissionSources(X2StrategyElementTemplate Template, int Difficulty)
{
	local X2MissionSourceTemplate SourceTemplate;

	SourceTemplate = X2MissionSourceTemplate(Template);
	if (SourceTemplate == none)
		return;

	switch (SourceTemplate.DataName)
	{
		case 'MissionSource_ChosenAmbush':
			 // Make sure players can back out of the squad select screen
			SourceTemplate.bCannotBackOutSquadSelect = false;
			SourceTemplate.bRequiresSkyrangerTravel = true;
			SourceTemplate.OnSuccessFn = ChosenAmbushOnSuccess;
			SourceTemplate.OnFailureFn = ChosenAmbushOnFailure;
			SourceTemplate.OnExpireFn = ChosenAmbushOnExpire;
			break;
		case 'MissionSource_BlackSite':
		case 'MissionSource_Forge':
		case 'MissionSOurce_PsiGate':
			SourceTemplate.SpawnUFOChance = 0;
			break;
		case 'MissionSource_Retaliation':
			SourceTemplate.SpawnMissionsFn = SpawnRetaliationMission_LW;
			SourceTemplate.OnSuccessFn = RetaliationOnSuccess_LW;
			SourceTemplate.OnFailureFn = RetaliationOnFailure_LW;
			SourceTemplate.OnExpireFn = RetaliationOnExpire_LW;
		case 'MissionSource_Council':
			SourceTemplate.OnSuccessFn = CouncilOnSuccess;


			break;
		default:
			break;
	}
}

// Captures the covert operatives on the mission before going through the
// normal failure path for the ambush mission.
static function ChosenAmbushOnExpire(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_CovertAction ActionState;
	local XComGameState_StaffSlot SlotState;
	local XComGameState_Unit UnitState;
	local int i;

	// Find the covert operatives and capture them
	ActionState = XComGameState_CovertAction(`XCOMHISTORY.GetGameStateForObjectID(
			XComGameState_MissionSiteChosenAmbush_LW(MissionState).CovertActionRef.ObjectID));

	// Go through all the soldier slots, marking the corresponding soldier
	// as captured
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	for (i = 0; i < ActionState.StaffSlots.Length; i++)
	{
		SlotState = ActionState.GetStaffSlot(i);
		if (SlotState.IsSlotFilled())
		{
			UnitState = SlotState.GetAssignedStaff();
			MarkUnitAsCaptured(NewGameState, XComHQ, ActionState, UnitState);
		}
	}

	// Continue with the normal failure path
	ChosenAmbushOnFailure(NewGameState, MissionState);

	`XEVENTMGR.TriggerEvent('CovertActionSoldierCaptured_Central', , , NewGameState);
}

// Adds some behaviour to ambush mission failure that marks the covert action
// rewards as not to be given.
static function ChosenAmbushOnFailure(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	// Go through default failure implementation for the ambush mission first
	class'X2StrategyElement_XpackMissionSources'.static.ChosenAmbushOnFailure(NewGameState, MissionState);

	// Update the covert action tracker
	class'XComGameState_CovertActionTracker'.static.CreateOrGetCovertActionTracker(NewGameState).LastAmbushMissionFailed = true;
}

static function ChosenAmbushOnSuccess(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	// Go through default success implementation for the ambush mission first
	class'X2StrategyElement_XpackMissionSources'.static.ChosenAmbushOnSuccess(NewGameState, MissionState);

	// Update the covert action tracker
	class'XComGameState_CovertActionTracker'.static.CreateOrGetCovertActionTracker(NewGameState).LastAmbushMissionFailed = false;
}

// Marks a unit on a covert action as having been captured by setting its
// `bCaptured` flag, removing it from the crew, and adding a covert action
// risk that will cause the unit to appear as captured in the covert action
// report.
static function MarkUnitAsCaptured(
	XComGameState NewGameState,
	XComGameState_HeadquartersXCom XComHQ,
	XComGameState_CovertAction ActionState,
	XComGameState_Unit UnitState)
{
	local CovertActionRisk ActionRisk;

	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	UnitState.bCaptured = true;

	// Remove captured unit from XComHQ crew
	XComHQ.RemoveFromCrew(UnitState.GetReference());

	// Add a fake "Captured" risk so that the soldier is displayed as such
	// in the after-action report
	ActionRisk.RiskTemplateName = 'CovertActionRisk_SoldierCaptured';
	ActionRisk.Target.ObjectID = UnitState.ObjectID;
	ActionRisk.bOccurs = true;
	ActionState.Risks.AddItem(ActionRisk);
}

static function SpawnRetaliationMission_LW(XComGameState NewGameState, int MissionMonthIndex)
{
	local XComGameState_MissionSite MissionState;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward RewardState;
	local array<XComGameState_WorldRegion> PossibleRegions;
	local float MissionDuration;
	local int iReward;
	local XComGameState_MissionCalendar CalendarState;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_HeadquartersResistance ResHQ;
	local XComGameState_HeadquartersXCom XComHQ;

	CalendarState = class'X2StrategyElement_DefaultMissionSources'.static.GetMissionCalendar(NewGameState);

	// Set Popup flag
	CalendarState.MissionPopupSources.AddItem('MissionSource_Retaliation');

	// Calculate Mission Expiration timer
	MissionDuration = float((class'X2StrategyElement_DefaultMissionSources'.default.MissionMaxDuration - class'X2StrategyElement_DefaultMissionSources'.default.MissionMinDuration + `SYNC_RAND_STATIC(class'X2StrategyElement_DefaultMissionSources'.default.MissionMaxDuration - class'X2StrategyElement_DefaultMissionSources'.default.MissionMinDuration + 1)) * 3600);

	MissionState = XComGameState_MissionSite(NewGameState.ModifyStateObject(class'XComGameState_MissionSite', CalendarState.CurrentMissionMonth[MissionMonthIndex].Missions[0].ObjectID));
	MissionState.Available = true;
	MissionState.Expiring = true;
	MissionState.TimeUntilDespawn = MissionDuration;
	MissionState.TimerStartDateTime = `STRATEGYRULES.GameTime;
	MissionState.SetProjectedExpirationDateTime(MissionState.TimerStartDateTime);
	PossibleRegions = MissionState.GetMissionSource().GetMissionRegionFn(NewGameState);
	RegionState = PossibleRegions[0];
	MissionState.Region = RegionState.GetReference();
	MissionState.Location = RegionState.GetRandomLocationInRegion();

	// Generate Rewards
	ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();
	for(iReward = 0; iReward < MissionState.Rewards.Length; iReward++)
	{
		RewardState = XComGameState_Reward(NewGameState.ModifyStateObject(class'XComGameState_Reward', MissionState.Rewards[iReward].ObjectID));
		RewardState.GenerateReward(NewGameState, ResHQ.GetMissionResourceRewardScalar(RewardState), MissionState.Region);
	}



	// Set Mission Data
	MissionState.SetMissionData(MissionState.GetRewardType(), false, 0);

	MissionState.PickPOI(NewGameState);

	// Flag AlienHQ as having spawned a Retaliation mission
	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersAlien', AlienHQ)
	{
		break;
	}

	if (AlienHQ == none)
	{
		AlienHQ = XComGameState_HeadquartersAlien(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
		AlienHQ = XComGameState_HeadquartersAlien(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersAlien', AlienHQ.ObjectID));
	}

	AlienHQ.bHasSeenRetaliation = true;
	CalendarState.CreatedMissionSources.AddItem('MissionSource_Retaliation');

	// Add tactical tags to upgrade the civilian militia if the force level has been met and the tags have not been previously added
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	if (AlienHQ.ForceLevel >= 14 && XComHQ.TacticalGameplayTags.Find('UseTier3Militia') == INDEX_NONE)
	{
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		XComHQ.TacticalGameplayTags.AddItem('UseTier3Militia');
	}
	else if (AlienHQ.ForceLevel >= 8 && XComHQ.TacticalGameplayTags.Find('UseTier2Militia') == INDEX_NONE)
	{
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		XComHQ.TacticalGameplayTags.AddItem('UseTier2Militia');
	}

	`XEVENTMGR.TriggerEvent('RetaliationMissionSpawned', MissionState, MissionState, NewGameState);
}


static function RetaliationOnSuccess_LW(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	class'X2StrategyElement_DefaultMissionSources'.static.GiveRewards(NewGameState, MissionState);
	class'X2StrategyElement_DefaultMissionSources'.static.SpawnPointOfInterest(NewGameState, MissionState);

	class'X2StrategyElement_DefaultMissionSources'.static.ModifyRegionSupplyYield(NewGameState, MissionState, class'XComGameState_WorldRegion'.static.GetRegionDisconnectSupplyChangePercent(), , true);

	MissionState.RemoveEntity(NewGameState);
	class'XComGameState_HeadquartersResistance'.static.RecordResistanceActivity(NewGameState, 'ResAct_RetaliationsStopped');

	`XEVENTMGR.TriggerEvent('RetaliationComplete', , , NewGameState);
}

static function RetaliationOnFailure_LW(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{	

	class'X2StrategyElement_DefaultMissionSources'.static.ModifyRegionSupplyYield(NewGameState, MissionState, class'XComGameState_WorldRegion'.static.GetRegionDisconnectSupplyChangePercent(), , true);


	MissionState.RemoveEntity(NewGameState);	
	class'XComGameState_HeadquartersResistance'.static.DeactivatePOI(NewGameState, MissionState.POIToSpawn);	
	class'XComGameState_HeadquartersResistance'.static.RecordResistanceActivity(NewGameState, 'ResAct_RetaliationsFailed');

	`XEVENTMGR.TriggerEvent('RetaliationComplete', , , NewGameState);
}

static function RetaliationOnExpire_LW(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local XComGameState_Objective ObjectiveState;

	class'X2StrategyElement_DefaultMissionSources'.static.ModifyRegionSupplyYield(NewGameState, MissionState, class'XComGameState_WorldRegion'.static.GetRegionDisconnectSupplyChangePercent(), , false);
	

	// If the objective to meet the first Chosen is active, complete it, since it contains lines specific
	// to meeting the Chosen in combat, which the player must have skipped. This will start the objective
	// which contains lines related to meeting the Chosen through making region contact, which are correct to play in this instance.
	ObjectiveState = class'XComGameState_HeadquartersXCom'.static.GetObjective('N_XPFirstChosenLocated');
	if (ObjectiveState != none && ObjectiveState.GetStateOfObjective() == eObjectiveState_InProgress)
	{
		ObjectiveState.CompleteObjective(NewGameState);
	}
	
	class'XComGameState_HeadquartersResistance'.static.DeactivatePOI(NewGameState, MissionState.POIToSpawn);
	class'XComGameState_HeadquartersResistance'.static.RecordResistanceActivity(NewGameState, 'ResAct_RetaliationsFailed');	
}


static function CouncilOnSuccess(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local array<int> ExcludeIndices;

	ExcludeIndices = GetCouncilExcludeRewards(MissionState);
	MissionState.bUsePartialSuccessText = (ExcludeIndices.Length > 0);
	class'X2StrategyElement_DefaultMissionSources'.static.GiveRewards(NewGameState, MissionState, ExcludeIndices);
	class'X2StrategyElement_DefaultMissionSources'.static.SpawnPointOfInterest(NewGameState, MissionState);
	MissionState.RemoveEntity(NewGameState);
	class'XComGameState_HeadquartersResistance'.static.RecordResistanceActivity(NewGameState, 'ResAct_CouncilMissionsCompleted');
}


static function array<int> GetCouncilExcludeRewards(XComGameState_MissionSite MissionState)
{
	local XComGameStateHistory History;
	local XComGameState_BattleData BattleData;
	local array<int> ExcludeIndices;
	local int idx;

	History = `XCOMHISTORY;
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	`assert(BattleData.m_iMissionID == MissionState.ObjectID);

	for(idx = 0; idx < BattleData.MapData.ActiveMission.MissionObjectives.Length; idx++)
	{
		if(BattleData.MapData.ActiveMission.MissionObjectives[idx].ObjectiveName == 'Capture' &&
		   !BattleData.MapData.ActiveMission.MissionObjectives[idx].bCompleted)
		{
			ExcludeIndices.AddItem(0);
			ExcludeIndices.AddItem(1);
		}
	}

	return ExcludeIndices;
}

defaultproperties
{
	StrategyElementTemplateModFn=UpdateMissionSources
}