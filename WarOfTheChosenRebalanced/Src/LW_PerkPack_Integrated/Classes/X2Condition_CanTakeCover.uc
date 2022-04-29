
//---------------------------------------------------------------------------------------
//  FILE:    X2Condition_CanTakeCover.uc
//  AUTHOR:  Grobobobo
//  PURPOSE: Condition that specifies that target must be able to take cover
//---------------------------------------------------------------------------------------
class X2Condition_CanTakeCover extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{
	local XComGameState_Unit UnitState;

	UnitState = XComGameState_Unit(kTarget);

	if (UnitState != none)
	{
		if (UnitState.CanTakeCover())
		{
			return 'AA_Success'; 
		}
	}
	else return 'AA_NotAUnit';

	return 'AA_AbilityUnavailable';
}