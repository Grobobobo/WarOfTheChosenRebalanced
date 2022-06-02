//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_WarOfTheChosenRebalanced.uc
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_WarOfTheChosenRebalanced extends X2DownloadableContentInfo config(LW_Overhaul);

// Conditional MCOs depending on whether another mod has overridden
// the base class or not.
var config array<ModClassOverrideEntry> ModClassOverrides;

//----------------------------------------------------------------
// A random selection of data and data structures from LW Overhaul
struct MinimumInfilForConcealEntry
{
	var string MissionType;
	var float MinInfiltration;
};

struct ChosenStrengthWeighted
{
	var name Strength;
	var float Weight;
};

var config array<ChosenStrengthWeighted> ASSASSIN_STRENGTHS_T1;
var config array<ChosenStrengthWeighted> ASSASSIN_STRENGTHS_T2;
var config array<ChosenStrengthWeighted> ASSASSIN_STRENGTHS_T3;

var config array<ChosenStrengthWeighted> WARLOCK_STRENGTHS_T1;
var config array<ChosenStrengthWeighted> WARLOCK_STRENGTHS_T2;
var config array<ChosenStrengthWeighted> WARLOCK_STRENGTHS_T3;

var config array<ChosenStrengthWeighted> HUNTER_STRENGTHS_T1;
var config array<ChosenStrengthWeighted> HUNTER_STRENGTHS_T2;
var config array<ChosenStrengthWeighted> HUNTER_STRENGTHS_T3;

// An array of mission types where we should just let vanilla do its
// thing with regard to the Chosen rather than try to override its
// behaviour.
var config array<string> SKIP_CHOSEN_OVERRIDE_MISSION_TYPES;

var config array<MinimumInfilForConcealEntry> MINIMUM_INFIL_FOR_CONCEAL;

struct ArchetypeToHealth
{
	var string ArchetypeName;
	var int Health;
	var int Difficulty;
	structDefaultProperties
	{
		Difficulty = -1;
	}
};

struct PlotObjectiveMod
{
	var string MapName;
	var array<String> ObjectiveTags;
};

var config array<ArchetypeToHealth> DestructibleActorHealthOverride;
var config array<bool> DISABLE_REINFORCEMENT_FLARES;
var config array<float> SOUND_RANGE_DIFFICULTY_MODIFIER;
var config int CHOSEN_RETRIBUTION_DURATION;

struct SocketReplacementInfo
{
	var name TorsoName;
	var string SocketMeshString;
	var bool Female;
};

var config array<SocketReplacementInfo> SocketReplacements;

var config bool ShouldCleanupObsoleteUnits;
var config array<name> CharacterTypesExemptFromCleanup;

var config array<name> CharacterTypesExceptFromInfiltrationModifiers;

var config array<PlotObjectiveMod> PlotObjectiveMods;

// Configurable list of abilities that should apply to the primary
// weapon. This is necessary because character template abilities
// can't be configured for a weapon slot, but some of those abilities
// need to be tied to a weapon slot to work.
//
// This is used in FinalizeUnitAbilitiesForInit() to patch existing
// abilities for non-XCOM units.
var config array<name> PrimaryWeaponAbilities;
var config array<name> SecondaryWeaponAbilities;

// Configurable list of parcels to remove from the game.
var config array<String> ParcelsToRemove;
var bool bDebugPodJobs;

// Minimum force level that needs to be reached before The Lost
// can start to appear.
var config array<int> MIN_FL_FOR_LOST;

// Thresholds for region strength translating to larger Alien Ruler pod size.
var config array<int> RULER_POD_SIZE_ALERT_THRESHOLDS;

// Scaling multiplier for the Brute's pawn
var config float BRUTE_SIZE_MULTIPLIER;

//Mission names dictating the out of LOS ai behavior
var config array<string> PASSIVE_MISSION_TYPES;
var config array<string> DEFENSIVE_MISSION_TYPES;
var config array<string> BALANCED_MISSION_TYPES;

// End data and data structures
//-----------------------------

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{
}


static event UpdateDLC()
{

	LevelUpXTP();

}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{
	//local XComGameState_WorldRegion StartingRegionState;
//	local XComGameState_ResistanceFaction StartingFactionState;

	//class'XComGameState_LWListenerManager'.static.CreateListenerManager(StartState);

	class'XComGameState_LWOverhaulOptions'.static.CreateModSettingsState_NewCampaign(class'XComGameState_LWOverhaulOptions', StartState);
	class'XComGameState_LWXTP'.static.CreateXTPState(StartState);

	// Save the second wave options, but only if we've actually started a new
	// campaign (hence the check for UIShellDifficulty being open).
	if (`SCREENSTACK != none && UIShellDifficulty(`SCREENSTACK.GetFirstInstanceOf(class'UIShellDifficulty')) != none)
	{
		SaveSecondWaveOptions();
	}

	//StartingRegionState = SetStartingLocationToStartingRegion(StartState);
	UpdateLockAndLoadBonus(StartState);  // update XComHQ and Continent states to remove LockAndLoad bonus if it was selected
	SetUpGateCrasherCrew(StartState);
	DisableUnwantedObjectives(StartState);

	// Clear starting resistance modes because we don't actually start
	// at the faction HQ, unlike vanilla WOTC.
	// StartingFactionState = StartingRegionState.GetResistanceFaction();
	// class'X2StrategyElement_DefaultResistanceModes'.static.OnXCOMLeavesIntelMode(StartState, StartingFactionState.GetReference());
	// class'X2StrategyElement_DefaultResistanceModes'.static.OnXCOMLeavesMedicalMode(StartState, StartingFactionState.GetReference());
	// class'X2StrategyElement_DefaultResistanceModes'.static.OnXCOMLeavesBuildMode(StartState, StartingFactionState.GetReference());
}

static function OnPreCreateTemplates()
{
	`Log("Long War of the Chosen (LWOTC) version: " $ class'LWVersion'.static.GetVersionString());
	PatchModClassOverrides();
}

/// <summary>
/// Called after the Templates have been created (but before they are validated) while this DLC / Mod is installed.
/// </summary>
static event OnPostTemplatesCreated()
{
	`Log(">>>> LW_Overhaul OnPostTemplates");
	class'LWTemplateMods_Utilities'.static.UpdateTemplates();
	UpdateWeaponAttachmentsForCoilgun();
	//WOTCR - Not used because we're back to vanilla mission types. might uncomment this later if i want to re-disable tunnels.
	//AddObjectivesToParcels();
	UpdateChosenActivities();
	UpdateChosenSabotages();
}

/// <summary>
/// This method is run when the player loads a saved game directly into Strategy while this DLC is installed
/// </summary>
static event OnLoadedSavedGameToStrategy()
{
	local XComGameState NewGameState;
	local XComGameStateHistory History;
	local XComGameState_Objective ObjectiveState;
	local XComGameState_LWToolboxOptions ToolboxOptions;
	
	
	History = `XCOMHISTORY;

	// TODO: Remove these post 1.0 - START

	// LWOTC beta 2: Remove the 'OnMonthlyReportAlert' listener as it's no
	// longer needed (Not Created Equally is handled by the 'UnitRandomizedStats'
	// event now).
	ToolboxOptions = class'XComGameState_LWToolboxOptions'.static.GetToolboxOptions();
	`XEVENTMGR.UnRegisterFromEvent(ToolboxOptions, 'OnMonthlyReportAlert');

		
	if (`LWOVERHAULOPTIONS == none)
		class'XComGameState_LWOverhaulOptions'.static.CreateModSettingsState_ExistingCampaign(class'XComGameState_LWOverhaulOptions');

	//make sure that critical narrative moments are active
	foreach History.IterateByClassType(class'XComGameState_Objective', ObjectiveState)
	{
		if (ObjectiveState.GetMyTemplateName() == 'N_GPCinematics')
		{
			if (ObjectiveState.ObjState != eObjectiveState_InProgress)
			{
				NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Forcing N_GPCinematics active");
				ObjectiveState = XComGameState_Objective(NewGameState.ModifyStateObject(class'XComGameState_Objective', ObjectiveState.ObjectID));
				ObjectiveState.StartObjective(NewGameState, true);
				History.AddGameStateToHistory(NewGameState);
			}
			break;
		}
	}

	CleanupObsoleteTacticalGamestate();
}

// Make sure we're not overriding classes already overridden by another
// mod, such as Detailed Soldier List. Thanks to Musashi for the basic
// code (as used in RPGO).
static function PatchModClassOverrides()
{
	local Engine LocalEngine;
	local ModClassOverrideEntry MCO;

	LocalEngine = class'Engine'.static.GetEngine();
	foreach default.ModClassOverrides(MCO)
	{
		if (LocalEngine.ModClassOverrides.Find('BaseGameClass', MCO.BaseGameClass) != INDEX_NONE)
		{
			`LWTrace(GetFuncName() @ "Found existing MCO for base class" @ MCO.BaseGameClass @ " - SKIPPING");
			continue;
		}
		LocalEngine.ModClassOverrides.AddItem(MCO);
		`LWTrace(GetFuncName() @ "Adding Mod Class Override -" @ MCO.BaseGameClass @ MCO.ModClass);
	}
}

static function SaveSecondWaveOptions()
{	
	local UIShellDifficulty ShellDifficultyUI;
	local UIShellDifficultySW NewShellDifficultyUI;
	local SecondWaveOption SWOption;
	local SecondWaveOptionObject NewSWOption;
	local SecondWavePersistentData PersistentData;
	local PersistentSecondWaveOption PersistentOption;
	local XComGameState_CampaignSettings CampaignSettingsState;

	
	ShellDifficultyUI = UIShellDifficulty(class'Engine'.static.FindClassDefaultObject("XComGame.UIShellDifficulty"));
	NewShellDifficultyUI = UIShellDifficultySW(class'Engine'.static.FindClassDefaultObject("BetterSecondWaveSupport.UIShellDifficultySW"));
	CampaignSettingsState = XComGameState_CampaignSettings(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));

	PersistentData = new class'SecondWavePersistentData';

	// Clear existing data from INI first
	PersistentData.SecondWaveOptionList.Length = 0;
	PersistentData.SaveConfig();

	// Save difficulty and beginner VO settings
	PersistentData.IsDifficultySet = true;
	PersistentData.Difficulty = CampaignSettingsState.DifficultySetting;
	PersistentData.DisableBeginnerVO = CampaignSettingsState.bSuppressFirstTimeNarrative;

	// Add base-game second wave options
	foreach ShellDifficultyUI.SecondWaveOptions(SWOption)
	{
		PersistentOption.ID = SWOption.ID;
		PersistentOption.IsChecked = CampaignSettingsState.SecondWaveOptions.Find(PersistentOption.ID) != INDEX_NONE;
		PersistentData.SecondWaveOptionList.AddItem(PersistentOption);
	}

	// Add extra second wave options
	foreach NewShellDifficultyUI.SecondWaveOptionsReal(NewSWOption)
	{
		PersistentOption.ID = NewSWOption.OptionData.ID;
		PersistentOption.IsChecked = CampaignSettingsState.SecondWaveOptions.Find(PersistentOption.ID) != INDEX_NONE;
		PersistentData.SecondWaveOptionList.AddItem(PersistentOption);
	}

	// Save the new second wave settings
	`LWTrace("Saving second wave options");
	PersistentData.SaveConfig();
}

static function XComGameState_WorldRegion SetStartingLocationToStartingRegion(XComGameState StartState)
{
	local XComGameState_HeadquartersXCom XComHQ;

	foreach StartState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	XComHQ.CurrentLocation = XComHQ.StartingRegion;
	return XComGameState_WorldRegion(StartState.GetGameStateForObjectID(XComHQ.StartingRegion.ObjectID));
}


static function UpdateLockAndLoadBonus(optional XComGameState StartState)
{
	// LWOTC: This implementation was copied from the Covert Infiltrations
	// mod. LockAndLoad is no longer a continent bonus.
	local XComGameState_HeadquartersXCom XComHQ;
	local bool bSubmitLocally;

	if (StartState == none)
	{
		bSubmitLocally = true;
		StartState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("CI: Forcing Lock And Load");
	}

	XComHQ = XComGameState_HeadquartersXCom(StartState.ModifyStateObject(class'XComGameState_HeadquartersXCom', `XCOMHQ.ObjectID));
	XComHQ.bReuseUpgrades = true;

	//This also makes it so you won't get an additional pop-up regarding res orders existing
	XComHQ.bHasSeenResistanceOrdersIntroPopup = true;

	if(bSubmitLocally)
	{
		`XCOMGAME.GameRuleset.SubmitGameState(StartState);
	}
}


/// <summary>
/// Called when viewing mission blades, used primarily to modify tactical tags for spawning
/// Returns true when the mission's spawning info needs to be updated
/// </summary>
static function bool UpdateMissionSpawningInfo(StateObjectReference MissionRef)
{
	// We need to clear up the mess that the Alien Rulers DLC leaves in its wake.
	// In this case, it clears all the alien ruler gameplay tags from XComHQ, just
	// before the schedules are picked (which rely on those tags). And of course it
	// may apply the ruler tags itself when we don't want them. Bleh.
	if (class'XComGameState_AlienRulerManager' != none)
	{
		return FixAlienRulerTags(MissionRef);
	}

	return false;
}

static function bool FixAlienRulerTags(StateObjectReference MissionRef)
{
	local XComGameState_AlienRulerManager RulerMgr;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_MissionSite MissionState;
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local name CurrentTag;
	local bool bUpdated;

	History = `XCOMHISTORY;
	bUpdated = false;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("LWOTC: Fix Alien Ruler gameplay tags");
	RulerMgr = XComGameState_AlienRulerManager(History.GetSingleGameStateObjectForClass(class'XComGameState_AlienRulerManager'));
	RulerMgr = XComGameState_AlienRulerManager(NewGameState.ModifyStateObject(class'XComGameState_AlienRulerManager', RulerMgr.ObjectID));
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	MissionState = XComGameState_MissionSite(History.GetGameStateForObjectID(MissionRef.ObjectID));

	// Check whether DLC has added active ruler tags to XComHQ. We don't want
	// them if there are any.
	if (class'LWDLCHelpers'.static.TagArrayHasActiveRulerTag(XComHQ.TacticalGameplayTags))
	{
		// Clear existing active tags out so we can replace them.
		RulerMgr.ClearActiveRulerTags(XComHQ);
		bUpdated = true;
	}

	// Add back any mission active ruler tags that DLC 2 will have kindly
	// removed from XComHQ for us. This is important to ensure that the
	// alien rulers are added to the mission schedule if it's possible.
	if (class'LWDLCHelpers'.static.IsAlienRulerOnMission(MissionState))
	{
		foreach MissionState.TacticalGameplayTags(CurrentTag)
		{
			if (class'LWDLCHelpers'.default.AlienRulerTags.Find(CurrentTag) != INDEX_NONE)
			{
				// Found an active Ruler tag, so add it to XComHQ.
				XComHQ.TacticalGameplayTags.AddItem(CurrentTag);
				AddRulerAdditionalTags(MissionState, XComHQ, CurrentTag);
				bUpdated = true;
			}
		}
	}

	if (bUpdated)
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	else
		History.CleanupPendingGameState(NewGameState);

	return bUpdated;
}

static function AddRulerAdditionalTags(
	XComGameState_MissionSite MissionState,
	XComGameState_HeadquartersXCom XComHQ,
	name RulerActiveTacticalTag)
{
	local int i, RulerIndex;

	for (i = 0; i < class'XComGameState_AlienRulerManager'.default.AlienRulerTemplates.Length; i++)
	{
		if (class'XComGameState_AlienRulerManager'.default.AlienRulerTemplates[i].ActiveTacticalTag == RulerActiveTacticalTag)
		{
			RulerIndex = i;
			break;
		}
	}

	// Check the mission alert level against the thresholds for Alien Ruler
	// pod size. If the alert level is below the first threshold, then we
	// don't add any additional tags. Otherwise we pull the required additional
	// tag from the Alien Ruler template config.
	for (i = 0; i < default.RULER_POD_SIZE_ALERT_THRESHOLDS.Length; i++)
	{
		if (MissionState.SelectedMissionData.AlertLevel < default.RULER_POD_SIZE_ALERT_THRESHOLDS[i])
		{
			if (i > 0)
			{
				XComHQ.TacticalGameplayTags.AddItem(
						class'XComGameState_AlienRulerManager'.default.AlienRulerTemplates[RulerIndex].AdditionalTags[i - 1].TacticalTag);
			}
			break;
		}
	}
}

private static function int SortNames(name NameA, name NameB)
{
	local string StringA, StringB;

	StringA = string(NameA);
	StringB = string(NameB);

	if (StringA < StringB)
	{
		return 1;
	}
	else if (StringA > StringB)
	{
		return -1;
	}
	else
	{
		return 0;
	}
}

// *****************************************************
// XCOM tactical mission adjustments
//

static event OnPreMission(XComGameState StartGameState, XComGameState_MissionSite MissionState)
{
	local XComGameStateHistory History;
	local XComGameState_PointOfInterest POIState;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_MissionCalendar CalendarState;

	History = `XCOMHISTORY;

	ResetDelayedEvac(StartGameState);
	ResetReinforcements(StartGameState);
	OverrideDestructibleHealths(StartGameState);
	//MaybeAddChosenToMission(StartGameState, MissionState);
	if (class'XComGameState_AlienRulerManager' != none)
	{
		OverrideAlienRulerSpawning(StartGameState, MissionState);
	}

	// Test Code to see if DLC POI replacement is working
	if (MissionState.POIToSpawn.ObjectID > 0)
	{
		POIState = XComGameState_PointOfInterest(StartGameState.GetGameStateForObjectID(MissionState.POIToSpawn.ObjectID));
		if (POIState == none)
		{
			POIState = XComGameState_PointOfInterest(`XCOMHISTORY.GetGameStateForObjectID(MissionState.POIToSpawn.ObjectID));
		}
	}
	`LWTRACE("PreMission : MissonPOI ObjectID = " $ MissionState.POIToSpawn.ObjectID);
	if (POIState != none)
	{
		`LWTRACE("PreMission : MissionPOI name = " $ POIState.GetMyTemplateName());
	}

	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
	//log some info relating to the AH POI 2 replacement conditions to see what might be causing it to not spawn
	`LWTRACE("============= POI_AlienNest Debug Info ========================");
	`LWTRACE("Mission POI to Replace                  : " $ string(MissionState.POIToSpawn.ObjectID > 0));
	foreach History.IterateByClassType(class'XComGameState_PointOfInterest', POIState)
	{
	`LWTRACE("     XCGS_PointOfInterest found : " $ POIState.GetMyTemplateName());
		if (POIState.GetMyTemplateName() == 'POI_AlienNest')
		{
			break;
		}
	}
	if (POIState != none && POIState.GetMyTemplateName() == 'POI_AlienNest')
	{
		`LWTRACE("XCGS_PointOfInterest for POI_AlienNest  : found");
	}
	else
	{
		`LWTRACE("XCGS_PointOfInterest for POI_AlienNest  : NOT found");
	}
	`LWTRACE("DLC_HunterWeapons objective complete    : " $ string(`XCOMHQ.IsObjectiveCompleted('DLC_HunterWeapons')));
	`LWTRACE("Time Test Passed                        : " $ string(class'X2StrategyGameRulesetDataStructures'.static.LessThan(AlienHQ.ForceLevelIntervalEndTime, CalendarState.CurrentMissionMonth[0].SpawnDate)));
	`LWTRACE("     AlienHQ       ForceLevelIntervalEndTime        : " $ class'X2StrategyGameRulesetDataStructures'.static.GetDateString(AlienHQ.ForceLevelIntervalEndTime) $ ", " $ class'X2StrategyGameRulesetDataStructures'.static.GetTimeString(AlienHQ.ForceLevelIntervalEndTime));
	`LWTRACE("     CalendarState CurrentMissionMonth[0] SpawnDate : " $ class'X2StrategyGameRulesetDataStructures'.static.GetDateString(CalendarState.CurrentMissionMonth[0].SpawnDate) $ ", " $ class'X2StrategyGameRulesetDataStructures'.static.GetTimeString(CalendarState.CurrentMissionMonth[0].SpawnDate));
	`LWTRACE("ForceLevel Test Passed                  : " $ string(AlienHQ.GetForceLevel() + 1 >= 4));
	`LWTRACE("     AlienHQ ForceLevel  : " $ AlienHQ.GetForceLevel());
	`LWTRACE("     Required ForceLevel : 4");
	`LWTRACE("===============================================================");
}

// Disable the Lost if we don't meet certain conditions. This is also
// called for the creation of Gatecrasher.
static function PostSitRepCreation(out GeneratedMissionData GeneratedMission, optional XComGameState_BaseObject SourceObject)
{
	local XComGameState_HeadquartersAlien AlienHQ;

	AlienHQ = XComGameState_HeadquartersAlien(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));

	// Disable TheLost SitRep if we haven't reached the appropriate force level yet.
	if (AlienHQ.ForceLevel < default.MIN_FL_FOR_LOST[`TACTICALDIFFICULTYSETTING])
	{
		GeneratedMission.SitReps.RemoveItem('TheLost');
		GeneratedMission.SitReps.RemoveItem('TheHorde');
	}
}

