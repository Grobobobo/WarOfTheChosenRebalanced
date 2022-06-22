class X2TargetingMethod_RocketLauncher_Fixed extends X2TargetingMethod_RocketLauncher config(Game);

var config bool DisableHighlanderFix;

function Update(float DeltaTime)
{
	local XComWorldData World;
	local VoxelRaytraceCheckResult Raytrace;
	local array<Actor> CurrentlyMarkedTargets;
	local int Direction, CanSeeFromDefault;
	local UnitPeekSide PeekSide;
	local int OutRequiresLean;
	local TTile BlockedTile, PeekTile, UnitTile;
	local TTile TargetTile;   // Issue #617
	local bool GoodView;
	local CachedCoverAndPeekData PeekData;
	local array<TTile> Tiles;
	local GameRulesCache_VisibilityInfo OutVisibilityInfo;
	local vector TempLocation;
	NewTargetLocation = Cursor.GetCursorFeetLocation();
	NewTargetLocation.Z = GetOptimalZForTile(NewTargetLocation);

	TempLocation = FiringUnit.Location;
	TempLocation.Z += class'XComWorldData'.const.WORLD_FloorHeight;
	if( NewTargetLocation != CachedTargetLocation )
	{
		World = `XWORLD;
		GoodView = false;
		if( World.VoxelRaytrace_Locations(TempLocation, NewTargetLocation, Raytrace) )
		{
			BlockedTile = Raytrace.BlockedTile; 
			//  check left and right peeks
			FiringUnit.GetDirectionInfoForPosition(NewTargetLocation, OutVisibilityInfo, Direction, PeekSide, CanSeeFromDefault, OutRequiresLean, true);
			
			if (PeekSide != eNoPeek)
			{	
				UnitTile = World.GetTileCoordinatesFromPosition(FiringUnit.Location);
				PeekData = World.GetCachedCoverAndPeekData(UnitTile);
				if (PeekSide == ePeekLeft)
					PeekTile = PeekData.CoverDirectionInfo[Direction].LeftPeek.PeekTile;
				else
					PeekTile = PeekData.CoverDirectionInfo[Direction].RightPeek.PeekTile;

				// Start Issue #617
				//
				// Ray trace from the peek tile to the target, not from the unit tile to the peek tile.
				if(!DisableHighlanderFix)
				{
				TargetTile = World.GetTileCoordinatesFromPosition(NewTargetLocation);
				if (!World.VoxelRaytrace_Tiles(PeekTile, TargetTile, Raytrace))
					GoodView = true;
				else
					BlockedTile = Raytrace.BlockedTile;
				}
				else
				{
					if (!World.VoxelRaytrace_Tiles(PeekTile, UnitTile, Raytrace))
						GoodView = true;
					else
						BlockedTile = Raytrace.BlockedTile;
					
				}
				// End Issue #617
			}				
		}		
		else
		{
			GoodView = true;
		}

		if( !GoodView )
		{
			NewTargetLocation = World.GetPositionFromTileCoordinates(BlockedTile);
		}
		GetTargetedActors(NewTargetLocation, CurrentlyMarkedTargets, Tiles);
		CheckForFriendlyUnit(CurrentlyMarkedTargets);	
		MarkTargetedActors(CurrentlyMarkedTargets, (!AbilityIsOffensive) ? FiringUnit.GetTeam() : eTeam_None );
		DrawSplashRadius();
		DrawAOETiles(Tiles);
	}

	super.UpdateTargetLocation(DeltaTime);
}

function int GetOptimalZForTileForShooter(const vector VectorLocation)
{
	local XComWorldData					World;

	World = `XWORLD;
	return World.GetFloorZForPosition(VectorLocation) + class'XComWorldData'.const.WORLD_FloorHeight;
	

}

function int GetOptimalZForTile(const vector VectorLocation)
{
	local XComWorldData					World;
	local TTile							TileLocation;
	local array<StateObjectReference>	TargetsOnTile;

	World = `XWORLD;

	TileLocation = World.GetTileCoordinatesFromPosition(VectorLocation);
	TargetsOnTile = World.GetUnitsOnTile(TileLocation);

	//	If there's a unit on the tile, or the tile contains a high cover object
	if (TargetsOnTile.Length > 0 || World.IsLocationHighCover(VectorLocation))
	{
		//	then we aim at a point a floor above the tile (around soldier's waist-chest level)
		return World.GetFloorZForPosition(VectorLocation) + class'XComWorldData'.const.WORLD_FloorHeight;
	}
	else
	{
		//	if the tile contains low cover object, then we aim slightly above the floor
		if (World.IsLocationLowCover(VectorLocation))
		{
			return class'XComWorldData'.const.WORLD_HalfFloorHeight;
		}
		else
		{
			//	otherwise we aim at floor
			return World.GetFloorZForPosition(VectorLocation);
		}
	}
}
