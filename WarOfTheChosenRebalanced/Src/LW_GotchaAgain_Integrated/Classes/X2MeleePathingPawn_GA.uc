class X2MeleePathingPawn_GA extends X2MeleePathingPawn;

// We do this elsewhere in order to properly handle conflicts with our new markers
function UpdatePathMarkers() {
    if(!class'LW_GotchaAgain_IntegratedSettings'.default.bUseCustomPathIndicatorSystem) {
        super.UpdatePathMarkers();
    }
}

// This override passes the entire PathingPawn instead of just the destination tile to the UnitFlagManager in order to create the path-indicators from there
// Requires pretty much all variables used in here to be changed from private to protected in order to compile
simulated function UpdatePathTileData() {
	if(LastActiveUnit != none ) {
		class'X2TacticalVisibilityHelpers'.static.FillPathTileData(LastActiveUnit.ObjectID, PathTiles, PathTileData);
		if(ShowLOSPreview) {
            UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).RealizePreviewMovementAndLOS(self);
		}
	}
}