// Diversify pod makeup, especially with all-alien pods which typically consist
// of the same alien unit. This also makes a few other adjustments to pods.
static function PostEncounterCreation(out name EncounterName, out PodSpawnInfo SpawnInfo, int ForceLevel, int AlertLevel, optional XComGameState_BaseObject SourceObject)
{
	local XComGameStateHistory History;
	local XComGameState_BattleData BattleData;
	local name								CharacterTemplateName, FirstFollowerName;
	local int								idx, Tries, PodSize, k;
	local X2CharacterTemplateManager		TemplateManager;
	local X2CharacterTemplate				LeaderCharacterTemplate, FollowerCharacterTemplate, CurrentCharacterTemplate;
	local bool								Swap, Satisfactory;
	local XComGameState_MissionSite			MissionState;
	local XComGameState_AIReinforcementSpawner	RNFSpawnerState;
	local XComGameState_HeadquartersXCom XCOMHQ;
	local array<SpawnDistributionListEntry>	LeaderSpawnList;
	local array<SpawnDistributionListEntry>	FollowerSpawnList;

	`LWTRACE("Parsing Encounter : " $ EncounterName);

	History = `XCOMHISTORY;
	MissionState = XComGameState_MissionSite(SourceObject);
	if (MissionState == none)
	{
		BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData', true));
		if (BattleData == none)
		{
			`LWTRACE("Could not detect mission type. Aborting with no mission variations applied.");
			return;
		}
		else
		{
			MissionState = XComGameState_MissionSite(History.GetGameStateForObjectID(BattleData.m_iMissionID));
		}
	}

	// Ignore the final and any DLC missions
	`LWTRACE("Mission type = " $ MissionState.GeneratedMission.Mission.sType $ " detected.");
	switch(MissionState.GeneratedMission.Mission.sType)
	{
		case "GP_Fortress":
		case "GP_Fortress_LW":
			`LWTRACE("Fortress mission detected. Aborting with no mission variations applied.");
			return;
		case "AlienNest":
		case "LastGift":
		case "LastGiftB":
		case "LastGiftC":
			`LWTRACE("DLC mission detected. Aborting with no mission variations applied.");
			return;
		default:
			break;
	}

	// Double check for the final mission. [PAL Not sure this is necessary as the original
	// code had no comment explaining why both the mission type and the encounter name are
	// checked]
	if (Left(string(EncounterName), 11) == "GP_Fortress")
	{
		`LWTRACE("Fortress mission detected. Aborting with no mission variations applied.");
		return;
	}

	// Ignore story encounters
	switch (EncounterName)
	{
		case 'LoneAvatar':
		case 'LoneCodex':
			return;
		default:
			break;
	}

	// Ignore explicitly protected encounters
	if (InStr (EncounterName,"PROTECTED") != -1)
	{
		return;
	}

	// Get the corresponding spawn distribution lists for this mission.
	GetLeaderSpawnDistributionList(EncounterName, MissionState, ForceLevel, LeaderSpawnList);
	GetFollowerSpawnDistributionList(EncounterName, MissionState, ForceLevel, FollowerSpawnList);

	//`LWTRACE("PE1");
	RNFSpawnerState = XComGameState_AIReinforcementSpawner(SourceObject);

	//	`LWTRACE ("PE2");
	if (RNFSpawnerState != none)
	{
		`LWTRACE("Called from AIReinforcementSpawner.OnReinforcementSpawnerCreated -- modifying reinforcement spawninfo");
	}
	else
	{
		if (MissionState != none)
		{
			`LWTRACE("Called from MissionSite.CacheSelectedMissionData -- modifying preplaced spawninfo");
		}
	}

	//`LWTRACE ("PE3");

	`LWTRACE("Encounter composition:");
	foreach SpawnInfo.SelectedCharacterTemplateNames(CharacterTemplateName, idx)
	{
		`LWTRACE("Character[" $ idx $ "] = " $ CharacterTemplateName);
	}

	PodSize = SpawnInfo.SelectedCharacterTemplateNames.length;

	TemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	LeaderCharacterTemplate = TemplateManager.FindCharacterTemplate(SpawnInfo.SelectedCharacterTemplateNames[0]);

	swap = false;

	// override native insisting every mission have a codex while certain tactical options are active
	XCOMHQ = XComGameState_HeadquartersXCom(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));

	// Swap out forced Codices on regular encounters
	if (SpawnInfo.SelectedCharacterTemplateNames[0] == 'Cyberus' && InStr (EncounterName,"PROTECTED") == -1 && EncounterName != 'LoneCodex')
	{
		swap = true;
		SpawnInfo.SelectedCharacterTemplateNames[0] = SelectNewPodLeader(SpawnInfo, ForceLevel, LeaderSpawnList);
		`LWTRACE ("Swapping Codex leader for" @ SpawnInfo.SelectedCharacterTemplateNames[0]);
	}

	// forces special conditions for avatar to pop
	if (SpawnInfo.SelectedCharacterTemplateNames[0] == 'AdvPsiWitchM3')
	{
		if (XCOMHQ.GetObjectiveStatus('T1_M5_SKULLJACKCodex') != eObjectiveState_Completed)
		{
			switch (EncounterName)
			{
				case 'LoneAvatar' :
				case 'GP_Fortress_AvatarGroup_First_LW' :
				case 'GP_Fortress_AvatarGroup_First' :
					break;
				default:
					swap = true;
					SpawnInfo.SelectedCharacterTemplateNames[0] = SelectNewPodLeader(SpawnInfo, ForceLevel, LeaderSpawnList);
					`LWTRACE ("Swapping Avatar leader for" @ SpawnInfo.SelectedCharacterTemplateNames[0]);
					break;
			}
		}
	}

	// reroll advent captains when the game is forcing captains
	if (RNFSpawnerState != none && InStr(SpawnInfo.SelectedCharacterTemplateNames[0],"Captain") != -1)
	{
		if (XCOMHQ.GetObjectiveStatus('T1_M3_KillCodex') == eObjectiveState_InProgress ||
			XCOMHQ.GetObjectiveStatus('T1_M5_SKULLJACKCodex') == eObjectiveState_InProgress ||
			XCOMHQ.GetObjectiveStatus('T1_M6_KillAvatar') == eObjectiveState_InProgress ||
			XCOMHQ.GetObjectiveStatus('T1_M2_S3_SKULLJACKCaptain') == eObjectiveState_InProgress)
		swap = true;
		SpawnInfo.SelectedCharacterTemplateNames[0] = SelectNewPodLeader(SpawnInfo, ForceLevel, LeaderSpawnList);
		`LWTRACE ("Swapping Reinf Captain leader for" @ SpawnInfo.SelectedCharacterTemplateNames[0]);
	}

	// Now deal with followers
	if (PodSize > 1)
	{
		TemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
		LeaderCharacterTemplate = TemplateManager.FindCharacterTemplate(SpawnInfo.SelectedCharacterTemplateNames[0]);
		// Find whatever the pod has the most of
		FirstFollowerName = FindMostCommonMember(SpawnInfo.SelectedCharacterTemplateNames);
		FollowerCharacterTemplate = TemplateManager.FindCharacterTemplate(FirstFollowerName);

		`LWTRACE("Pod Leader:" @ SpawnInfo.SelectedCharacterTemplateNames[0]);
		`LWTRACE("Pod Follower:" @ FirstFollowerName);

		if (LeaderCharacterTemplate.bIsTurret)
			return;

		if (InStr(EncounterName, "LIST_BOSSx") != -1 && InStr(EncounterName, "_LW") == -1)
		{
			`LWTRACE("Don't Edit certain vanilla Boss pods");
			return;
		}
		if (Instr(EncounterName, "Chryssalids") != -1)
		{
			`LWTRACE("Don't edit Chryssypods");
			return;
		}

		// Handle vanilla pod construction of one type of alien follower;
		if (!swap && LeaderCharacterTemplate.bIsAlien && FollowerCharacterTemplate.bIsAlien && CountMembers(FirstFollowerName, SpawnInfo.SelectedCharacterTemplateNames) > 1)
		{
			`LWTRACE("Mixing up alien-dominant pod");
			swap = true;
		}

		// Check for pod members that shouldn't appear yet for plot reaons
		if (CountMembers('Cyberus', SpawnInfo.SelectedCharacterTemplateNames) >= 1 && XCOMHQ.GetObjectiveStatus('T1_M2_S3_SKULLJACKCaptain') != eObjectiveState_Completed)
		{
			`LWTRACE("Removing Codex for objective reasons");
			swap = true;
		}

		if (CountMembers ('AdvPsiWitch', SpawnInfo.SelectedCharacterTemplateNames) >= 1 && XCOMHQ.GetObjectiveStatus('T1_M5_SKULLJACKCodex') != eObjectiveState_Completed)
		{
			`LWTRACE("Exicising Avatar for objective reasons");
			swap = true;
		}

		if (!swap)
		{
			for (k = 0; k < SpawnInfo.SelectedCharacterTemplateNames.Length; k++)
			{
				FollowerCharacterTemplate = TemplateManager.FindCharacterTemplate(SpawnInfo.SelectedCharacterTemplateNames[k]);
				if (CountMembers(SpawnInfo.SelectedCharacterTemplateNames[k], SpawnInfo.SelectedCharacterTemplateNames) > FollowerCharacterTemplate.default.MaxCharactersPerGroup)
				{
					swap = true;
				}
			}
			if (swap)
			{
				`LWTRACE("Mixing up pod that violates MCPG setting");
			}
		}

		// if size 4 && at least 3 are the same
		if (!swap && (PodSize == 4 || PodSize == 5))
		{
			if (CountMembers(FirstFollowerName, SpawnInfo.SelectedCharacterTemplateNames) >= PodSize - 1)
			{
				`LWTRACE ("Mixing up undiverse 4/5-enemy pod");
				swap = true;
			}
		}

		// if larger && at least size - 2 are the same
		if (!swap && PodSize >= 6)
		{
			// if a max of one guy is different
			if (!swap && CountMembers(FirstFollowerName, SpawnInfo.SelectedCharacterTemplateNames) >= PodSize - 2)
			{
				`LWTRACE ("Mixing up undiverse 5+ enemy pod");
				swap = true;
			}
		}

		if (swap)
		{
			// Re-roll the follower character templates
			Satisfactory = false;
			Tries = 0;
			While (!Satisfactory && Tries < 12)
			{
				// let's look at
				foreach SpawnInfo.SelectedCharacterTemplateNames(CharacterTemplateName, idx)
				{
					if (idx <= 2)
						continue;

					if (SpawnInfo.SelectedCharacterTemplateNames[idx] != FirstFollowerName)
						continue;

					CurrentCharacterTemplate = TemplateManager.FindCharacterTemplate(SpawnInfo.SelectedCharacterTemplateNames[idx]);
					if (CurrentCharacterTemplate.bIsTurret)
						continue;

					SpawnInfo.SelectedCharacterTemplateNames[idx] = SelectRandomPodFollower(SpawnInfo, LeaderCharacterTemplate.SupportedFollowers, ForceLevel, FollowerSpawnList);
				}
				//`LWTRACE ("Try" @ string (tries) @ CountMembers (FirstFollowerName, SpawnInfo.SelectedCharacterTemplateNames) @ string (PodSize));
				// Let's look over our outcome and see if it's any better
				if ((PodSize == 4 || PodSize == 5) && CountMembers(FirstFollowerName, SpawnInfo.SelectedCharacterTemplateNames) >= Podsize - 1)
				{
					Tries += 1;
				}
				else
				{
					if (PodSize >= 6 && CountMembers(FirstFollowerName, SpawnInfo.SelectedCharacterTemplateNames) >= PodSize - 2)
					{
						Tries += 1;
					}
					else
					{
						Satisfactory = true;
					}
				}
			}
			`LWTRACE("Attempted to edit Encounter to add more enemy diversity! Satisfactory:" @ string(satisfactory) @ "New encounter composition:");
			foreach SpawnInfo.SelectedCharacterTemplateNames (CharacterTemplateName, idx)
			{
				`LWTRACE("Character[" $ idx $ "] = " $ CharacterTemplateName);
			}
		}
	}

	return;
}

static function GetLeaderSpawnDistributionList(name EncounterName, XComGameState_MissionSite MissionState, int ForceLevel, out array<SpawnDistributionListEntry> SpawnList)
{
	GetSpawnDistributionList(EncounterName, MissionState, ForceLevel, SpawnList, true);
}

static function GetFollowerSpawnDistributionList(name EncounterName, XComGameState_MissionSite MissionState, int ForceLevel, out array<SpawnDistributionListEntry> SpawnList)
{
	GetSpawnDistributionList(EncounterName, MissionState, ForceLevel, SpawnList, false);
}

static function GetSpawnDistributionList(
	name EncounterName,
	XComGameState_MissionSite MissionState,
	int ForceLevel,
	out array<SpawnDistributionListEntry> SpawnList,
	bool IsLeaderList)
{
	local SpawnDistributionList CurrentList;
	local SpawnDistributionListEntry CurrentListEntry;
	local name SpawnListID;
	local int idx;

	idx = class'XComTacticalMissionManager'.default.ConfigurableEncounters.Find('EncounterID', EncounterName);
	if (IsLeaderList)
	{
		if (class'XComTacticalMissionManager'.default.ConfigurableEncounters[idx].EncounterLeaderSpawnList != '')
		{
			SpawnListID = class'XComTacticalMissionManager'.default.ConfigurableEncounters[idx].EncounterLeaderSpawnList;
		}
	}
	else
	{
		if (class'XComTacticalMissionManager'.default.ConfigurableEncounters[idx].EncounterFollowerSpawnList != '')
		{
			SpawnListID = class'XComTacticalMissionManager'.default.ConfigurableEncounters[idx].EncounterFollowerSpawnList;
		}
	}

	// LWOTC TODO: Support SitRep overrides

	// Fall back to using the schedule's default spawn distribution list
	if (SpawnListID == '')
	{
		idx = class'XComTacticalMissionManager'.default.MissionSchedules.Find('ScheduleID', MissionState.SelectedMissionData.SelectedMissionScheduleName);
		if (IsLeaderList)
		{
			SpawnListID = class'XComTacticalMissionManager'.default.MissionSchedules[idx].DefaultEncounterLeaderSpawnList;
		}
		else
		{
			SpawnListID = class'XComTacticalMissionManager'.default.MissionSchedules[idx].DefaultEncounterFollowerSpawnList;
		}
	}

	`LWTrace("Using spawn distribution list " $ SpawnListID);
	
	// Build a merged list of all spawn distribution list entries that satisfy the selected
	// list ID and force level.
	foreach class'XComTacticalMissionManager'.default.SpawnDistributionLists(CurrentList)
	{
		if (CurrentList.ListID == SpawnListID)
		{
			foreach CurrentList.SpawnDistribution(CurrentListEntry)
			{
				if (ForceLevel >= CurrentListEntry.MinForceLevel && ForceLevel <= CurrentListEntry.MaxForceLevel)
				{
					`LWTrace("Adding " $ CurrentListEntry.Template $ " to the merged spawn distribution list with spawn weight " $ CurrentListEntry.SpawnWeight);
					SpawnList.AddItem(CurrentListEntry);
				}
			}
		}
	}
}

static function int CountMembers(name CountItem, array<name> ArrayToScan)
{
	local int idx, k;

	k = 0;
	for (idx = 0; idx < ArrayToScan.Length; idx++)
	{
		if (ArrayToScan[idx] == CountItem)
		{
			k += 1;
		}
	}
	return k;
}

