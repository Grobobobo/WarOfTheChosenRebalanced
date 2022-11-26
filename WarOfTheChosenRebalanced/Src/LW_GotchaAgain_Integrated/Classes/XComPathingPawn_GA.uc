class XComPathingPawn_GA extends XComPathingPawn;

var private bool AlreadySearched;
var private bool PerfectInformationFound;


// This is done elsewhere in order to properly handle conflicts with our new markers
function UpdatePathMarkers() {
    if(!class'LW_GotchaAgain_IntegratedSettings'.default.bUseCustomPathIndicatorSystem) {
        super.UpdatePathMarkers();
    }
}


// This override passes the entire PathingPawn instead of just the destination tile to the UnitFlagManager in order to create the path-indicators from there
// Requires pretty much all variables used in here to be changed from private to protected in order to compile
simulated function UpdatePathTileData() {
	local XComPresentationLayer Pres;
	local array<StateObjectReference> ObjectsVisibleToPlayer;

	if(LastActiveUnit != none ) {
		class'X2TacticalVisibilityHelpers'.static.FillPathTileDataAndVisibleObjects(LastActiveUnit.ObjectID, PathTiles, PathTileData, ObjectsVisibleToPlayer, true);
		if(ShowLOSPreview) {
			Pres = `PRES;
			UITacticalHUD_EnemyPreview(Pres.m_kTacticalHUD.m_kEnemyPreview).UpdatePreviewTargets(PathTileData[PathTileData.Length - 1], ObjectsVisibleToPlayer);
            UIUnitFlagManager_GA(Pres.m_kUnitFlagManager).RealizePreviewMovementAndLOS(self);
		}
	}
}
