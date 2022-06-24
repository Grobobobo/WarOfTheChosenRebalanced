//---------------------------------------------------------------------------------------
//  FILE:    LWTacticalMissionUnitSpawner
//  AUTHOR:  tracktwo (Pavonis Interactive)
//
//  PURPOSE: Handles spawning of units not in the main XCOM squad in tactical missions.
//           Primarily: rebels, resistance mecs, liaisons.
//--------------------------------------------------------------------------------------- 

class LWTacticalMissionUnitSpawner extends Object config(LW_Overhaul);

var config array<float> arrEncounterZoneWidths;
var config array<float> arrEncounterZoneOffsetsAlongLOP;

var config int RebelCapOnRetals;
var config int MecCap;

var config int MinCivilianSpawnDistanceSq;
var config int MaxCivilianSpawnDistanceSq;

static function SpawnUnitsForMission(XComGameState_MissionSite Mission)
{
	local XComGameStateHistory History;

		switch (class'Utilities_LW'.static.CurrentMissionType())
		{
		case "CovertEscape_LW":
		case "CovertEscape_NonPCP_LW":
			LoadCovertOperatives(Mission);
			break;
		}
	
}

static function array<XComGroupSpawn> GetCivilianSpawnLocations()
{
	local XComGameState_BattleData BattleData;
	local array<XComGroupSpawn> SpawnPoints;
	local XComGroupSpawn Spawn;
	local Vector XComSpawnLocation;
	local float SpawnDistance;
	local int i;

	foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'XComGroupSpawn', Spawn)
	{
		SpawnPoints.AddItem(Spawn);
	}

	BattleData = XComGameState_BattleData(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	XComSpawnLocation = BattleData.MapData.SoldierSpawnLocation;

	`Log("Found " $ SpawnPoints.Length $ " spawn possibilities");
	// Filter the spawn point list to those within appropriate distances.
	for (i = SpawnPoints.Length - 1; i >= 0; --i)
	{
		SpawnDistance = VSizeSq(SpawnPoints[i].Location - XComSpawnLocation);
		if (SpawnDistance < default.MinCivilianSpawnDistanceSq || SpawnDistance > default.MaxCivilianSpawnDistanceSq)
		{
			SpawnPoints.Remove(i, 1);
		}
	}

	`Log(SpawnPoints.Length $ " spawn possibilities remain after distance filter");
	return SpawnPoints;
}

static  function bool IsValidSpawnTile(TTile Tile)
{
	local XComWorldData WorldData;
	local TileData TData;

	WorldData = `XWORLD;

	// Must be in bounds on the map
	if (WorldData.IsTileOutOfRange(Tile))
	{
		return false;
	}

	// Can't already be occupied
	if (WorldData.IsTileFullyOccupied(Tile))
	{
		return false;
	}

	// No hazards
	if (WorldData.TileContainsPoison(Tile) || WorldData.TileContainsFire(Tile) || WorldData.TileContainsAcid(Tile))
	{
		return false;
	}

	// Heuristic to avoid civvies standing around on top of vans in terror missions. Only allow placement above the
	// ground floor if the tile has any cover.
	WorldData.GetTileData(Tile, TData);
	if (!WorldData.IsGroundTile(Tile) && 
		(TData.CoverFlags & (class'XComWorldData'.const.COVER_DIR_ANY | class'XComWorldData'.const.COVER_LOW_ANY)) == 0)
	{
		return false;
	}

	return true;
}

static function array<TTile> PickSpawnTiles(array<XComGroupSpawn> SpawnPoints, int Count)
{
	local int SpawnIndex;
	local int x, y;
	local TTile Candidate;
	local XComWorldData WorldData;
	local array<TTile> SpawnTiles;

	WorldData = `XWORLD;
	`Log("Choosing " $ Count $ " spawn points out of " $ SpawnPoints.Length $ " candidates");
	SpawnIndex = 0;
	// Start in the corner of the spawn zone. We'll move through the zone and put multiple civs
	// in the same spawn if we run out of valid spawns before we place all the civs.
	x = -1;
	y = -1;

	while (Count >= 0)
	{
		// Find our candidate tile and add the current offset values to it.
		WorldData.GetFloorTileForPosition(SpawnPoints[SpawnIndex].Location, Candidate, true);
		Candidate.X += x;
		Candidate.Y += y;

		// Check if this tile is in a "good" place.
		if (IsValidSpawnTile(Candidate))
		{
			// It's good. Add it to our list and reduce the number of civvies left to place.
			`Log("Using spawn tile " $ Candidate.X $ " " $ Candidate.Y);
			SpawnTiles.AddItem(Candidate);
			--Count;
		}

		// Move to the next spawn point on our list, cycling back to the beginning and updating
		// the offsets if we run off the end. It'd probably be better to use a more spread out
		// system instead of just incrementing the offsets so the civs don't spawn right next to
		// each other when they get doubled up, but this should ideally be rare.
		if (++SpawnIndex >= SpawnPoints.Length)
		{
			SpawnIndex = 0;
			if (++x > 1)
			{
				x = -1;
				if (++y > 1)
				{
					// We hit the end of the spawn box - no candidates left.
					return SpawnTiles;
				}
			}
		}
	}

	return SpawnTiles;
}