static function name FindMostCommonMember(array<name> ArrayToScan)
{
	local int idx, highest, highestidx;
	local array<int> kount;

	highestidx = 1; // Start with first follower rather than the leader
	kount.length = 0;
	for (idx = 0; idx < ArrayToScan.Length; idx++)
	{
		kount.AddItem(CountMembers(ArrayToScan[idx], ArrayToScan));
	}
	highest = 1;
	for (idx = 0; idx < kount.length; idx ++)
	{
		if (kount[idx] > highest)
		{
			Highest = kount[idx];
			HighestIdx = Idx;
		}
	}
	return ArrayToScan[highestidx];
}

static function SpawnDistributionListEntry GetCharacterSpawnEntry(out array<SpawnDistributionListEntry> SpawnList, X2CharacterTemplate CharacterTemplate, int ForceLevel)
{
	local SpawnDistributionListEntry SpawnEntry, NullEntry;

	foreach SpawnList(SpawnEntry)
	{
		if (SpawnEntry.Template == CharacterTemplate.DataName && ForceLevel >= SpawnEntry.MinForceLevel && ForceLevel <= SpawnEntry.MaxForceLevel)
		{
			return SpawnEntry;
		}
	}

	return NullEntry;
}

static function float GetCharacterSpawnWeight(out array<SpawnDistributionListEntry> SpawnList, X2CharacterTemplate CharacterTemplate, int ForceLevel)
{
	local SpawnDistributionListEntry SpawnEntry;

	SpawnEntry = GetCharacterSpawnEntry(SpawnList, CharacterTemplate, ForceLevel);
	if (SpawnEntry.Template != '')
	{
		return SpawnEntry.SpawnWeight;
	}
	else
	{
		return 0.0;
	}
}

static function name SelectNewPodLeader(PodSpawnInfo SpawnInfo, int ForceLevel, out array<SpawnDistributionListEntry> SpawnList)
{
	local X2CharacterTemplateManager CharacterTemplateMgr;
	local X2DataTemplate Template;
	local X2CharacterTemplate CharacterTemplate;
	local array<name> PossibleChars;
	local array<float> PossibleWeights;
	local float TotalWeight, TestWeight, RandomWeight;
	local int k;
	local XComGameState_HeadquartersXCom XCOMHQ;

	`LWTRACE ("Initiating SelectNewPodLeader" @ ForceLevel);

	PossibleChars.length = 0;
	XCOMHQ = XComGameState_HeadquartersXCom(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));

	CharacterTemplateMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	foreach CharacterTemplateMgr.IterateTemplates (Template, None)
	{
		CharacterTemplate = X2CharacterTemplate(Template);
		if (CharacterTemplate == none)
			continue;
		if (!(CharacterTemplate.bIsAdvent || CharacterTemplate.bIsAlien))
			continue;
		if (CharacterTemplate.bIsTurret)
			continue;
		if (CharacterTemplate.DataName == 'Cyberus' && XCOMHQ.GetObjectiveStatus('T1_M2_S3_SKULLJACKCaptain') != eObjectiveState_Completed)
			continue;
		if (CharacterTemplate.DataName == 'AdvPsiWitchM3' && XCOMHQ.GetObjectiveStatus ('T1_M5_SKULLJACKCodex') != eObjectiveState_Completed)
			continue;

		TestWeight = GetCharacterSpawnWeight(SpawnList, CharacterTemplate, ForceLevel);
		// this is a valid character type, so store off data for later random selection
		if (TestWeight > 0.0)
		{
			PossibleChars.AddItem(CharacterTemplate.DataName);
			PossibleWeights.AddItem(TestWeight);
			TotalWeight += TestWeight;
		}
	}

	if (PossibleChars.length == 0)
	{
		return 'AdvCaptainM1';
	}

	RandomWeight = `SYNC_FRAND_STATIC() * TotalWeight;
	TestWeight = 0.0;
	for (k = 0; k < PossibleChars.length; k++)
	{
		TestWeight += PossibleWeights[k];
		if (RandomWeight < TestWeight)
		{
			return PossibleChars[k];
		}
	}
	return PossibleChars[PossibleChars.length - 1];
}

static function name SelectRandomPodFollower(PodSpawnInfo SpawnInfo, array<name> SupportedFollowers, int ForceLevel, out array<SpawnDistributionListEntry> SpawnList)
{
	local X2CharacterTemplateManager CharacterTemplateMgr;
	local X2DataTemplate Template;
	local X2CharacterTemplate CharacterTemplate;
	local SpawnDistributionListEntry SpawnEntry;
	local array<name> PossibleChars;
	local array<float> PossibleWeights;
	local float TotalWeight, TestWeight, RandomWeight;
	local int k;
	local XComGameState_HeadquartersXCom XCOMHQ;

	PossibleChars.Length = 0;
	//`LWTRACE ("Initiating SelectRandomPodFollower" @ ForceLevel @ AlienAllowed @ AdventAllowed @ TerrorAllowed);
	CharacterTemplateMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	foreach CharacterTemplateMgr.IterateTemplates(Template, None)
	{
		CharacterTemplate = X2CharacterTemplate(Template);
		if (CharacterTemplate == none)
			continue;
		if (!(CharacterTemplate.bIsAdvent || CharacterTemplate.bIsAlien))
			continue;
		if (CharacterTemplate.bIsTurret)
			continue;
		if (SupportedFollowers.Find(CharacterTemplate.DataName) == -1)
			continue;

		SpawnEntry = GetCharacterSpawnEntry(SpawnList, CharacterTemplate, ForceLevel);
		if (SpawnEntry.Template == '')
			continue;

		if (CountMembers(CharacterTemplate.DataName, SpawnInfo.SelectedCharacterTemplateNames) >= SpawnEntry.MaxCharactersPerGroup)
			continue;

		XCOMHQ = XComGameState_HeadquartersXCom(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));

		// don't let cyberuses in yet
		if (CharacterTemplate.DataName == 'Cyberus' && XCOMHQ.GetObjectiveStatus('T1_M2_S3_SKULLJACKCaptain') != eObjectiveState_Completed)
			continue;

		// don't let Avatars in yet
		if (CharacterTemplate.DataName == 'AdvPsiWitchM3' && XCOMHQ.GetObjectiveStatus ('T1_M5_SKULLJACKCodex') != eObjectiveState_Completed)
			continue;

		TestWeight = SpawnEntry.SpawnWeight;
		if (TestWeight > 0.0)
		{
			// this is a valid character type, so store off data for later random selection
			PossibleChars.AddItem (CharacterTemplate.DataName);
			PossibleWeights.AddItem (TestWeight);
			TotalWeight += TestWeight;
		}
	}
	if (PossibleChars.length == 0)
	{
		return 'AdvTrooperM1';
	}
	RandomWeight = `SYNC_FRAND_STATIC() * TotalWeight;
	TestWeight = 0.0;
	for (k = 0; k < PossibleChars.length; k++)
	{
		TestWeight += PossibleWeights[k];
		if (RandomWeight < TestWeight)
		{
			return PossibleChars[k];
		}
	}
	return PossibleChars[PossibleChars.length - 1];
}

static function PostReinforcementCreation(out name EncounterName, out PodSpawnInfo Encounter, int ForceLevel, int AlertLevel, optional XComGameState_BaseObject SourceObject, optional XComGameState_BaseObject ReinforcementState)
{
}

// Increase the size of Lost Brutes (unless WWL is installed)
static function UpdateAnimations(out array<AnimSet> CustomAnimSets, XComGameState_Unit UnitState, XComUnitPawn Pawn)
{
	if (Left(UnitState.GetMyTemplateName(), Len("TheLostBrute")) != "TheLostBrute")
		return;

	// No need to scale the Brute's pawn size if World War Lost is installed
	// because we'll be using its dedicated Brute model.
	if (class'Helpers_LW'.static.IsModInstalled("WorldWarLost"))
		return;

	Pawn.Mesh.SetScale(default.BRUTE_SIZE_MULTIPLIER);
}

// Use SLG hook to add infiltration modifiers to alien units
static function FinalizeUnitAbilitiesForInit(XComGameState_Unit UnitState, out array<AbilitySetupData> SetupData, optional XComGameState StartState, optional XComGameState_Player PlayerState, optional bool bMultiplayerDisplay)
{
	local X2AbilityTemplate AbilityTemplate;
	local X2AbilityTemplateManager AbilityTemplateMan;
	local name AbilityName;
	local AbilitySetupData Data, EmptyData;
	local X2CharacterTemplate CharTemplate;
	local int i;
	local XComGameState_MissionSite MissionState;
	local XComGameState_BattleData	BattleData;

	if (`XENGINE.IsMultiplayerGame()) { return; }

	CharTemplate = UnitState.GetMyTemplate();
	if (CharTemplate == none)
		return;

	AbilityTemplateMan = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	if(UnitState.GetTeam() == eTeam_Alien || UnitState.GetTeam() == eTeam_Neutral)
	{
		//MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(`XCOMHQ.MissionRef.ObjectID));
		BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
		MissionState = XComGameState_MissionSite(`XCOMHISTORY.GetGameStateForObjectID(BattleData.m_iMissionID));
	
		if(default.PASSIVE_MISSION_TYPES.Find(MissionState.GeneratedMission.Mission.sType) != INDEX_NONE)
		{
			AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate('PassiveMission_LW');

			Data = EmptyData;
			Data.TemplateName = 'PassiveMission_LW';
			Data.Template = AbilityTemplate;
			SetupData.AddItem(Data);
		}
		else if (default.DEFENSIVE_MISSION_TYPES.Find(MissionState.GeneratedMission.Mission.sType) != INDEX_NONE)
		{
			AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate('DefensiveMission_LW');

			Data = EmptyData;
			Data.TemplateName = 'DefensiveMission_LW';
			Data.Template = AbilityTemplate;
			SetupData.AddItem(Data);
		}
		else if (default.BALANCED_MISSION_TYPES.Find(MissionState.GeneratedMission.Mission.sType) != INDEX_NONE)
		{
			AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate('BalancedMission_LW');

			Data = EmptyData;
			Data.TemplateName = 'BalancedMission_LW';
			Data.Template = AbilityTemplate;
			SetupData.AddItem(Data);
		}
	}

	if (ShouldApplyInfiltrationModifierToCharacter(CharTemplate))
	{
		AbilityName = 'InfiltrationTacticalModifier_LW';
		if (SetupData.Find('TemplateName', AbilityName) == -1)
		{
			AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate(AbilityName);

			if(AbilityTemplate != none)
			{
				Data = EmptyData;
				Data.TemplateName = AbilityName;
				Data.Template = AbilityTemplate;
				SetupData.AddItem(Data);  // return array -- we don't have to worry about additional abilities for this simple ability
			}
			
		}
	}

	switch(CharTemplate.DataName)
	{
		case 'Rebel':
		case 'RebelSoldierProxy':
		case 'RebelSoldierProxyM2':
		case 'RebelSoldierProxyM3':

			if (class'UIUtilities_Strategy'.static.GetXComHQ().IsTechResearched('PoweredArmor'))
			{
				AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate('RebelHPUpgrade_T2');

				Data = EmptyData;
				Data.TemplateName = 'RebelHPUpgrade_T2';
				Data.Template = AbilityTemplate;
				SetupData.AddItem(Data);
			}
			else if (class'UIUtilities_Strategy'.static.GetXComHQ().IsTechResearched('PlatedArmor'))
			{
				AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate('RebelHPUpgrade_T1');
				Data = EmptyData;
				Data.TemplateName = 'RebelHPUpgrade_T1';
				Data.Template = AbilityTemplate;
				SetupData.AddItem(Data);
			}
			
			if (class'UIUtilities_Strategy'.static.GetXComHQ().IsTechResearched('AdvancedGrenades'))
			{
				AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate('RebelGrenadeUpgrade');
				Data = EmptyData;
				Data.TemplateName = 'RebelGrenadeUpgrade';
				Data.Template = AbilityTemplate;
				SetupData.AddItem(Data);
				}

		break;
		default:
		break;
	}

	// Fix enemy unit abilities that need to be tied to a weapon, since abilities
	// attached to character templates can't be configured for a particular weapon slot.
	for (i = 0; i < SetupData.Length; i++)
	{
		if (default.PrimaryWeaponAbilities.Find(SetupData[i].TemplateName) != INDEX_NONE && SetupData[i].SourceWeaponRef.ObjectID == 0)
		{
			`LWTrace(" >>> Binding ability '" $ SetupData[i].TemplateName $ "' to primary weapon for unit " $ UnitState.GetMyTemplateName());
			SetupData[i].SourceWeaponRef = UnitState.GetPrimaryWeapon().GetReference();
		}

		if (default.SecondaryWeaponAbilities.Find(SetupData[i].TemplateName) != INDEX_NONE && SetupData[i].SourceWeaponRef.ObjectID == 0)
		{
			`LWTrace(" >>> Binding ability '" $ SetupData[i].TemplateName $ "' to Secondary weapon for unit " $ UnitState.GetMyTemplateName());
			SetupData[i].SourceWeaponRef = UnitState.GetSecondaryWeapon().GetReference();
		}	
	}
	/*
	// Prevent units summoned by the Chosen from dropping loot and corpses
	if (StartState.GetContext().IsA(class'XComGameStateContext_Ability'.Name))
	{
		if (XComGameStateContext_Ability(StartState.GetContext()).InputContext.AbilityTemplateName == 'ChosenSummonFollowers')
		{
			AbilityName = 'FollowerDefeatedEscape';
			if (SetupData.Find('TemplateName', AbilityName) == -1)
			{
				AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate(AbilityName);

				if (AbilityTemplate != none)
				{
					Data = EmptyData;
					Data.TemplateName = AbilityName;
					Data.Template = AbilityTemplate;
					SetupData.AddItem(Data);  // return array -- we don't have to worry about additional abilities for this simple ability
				}
			}
				
			AbilityName = 'NoLootAndCorpse';
			if (SetupData.Find('TemplateName', AbilityName) == -1)
			{
				AbilityTemplate = AbilityTemplateMan.FindAbilityTemplate(AbilityName);

				if (AbilityTemplate != none)
				{
					Data = EmptyData;
					Data.TemplateName = AbilityName;
					Data.Template = AbilityTemplate;
					SetupData.AddItem(Data);  // return array -- we don't have to worry about additional abilities for this simple ability
				}
			}
		}
	}
	*/
}

static function bool ShouldApplyInfiltrationModifierToCharacter(X2CharacterTemplate CharTemplate)
{
	// Specific character types should never have an infiltration modifier applied.
	if (default.CharacterTypesExceptFromInfiltrationModifiers.Find(CharTemplate.DataName) >= 0)
	{
		return false;
	}

	// Otherwise anything that's alien or advent gets one
	return CharTemplate.bIsAdvent || CharTemplate.bIsAlien;
}

static event OnExitPostMissionSequence()
{
	CleanupObsoleteTacticalGamestate();
}

static function CleanupObsoleteTacticalGamestate()
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;
	local int idx, idx2;
	local XComGameState ArchiveState;
	local int LastArchiveStateIndex;
	local array<XComGameState_Item> InventoryItems;
	local XComGameState_Item Item;

	History = `XCOMHISTORY;
	//mark all transient tactical gamestates as removed
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Test remove all ability gamestates");
	// grab the archived strategy state from the history and the headquarters object
	LastArchiveStateIndex = History.FindStartStateIndex() - 1;
	ArchiveState = History.GetGameStateFromHistory(LastArchiveStateIndex, eReturnType_Copy, false);
	idx = 0;

	`LWTRACE("REMOVED " $ idx $ " tactical transient gamestates when loading into strategy");
	if (default.ShouldCleanupObsoleteUnits)
	{
		idx = 0;
		idx2 = 0;
		foreach ArchiveState.IterateByClassType(class'XComGameState_Unit', UnitState)
		{
			if (UnitTypeShouldBeCleanedUp(UnitState))
			{
				InventoryItems = UnitState.GetAllInventoryItems(ArchiveState);
				foreach InventoryItems (Item)
				{
					NewGameState.RemoveStateObject (Item.ObjectID);
					idx2++;
				}
				NewGameState.RemoveStateObject (UnitState.ObjectID);
				idx++;
			}
		}
	}
	`LWTRACE("REMOVED " $ idx $ " obsolete enemy unit gamestates when loading into strategy");
	`LWTRACE("REMOVED " $ idx2 $ " obsolete enemy item gamestates when loading into strategy");

	History.AddGameStateToHistory(NewGameState);
}

static function bool UnitTypeShouldBeCleanedUp(XComGameState_Unit UnitState)
{
	local X2CharacterTemplate CharTemplate;
	local name CharTemplateName;
	local int ExcludeIdx;

	CharTemplate = UnitState.GetMyTemplate();
	if (CharTemplate == none) { return false; }
	CharTemplateName = UnitState.GetMyTemplateName();
	if (CharTemplateName == '') { return false; }
	if (class'LWDLCHelpers'.static.IsAlienRuler(CharTemplateName)) { return false; }
	if (!CharTemplate.bIsSoldier)
	{
		if (CharTemplate.bIsAlien || CharTemplate.bIsAdvent || CharTemplate.bIsCivilian)
		{
			ExcludeIdx = default.CharacterTypesExemptFromCleanup.Find(CharTemplateName);
			if (ExcludeIdx == -1)
			{
				return true;
			}
		}
	}
	return false;
}

static function AddObjectivesToParcels()
{
	local XComParcelManager ParcelMgr;
	local PlotDefinition PlotDef;
	local int i, j, k;

	// Go over the plot list and add new objectives to certain plots.
	ParcelMgr = `PARCELMGR;
	if (ParcelMgr != none)
	{
		`LWTrace("Modding plot objectives");
		for (i = 0; i < default.PlotObjectiveMods.Length; ++i)
		{
			for (j = 0; j < ParcelMgr.arrPlots.Length; ++j)
			{
				if (ParcelMgr.arrPlots[j].MapName == default.PlotObjectiveMods[i].MapName)
				{
					for (k = 0; k < default.PlotObjectiveMods[i].ObjectiveTags.Length; ++k)
					{
						`LWTrace("Adding objective " $ default.PlotObjectiveMods[i].ObjectiveTags[k] $ " to plot " $ ParcelMgr.arrPlots[j].MapName);
						ParcelMgr.arrPlots[j].ObjectiveTags.AddItem(default.PlotObjectiveMods[i].ObjectiveTags[k]);
					}
					break;
				}
			}
		}

		// Remove a mod-specified set of parcels (e.g. to replace them with modded versions).
		for (i = 0; i < default.ParcelsToRemove.Length; ++i)
		{
			j = ParcelMgr.arrAllParcelDefinitions.Find('MapName', default.ParcelsToRemove[i]);
			if (j >= 0)
			{
				`LWTrace("Removing parcel definition " $ default.ParcelsToRemove[i]);
				ParcelMgr.arrAllParcelDefinitions.Remove(j, 1);
			}
		}
		
		// LWOTC: Add size-based objective tags using the plot name to infer the
		// appropriate tag ('LargePlot' or 'MediumPlot')
		//
		// Note that foreach uses pass-by-value, so we can't modify the objective
		// tags that way.
		for (i = 0; i < ParcelMgr.arrPlots.Length; ++i)
		{
			PlotDef = ParcelMgr.arrPlots[i];
			if ((InStr(PlotDef.MapName, "_LgObj_") != INDEX_NONE || InStr(PlotDef.MapName, "_vlgObj_") != INDEX_NONE)
					&& PlotDef.ObjectiveTags.Find("LargePlot") == INDEX_NONE)
			{
				`LWTrace("Adding 'LargePlot' objective tag to " $ PlotDef.MapName);
				ParcelMgr.arrPlots[i].ObjectiveTags.AddItem("LargePlot");
			}
			else if (InStr(PlotDef.MapName, "_MdObj_") != INDEX_NONE && PlotDef.ObjectiveTags.Find("MediumPlot") == INDEX_NONE)
			{
				`LWTrace("Adding 'MediumPlot' objective tag to " $ PlotDef.MapName);
				ParcelMgr.arrPlots[i].ObjectiveTags.AddItem("MediumPlot");
			}

			// Quick hack to enable Rendezvous maps for Ambush mission
			if (ParcelMgr.arrPlots[i].ObjectiveTags.Length > 0 && ParcelMgr.arrPlots[i].ObjectiveTags[0] == "AvengerDefense")
			{
				ParcelMgr.arrPlots[i].ObjectiveTags.AddItem("CovertEscape");
			}

			// Exclude Sewer maps so that Tunnels don't dominate the map pool quite so hard.
			if (PlotDef.strType == "Tunnels_Sewer")
			{
				ParcelMgr.arrPlots[i].ExcludeFromStrategy = true;
			}
		}

		i = 0;
	}
}


static function OverrideDestructibleHealths(XComGameState StartGameState)
{
	local XComContentManager ContentMgr;
	local ArchetypeToHealth DestructibleActorConfig;
	local XComDestructibleActor_Toughness Toughness;
	local int CurrentDifficulty;

	ContentMgr = `CONTENT;
	CurrentDifficulty = `TacticalDifficultySetting;
	foreach default.DestructibleActorHealthOverride(DestructibleActorConfig)
	{
		Toughness = XComDestructibleActor_Toughness(ContentMgr.RequestGameArchetype(DestructibleActorConfig.ArchetypeName));
		if (Toughness != none && (DestructibleActorConfig.Difficulty == CurrentDifficulty || DestructibleActorConfig.Difficulty == -1))
		{
			`LWTrace("Updating" @ DestructibleActorConfig.ArchetypeName @ "max health to" @ DestructibleActorConfig.Health);
			Toughness.Health = DestructibleActorConfig.Health;
		}
	}
}

