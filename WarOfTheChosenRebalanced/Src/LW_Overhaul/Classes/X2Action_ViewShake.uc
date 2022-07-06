class X2Action_ViewShake extends X2Action;

/** Duration in seconds of shake */
var	private float Duration;
/** view rotation amplitude (pitch,yaw,roll) */
var	private vector RotAmplitude;
/** frequency of rotation shake */
var	private vector RotFrequency;
/** relative view offset amplitude (x,y,z) */
var	private vector LocAmplitude;
/** frequency of view offset shake */
var	private vector LocFrequency;
/** fov shake amplitude */
var	private float FOVAmplitude;
/** fov shake frequency */
var	private float FOVFrequency;

var bool bDoControllerVibration;

/** Radius within which to shake player views. If 0 only plays on the animated player */
var float ShakeRadius;

var CameraShake ShakeParams;

var vector ViewShakeOrigin;

function Init()
{
	super.Init();

	// Figure out world origin of view shake
	ViewShakeOrigin = Unit.Location;
	ShakeParams = new class'CameraShake';
	ShakeParams.Anim = CameraAnim(`CONTENT.RequestGameArchetype("CIN_CameraAnims.Shakes.Shake_Bang1"));
}

simulated state Executing
{
Begin:
	class'Camera'.static.PlayWorldCameraShake(ShakeParams, Unit, ViewShakeOrigin, 0.f, ShakeRadius, 1.f, bDoControllerVibration);
	CompleteAction();
}

defaultproperties
{
	ShakeRadius=4096.0
	Duration=1.f
	RotAmplitude=(X=100,Y=100,Z=200)
	RotFrequency=(X=10,Y=10,Z=25)
	LocAmplitude=(X=0,Y=3,Z=6)
	LocFrequency=(X=1,Y=10,Z=20)
	FOVAmplitude=2
	FOVFrequency=5
	bDoControllerVibration = true
}