class X2Action_Reveal extends X2Action;

event bool BlocksAbilityActivation()
{
	return false;
}

function Init()
{
	super.Init();
}

simulated function Reveal()
{
	local MaterialInstanceTimeVarying MITV;

	MITV = MaterialInstanceTimeVarying(DynamicLoadObject("FX_Templar_Ghost.M_Ghost_Character_Reveal_MITV", class'MaterialInstanceTimeVarying'));
	UnitPawn.ApplyMITV(MITV);
}

simulated state Executing
{
	
Begin:
	UnitPawn.CleanUpMITV();
	Reveal();
	Sleep(1.0f);
	UnitPawn.CleanUpMITV();
	CompleteAction();
}