// The base Alien Rulers DLC will do its own thing with regard to spawning
// Rulers on missions, so we potentially need to override the current Ruler
// and mission state to fit with our use of sit reps for the Rulers.
//
// *WARNING* This function should not be called unless the Alien Rulers DLC
// has first been confirmed to be installed.
static function OverrideAlienRulerSpawning(XComGameState StartState, XComGameState_MissionSite MissionState)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_AlienRulerManager RulerMgr;
	local XComGameState_Unit RulerState;
	local StateObjectReference EmptyRef;
	local bool RulerOnMission;

	History = `XCOMHISTORY;

	RulerMgr = XComGameState_AlienRulerManager(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_AlienRulerManager'));
	if (!RulerMgr.bContentActivated) return;

	// Leave the Alien Nest mission alone
	if (MissionState.Source == 'MissionSource_AlienNest')
		return;

	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(StartState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	RulerMgr = XComGameState_AlienRulerManager(StartState.ModifyStateObject(class'XComGameState_AlienRulerManager', RulerMgr.ObjectID));

	// Check whether the DLC has placed a Ruler on this mission
	RulerOnMission = RulerMgr.RulerOnCurrentMission.ObjectID != 0;
	if (RulerOnMission)
	{
		RulerMgr.ClearActiveRulerTags(XComHQ);
		RulerMgr.RulerOnCurrentMission = EmptyRef;
	}

	if (class'LWDLCHelpers'.static.IsAlienRulerOnMission(MissionState))
	{
		RulerState = class'LWDLCHelpers'.static.GetAlienRulerForMission(MissionState);
		class'LWDLCHelpers'.static.PutRulerOnCurrentMission(StartState, RulerState, XComHQ);
	}
}

// (Based on code from XCGS_HeadquartersAlien.AddChosenTacticalTagsToMission())
//
// Add the Chosen tactical tags to the mission if the LWOTC versions of those
// tags are in the mission's tactical tags. The actual decision about whether
// to add a Chosen to the mission is made by XCGS_LWAlienActivityManager.
// ModifyAlertByMaybeAddingChosenToMission().
//
// The main purpose of this function is to ensure that any attempts by vanilla
// to add Chosen to the mission are blocked and Chosen are added to the HQ
// tactical tags if the alien activity manager has set them up.
// static function MaybeAddChosenToMission(XComGameState StartState, XComGameState_MissionSite MissionState)
// {
// 	local XComGameStateHistory History;
// 	local XComGameState_HeadquartersXCom XComHQ;
// 	local XComGameState_HeadquartersAlien AlienHQ;
// 	local array<XComGameState_AdventChosen> AllChosen;
// 	local XComGameState_AdventChosen ChosenState;
// 	local name ChosenSpawningTag, ChosenSpawningTagLWOTC, ChosenSpawningTagRemove;
// 	local bool HasRulerOnMission;
// 	local array <name> SpawningTags;

// 	// Certain missions should just use vanilla Chosen behaviour, like the Chosen
// 	// Avenger Defense
// 	if (default.SKIP_CHOSEN_OVERRIDE_MISSION_TYPES.Find(MissionState.GeneratedMission.Mission.sType) != INDEX_NONE)
// 	{
// 		return;
// 	}

// 	// Don't allow Chosen on the mission if there is already a Ruler
// 	if (class'XComGameState_AlienRulerManager' != none && class'LWDLCHelpers'.static.IsAlienRulerOnMission(MissionState))
// 	{
// 		HasRulerOnMission = true;
// 	}

// 	History = `XCOMHISTORY;
// 	foreach History.IterateByClassType(class'XComGameState_HeadquartersAlien', AlienHQ)
// 	{
// 		break;
// 	}

// 	if (AlienHQ.bChosenActive)
// 	{
// 		XComHQ = `XCOMHQ;
// 		AllChosen = AlienHQ.GetAllChosen(, true);

// 		foreach AllChosen(ChosenState)
// 		{
// 			ChosenSpawningTag = ChosenState.GetMyTemplate().GetSpawningTag(ChosenState.Level);
// 			ChosenSpawningTagLWOTC = class'Helpers_LW'.static.GetChosenActiveMissionTag(ChosenState);

// 			// Remove All vanilla chosen tags if they are attached to this mission. This is the only
// 			// place that should add Chosen tactical mission tags to the XCOM HQ. This
// 			// basically prevents the base game and other mods from adding Chosen to missions.
// 			SpawningTags = ChosenState.GetMyTemplate().ChosenProgressionData.SpawningTags;
// 			foreach SpawningTags(ChosenSpawningTagRemove)
// 			{
// 				XComHQ.TacticalGameplayTags.RemoveItem(ChosenSpawningTagRemove);
// 			}

// 			// Now add the appropriate tactical gameplay tag for this Chosen if the
// 			// corresponding LWOTC-specific one is in the mission's tactical tags.
// 			if (!HasRulerOnMission && !ChosenState.bDefeated &&
// 				MissionState.TacticalGameplayTags.Find(ChosenSpawningTagLWOTC) != INDEX_NONE)
// 			{
// 				XComHQ.TacticalGameplayTags.AddItem(ChosenSpawningTag);
// 			}
// 		}
// 	}

// 	foreach History.IterateByClassType(class'XComGameState_AdventChosen', ChosenState)
// 	{
// 		if (ChosenState.bDefeated)
// 		{
// 			ChosenState.PurgeMissionOfTags(MissionState);
// 		}
// 	}
// }


// WOTC TODO: Perhaps this is supposed to honour the SpawnSizeOverride parameter somehow. Seems to work
// though (a 10-man squad on first mission spawned OK)
//enlarge the deployable area so can spawn more units
static function bool GetValidFloorSpawnLocations(out array<Vector> FloorPoints, float SpawnSizeOverride, XComGroupSpawn SpawnPoint)
{
	local TTile RootTile, Tile;
	local array<TTile> FloorTiles;
	local XComWorldData World;
	local int Length, Width, Height, NumSoldiers, Iters;
	local bool Toggle;

	Length = 3;
	Width = 3;
	Height = 1;
	Toggle = false;
	if(`XCOMHQ != none)
		NumSoldiers = `XCOMHQ.Squad.Length;
	else
		NumSoldiers = class'X2StrategyGameRulesetDataStructures'.static.GetMaxSoldiersAllowedOnMission();

	// For TQL, etc, where the soldier are coming from the Start State, always reserve space for 8 soldiers
	if (NumSoldiers == 0)
		NumSoldiers = 8;


	if (NumSoldiers >= 6)
	{
		Length = 4;
		Iters--;
	}
	if (NumSoldiers >= 9)
	{
		Width = 4;
		Iters--;
	}
	if (NumSoldiers >= 12)
	{
		Length = 5;
		Width = 5;
	}
	World = `XWORLD;
	RootTile = SpawnPoint.GetTile();
	while(FloorPoints.Length < NumSoldiers && Iters++ < 8)
	{
		FloorPoints.Length = 0;
		FloorTiles.Length = 0;
		RootTile.X -= Length/2;
		RootTile.Y -= Width/2;

		World.GetSpawnTilePossibilities(RootTile, Length, Width, Height, FloorTiles);

		foreach FloorTiles(Tile)
		{
			// Skip any tile that is going to be destroyed on tactical start.
			if (IsTilePositionDestroyed(Tile))
				continue;
			FloorPoints.AddItem(World.GetPositionFromTileCoordinates(Tile));
		}
		if(Toggle)
			Width ++;
		else
			Length ++;

		Toggle = !Toggle;
	}

	`LWTRACE("GetValidFloorSpawnLocations called from : " $ GetScriptTrace());
	`LWTRACE("Found " $ FloorPoints.Length $ " Valid Tiles to place units around location : " $ string(SpawnPoint.Location));
	for (Iters = 0; Iters < FloorPoints.Length; Iters++)
	{
		`LWTRACE("Point[" $ Iters $ "] = " $ string(FloorPoints[Iters]));
	}

	return true;
}

