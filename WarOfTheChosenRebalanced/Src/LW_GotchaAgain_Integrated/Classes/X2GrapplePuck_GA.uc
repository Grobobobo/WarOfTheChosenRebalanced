class X2GrapplePuck_GA extends X2GrapplePuck;

var private vector LastLOSLocation;

simulated event Tick(float DeltaTime) {
    local vector GrappleTargetLocation;
    local GameplayTileData MoveToTileData;
    local UIUnitFlagManager_GA UnitFlagManager;

    super.Tick(DeltaTime);

    // If this is not enabled, just return and skip updating the LOS indicators
    if(!class'LW_GotchaAgain_IntegratedSettings'.default.bShowLOSIndicatorsForGrappleDestinations) {
        return;
    }

    // If a valid grapplelocation exists and a new one is selected, update LOS indicators based on it
    if(GetGrappleTargetLocation(GrappleTargetLocation) && GrappleTargetLocation != LastLOSLocation) {
        // Gotcha Agains overridden RealizePreviewEndOfMoveLOS does not use all fields of the GameplayTileData parameter, so we only fill what is needed
        MoveToTileData.SourceObjectID = XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).ControllingUnit.ObjectID;
        MoveToTileData.EventTile = class'XComWorldData'.static.GetWorldData().GetTileCoordinatesFromPosition(GrappleTargetLocation);
        
        UnitFlagManager = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager);

        UnitFlagManager.GrappleIsActive = true;
        UnitFlagManager.RealizePreviewEndOfMoveLOS(MoveToTileData);
        UnitFlagManager.GrappleIsActive = false;

        LastLOSLocation = GrappleTargetLocation;
    }
}