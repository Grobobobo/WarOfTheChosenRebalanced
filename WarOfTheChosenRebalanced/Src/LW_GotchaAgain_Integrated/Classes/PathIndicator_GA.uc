class PathIndicator_GA extends Actor;

// Order matters and corresponds to their position in the texturearrays.
// Custom texturearrays cannot be used without noseekfreeloading, so we don't use them and order actually doesn't matter anymore
// Standard indicators are defined in DefaultGameCore.ini / XComGameCore.ini
// PathIndicatorUtility_GA handles assignment of non-standard indicators (activation, overwatch, PSI bomb).
enum EIndicatorType {
    eNone,
    eMoveThroughAcid,
    eMoveThroughPoison,
    eMoveThroughFire,
    eMoveThroughSmoke,
    eMakeNoise,
    eBreakConceal,
    eHunterShot, // WOTC - Hunter's Mark Tracking Shot
    eTriggerActivation,
    eTriggerOverwatch,
    ePsiBomb,
};

enum EWaypointUpdateMode {
    eNoUpdate,
    eCreate,
    eRemove,
};

var private StaticMeshComponent IndicatorMesh;
var private MaterialInstanceConstant MIC;

var private vector Position;

public function Init(TTile Tile,
                     array<EIndicatorType> IndicatorTypes,
                     EWaypointUpdateMode WaypointMode) {
    local int i;

    IndicatorMesh.SetStaticMesh(StaticMesh(XComContentManager(class'Engine'.static.GetEngine().GetContentManager()).RequestGameArchetype("UILibrary_GA.PathIndicators.WaypointStatus")));
    
    Position = class'XComWorldData'.static.GetWorldData().GetPositionFromTileCoordinates(Tile);
    Position.Z = class'XComWorldData'.static.GetWorldData().GetFloorZForPosition(Position) + XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).m_kPathingPawn.PathHeightOffset;
    IndicatorMesh.SetTranslation(Position);
    
    MIC = GetMIC(IndicatorMesh, 1);
    
    for(i = 0; i < IndicatorTypes.Length; i++) {
        switch(i) {
            case 0:
                MIC.SetScalarParameterValue('FirstStatusIndex', IndicatorTypes[i]);
                break;
            case 1:
                MIC.SetScalarParameterValue('SecondStatusIndex', IndicatorTypes[i]);
                break;
            case 2:
                MIC.SetScalarParameterValue('ThirdStatusIndex', IndicatorTypes[i]);
                break;
        }
    }

    UpdateWaypointMode(WaypointMode);

    IndicatorMesh.SetHidden(false);
}

public function UpdateWaypointMode(EWaypointUpdateMode WaypointMode) {
    MIC.SetScalarParameterValue('WaypointStatusIndex', WaypointMode);
}


private function MaterialInstanceConstant GetMIC(StaticMeshComponent Mesh, optional int MICIndex = 0) {
    local MaterialInstanceConstant currentMIC,
                                   newMIC;

    // Creates a new MIC to avoid changing all indicators
    currentMIC = MaterialInstanceConstant(Mesh.GetMaterial(MICIndex));
	newMIC = new (self) class'MaterialInstanceConstant';
	newMIC.SetParent(currentMIC);
	Mesh.SetMaterial(MICIndex, newMIC);
    return newMIC;
}


defaultproperties
{
    Begin Object Class=StaticMeshComponent Name=IndicatorMeshComponentObject_01
        bOwnerNoSee=false
		CastShadow=false
		BlockNonZeroExtent=false
		BlockZeroExtent=false
        BlockActors=false
		CollideActors=false
		TranslucencySortPriority=10000
		bTranslucentIgnoreFOW=true
		AbsoluteTranslation=true
		AbsoluteRotation=true
		Scale=1.0
	End Object
	IndicatorMesh=IndicatorMeshComponentObject_01
    Components.Add(IndicatorMeshComponentObject_01)
}