// The XComTileDestructionActor contains a list of positions that it will destroy before the mission starts.
// These will report as valid floor tiles at the point we are searching for valid spawn tiles (because they
// are, now) but after the mission starts their tile will disappear and they will be unable to move.
//
// Given a potential spawn floor tile, check to see if this tile will be destroyed on mission start, so we
// can exclude them as candidates.
static function bool IsTilePositionDestroyed(TTile Tile)
{
	local XComTileDestructionActor TileDestructionActor;
	local Vector V;
	local IntPoint ParcelBoundsMin, ParcelBoundsMax;
	local XComGameState_BattleData BattleData;
	local XComParcelManager ParcelManager;
	local XComWorldData World;
	local XComParcel Parcel;
	local int i;
	local TTile DestroyedTile;

	BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	ParcelManager = `PARCELMGR;
	World = `XWORLD;

	// Find the parcel containing this tile.
	for (i = 0; i < BattleData.MapData.ParcelData.Length; ++i)
	{
		Parcel = ParcelManager.arrParcels[BattleData.MapData.ParcelData[i].ParcelArrayIndex];

		// Find the parcel this tile is in.
		Parcel.GetTileBounds(ParcelBoundsMin, ParcelBoundsMax);
		if (Tile.X >= ParcelBoundsMin.X && Tile.X <= ParcelBoundsMax.X &&
			Tile.Y >= ParcelBoundsMin.Y && Tile.Y <= ParcelBoundsMax.Y)
		{
			break;
		}
	}

	foreach `BATTLE.AllActors(class'XComTileDestructionActor', TileDestructionActor)
	{
		foreach TileDestructionActor.PositionsToDestroy(V)
		{
			// The vectors within the XComTileDestructionActor are relative to the origin
			// of the associated parcel itself. So each destroyed position needs to be rotated
			// and translated based on the location of the destruction actor before we look up
			// the tile position to account for the particular map layout.
			V = V >> TileDestructionActor.Rotation;
			V += TileDestructionActor.Location;
			DestroyedTile = World.GetTileCoordinatesFromPosition(V);
			if (DestroyedTile == Tile)
			{
				return true;
			}
		}
	}

	return false;
}

// Clean up any stale delayed evac spawners that may be left over from a previous mission that ended while
// a counter was active.
static function ResetDelayedEvac(XComGameState StartGameState)
{
	local XComGameState_LWEvacSpawner EvacState;

	EvacState = XComGameState_LWEvacSpawner(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LWEvacSpawner', true));

	if (EvacState != none && EvacState.GetCountdown() >= 0)
	{
		EvacState = XComGameState_LWEvacSpawner(StartGameState.CreateStateObject(class'XComGameState_LWEvacSpawner', EvacState.ObjectID));
		EvacState.ResetCountdown();
		StartGameState.AddStateObject(EvacState);
	}
}

// Reset the reinforcements system for the new mission.
static function ResetReinforcements(XComGameState StartGameState)
{
	local XComGameState_LWReinforcements Reinforcements;

	Reinforcements = XComGameState_LWReinforcements(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LWReinforcements', true));

	if (Reinforcements == none)
	{
		Reinforcements = XComGameState_LWReinforcements(StartGameState.CreateStateObject(class'XComGameState_LWReinforcements'));
	}
	else
	{
		Reinforcements = XComGameState_LWReinforcements(StartGameState.CreateStateObject(class'XComGameState_LWReinforcements', Reinforcements.ObjectID));
	}

	Reinforcements.Reset();
	StartGameState.AddStateObject(Reinforcements);
}


static function SetUpGateCrasherCrew(XComGameState StartState)
{
	local XComGameState_HeadquartersXCom XComHQ;
	local StateObjectReference FactionSoldierRef;
	local name SelectedClass;
	local int Index;
	local XComGameState_Unit NewSoldierState;
	local XComOnlineProfileSettings ProfileSettings;
	local XGCharacterGenerator CharacterGenerator;
	local XComGameState_GameTime GameTime;


	ProfileSettings = `XPROFILESETTINGS;

	foreach StartState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}
		foreach StartState.IterateByClassType(class'XComGameState_GameTime', GameTime)
	{
		break;
	}

	FactionSoldierRef = XComHQ.Squad[3];
	//Reset The Squad count
	XComHQ.Squad.Length = 0;
	//Now Add 6 squaddies to crew
	XComHQ.Squad.AddItem(FactionSoldierRef);

	for( Index = 0; Index < 6; ++Index)
	{

		NewSoldierState = `CHARACTERPOOLMGR.CreateCharacter(StartState, ProfileSettings.Data.m_eCharPoolUsage);
		CharacterGenerator = `XCOMGRI.Spawn(NewSoldierState.GetMyTemplate().CharacterGeneratorClass);
		`assert(CharacterGenerator != none);

		
		NewSoldierState.RandomizeStats();
		NewSoldierState.ApplyInventoryLoadout(StartState);

		NewSoldierState.SetXPForRank(1);
		NewSoldierState.StartingRank = 1;

		SelectedClass = XComHQ.SelectNextSoldierClass();
		
		NewSoldierState.RankUpSoldier(StartState, SelectedClass);
		NewSoldierState.ApplySquaddieLoadout(StartState);

	
		NewSoldierState.bIsFamous = true;

		NewSoldierState.SetHQLocation(eSoldierLoc_Barracks);

		XComHQ.AddToCrew(StartState, NewSoldierState);
		NewSoldierState.m_RecruitDate = GameTime.CurrentTime; // AddToCrew does this, but during start state creation the StrategyRuleset hasn't been created yet

		XComHQ.Squad.AddItem(NewSoldierState.GetReference());

	}

}

// static function UpdateFirstMissionTemplate()
// {
// 	local X2StrategyElementTemplateManager TemplateMgr;
// 	local X2ObjectiveTemplate Template;

// 	TemplateMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
// 	Template = X2ObjectiveTemplate(TemplateMgr.FindStrategyElementTemplate('T1_M0_FirstMission'));
// 	if(Template == none)
// 		return;

// 	//Template.AddNarrativeTrigger("X2NarrativeMoments.Strategy.GP_WelcomeToTheLabsShort", NAW_OnCompletion, 'OnEnteredFacility_CommandersQuarters', '', ELD_OnStateSubmitted, NPC_Once, '');
// 	Template.AddNarrativeTrigger("LWNarrativeMoments_Bink.TACTICAL.CIN_WelcomeToTheResistance_LW", NAW_OnCompletion, 'OnEnteredFacility_CommandersQuarters', '', ELD_OnStateSubmitted, NPC_Once, '');
// 	Template.CompleteObjectiveFn = FirstMissionComplete;
// }

// // add TriggerNeedsAttention to Commander's quarters for the new WelcomeToResistance
// static function FirstMissionComplete(XComGameState NewGameState, XComGameState_Objective ObjectiveState)
// {
// 	local XComGameStateHistory History;
// 	local XComGameState_HeadquartersXCom XComHQ;
// 	local XComGameState_FacilityXCom CommandersQuarters;
// 	local int idx;

// 	class'X2StrategyElement_DefaultObjectives'.static.FirstMissionComplete(NewGameState, ObjectiveState);

// 	History = `XCOMHISTORY;
// 	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

// 	for( idx = 0; idx < XComHQ.Facilities.Length; idx++ )
// 	{
// 		CommandersQuarters = XComGameState_FacilityXCom(History.GetGameStateForObjectID(XComHQ.Facilities[idx].ObjectID));

// 		if( CommandersQuarters.GetMyTemplateName() == 'CommandersQuarters' )
// 		{
// 			CommandersQuarters = XComGameState_FacilityXCom(NewGameState.CreateStateObject(class'XComGameState_FacilityXCom', CommandersQuarters.ObjectID));
// 			NewGameState.AddStateObject(CommandersQuarters);
// 			CommandersQuarters.TriggerNeedsAttention();
// 		}
// 	}
// 	`HQPRES.m_kFacilityGrid.UpdateData();
// }

static function DisableUnwantedObjectives(XComGameState StartState)
{
	local XComGameState_Objective ObjectiveState;

	foreach StartState.IterateByClassType(class'XComGameState_Objective', ObjectiveState)
	{
		switch (ObjectiveState.GetMyTemplateName())
		{
		case 'XP2_M0_FirstCovertActionTutorial':
		case 'XP2_M1_SecondCovertActionTutorial':
			ObjectiveState.CompleteObjective(StartState);
			break;
		default:
			break;
		}
	}
}

// ******** HANDLE CUSTOM WEAPON RESTRICTIONS ******** //

// Disable heavy weapons items based on soldier class and also
// control who can have pistols.
static function bool CanAddItemToInventory_CH_Improved(
	out int bCanAddItem,
	const EInventorySlot Slot,
	const X2ItemTemplate ItemTemplate,
	int Quantity,
	XComGameState_Unit UnitState,
	optional XComGameState CheckGameState,
	optional out string DisabledReason,
	optional XComGameState_Item ItemState)
{
	local X2SoldierClassTemplate SoldierClassTemplate;
	local X2WeaponTemplate WeaponTemplate;
	local int i;

	SoldierClassTemplate = UnitState.GetSoldierClassTemplate();

	// Handle the pistol slot first
	WeaponTemplate = X2WeaponTemplate(ItemTemplate);
	if (WeaponTemplate == none)
	{
		// We want this hook to be ignored from both the armory
		// screen and the unit's CanAddItemToInventory() method,
		// but they expect different return values to indicate
		// that. CheckGameState is the only way to distinguish
		// between them.
		return CheckGameState == none;
	}

	if (Slot == eInvSlot_Pistol && !class'CHItemSlot_PistolSlot_LW'.default.DISABLE_LW_PISTOL_SLOT &&
			class'CHItemSlot_PistolSlot_LW'.static.IsWeaponAllowedInPistolSlot(WeaponTemplate) && DisabledReason != class'X2DownloadableContentInfo_LW_WeaponsAndArmor'.default.CannotEquipCanisterLabel)
	{
		// Allow the weapon to be equipped.
		DisabledReason = "";
		bCanAddItem = 1;
		
		// Override normal behavior.
		return CheckGameState != none;
	}

	// Ignore all slots other than HeavyWeapons and any units that don't have
	// a soldier class template (like ADVENT Rocketeers!)
	if (Slot != eInvSlot_HeavyWeapon || SoldierClassTemplate == none)
	{
		// We want this hook to be ignored from both the armory
		// screen and the unit's CanAddItemToInventory() method,
		// but they expect different return values to indicate
		// that. CheckGameState is the only way to distinguish
		// between them.
		return CheckGameState == none;
	}

	for (i = 0; i < SoldierClassTemplate.AllowedWeapons.Length; ++i)
	{
		if (WeaponTemplate.WeaponCat == SoldierClassTemplate.AllowedWeapons[i].WeaponType)
		{
			// We think the item can be added, but we should leave it to
			// the default base game logic to make the final determination.
			// Otherwise we would have to handle the case where a weapon is
			// already in the slot. We would also have to consider that the
			// highlander supports multiple heavy weapons on a soldier.
			return CheckGameState == none;
		}
	}
	
	// The soldier class isn't allowed to use this weapon
	DisabledReason = class'UIUtilities_Text'.static.CapsCheckForGermanScharfesS(
		`XEXPAND.ExpandString(class'UIArmory_Loadout'.default.m_strUnavailableToClass));
	bCanAddItem = 0;
	return CheckGameState != none;  // false if called from armory, true if called from XCGS_Unit
}

// ******** HANDLE SECONDARY WEAPON VISUALS ******** //

// append sockets to the human skeletal meshes for the new secondary weapons
static function string DLCAppendSockets(XComUnitPawn Pawn)
{
	local SocketReplacementInfo SocketReplacement;
	local name TorsoName;
	local bool bIsFemale;
	local string DefaultString, ReturnString;
	local XComHumanPawn HumanPawn;

	HumanPawn = XComHumanPawn(Pawn);
	if (HumanPawn == none) { return ""; }

	TorsoName = HumanPawn.m_kAppearance.nmTorso;
	bIsFemale = HumanPawn.m_kAppearance.iGender == eGender_Female;

	//`LWTRACE("DLCAppendSockets: Torso= " $ TorsoName $ ", Female= " $ string(bIsFemale));

	foreach default.SocketReplacements(SocketReplacement)
	{
		if (TorsoName != 'None' && TorsoName == SocketReplacement.TorsoName && bIsFemale == SocketReplacement.Female)
		{
			ReturnString = SocketReplacement.SocketMeshString;
			break;
		}
		else
		{
			if (SocketReplacement.TorsoName == 'Default' && SocketReplacement.Female == bIsFemale)
			{
				DefaultString = SocketReplacement.SocketMeshString;
			}
		}
	}
	if (ReturnString == "")
	{
		// did not find, so use default
		ReturnString = DefaultString;
	}
	//`LWTRACE("Returning mesh string: " $ ReturnString);
	return ReturnString;
}

// ******** HANDLE UPDATING WEAPON ATTACHMENTS ************* //

// WOTC TODO: Called from highlander - check whether CHL does it
// always allow removal of weapon upgrades
static function bool CanRemoveWeaponUpgrade(XComGameState_Item Weapon, X2WeaponUpgradeTemplate UpgradeTemplate, int SlotIndex)
{
	if (UpgradeTemplate == none)
		return false;
	else
		return true;
}

// This provides the artwork/assets for weapon attachments for SMGs
static function UpdateWeaponAttachmentsForCoilgun()
{
	local X2ItemTemplateManager ItemTemplateManager;

	//get access to item template manager to update existing upgrades
	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	if (ItemTemplateManager == none) {
		`Redscreen("LW Coilguns : failed to retrieve ItemTemplateManager to configure upgrades");
		return;
	}

	AddCritUpgrade(ItemTemplateManager, 'CritUpgrade_Bsc');
	AddCritUpgrade(ItemTemplateManager, 'CritUpgrade_Adv');
	AddCritUpgrade(ItemTemplateManager, 'CritUpgrade_Sup');

	AddAimBonusUpgrade(ItemTemplateManager, 'AimUpgrade_Bsc');
	AddAimBonusUpgrade(ItemTemplateManager, 'AimUpgrade_Adv');
	AddAimBonusUpgrade(ItemTemplateManager, 'AimUpgrade_Sup');

	AddClipSizeBonusUpgrade(ItemTemplateManager, 'ClipSizeUpgrade_Bsc');
	AddClipSizeBonusUpgrade(ItemTemplateManager, 'ClipSizeUpgrade_Adv');
	AddClipSizeBonusUpgrade(ItemTemplateManager, 'ClipSizeUpgrade_Sup');

	AddFreeFireBonusUpgrade(ItemTemplateManager, 'FreeFireUpgrade_Bsc');
	AddFreeFireBonusUpgrade(ItemTemplateManager, 'FreeFireUpgrade_Adv');
	AddFreeFireBonusUpgrade(ItemTemplateManager, 'FreeFireUpgrade_Sup');

	AddReloadUpgrade(ItemTemplateManager, 'ReloadUpgrade_Bsc');
	AddReloadUpgrade(ItemTemplateManager, 'ReloadUpgrade_Adv');
	AddReloadUpgrade(ItemTemplateManager, 'ReloadUpgrade_Sup');

	AddMissDamageUpgrade(ItemTemplateManager, 'MissDamageUpgrade_Bsc');
	AddMissDamageUpgrade(ItemTemplateManager, 'MissDamageUpgrade_Adv');
	AddMissDamageUpgrade(ItemTemplateManager, 'MissDamageUpgrade_Sup');

	AddFreeKillUpgrade(ItemTemplateManager, 'FreeKillUpgrade_Bsc');
	AddFreeKillUpgrade(ItemTemplateManager, 'FreeKillUpgrade_Adv');
	AddFreeKillUpgrade(ItemTemplateManager, 'FreeKillUpgrade_Sup');
}


static function AddCritUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));
	if(Template == none)
	{
		`Redscreen("LW Coilguns : Failed to find upgrade template " $ string(TemplateName));
		return;
	}
	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	// Assault Rifle
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticB", "", 'AssaultRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_OpticB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

	//SMG
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticB", "", 'SMG_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_OpticB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

	// Shotgun
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "BeamShotgun.Meshes.SM_BeamShotgun_OpticB", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_OpticB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

	// Sniper Rifle
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "BeamSniper.Meshes.SM_BeamSniper_OpticB", "", 'SniperRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_OpticB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilSniperRifle_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

	// Cannon
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Cannon_Optic', "LWCannon_CG.Meshes.LW_CoilCannon_OpticB", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_OpticB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_OpticB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

}

static function AddAimBonusUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));
	if(Template == none)
	{
		`Redscreen("LW Coilguns : Failed to find upgrade template " $ string(TemplateName));
		return;
	}
	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	// Assault Rifle
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticC", "", 'AssaultRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_OpticC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

	//SMG
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Optic', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_OpticC", "", 'SMG_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_OpticC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

	// Shotgun
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun_Optic', "BeamShotgun.Meshes.SM_BeamShotgun_OpticC", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_OpticC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

	// Sniper Rifle
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Sniper_Optic', "BeamSniper.Meshes.SM_BeamSniper_OpticC", "", 'SniperRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_OpticC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilSniperRifle_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

	// Cannon
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Cannon_Optic', "LWCannon_CG.Meshes.LW_CoilCannon_OpticC", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_OpticC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_OpticC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_scope");

}

static function AddClipSizeBonusUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));
	if(Template == none)
	{
		`Redscreen("LW Coilguns : Failed to find upgrade template " $ string(TemplateName));
		return;
	}
	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	// Assault Rifle
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_MagB", "", 'AssaultRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_MagB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMG_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);

	//SMG
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_MagB", "", 'SMG_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_MagB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMG_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);

	// Shotgun
	//Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "LWShotgun_CG.Meshes.LW_CoilShotgun_MagB", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_MagB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilShotgun_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "LWShotgun_CG.Meshes.LW_CoilShotgun_MagB", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_MagB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilShotgun_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);

	// Sniper Rifle
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "LWSniperRifle_CG.Meshes.LW_CoilSniper_MagB", "", 'SniperRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_MagB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilSniperRifle_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);

	// Cannon
	//Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "LWCannon_CG.Meshes.LW_CoilCannon_MagB", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_MagB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "LWCannon_CG.Meshes.LW_CoilCannon_MagB", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_MagB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_MagB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent);

}

static function AddFreeFireBonusUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));
	if(Template == none)
	{
		`Redscreen("LW Coilguns : Failed to find upgrade template " $ string(TemplateName));
		return;
	}
	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	// Assault Rifle
	Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "LWAccessories_CG.Meshes.LW_Coil_ReargripB", "", 'AssaultRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_ReargripB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgunSniper_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");

	//SMG
	Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "LWAccessories_CG.Meshes.LW_Coil_ReargripB", "", 'SMG_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_ReargripB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgunSniper_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");

	// Shotgun
	Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Shotgun_Stock', "LWAccessories_CG.Meshes.LW_Coil_ReargripB", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_ReargripB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgunSniper_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");

	// Sniper
	Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "LWAccessories_CG.Meshes.LW_Coil_ReargripB", "", 'SniperRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_ReargripB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgunSniper_TriggerB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");

	// Cannon
	Template.AddUpgradeAttachment('Reargrip', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "LWCannon_CG.Meshes.LW_CoilCannon_ReargripB", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_ReargripB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_ReargripB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_trigger");

}

static function AddReloadUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));
	if(Template == none)
	{
		`Redscreen("LW Coilguns : Failed to find upgrade template " $ string(TemplateName));
		return;
	}
	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	// Assault Rifle
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_MagC", "", 'AssaultRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_MagC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMG_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_MagD", "", 'AssaultRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_MagD", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMG_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);

	//SMG
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_MagC", "", 'SMG_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_MagC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMG_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Mag', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_MagD", "", 'SMG_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_MagD", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMG_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);

	// Shotgun
	//Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "LWShotgun_CG.Meshes.LW_CoilShotgun_MagC", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_MagC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilShotgun_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "LWShotgun_CG.Meshes.LW_CoilShotgun_MagC", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_MagC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilShotgun_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Shotgun_Mag', "LWShotgun_CG.Meshes.LW_CoilShotgun_MagD", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_MagD", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilShotgun_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);

	// Sniper
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "LWSniperRifle_CG.Meshes.LW_CoilSniper_MagC", "", 'SniperRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_MagC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilSniperRifle_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Sniper_Mag', "LWSniperRifle_CG.Meshes.LW_CoilSniper_MagD", "", 'SniperRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_MagD", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilSniperRifle_MagD", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);

	// Cannon
	//Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "LWCannon_CG.Meshes.LW_CoilCannon_MagC", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_MagC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip");
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "LWCannon_CG.Meshes.LW_CoilCannon_MagC", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_MagC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent);
	Template.AddUpgradeAttachment('Mag', 'UIPawnLocation_WeaponUpgrade_Cannon_Mag', "LWCannon_CG.Meshes.LW_CoilCannon_MagD", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_MagD", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_MagC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_clip", class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent);

}

static function AddMissDamageUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));
	if(Template == none)
	{
		`Redscreen("LW Coilguns : Failed to find upgrade template " $ string(TemplateName));
		return;
	}
	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	// Assault Rifle
	Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "LWAccessories_CG.Meshes.LW_Coil_StockB", "", 'AssaultRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_StockB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");

	//SMG
	Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Stock', "LWAccessories_CG.Meshes.LW_Coil_StockB", "", 'SMG_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_StockB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");

	// Shotgun
	Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_Shotgun_Stock', "LWAccessories_CG.Meshes.LW_Coil_StockB", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_StockB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMGShotgun_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");

	// Sniper Rifle
	Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_Sniper_Stock', "LWAccessories_CG.Meshes.LW_Coil_StockC", "", 'SniperRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_StockC", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilSniperRifle_StockC", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");

	// Cannon
	Template.AddUpgradeAttachment('Stock', 'UIPawnLocation_WeaponUpgrade_Cannon_Stock', "LWCannon_CG.Meshes.LW_CoilCannon_StockB", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_StockB", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_StockB", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_stock");
	Template.AddUpgradeAttachment('StockSupport', '', "LWCannon_CG.Meshes.LW_CoilCannon_StockSupportB", "", 'Cannon_CG');

}

static function AddFreeKillUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));
	if(Template == none)
	{
		`Redscreen("LW Coilguns : Failed to find upgrade template " $ string(TemplateName));
		return;
	}
	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	// Assault Rifle
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_Silencer", "", 'AssaultRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_Suppressor", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMG_Suppressor", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");

	//SMG
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_AssaultRifle_Suppressor', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_Silencer", "", 'SMG_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_Suppressor", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilRifleSMG_Suppressor", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");

	// Shotgun
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Shotgun_Suppressor', "LWShotgun_CG.Meshes.LW_CoilShotgun_Suppressor", "", 'Shotgun_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_Suppressor", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilShotgun_Suppressor", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");

	// Sniper Rifle
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Sniper_Suppressor', "LWSniperRifle_CG.Meshes.LW_CoilSniper_Suppressor", "", 'SniperRifle_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_Suppressor", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilSniperRifle_Suppressor", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");

	// Cannon
	Template.AddUpgradeAttachment('Suppressor', 'UIPawnLocation_WeaponUpgrade_Cannon_Suppressor', "LWCannon_CG.Meshes.LW_CoilCannon_Suppressor", "", 'Cannon_CG', , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_Suppressor", "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_CoilCannon_Suppressor", "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_weaponIcon_barrel");

}


