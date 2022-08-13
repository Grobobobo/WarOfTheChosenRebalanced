class DoorHackingIndicator_GA extends Actor;

enum EAnimationState {
    eHidden,
    eGrowing,
    eShrinking,
    eFullyVisible
};

const ANIM_TIME = 0.2f;

var private StaticMeshComponent IndicatorMesh;

var private vector Position;

var private vector Scale3D;
var private EAnimationState AnimState;
var private float CurrentAnimTime;


public function Init(XComGameState_InteractiveObject DoorObject) {
    local XComInteractiveLevelActor DoorVisualizer;
    local int i;
    local vector Corner1,
                 Corner2;

    DoorVisualizer = XComInteractiveLevelActor(DoorObject.FindOrCreateVisualizer());
    IndicatorMesh.SetStaticMesh(StaticMesh(XComContentManager(class'Engine'.static.GetEngine().GetContentManager()).RequestGameArchetype("UI_3D.Hacking.Hacking_Door")));
    IndicatorMesh.SetRotation(DoorVisualizer.InteractPoints[0].Rotation); // Rotation of all elements is the same so just grab the first

    // Center icon on the door
    Corner1 = DoorVisualizer.InteractPoints[0].Location;
    Corner2 = DoorVisualizer.InteractPoints[0].Location;
    for(i = 1; i < DoorVisualizer.InteractPoints.Length; i++) {
        Corner1.X = FMin(Corner1.X, DoorVisualizer.InteractPoints[i].Location.X);
        Corner2.X = FMax(Corner2.X, DoorVisualizer.InteractPoints[i].Location.X);
        Corner1.Y = FMin(Corner1.Y, DoorVisualizer.InteractPoints[i].Location.Y);
        Corner2.Y = FMax(Corner2.Y, DoorVisualizer.InteractPoints[i].Location.Y);
    }
    Position = Corner1 + ((Corner2 - Corner1) / 2);

    Scale3D.Z = 0;
    Scale3D.X = 1;
    Scale3D.Y = 1;

    IndicatorMesh.SetScale3D(Scale3D);
    IndicatorMesh.SetTranslation(Position);
}

public function Show() {
    switch(AnimState) {
        case eHidden:
            IndicatorMesh.SetHidden(false);
            CurrentAnimTime = ANIM_TIME;
        case eShrinking:
            AnimState = eGrowing;
            CurrentAnimTime = ANIM_TIME - CurrentAnimTime;
    }
}

public function Hide() {
    switch(AnimState) {
        case eFullyVisible:
            CurrentAnimTime = ANIM_TIME;
        case eGrowing:
            AnimState = eShrinking;
            CurrentAnimTime = ANIM_TIME - CurrentAnimTime;
    }
}

simulated function Tick(float DeltaTime) {
    UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).ObjectiveIndicatorUtility.HideDefaultDoorHackingIndicators();

    if(AnimState == eFullyVisible || AnimState == eHidden) return;

    CurrentAnimTime += DeltaTime;

    Scale3D.Z = FMin(CurrentAnimTime / ANIM_TIME, 1);
    
    if(AnimState == eShrinking) {
        Scale3D.Z = 1 - Scale3D.Z;
    }
    IndicatorMesh.SetScale3D(Scale3D);

    if(Scale3D.Z == 0) {
        AnimState = eHidden;
        IndicatorMesh.SetHidden(true);
    } else if(Scale3D.Z == 1) {
        AnimState = eFullyVisible;
    }
}



defaultproperties
{
    Begin Object Class=StaticMeshComponent Name=IndicatorMeshComponentObject_01
        bOwnerNoSee=false
		CastShadow=true
        CanBlockCamera=false
        BlockRigidBody=false
        bDisableAllRigidBody=true
        bWasSNFiltered=false
		BlockNonZeroExtent=false
		BlockZeroExtent=false
        BlockActors=false
		CollideActors=false
		TranslucencySortPriority=0
		bTranslucentIgnoreFOW=false
		AbsoluteTranslation=true
		AbsoluteRotation=true
		Scale=1.0
	End Object
	IndicatorMesh=IndicatorMeshComponentObject_01
    Components.Add(IndicatorMeshComponentObject_01)
}