static function bool IsVisibleToAI(out TTile Tile)
{
	local XComGameState_Unit Viewer;
	local XComGameStateHistory History;
	local X2GameRulesetVisibilityManager VisibilityMgr;
	local array<GameRulesCache_VisibilityInfo> VisibilityInfos;
	local int i;

	History = `XCOMHISTORY;
	VisibilityMgr = `TACTICALRULES.VisibilityMgr;

	VisibilityMgr.GetAllViewersOfLocation(Tile, VisibilityInfos, class'XComGameState_Unit');

	for (i = VisibilityInfos.Length - 1; i >= 0; --i)
	{
		if(VisibilityInfos[i].bVisibleBasic)
		{
			Viewer = XComGameState_Unit(History.GetGameStateForObjectID(VisibilityInfos[i].SourceID));

			//Remove non-enemies from the list
			if(Viewer == none || Viewer.GetTeam() != eTeam_Alien)
			{
				VisibilityInfos.Remove(I, 1);
			}
			else if (!Viewer.IsAlive( ))
			{
				VisibilityInfos.Remove( I, 1 );
			}
		}
		else
		{
			VisibilityInfos.Remove(i, 1);
		}
	}

	return VisibilityInfos.Length > 0;
}

// Loads any covert action operatives into the given Ambush mission.
// Mostly based on `XCGS_MissionSiteChosenAmbush.SelectSquad()`.
static function LoadCovertOperatives(XComGameState_MissionSite MissionState)
{
	local XComGameStateHistory                     History;
	local XComWorldData                            WorldData;
	local XComGameState_BattleData                 BattleDataState;
	local XComGameState_CovertAction               ActionState;
	local XComGameState_MissionSiteChosenAmbush_LW AmbushMissionState;
	local XComGameState_StaffSlot                  SlotState;
	local array<StateObjectReference>              MissionSoldiers;
	local StateObjectReference                     SoldierRef;
	local TTile                                    RootTile, Tile;
	local int                                      idx;
	
	History = `XCOMHISTORY;
	WorldData = `XWORLD;
	BattleDataState = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	AmbushMissionState = XComGameState_MissionSiteChosenAmbush_LW(MissionState);
	ActionState = XComGameState_CovertAction(History.GetGameStateForObjectID(AmbushMissionState.CovertActionRef.ObjectID));

	// We want to spawn the covert operatives near the objective.
	WorldData.GetFloorTileForPosition(BattleDataState.MapData.ObjectiveLocation, RootTile);

	for (idx = 0; idx < ActionState.StaffSlots.Length; idx++)
	{
		// If the Covert Action has a soldier in one of its staff slots, add them to the Ambush soldier list
		SlotState = ActionState.GetStaffSlot(idx);
		if (SlotState != none && SlotState.IsSoldierSlot() && SlotState.IsSlotFilled())
		{
			MissionSoldiers.AddItem(SlotState.GetAssignedStaffRef());
		}
	}

	foreach MissionSoldiers(SoldierRef)
	{
		Tile = RootTile;
		if (class'Utilities_LW'.static.GetSpawnTileNearTile(Tile, 3, 8))
		{
			class'LWSpawnUnitFromAvenger'.static.AddStrategyUnitToBoardAtLocation(
				XComGameState_Unit(History.GetGameStateForObjectID(SoldierRef.ObjectID)),
				History,
				WorldData.GetPositionFromTileCoordinates(Tile));
		}
	}
}


static function CreateNewCivilianUnits()
{
	local name CharacterTemplateName;
	local StateObjectReference NewUnitRef;
	local XComAISpawnManager SpawnManager;
	local UIUnitFlag UnitFlag;
	local int i;

	SpawnManager = `SPAWNMGR;

	for (i = 0; i < 13; ++i)
	{
		CharacterTemplateName = `SYNC_RAND_STATIC(10) == 0 ? 'FacelessRebel' : 'Rebel';
		NewUnitRef = SpawnManager.CreateUnit(GetPositionForCivilian(i), 
											CharacterTemplateName, 
											eTeam_Neutral, 
											false,
											false);
		UnitFlag = `PRES.m_kUnitFlagManager.GetFlagForObjectID(NewUnitRef.ObjectID);
		UnitFlag.Hide();
		`PRES.m_kUnitFlagManager.RemoveFlag(UnitFlag);
		UnitFlag.Destroy();
	}
}