// ******** HANDLE UPDATING STORAGE & TECH ************* //
// This handles updating storage in order to create new unlimited items of various flavors
static function UpdateStorage()
{
	local XComGameState NewGameState;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local X2ItemTemplateManager ItemTemplateMgr;
	local name ItemName;
	local bool bAddedAnyItem;

	History = `XCOMHISTORY;
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Updating HQ Storage to add items");
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.CreateStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	NewGameState.AddStateObject(XComHQ);
	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	bAddedAnyItem = false;

	foreach class'LWTemplateMods'.default.UnlimitedItemsAdded(ItemName)
	{
	if(AddItemToStorage(ItemName, ItemTemplateMgr, XComHQ, NewGameState))
		bAddedAnyItem = true;
	}

	if(bAddedAnyItem)
		History.AddGameStateToHistory(NewGameState);
	else
		History.CleanupPendingGameState(NewGameState);


	//schematics should be handled already, as the BuildItem UI draws from ItemTemplates, which are automatically loaded
}

static function bool AddItemToStorage(name ItemTemplateName, X2ItemTemplateManager ItemTemplateMgr, XComGameState_HeadquartersXCom XComHQ, XComGameState NewGameState)
{
	local X2ItemTemplate ItemTemplate;
	local XComGameState_Item NewItemState;

	`LWTRACE("Searching for item template:" @ ItemTemplateName);
	ItemTemplate = ItemTemplateMgr.FindItemTemplate(ItemTemplateName);
	if(ItemTemplate != none)
	{
		`LWTRACE("Found item template:" @ ItemTemplateName);
		if (!XComHQ.HasItem(ItemTemplate))
		{
			`LWTRACE(ItemTemplateName $ " not found, adding to inventory");
			NewItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			NewGameState.AddStateObject(NewItemState);
			XComHQ.AddItemToHQInventory(NewItemState);
			return true;
		} else {
			`LWTRACE(ItemTemplateName $ " found, skipping inventory add");
			return false;
		}
	}
}

// WOTC TODO: Is this necessary? Was called from `OnLoadSavedGame()` and still called
// from `UIScreenListener_AvengerHUD`
static function UpdateTechs()
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local array<X2StrategyElementTemplate> arrTechTemplates;
	local XComGameState_Tech TechStateObject;
	local X2TechTemplate TechTemplate;
	local int idx;
	//local array<XComGameState_Tech> AllTechGameStates;
	local array<name> AllTechGameStateNames;
	local XComGameState_Tech TechState;
	local bool bUpdatedAnyTech;

	History = `XCOMHISTORY;

	// Grab all existing tech gamestates
	foreach History.IterateByClassType(class'XComGameState_Tech', TechState)
	{
		//AllTechGameStates.AddItem(TechState);
		AllTechGameStateNames.AddItem(TechState.GetMyTemplateName());
	}

	// Grab all Tech Templates
	arrTechTemplates = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().GetAllTemplatesOfClass(class'X2TechTemplate');

	if(arrTechTemplates.Length == AllTechGameStateNames.Length)
		return;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Adding new tech gamestates");

	// Iterate through the templates and build each Tech State Object, if it hasn't been already built
	for(idx = 0; idx < arrTechTemplates.Length; idx++)
	{
		TechTemplate = X2TechTemplate(arrTechTemplates[idx]);

		if(AllTechGameStateNames.Find(TechTemplate.DataName) != -1)
			continue;

		if (TechTemplate.RewardDeck != '')
		{
			class'XComGameState_Tech'.static.SetUpTechRewardDeck(TechTemplate);
		}

		bUpdatedAnyTech = true;

		`LOG("Adding new tech gamestate: " $ TechTemplate.DataName);

		TechStateObject = XComGameState_Tech(NewGameState.CreateStateObject(class'XComGameState_Tech'));
		TechStateObject.OnCreation(X2TechTemplate(arrTechTemplates[idx]));
		NewGameState.AddStateObject(TechStateObject);
	}

	if(bUpdatedAnyTech)
		History.AddGameStateToHistory(NewGameState);
	else
		History.CleanupPendingGameState(NewGameState);
}

static function UpdateChosenActivities()
{
	UpdateTraining();
}

static function UpdateChosenSabotages()
{
	UpdateWeaponLockers();
	UpdateLabStorage();
	UpdateSecureStorage();
}


static function UpdateWeaponLockers()
{
	local X2SabotageTemplate Template;

	Template = X2SabotageTemplate(class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().FindStrategyElementTemplate('Sabotage_WeaponLockers'));
	Template.CanActivateFn = CanActivateWeaponLockers;
}

static function UpdateLabStorage()
{
	local X2SabotageTemplate Template;

	Template = X2SabotageTemplate(class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().FindStrategyElementTemplate('Sabotage_LabStorage'));
	Template.CanActivateFn = CanActivateLabStorage;
}
static function UpdateSecureStorage()
{
	local X2SabotageTemplate Template;

	Template = X2SabotageTemplate(class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().FindStrategyElementTemplate('Sabotage_SecureStorage'));
	Template.CanActivateFn = CanActivateSecureStorage;
}
function bool CanActivateWeaponLockers()
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_Item ItemState;
	local StateObjectReference ItemRef;
	local X2WeaponUpgradeTemplate UpgradeTemplate;
	local int NumUpgrades, MinMods;

	MinMods = `ScaleStrategyArrayInt(class'X2StrategyElement_DefaultSabotages'.default.MinWeaponLockersMods);
	
	NumUpgrades = 10;
	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));

	foreach XComHQ.Inventory(ItemRef)
	{
		ItemState = XComGameState_Item(History.GetGameStateForObjectID(ItemRef.ObjectID));

		if(ItemState != none)
		{
			UpgradeTemplate = X2WeaponUpgradeTemplate(ItemState.GetMyTemplate());

			if(UpgradeTemplate != none)
			{
				NumUpgrades++;
				if(NumUpgrades >= MinMods)
				{
					return true;
				}
			}
		}
	}
	return false;
}
function bool CanActivateLabStorage()
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_Item ItemState;
	local StateObjectReference ItemRef;
	local int NumPads, MinPads;
	NumPads = 0;
	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	MinPads = `ScaleStrategyArrayInt(class'X2StrategyElement_DefaultSabotages'.default.LabStorageMinDatapads);
	foreach XComHQ.Inventory(ItemRef)
	{
		ItemState = XComGameState_Item(History.GetGameStateForObjectID(ItemRef.ObjectID));

		if(ItemState != none && (ItemState.GetMyTemplateName() == 'AdventDatapad' || ItemState.GetMyTemplateName() == 'AlienDatapad'))
		{
			NumPads++;
			if(NumPads >= MinPads)
			{
				return true;
			}
		}
	}

	return false;
}

static function bool CanActivateSecureStorage()
{
	return (class'UIUtilities_Strategy'.static.GetResource('EleriumCore') >= `ScaleStrategyArrayInt(class'X2StrategyElement_DefaultSabotages'.default.MinSecureStorageCores) && class'X2StrategyElement_DefaultSabotages'.static.ExistsValidStaffForWounding());
}
static function UpdateTraining()
{
	local X2ChosenActionTemplate Template;

	Template = X2ChosenActionTemplate(class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().FindStrategyElementTemplate('ChosenAction_Training'));
	Template.OnActivatedFn = ActivateTraining;
}

static function ActivateTraining(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate = false)
{
	local XComGameState_ChosenAction ActionState;
	local XComGameState_AdventChosen ChosenState;
	local name OldTacticalTag, NewTacticalTag;

	ActionState = class'X2StrategyElement_XpackChosenActions'.static.GetAction(InRef, NewGameState);
	ChosenState = class'X2StrategyElement_XpackChosenActions'.static.GetChosen(ActionState.ChosenRef, NewGameState);

	// Grab Old Tactical Tag
	OldTacticalTag = ChosenState.GetMyTemplate().GetSpawningTag(ChosenState.Level);

	// Increase the Chosen's level
	ChosenState.Level++;
	NewTacticalTag = ChosenState.GetMyTemplate().GetSpawningTag(ChosenState.Level);

	// Only met, active chosen trigger the just leveled up popup
	if(ChosenState.bMetXCom && !ChosenState.bDefeated)
	{
		ChosenState.bJustLeveledUp = true;
	}

	// Replace Old Tag with new Tag in missions
	ChosenState.RemoveTacticalTagFromAllMissions(NewGameState, OldTacticalTag, NewTacticalTag);

	// Gain New Traits
	GainNewStrengths(NewGameState, class'XComGameState_AdventChosen'.default.NumStrengthsPerLevel, ChosenState);

}

