class X2Action_Conceal extends X2Action;

event bool BlocksAbilityActivation()
{
	return false;
}

function Init()
{
	super.Init();
}

simulated function ApplyMITV(String MITVPath)
{
	local MaterialInstanceTimeVarying	MITV;

	MITV = MaterialInstanceTimeVarying(DynamicLoadObject(MITVPath, class'MaterialInstanceTimeVarying'));
	UnitPawn.ApplyMITV(MITV);
}

simulated state Executing
{
	
Begin:
	ApplyMITV("FX_Templar_Ghost.M_Ghost_Character_Dissolve_MITV");
	Sleep(0.5f);
	//ApplyMITV("InvisibleEffect.Invisible_MITV");
	ApplyMITV("InvisibleEffectLiquid.M_Stream_Distort_Flowing_MITV");

	CompleteAction();
}