// For the recruit raid mission, we need to override the globally disabled evac ability
// on all rebel units.
static function GiveEvacAbilityToRebels()
{
	local XComGameState_Unit Unit;
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameState_Unit NewUnit;

	History = `XCOMHISTORY;
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Enable Evac on Rebels");

	foreach History.IterateByClassType(class'XComGameState_Unit', Unit)
	{
		if (Unit.GetMyTemplateName() == 'RebelSoldierProxy' || Unit.GetMyTemplateName() == 'RebelSoldierProxyM2' || Unit.GetMyTemplateName() == 'RebelSoldierProxyM3')
		{
			NewUnit = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', Unit.ObjectID));
			NewUnit.EnableGlobalAbilityForUnit('Evac');
			NewGameState.AddStateObject(NewUnit);
		}
	}

	if (NewGameState.GetNumGameStateObjects() > 0)
	{
		`TACTICALRULES.SubmitGameState(NewGameState);
	}
	else
	{
		History.CleanupPendingGameState(NewGameState);
	}
}

static function Vector GetPositionForCivilian(int i)
{
	local EncounterZone MyEncounterZone;
	local XComAISpawnManager SpawnManager;
	local XComTacticalMissionManager MissionManager;
	local MissionSchedule ActiveMissionSchedule;
	local XComGameStateHistory History;
	local float MyEncounterZoneDepth;
	local XComGameState_BattleData BattleData;
	local Vector XComLocation;
	local Vector SpawnPosition;

	SpawnManager = `SPAWNMGR;
	MissionManager = `TACTICALMISSIONMGR;
	History = `XCOMHISTORY;

	MissionManager.GetActiveMissionSchedule(ActiveMissionSchedule);
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));

	XComLocation = SpawnManager.GetCurrentXComLocation();
	MyEncounterZoneDepth = ActiveMissionSchedule.EncounterZonePatrolDepth;

	if (i >= default.arrEncounterZoneWidths.Length)
	{
		i = i % default.arrEncounterZoneWidths.Length;
	}

	if (i >= default.arrEncounterZoneOffsetsAlongLOP.Length)
	{
		i = i % default.arrEncounterZoneOffsetsAlongLOP.Length;
	}

	MyEncounterZone = SpawnManager.BuildEncounterZone(
		BattleData.MapData.ObjectiveLocation,
		XComLocation,
		MyEncounterZoneDepth,
		default.arrEncounterZoneWidths[i],
		/*MyEncounterZoneOffsetFromLOP*/ 0.0f,
		default.arrEncounterZoneOffsetsAlongLOP[i],
		'');

	// Choose a random position within the encounter zone bounding box.
	SpawnPosition = class'XComAISpawnmanager'.static.CastVector(MyEncounterZone.Origin);
	SpawnPosition.X += `SYNC_RAND_STATIC(int(MyEncounterZone.SideA.X) - int(MyEncounterZone.Origin.X));
	SpawnPosition.Y += `SYNC_RAND_STATIC(int(MyEncounterZone.SideB.Y) - int(MyEncounterZone.Origin.Y));
	return SpawnPosition;
}

static function bool GetTileForCivilian(int i, out TTile UnitTile)
{
	local XComWorldData WorldData;
	local Vector Position;
	local int j;

	WorldData = `XWORLD;

	for (j = 0; j < default.arrEncounterZoneWidths.Length; ++j)
	{
		Position = GetPositionForCivilian(i + j);
		WorldData.GetFloorTileForPosition(Position, UnitTile);
		if (class'Utilities_LW'.static.GetSpawnTileNearTile(UnitTile, 3, 9))
		{
			return true;
		}
	}

	if (j == default.arrEncounterZoneWidths.Length)
	{
		`redscreen("Failed to find a valid position for civilian " $ i $ " in any encounter zone!");
		return false;
	}
}

static function bool FindSpawnTile(out TTile SpawnLocation)
{
	local XComGroupSpawn SoldierSpawn;
	local array<Vector> FloorPoints;
	local XComWorldData World;

	World = `XWORLD;

	foreach `XComGRI.AllActors(class'XComGroupSpawn', SoldierSpawn)
	{
		FloorPoints.Length = 0;
		SoldierSpawn.GetValidFloorLocations(FloorPoints);
		if(FloorPoints.Length > 0)
		{
			World.GetFloorTileForPosition(FloorPoints[0], SpawnLocation);
			if (!IsVisibleToAI(SpawnLocation))
				return true;
		}
	}

	`Redscreen("Failed to find a valid spawn tile");
	return false;

}