static function	GainNewStrengths(XComGameState NewGameState, int NumStrengthsPerLevel, XComGameState_AdventChosen ChosenState)
{
	local X2CharacterTemplate ChosenTemplate;
	local array<ChosenStrengthWeighted> ChosenStrengths , ValidChosenStrengths;	
	local array<ChosenStrengthWeighted> BackupChosenStrengths, FurtherBackupChosenStrengths;	
	local ChosenStrengthWeighted WStrength;
	local float finder, selection, TotalWeight;
	local int i;
	local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;

	ChosenTemplate = ChosenState.GetChosenTemplate();
	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));

	if(ChosenTemplate.CharacterGroupName == 'ChosenSniper')
	{

		if(AlienHQ.GetForceLevel() > 14)
		{
			ChosenStrengths = default.HUNTER_STRENGTHS_T3;
			BackupChosenStrengths = default.HUNTER_STRENGTHS_T2;
			FurtherBackupChosenStrengths = default.HUNTER_STRENGTHS_T1;
		}
		else if(AlienHQ.GetForceLevel() > 9)
		{
			ChosenStrengths = default.HUNTER_STRENGTHS_T2;
			BackupChosenStrengths = default.HUNTER_STRENGTHS_T1;
		}
		else 
		{
			ChosenStrengths = default.HUNTER_STRENGTHS_T1;
		}
	}
	if(ChosenTemplate.CharacterGroupName == 'ChosenWarlock')
	{
		if(AlienHQ.GetForceLevel() > 14)
		{
			ChosenStrengths = default.WARLOCK_STRENGTHS_T3;
			BackupChosenStrengths = default.WARLOCK_STRENGTHS_T2;
			FurtherBackupChosenStrengths = default.WARLOCK_STRENGTHS_T1;
		}
		else if(AlienHQ.GetForceLevel() > 9)
		{
			ChosenStrengths = default.WARLOCK_STRENGTHS_T2;
			BackupChosenStrengths = default.WARLOCK_STRENGTHS_T1;
		}
		else 
		{
			ChosenStrengths = default.WARLOCK_STRENGTHS_T1;
		}	
	}
	if(ChosenTemplate.CharacterGroupName == 'ChosenAssassin')
	{
		if(AlienHQ.GetForceLevel() > 14)
		{
			ChosenStrengths = default.ASSASSIN_STRENGTHS_T3;
			BackupChosenStrengths = default.ASSASSIN_STRENGTHS_T2;
			FurtherBackupChosenStrengths = default.ASSASSIN_STRENGTHS_T1;
		}
		else if(AlienHQ.GetForceLevel() > 9)
		{
			ChosenStrengths = default.ASSASSIN_STRENGTHS_T2;
			BackupChosenStrengths = default.ASSASSIN_STRENGTHS_T1;
		}
		else 
		{
			ChosenStrengths = default.ASSASSIN_STRENGTHS_T1;
		}		
	}
	ValidChosenStrengths = ChosenStrengths;

	//Remove Strengths Are already added, and those that are excluded by already added strengths
	ValidateStrengthList(ValidChosenStrengths, ChosenState);
	if(ValidChosenStrengths.Length == 0)
	{
		ValidChosenStrengths = BackupChosenStrengths;
		ValidateStrengthList(ValidChosenStrengths, ChosenState);
		if(ValidChosenStrengths.Length == 0)
		{
			ValidChosenStrengths = FurtherBackupChosenStrengths;
			ValidateStrengthList(ValidChosenStrengths, ChosenState);
		}
	}

		TotalWeight = 0.0f;
		foreach ValidChosenStrengths(WStrength)
		{
			TotalWeight+=WStrength.Weight;
		}
		for(i=0; i<NumStrengthsPerLevel; i++)
		{
			finder = 0.0f;
			selection = `SYNC_FRAND_STATIC() * TotalWeight;
			foreach ValidChosenStrengths(WStrength)
			{
				finder += WStrength.Weight;
				if(finder > selection)
				{
					break;
				}
			}
			ChosenState.Strengths.AddItem(WStrength.Strength);
		}
}

static function ValidateStrengthList(out array<ChosenStrengthWeighted> ValidChosenStrengths, XComGameState_AdventChosen ChosenState)
{
	local name Traitname, ExcludeTraitName;
	local X2AbilityTemplate TraitTemplate;
	local X2AbilityTemplateManager AbilityMgr;
	local int i;
	AbilityMgr = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager();

	foreach ChosenState.Strengths(Traitname)
	{
		TraitTemplate = AbilityMgr.FindAbilityTemplate(Traitname);

		for(i = ValidChosenStrengths.length -1; i>= 0; i--)
		{
			if(ValidChosenStrengths[i].Strength == Traitname)
			{
				ValidChosenStrengths.Remove(i, 1);
			}
		}
		
		foreach TraitTemplate.ChosenExcludeTraits(ExcludeTraitName)
		{
			for(i = ValidChosenStrengths.length -1; i>= 0; i--)
			{
				if(ValidChosenStrengths[i].Strength == ExcludeTraitName)
				{
					ValidChosenStrengths.Remove(i, 1);
				}
			}
		}
	}
	//Remove Strengths That are excluded by weaknesses
	foreach ChosenState.Weaknesses(Traitname)
	{
		TraitTemplate = AbilityMgr.FindAbilityTemplate(Traitname);

		foreach TraitTemplate.ChosenExcludeTraits(ExcludeTraitName)
		{
			for(i = ValidChosenStrengths.length -1; i>= 0; i--)
			{
				if(ValidChosenStrengths[i].Strength == ExcludeTraitName)
				{
					ValidChosenStrengths.Remove(i, 1);
				}

			}
		}
	}
}



static function XComGameState_WorldRegion ChooseRetributionRegion(XComGameState_AdventChosen ChosenState)
{
	local XComGameStateHistory History;
	local XComGameState_WorldRegion RegionState;
	local StateObjectReference RegionRef;
	local int i;

	History = `XCOMHISTORY;

	// For target deck, get Chosen territories and then remove the uncontacted ones.
	// That way it will select a region that's both this Chosen's region AND contacted.
	// There will always be at least one because you need to have at least one
	// territory contacted to meet the chosen, and you can't lose contact to regions in
	// LWOTC.
	ChosenState.RegionAttackDeck = ChosenState.TerritoryRegions;
	for (i = ChosenState.RegionAttackDeck.length - 1; i >= 0 ; i--)
	{
		if (XComGameState_WorldRegion(History.GetGameStateForObjectID(ChosenState.RegionAttackDeck[i].ObjectID)).ResistanceLevel < eResLevel_Contact)
		ChosenState.RegionAttackDeck.Remove(i, 1);
	}
	RegionRef = ChosenState.RegionAttackDeck[`SYNC_RAND_STATIC(ChosenState.RegionAttackDeck.Length)];
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(RegionRef.ObjectID));

	return RegionState;
}

//=========================================================================================
//================= BEGIN LONG WAR ABILITY TAG HANDLER ====================================
//=========================================================================================

// PLEASE LEAVE THIS FUNCTION AT THE BOTTOM OF THE FILE FOR EASY FINDING - JL

static function bool AbilityTagExpandHandler(string InString, out string OutString)
{
	local name Type;
	local UITacticalHUD TacticalHUD;
	local StateObjectReference UnitRef;
	local XComGameState_Unit UnitState;
	local int NumTiles;
	local XComGameState_HeadquartersXCom XComHQ;

	Type = name(InString);
	switch(Type)
	{
		case 'EVACDELAY_LW':
			OutString = string(class'X2Ability_PlaceDelayedEvacZone'.static.GetEvacDelay());
			return true;
		case 'INDEPENDENT_TRACKING_BONUS_TURNS_LW':
			OutString = string(class'X2Effect_LWHoloTarget'.default.INDEPENDENT_TARGETING_NUM_BONUS_TURNS);
			return true;
		case 'HOLO_CV_AIM_BONUS_LW':
			OutString = string(class'X2Effect_LWHoloTarget'.default.HOLO_CV_AIM_BONUS);
			return true;
		case 'HOLO_MG_AIM_BONUS_LW':
			OutString = string(class'X2Effect_LWHoloTarget'.default.HOLO_MG_AIM_BONUS);
			return true;
		case 'HOLO_BM_AIM_BONUS_LW':
			OutString = string(class'X2Effect_LWHoloTarget'.default.HOLO_BM_AIM_BONUS);
			return true;
		case 'HDHOLO_CV_CRIT_BONUS_LW':
			OutString = string(class'X2Effect_LWHoloTarget'.default.HDHOLO_CV_CRIT_BONUS);
			return true;
		case 'HDHOLO_MG_CRIT_BONUS_LW':
			OutString = string(class'X2Effect_LWHoloTarget'.default.HDHOLO_MG_CRIT_BONUS);
			return true;
		case 'HDHOLO_BM_CRIT_BONUS_LW':
			OutString = string(class'X2Effect_LWHoloTarget'.default.HDHOLO_BM_CRIT_BONUS);
			return true;
		case 'VITAL_POINT_CV_BONUS_DMG_LW':
			OutString = string(class'X2Item_LWHolotargeter'.default.Holotargeter_CONVENTIONAL_BASEDAMAGE.Damage);
			if (class'X2Item_LWHolotargeter'.default.Holotargeter_CONVENTIONAL_BASEDAMAGE.PlusOne > 0)
			{
				Outstring $= ".";
				Outstring $= string (class'X2Item_LWHolotargeter'.default.Holotargeter_CONVENTIONAL_BASEDAMAGE.PlusOne);
			}
			return true;
		case 'VITAL_POINT_MG_BONUS_DMG_LW':
			OutString = string(class'X2Item_LWHolotargeter'.default.Holotargeter_MAGNETIC_BASEDAMAGE.Damage);
			if (class'X2Item_LWHolotargeter'.default.Holotargeter_MAGNETIC_BASEDAMAGE.PlusOne > 0)
			{
				Outstring $= ".";
				Outstring $= string (class'X2Item_LWHolotargeter'.default.Holotargeter_MAGNETIC_BASEDAMAGE.PlusOne);
			}
			return true;
		case 'VITAL_POINT_BM_BONUS_DMG_LW':
			OutString = string(class'X2Item_LWHolotargeter'.default.Holotargeter_BEAM_BASEDAMAGE.Damage);
			if (class'X2Item_LWHolotargeter'.default.Holotargeter_BEAM_BASEDAMAGE.PlusOne > 0)
			{
				Outstring $= ".";
				Outstring $= string (class'X2Item_LWHolotargeter'.default.Holotargeter_BEAM_BASEDAMAGE.PlusOne);
			}
			return true;
		case 'MULTI_HOLO_CV_RADIUS_LW':
			OutString = string(class'X2Item_LWHolotargeter'.default.Holotargeter_CONVENTIONAL_RADIUS);
			return true;
		case 'MULTI_HOLO_MG_RADIUS_LW':
			OutString = string(class'X2Item_LWHolotargeter'.default.Holotargeter_MAGNETIC_RADIUS);
			return true;
		case 'MULTI_HOLO_BM_RADIUS_LW':
			OutString = string(class'X2Item_LWHolotargeter'.default.Holotargeter_BEAM_RADIUS);
			return true;
		case 'RAPID_TARGETING_COOLDOWN_LW':
			OutString = string(class'X2Ability_LW_SharpshooterAbilitySet'.default.RAPID_TARGETING_COOLDOWN);
			return true;

		case 'BURNOUT_RADIUS_LW':
			OutString = Repl(string(class'X2Ability_LW_TechnicalAbilitySet'.default.BURNOUT_RADIUS), "0", "");
			return true;
		case 'HIGH_PRESSURE_CHARGES_LW':
			Outstring = string(class'X2Ability_LW_TechnicalAbilitySet'.default.FLAMETHROWER_HIGH_PRESSURE_CHARGES);
			return true;
		case 'FLAMETHROWER_CHARGES_LW':
			Outstring = string(class'X2Ability_LW_TechnicalAbilitySet'.default.FLAMETHROWER_CHARGES);
			return true;
		case 'FIRESTORM_DAMAGE_BONUS_LW':
			Outstring = string(int(class'X2Ability_LW_TechnicalAbilitySet'.default.FIRESTORM_DAMAGE_BONUS));
			return true;
		case 'NANOFIBER_HEALTH_BONUS_LW':
			Outstring = string(class'X2Ability_ItemGrantedAbilitySet'.default.NANOFIBER_VEST_HP_BONUS);
			return true;
		case 'NANOFIBER_CRITDEF_BONUS_LW':
			Outstring = string(class'X2Ability_LW_GearAbilities'.default.NANOFIBER_CRITDEF_BONUS);
			return true;
		case 'RESILIENCE_BONUS_LW':
			Outstring = string(class'X2Ability_PerkPackAbilitySet'.default.RESILIENCE_CRITDEF_BONUS);
			return true;
		case 'ALPHA_MIKE_FOXTROT_DAMAGE_LW':
			Outstring = string(int(class'X2Ability_LW_SharpshooterAbilitySet'.default.ALPHAMIKEFOXTROT_DAMAGE * 100));
			return true;
		case 'ALPHA_MIKE_FOXTROT_CRIT_DAMAGE_LW':
			Outstring = string(int(class'X2Ability_LW_SharpshooterAbilitySet'.default.ALPHAMIKEFOXTROT_DAMAGE * 100 / 2));
			return true;			
		case 'ROCKETSCATTER':
			TacticalHUD = UITacticalHUD(`SCREENSTACK.GetScreen(class'UITacticalHUD'));
			if (TacticalHUD != none)
				UnitRef = XComTacticalController(TacticalHUD.PC).GetActiveUnitStateRef();
			if (UnitRef.ObjectID > 0)
				UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));

			if (TacticalHUD != none && TacticalHUD.GetTargetingMethod() != none && UnitState != none)
			{
				NumTiles = class'X2Ability_LW_TechnicalAbilitySet'.static.GetNumAimRolls(UnitState);
				Outstring = class'X2Ability_LW_TechnicalAbilitySet'.default.strMaxScatter $ string(NumTiles);
			}
			else
			{
				Outstring = "";
			}
			return true;
		case 'FORTIFY_DEFENSE_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.FORTIFY_DEFENSE);
			return true;
		case 'FORTIFY_COOLDOWN_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.FORTIFY_COOLDOWN);
			return true;
		case 'COMBAT_FITNESS_HP_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.COMBAT_FITNESS_HP);
			return true;
		case 'COMBAT_FITNESS_OFFENSE_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.COMBAT_FITNESS_OFFENSE);
			return true;
		case 'COMBAT_FITNESS_MOBILITY_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.COMBAT_FITNESS_MOBILITY);
			return true;
		case 'COMBAT_FITNESS_DODGE_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.COMBAT_FITNESS_DODGE);
			return true;
		case 'COMBAT_FITNESS_WILL_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.COMBAT_FITNESS_WILL);
			return true;
		case 'COMBAT_FITNESS_DEFENSE_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.COMBAT_FITNESS_DEFENSE);
			return true;
		case 'RUPTURE_CRIT_BONUS_LW':
			Outstring = string(class'LWTemplateMods'.default.RUPTURE_CRIT_BONUS);
			return true;
		case 'SCANNING_PROTOCOL_INITIAL_CHARGES_LW':
			Outstring = string(class'X2LWAbilitiesModTemplate'.default.SCANNING_PROTOCOL_INITIAL_CHARGES);
			return true;
		case 'COMBATIVES_DODGE_LW':
			Outstring = string(class'X2Ability_LW_GunnerAbilitySet'.default.COMBATIVES_DODGE);
			return true;
		case 'COUNTERATTACK_DODGE_AMOUNT_LW':
			Outstring = string(class'X2Ability_LW_GunnerAbilitySet'.default.COUNTERATTACK_DODGE_AMOUNT);
			return true;
		case 'SPRINTER_MOBILITY_LW':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.SPRINTER_MOBILITY);
			return true;
		case 'TD_SHIELD_HP':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.TD_SHIELD_HP);
			return true;
		case 'TD_CRIT_DEF':
			Outstring = string(class'X2Ability_LW_RangerAbilitySet'.default.TD_CRIT_DEF);
			return true;
		case 'HEAT_WARHEADS_PIERCE_LW':
			Outstring = string(class'X2Ability_LW_GrenadierAbilitySet'.default.HEAT_WARHEADS_PIERCE);
			return true;
		case 'HEAT_WARHEADS_SHRED_LW':
			Outstring = string(class'X2Ability_LW_GrenadierAbilitySet'.default.HEAT_WARHEADS_SHRED);
			return true;
		case 'NEEDLE_BONUS_UNARMORED_DMG_LW':
			Outstring = string(class'X2Ability_LW_GrenadierAbilitySet'.default.NEEDLE_BONUS_UNARMORED_DMG);
			return true;
		case 'BLUESCREENBOMB_HACK_DEFENSE_CHANGE_LW':
			Outstring = string(-class'X2Ability_LW_GrenadierAbilitySet'.default.BLUESCREENBOMB_HACK_DEFENSE_CHANGE);
			return true;
		case 'REDSCREEN_EFFECT_LW':
			Outstring = string(-class'X2Item_LWUtilityItems'.default.REDSCREEN_HACK_DEFENSE_CHANGE);
			return true;
		case 'SCOPE_BSC_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.SCOPE_BSC_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.SCOPE_EMPOWER_BONUS : 0));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.SCOPE_BSC_AIM_BONUS);
			}
			return true;
		case 'SCOPE_ADV_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.SCOPE_ADV_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.SCOPE_EMPOWER_BONUS : 0));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.SCOPE_ADV_AIM_BONUS);
			}
			return true;
		case 'SCOPE_SUP_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.SCOPE_SUP_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.SCOPE_EMPOWER_BONUS : 0));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.SCOPE_SUP_AIM_BONUS);
			}
			return true;
		case 'TRIGGER_BSC_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(round((class'X2Ability_LW_GearAbilities'.default.TRIGGER_BSC_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.TRIGGER_EMPOWER_BONUS : 0)) 
				* (1.0f - class'X2AbilityToHitCalc_StandardAim'.default.REACTION_FINALMOD)));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.TRIGGER_BSC_AIM_BONUS);
			}
			return true;
		case 'TRIGGER_ADV_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(round((class'X2Ability_LW_GearAbilities'.default.TRIGGER_ADV_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.TRIGGER_EMPOWER_BONUS : 0)) 
				* (1.0f - class'X2AbilityToHitCalc_StandardAim'.default.REACTION_FINALMOD)));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.TRIGGER_ADV_AIM_BONUS);
			}
			return true;
		case 'TRIGGER_SUP_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(round((class'X2Ability_LW_GearAbilities'.default.TRIGGER_SUP_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.TRIGGER_EMPOWER_BONUS : 0)) 
				* (1.0f - class'X2AbilityToHitCalc_StandardAim'.default.REACTION_FINALMOD)));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.TRIGGER_SUP_AIM_BONUS);
			}
			return true;
		case 'STOCK_BSC_SW_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_BSC_SW_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.STOCK_EMPOWER_BONUS : 0));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_BSC_SW_AIM_BONUS);
			}
			return true;
		case 'STOCK_ADV_SW_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_ADV_SW_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.STOCK_EMPOWER_BONUS : 0));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_ADV_SW_AIM_BONUS);
			}
			return true;
		case 'STOCK_SUP_SW_AIM_BONUS':
			XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none) {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_SUP_SW_AIM_BONUS + (XComHQ.bEmpoweredUpgrades ? class'X2Ability_LW_GearAbilities'.default.STOCK_EMPOWER_BONUS : 0));
			} else {
				Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_SUP_SW_AIM_BONUS);
			}
			return true;
		case 'STOCK_BSC_GF_CHANCE':
			Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_BSC_SUCCESS_CHANCE);
			return true;
		case 'STOCK_ADV_GF_CHANCE':
			Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_ADV_SUCCESS_CHANCE);
			return true;
		case 'STOCK_SUP_GF_CHANCE':
			Outstring = string(class'X2Ability_LW_GearAbilities'.default.STOCK_SUP_SUCCESS_CHANCE);
			return true;
		case 'FLUSH_DEFENSE_REDUCTION':
			Outstring = string(class'X2Ability_LW_GunnerAbilitySet'.default.FLUSH_DEFENSE_REDUCTION);
			return true;
		case 'FLUSH_DODGE_REDUCTION':
			Outstring = string(class'X2Ability_LW_GunnerAbilitySet'.default.FLUSH_DODGE_REDUCTION);
			return true;
		case 'FLUSH_STATEFFECT_DURATION':
			Outstring = string(class'X2Ability_LW_GunnerAbilitySet'.default.FLUSH_STATEFFECT_DURATION);
			return true;
		case 'FLUSH_AIM_BONUS':
			Outstring = string(class'X2Ability_LW_GunnerAbilitySet'.default.FLUSH_AIM_BONUS);
			return true;
		case 'MIND_SCORCH_BURN_CHANCE':
			Outstring = string(class'X2LWAbilitiesModTemplate'.default.MIND_SCORCH_BURN_CHANCE);
			return true;
		case 'SUSTAIN_WOUND_HP_REDUCTTION':
			Outstring = string(class'X2LWAbilitiesModTemplate'.default.SUSTAIN_WOUND_HP_REDUCTTION);
			return true;
		case 'NULL_WARD_BASE_SHIELD':
			Outstring = string(class'X2Ability_LW_PsiOperativeAbilitySet'.default.NULL_WARD_BASE_SHIELD);
			return true;
		case 'PHASEWALK_CAST_RANGE_TILES':
			Outstring = string(class'X2Ability_LW_PsiOperativeAbilitySet'.default.PHASEWALK_CAST_RANGE_TILES);
			return true;
		case 'SMOKEGRENADE_HITMOD_LW':
			Outstring = string(-class'X2Item_DefaultGrenades'.default.SMOKEGRENADE_HITMOD);
			return true;
		case 'STREET_SWEEPER2_UNARMORED_DAMAGE_BONUS_LW':
			Outstring = string(class'X2Ability_LW_AssaultAbilitySet'.default.STREET_SWEEPER2_UNARMORED_DAMAGE_BONUS);
			return true;
		case 'CHAIN_LIGHTNING_AIM_MOD_LW':
			Outstring = string(class'X2Ability_LW_AssaultAbilitySet'.default.CHAIN_LIGHTNING_AIM_MOD);
			return true;
		case 'STUNGUNNER_BONUS_CV_LW':
			Outstring = string(class'X2Effect_StunGunner'.default.STUNGUNNER_BONUS_CV);
			return true;
		case 'STUNGUNNER_BONUS_BM_LW':
			Outstring = string(class'X2Effect_StunGunner'.default.STUNGUNNER_BONUS_BM);
			return true;
		case 'EMPULSER_HACK_DEFENSE_CHANGE_LW':
			Outstring = string(-class'X2Ability_LW_AssaultAbilitySet'.default.EMPULSER_HACK_DEFENSE_CHANGE);
			return true;
		case 'RESCUE_BONUS_DODGE':
			Outstring = string(class'X2Ability_LW_SpecialistAbilitySet'.default.RESCUE_BONUS_DODGE);
			return true;
		case 'RESCUE_BONUS_MOBILITY':
			Outstring = string(class'X2Ability_LW_SpecialistAbilitySet'.default.RESCUE_BONUS_MOBILITY);
			return true;
		case 'RESCUE_CV_CHARGES':
			Outstring = string(class'X2Ability_LW_SpecialistAbilitySet'.default.RESCUE_CV_CHARGES);
			return true;
		case 'IMPACT_COMPENSATION_PCT_DR':
			Outstring = string(int(class'X2Ability_LW_ChosenAbilities'.default.IMPACT_COMPENSATION_PCT_DR * 100));
			return true;
		case 'IMPACT_COMPENSATION_MAX_STACKS':
			Outstring = string(class'X2Ability_LW_ChosenAbilities'.default.IMPACT_COMPENSATION_MAX_STACKS);
			return true;
		case 'HIGH_VOLUME_FIRE_MALUS':
			Outstring = string(class'X2Ability_LW_ChosenAbilities'.default.HIGH_VOLUME_FIRE_MALUS);
			return true;
		case 'ARTERIAL_STRIKE_PRIMARY_BLEED':
			Outstring = string(class'X2Ability_LW_ChosenAbilities'.default.ARTERIAL_STRIKE_PRIMARY_BLEED);
			return true;
		case 'ARTERIAL_STRIKE_BLEED_INCREASE':
			Outstring = string(class'X2Ability_LW_ChosenAbilities'.default.ARTERIAL_STRIKE_BLEED_INCREASE);
			return true;
		case 'SHIELD_ALLY_PCT_DR':
			Outstring = string(int(class'X2Ability_LW_ChosenAbilities'.default.SHIELD_ALLY_PCT_DR * 100));
			return true;
		case 'CHOSEN_RETRIBUTION_DURATION':
			OutString = string(default.CHOSEN_RETRIBUTION_DURATION);
			return true;
		case 'UNSTOPPABLE_MIN_MOB':
			Outstring = string(class'X2Ability_LW_ChosenAbilities'.default.UNSTOPPABLE_MIN_MOB);
			return true;
		case 'NAPALM_X_BASEVALUE':
			Outstring = string(class'X2AbilityToHitCalc_StatCheck_LWFlamethrower'.default.BaseValue);
			return true;
		case 'GAUNTLET_CONVENTIONAL_OPPOSED_STAT_STRENTH':
			Outstring = string(class'X2Item_LWGauntlet'.default.Gauntlet_Secondary_CONVENTIONAL_OPPOSED_STAT_STRENTH);
			return true;
		case 'GAUNTLET_MAG_OPPOSED_STAT_STRENTH':
			Outstring = string(class'X2Item_LWGauntlet'.default.Gauntlet_Secondary_MAG_OPPOSED_STAT_STRENTH);
			return true;
		case 'GAUNTLET_BEAM_OPPOSED_STAT_STRENTH':
			Outstring = string(class'X2Item_LWGauntlet'.default.Gauntlet_Secondary_BEAM_OPPOSED_STAT_STRENTH);
			return true;
		case 'COMBATREADINESS_DEF':
			Outstring = string(class'X2Ability_XMBPerkAbilitySet'.default.COMBATREADINESS_DEF);
			return true;
		case 'COMBATREADINESS_AIM':
			Outstring = string(class'X2Ability_XMBPerkAbilitySet'.default.COMBATREADINESS_AIM);
			return true;
		case 'COMBAT_READINESS_EXPLOSIVE_DR':
			Outstring = string(int(class'X2Ability_XMBPerkAbilitySet'.default.COMBAT_READINESS_EXPLOSIVE_DR * 100));
			return true;
		case 'BLOODTHIRST_T1_DMG':
			Outstring = string(class'X2Effect_BloodThirst'.default.BLOODTHIRST_T1_DMG);
			return true;
		case 'BLOODTHIRST_T2_DMG':
			Outstring = string(class'X2Effect_BloodThirst'.default.BLOODTHIRST_T2_DMG);
			return true;
		case 'BLOODTHIRST_T3_DMG':
			Outstring = string(class'X2Effect_BloodThirst'.default.BLOODTHIRST_T3_DMG);
			return true;
		case 'BLOODTHIRST_T4_DMG':
			Outstring = string(class'X2Effect_BloodThirst'.default.BLOODTHIRST_T4_DMG);
			return true;
		case 'BLOODTHIRST_T5_DMG':
			Outstring = string(class'X2Effect_BloodThirst'.default.BLOODTHIRST_T5_DMG);
			return true;
		case 'DISRUPTOR_RIFLE_PSI_CRIT':
			Outstring = string(class'X2Ability_XPackAbilitySet'.default.DISRUPTOR_RIFLE_PSI_CRIT);
			return true;
		case 'AP_ROUNDS_CRIT_PENALTY':
			Outstring = string(-1 * class'X2Ability_LW_GearAbilities'.default.AP_ROUNDS_CRIT_PENALTY);
			return true;
		case 'HUNTERS_INSTINCT_DAMAGE_PCT':
			Outstring = string(int(class'LWTemplateMods'.default.HUNTERS_INSTINCT_DAMAGE_PCT * 100));
			return true;
		case 'HUNKER_EXPLOSIVE_PCT_DR':
			Outstring = string(int(class'LWTemplateMods'.default.HUNKER_EXPLOSIVE_PCT_DR * 100));
			return true;
		case 'HUNKER_DODGE_PER_TILE':
			Outstring = string(class'LWTemplateMods'.default.HUNKER_DODGE_PER_TILE);
			return true;
		case 'GUARDIAN_BONUS_AMMO':
			Outstring = string(class'LWTemplateMods'.default.GUARDIAN_BONUS_AMMO);
			return true;
		case 'FATALITY_THRESHOLD':
			Outstring = string(int(class'X2Ability_XMBPerkAbilitySet'.default.FATALITY_THRESHOLD * 100));
			return true;
		case 'BIND_M2_BONUSDAMAGE':
			Outstring = string(class'X2LWAbilitiesModTemplate'.default.BIND_M2_BONUSDAMAGE);
			return true;
		case 'BIND_M3_BONUSDAMAGE':
			Outstring = string(class'X2LWAbilitiesModTemplate'.default.BIND_M3_BONUSDAMAGE);
			return true;	
		case 'BIND_M4_BONUSDAMAGE':
			Outstring = string(class'X2LWAbilitiesModTemplate'.default.BIND_M4_BONUSDAMAGE);
			return true;
		case 'BIND_M5_BONUSDAMAGE':
			Outstring = string(class'X2LWAbilitiesModTemplate'.default.BIND_M5_BONUSDAMAGE);
			return true;	
		case 'BIND_M6_BONUSDAMAGE':
			Outstring = string(class'X2LWAbilitiesModTemplate'.default.BIND_M6_BONUSDAMAGE);
			return true;
		case 'BENDINGREED_MOBILITY_INCREASE':
			Outstring = string(int((class'X2Ability_ChosenAssassin'.default.BENDINGREED_MOBILITY_INCREASE-1)*100));
			return true;
		case 'SIDEWINDER_FOCUS1MOBILITY':
			Outstring = string(class'X2Ability_LWAlienAbilities'.default.SIDEWINDER_FOCUS1MOBILITY);
			return true;
		case 'SIDEWINDER_FOCUS1AIM':
			Outstring = string(class'X2Ability_LWAlienAbilities'.default.SIDEWINDER_FOCUS1AIM);
			return true;
		case 'SIDEWINDER_FOCUS1CRIT':
			Outstring = string(class'X2Ability_LWAlienAbilities'.default.SIDEWINDER_FOCUS1CRIT);
			return true;
		default:
			return false;
	}
}

static function bool AbilityTagExpandHandler_CH(string InString, out string OutString, Object ParseObj, Object StrategyParseOb, XComGameState GameState)
{
	local name Type;
	local XComGameState_Ability AbilityState;
	local XComGameState_Effect EffectState;
	local XComGameState_Unit UnitState;
	local X2AbilityTemplate AbilityTemplate;
	local int ImpactCompensationStacks;
	local int k;
	local XComGameState_Item PrimaryWeaponState;

	Type = name(InString);
	switch(Type)
	{
	case 'SELFCOOLDOWN_LW':
		OutString = "0";
		AbilityTemplate = X2AbilityTemplate(ParseObj);
		if (AbilityTemplate == none)
		{
			AbilityState = XComGameState_Ability(ParseObj);
			if (AbilityState != none)
				AbilityTemplate = AbilityState.GetMyTemplate();
		}
		if (AbilityTemplate != none)
		{
			if (AbilityTemplate.AbilityCooldown != none)
			{
				// LW2 doesn't subtract 1 from cooldowns as a general rule, so to keep it consistent
				// there is substitute tag
				OutString = string(AbilityTemplate.AbilityCooldown.iNumTurns);
			}
		}
		return true;
	case 'IMPACT_COMPENSATION_CURRENT_DR':
		OutString = "0";
		AbilityState = XComGameState_Ability(ParseObj);
		if (AbilityState != none)
		{
			UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
		}
		else
		{
			EffectState = XComGameState_Effect(ParseObj);
			if (EffectState != none)
			{
				UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
			}
		}

		if (UnitState != none)
		{
			ImpactCompensationStacks = int(class'Utilities_LW'.static.GetUnitValue(UnitState, class'X2Ability_PerkPackAbilitySet2'.const.DAMAGED_COUNT_NAME));
			if (ImpactCompensationStacks > 0)
			{
				OutString = string(int((1 - (1 - class'X2Ability_LW_ChosenAbilities'.default.IMPACT_COMPENSATION_PCT_DR) **
						Min(ImpactCompensationStacks, class'X2Ability_LW_ChosenAbilities'.default.IMPACT_COMPENSATION_MAX_STACKS)) * 100));
			}
		}
		return true;
	case 'FLASHBANG_RESIST_VALUE':
		OutString = "0";
		AbilityState = XComGameState_Ability(ParseObj);
		if (AbilityState != none)
		{
			UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
		}
		else
		{
			EffectState = XComGameState_Effect(ParseObj);
			if (EffectState != none)
			{
				UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));
			}
		}

		if (UnitState != none)
		{
			for (k = 0; k < class'LWTemplateMods'.default.ENEMY_FLASHBANG_RESIST.length; k++)
			{
				if (class'LWTemplateMods'.default.ENEMY_FLASHBANG_RESIST[k].UnitName == UnitState.GetMyTemplateName())
				{
					OutString = string(class'LWTemplateMods'.default.ENEMY_FLASHBANG_RESIST[k].Chance);
					break;
				}
			}
		}
		return true;
		case 'MAX_PRIMARY_AMMO':
			OutString = "0";
			AbilityState = XComGameState_Ability(ParseObj);
			if (AbilityState != none)
			{
				PrimaryWeaponState = AbilityState.GetSourceWeapon();
				if(PrimaryWeaponState != none)
				{
					Outstring = string(PrimaryWeaponState.GetClipSize());
				}
			}
			return true;
		case 'CURRENT_PRIMARY_AMMO':
			OutString = "0";
			AbilityState = XComGameState_Ability(ParseObj);
			if (AbilityState != none)
			{
				PrimaryWeaponState = AbilityState.GetSourceWeapon();
				if(PrimaryWeaponState != none)
				{
					Outstring = string(PrimaryWeaponState.Ammo);
				}
			}
			return true;

	default:
		return false;
	}
}

//=========================================================================================
//================== BEGIN EXEC LONG WAR CONSOLE EXEC =====================================
//=========================================================================================

function XComGameState_WorldRegion GetRandomContactedRegion()
{
	local XComGameStateHistory History;
	local XComGameState_WorldRegion RegionState;
	local array<XComGameState_WorldRegion> ValidRegions, AllRegions;

	History = `XCOMHISTORY;

	foreach History.IterateByClassType(class'XComGameState_WorldRegion', RegionState)
	{
		AllRegions.AddItem(RegionState);

		if(RegionState.ResistanceLevel >= eResLevel_Contact)
		{
			ValidRegions.AddItem(RegionState);
		}
	}

	if(ValidRegions.Length > 0)
	{
		return ValidRegions[`SYNC_RAND(ValidRegions.Length)];
	}

	return AllRegions[`SYNC_RAND(AllRegions.Length)];
}

function XComGameState_WorldRegion FindRegionByName(name RegionName)
{
	local XComGameState_WorldRegion RegionState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	foreach History.IterateByClassType(class'XComGameState_WorldRegion', RegionState)
	{
		if(RegionState.GetMyTemplateName() == RegionName)
			return RegionState;
	}
	return none;
}

function string GetDateTimeString(TDateTime DateTime)
{
	local string DateTimeString;
	DateTimeString = class'X2StrategyGameRulesetDataStructures'.static.GetDateString(DateTime);
	DateTimeString $= " / " $ class'X2StrategyGameRulesetDataStructures'.static.GetTimeString(DateTime);
	return DateTimeString;
}

exec function LWSetEvacCounter(int Turns)
{
	local XComGameState_LWEvacSpawner EvacState;
	local XComGameState NewGameState;

	EvacState = XComGameState_LWEvacSpawner(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_LWEvacSpawner', true));

	if (EvacState != none && EvacState.GetCountdown() >= 0)
	{
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("CHEAT: LWSetEvacCounter");
		EvacState = XComGameState_LWEvacSpawner(NewGameState.CreateStateObject(class'XComGameState_LWEvacSpawner', EvacState.ObjectID));
		EvacState.SetCountdown(Turns);
		NewGameState.AddStateObject(EvacState);
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
}

exec function LWSetUnitValue(Name ValueName, float Value)
{
	local StateObjectReference ActiveUnitRef;
	local UITacticalHUD TacticalHUD;
	local XComGameState_Unit Unit;
	local XComGameState NewGameState;

	TacticalHUD = UITacticalHUD(`SCREENSTACK.GetScreen(class'UITacticalHUD'));
	if (TacticalHUD != none)
	{
		ActiveUnitRef = XComTacticalController(TacticalHUD.PC).GetActiveUnitStateRef();
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("LWCHEAT : SetUnitValue");
		Unit = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', ActiveUnitRef.ObjectID));
		NewGameState.AddStateObject(Unit);
		Unit.SetUnitFloatValue(ValueName, Value, eCleanup_BeginTactical);
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
}

// Rebuild ability tree and XCOM abilities for the soldier selected
// in the armory.
exec function RespecSelectedSoldier()
{
	local UIArmory							Armory;
	local StateObjectReference				UnitRef;
	local XComGameState_Unit				UnitState;
	
	Armory = UIArmory(`SCREENSTACK.GetFirstInstanceOf(class'UIArmory'));
	if (Armory == none)
	{
		class'Helpers'.static.OutputMsg("No unit selected - cannot respec soldier");
		return;
	}

	UnitRef = Armory.GetUnitRef();
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));
	if (UnitState == none)
	{
		class'Helpers'.static.OutputMsg("No unit selected - cannot respec soldier");
		return;
	}

	RespecSoldier(UnitState);
	Armory.PopulateData();
}

exec function RespecAllSoldiers()
{
	local XComGameState_HeadquartersXCom	XComHQ;
	local XComGameState_Unit				UnitState;
	local array<XComGameState_Unit>			Soldiers;

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	Soldiers = XComHQ.GetSoldiers();
	foreach Soldiers(UnitState)
	{
		// Skip Psi Operatives as they're ranking up requires training
		if (!UnitState.IsPsiOperative())
			RespecSoldier(UnitState);
	}
}

static function RespecSoldier(XComGameState_Unit UnitState)
{
	local XComGameStateHistory				History;
	local XComGameState						NewGameState;
	local XComGameState_HeadquartersXCom	XComHQ;
	local name								ClassName;
	local int								i, NumRanks, iXP;
	local array<XComGameState_Item>			EquippedImplants;

	History = `XCOMHISTORY;

	ClassName = UnitState.GetSoldierClassTemplateName();
	NumRanks = UnitState.GetRank();

	iXP = UnitState.GetXPValue();
	iXP -= class'X2ExperienceConfig'.static.GetRequiredXp(NumRanks);

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Respec Soldier");
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	
	if (ClassName == 'Random' || ClassName == 'Rookie')
	{
		ClassName = XComHQ.SelectNextSoldierClass();
	}

	// Remove PCSes because they mess up the base stats after the reset.
	EquippedImplants = UnitState.GetAllItemsInSlot(eInvSlot_CombatSim);
	for (i = 0; i < EquippedImplants.Length; i++)
	{
		UnitState.RemoveItemFromInventory(EquippedImplants[i], NewGameState);
	}

	UnitState.AbilityPoints = 0; // Reset Ability Points
	UnitState.SpentAbilityPoints = 0; // And reset the spent AP tracker
	UnitState.ResetSoldierRank(); // Clear their rank
	ApplyRandomizedInitialStats(UnitState, NewGameState);
	UnitState.ResetSoldierAbilities(); // Clear their current abilities
	UnitState.ClearUnitValue('LWOTC_AbilityCostModifier'); // Reset the ability cost multiplier
	for (i = 0; i < NumRanks; ++i) // Rank soldier back up to previous level
	{
		UnitState.RankUpSoldier(NewGameState, ClassName);
	}
	// UnitState.ApplySquaddieLoadout(NewGameState, XComHQ);

	// Reapply Stat Modifiers (Beta Strike HP, etc.)
	UnitState.bEverAppliedFirstTimeStatModifiers = false;
	if (UnitState.GetMyTemplate().OnStatAssignmentCompleteFn != none)
	{
		UnitState.GetMyTemplate().OnStatAssignmentCompleteFn(UnitState);
	}
	UnitState.ApplyFirstTimeStatModifiers();

	// Restore any partial XP the soldier had
	if (iXP > 0)
	{
		UnitState.AddXp(iXP);
	}

	// Restore the PCSes.
	for (i = 0; i < EquippedImplants.Length; i++)
	{
		UnitState.AddItemToInventory(EquippedImplants[i], eInvSlot_CombatSim, NewGameState);
	}

	if (NewGameState.GetNumGameStateObjects() > 0)
	{
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else
	{
		History.CleanupPendingGameState(NewGameState);
	}
}

static function ApplyRandomizedInitialStats(XComGameState_Unit UnitState, XComGameState NewGameState)
{
	local XComGameState_LWToolboxOptions ToolboxOptions;
	
	ToolboxOptions = class'XComGameState_LWToolboxOptions'.static.GetToolboxOptions();
	ToolboxOptions.UpdateOneSoldier_RandomizedInitialStats(UnitState, NewGameState, true);
}

exec function MeetFaction(string FactionName, optional bool bIgnoreRevealSequence)
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameState_ResistanceFaction FactionState;
	local X2StrategyElementTemplateManager StratMgr;
	local XComGameState_Reward RewardState;
	local X2RewardTemplate RewardTemplate;

	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_FactionSoldier'));

	if (InStr(FactionName, "Faction_") != 0)
		FactionName = "Faction_" $ FactionName;

	if (FactionName != "Faction_Skirmishers" && FactionName != "Faction_Reapers" && FactionName != "Faction_Templars")
	{
		`Log("No faction found for name '" $ FactionName $ "'");
		return;
	}

	foreach History.IterateByClassType(class'XComGameState_ResistanceFaction', FactionState)
	{
		if (FactionState.GetMyTemplateName() == name(FactionName))
			break;
	}

	if (!FactionState.bMetXCom)
	{
		// Generate a Faction Soldier reward and give it to the player
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("CHEAT: MeetFaction");

		RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
		RewardState.GenerateReward(NewGameState, , FactionState.GetReference());
		RewardState.GiveReward(NewGameState);

		FactionState = XComGameState_ResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_ResistanceFaction', FactionState.ObjectID));
		FactionState.MeetXCom(NewGameState);
		FactionState.bSeenFactionHQReveal = bIgnoreRevealSequence;

		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}

	`HQPRES.DisplayNewStaffPopupIfNeeded();
}

// This is a DLCInfo hook added by the Community Highlander
static function WeaponInitialized(XGWeapon WeaponArchetype, XComWeapon Weapon, optional XComGameState_Item ItemState = none)
{
	local X2WeaponTemplate		WeaponTemplate;
	local XComGameState_Item	InternalWeaponState;
	local X2UnifiedProjectile	Proj;

	//`Log("IRIDAR Weapon Initialized triggered.", class'X2DownloadableContentInfo_WOTCUnderbarrelAttachments'.default.ENABLE_LOGGING, 'WOTCUnderbarrelAttachments');

	InternalWeaponState = ItemState;
	if (InternalWeaponState == none)
	{
		//`Log("IRIDAR InternalWeaponState is none.", class'X2DownloadableContentInfo_WOTCUnderbarrelAttachments'.default.ENABLE_LOGGING, 'WOTCUnderbarrelAttachments');
		InternalWeaponState = XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(WeaponArchetype.ObjectID));
	}

	WeaponTemplate = X2WeaponTemplate(InternalWeaponState.GetMyTemplate());

	if (WeaponTemplate.WeaponCat == 'psiamp')
	{
		Proj = X2UnifiedProjectile(`CONTENT.RequestGameArchetype("LW_PsiOverhaul.PJ_PsiPinion"));

		if (!IsProjectileElementPresent(Weapon.DefaultProjectileTemplate.ProjectileElements, Proj.ProjectileElements[0]))
		{
			//`Log("IRIDAR Adding projectiles to: " @ WeaponTemplate.DataName, class'X2DownloadableContentInfo_WOTCUnderbarrelAttachments'.default.ENABLE_LOGGING, 'WOTCUnderbarrelAttachments');
			Weapon.DefaultProjectileTemplate.ProjectileElements.AddItem(Proj.ProjectileElements[0]);
		}
		if (!IsProjectileElementPresent(Weapon.DefaultProjectileTemplate.ProjectileElements, Proj.ProjectileElements[1]))
		{
			//`Log("IRIDAR Adding projectiles to: " @ WeaponTemplate.DataName, class'X2DownloadableContentInfo_WOTCUnderbarrelAttachments'.default.ENABLE_LOGGING, 'WOTCUnderbarrelAttachments');
			Weapon.DefaultProjectileTemplate.ProjectileElements.AddItem(Proj.ProjectileElements[1]);
		}
	}
}
		
static function bool IsProjectileElementPresent(array<X2UnifiedProjectileElement> Haystack, X2UnifiedProjectileElement Needle)	// Thanks, Musashi-san!
{
    local X2UnifiedProjectileElement Element;
    
    foreach Haystack(Element)
    {
        if (Element.Comment == Needle.Comment)
        {
            return true;
        }
    }
    return false;
}

exec function DumpObjectInfo(int ObjectID)
{
	local XComGameStateHistory History;
	local XComGameState_BaseObject DumpObject;

	History = `XCOMHISTORY;

	DumpObject = History.GetGameStateForObjectID(ObjectID);
	class'Helpers'.static.OutputMsg("Object class: " $ DumpObject.Class $ ", template: " $ DumpObject.GetMyTemplateName());
	class'Helpers'.static.OutputMsg("Parent object ID: " $ DumpObject.OwningObjectId);
}

exec function DumpUnitInfo()
{
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;

	History = `XCOMHISTORY;
	foreach History.IterateByClassType(class'XComGameState_Unit', UnitState, eReturnType_Reference, true)
	{
		`LWTrace("=== Unit " $ UnitState.ObjectID $ " ===");
		`LWTrace("  Name: " $ UnitState.GetFullName());
		`LWTrace("  Unit template: " $ UnitState.GetMyTemplateName());
		`LWTrace("  Unit class: " $ UnitState.GetSoldierClassTemplateName());
	}

	class'Helpers'.static.OutputMsg("Unit information dumped to log");
}


static function LevelUpXTP(optional int Ranks = 1)
{
	local XComGameState NewGameState;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;
	local int idx, CurrentRank, NewRank, j;
	local XComGameState_LWXTP XTPState;

	XTPState = class'XComGameState_LWXTP'.static.GetXTPState();

	if (class'X2StrategyGameRulesetDataStructures'.static.LessThan(XTPState.NextUpdateTime, `STRATEGYRULES.GameTime))
	{
		History = `XCOMHISTORY;
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Rankup Soldiers XTP");
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
		XTPState = XComGameState_LWXTP(NewGameState.ModifyStateObject(class'XComGameState_LWXTP', XTPState.ObjectID));
		class'X2StrategyGameRulesetDataStructures'.static.AddDay(XTPState.NextUpdateTime);

		if(`XCOMHQ.SoldierUnlockTemplates.Find('XTP4') != -1)
		{
			NewRank = 5;
		}
		if(`XCOMHQ.SoldierUnlockTemplates.Find('XTP3') != -1)
		{
			NewRank = 4;
		}
		else if(`XCOMHQ.SoldierUnlockTemplates.Find('XTP2') != -1)
		{
			NewRank = 3;
		}
		else if(`XCOMHQ.SoldierUnlockTemplates.Find('XTP1') != -1)
		{
			NewRank = 2;
		}
		else
		{
			NewRank = 1;
		}
		
		for(idx = 0; idx < XComHQ.Crew.Length; idx++)
		{
			UnitState = XComGameState_Unit(History.GetGameStateForObjectID(XComHQ.Crew[idx].ObjectID));

			if(UnitState.IsActive())
			{
				if(UnitState != none && UnitState.IsSoldier() && UnitState.GetRank() < NewRank)
				{
					UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));

					if(NewRank >= class'X2ExperienceConfig'.static.GetMaxRank())
					{
						NewRank = (class'X2ExperienceConfig'.static.GetMaxRank());
					}
					CurrentRank = UnitState.GetRank();
					if(UnitState.GetSoldierClassTemplate().DataName != 'Rookie')
					{
						for (j = 0; j < NewRank - CurrentRank; j++)
						{
							
							UnitState.RankUpSoldier(NewGameState, UnitState.GetSoldierClassTemplate().DataName);
							
						}
					}
					UnitState.StartingRank = NewRank;

					UnitState.SetXPForRank(NewRank);
				}
			}

		}

		if( NewGameState.GetNumGameStateObjects() > 0 )
		{
			`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
		}
		else
		{
			History.CleanupPendingGameState(NewGameState);
		}

	}

}
