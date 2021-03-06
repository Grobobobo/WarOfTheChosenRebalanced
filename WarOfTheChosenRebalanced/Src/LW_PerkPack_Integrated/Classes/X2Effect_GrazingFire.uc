//--------------------------------------------------------------------------------------- 
//  FILE:    X2Effect_GrazingFire
//  AUTHOR:  John Lumpkin (Pavonis Interactive)
//  PURPOSE: Sets up Grazing Fire -- enemy must make saving throw versus dodge to avoid
// being grazed on a miss
//--------------------------------------------------------------------------------------- 

class X2Effect_GrazingFire extends X2Effect_Persistent;

var int SuccessChance;

function bool ChangeHitResultForAttacker(XComGameState_Unit Attacker, XComGameState_Unit TargetUnit, XComGameState_Ability AbilityState, const EAbilityHitResult CurrentResult, out EAbilityHitResult NewHitResult)
{
	local int randroll;

		//`LOG ("Grazing Fire 2");
	if (AbilityState.GetSourceWeapon() == Attacker.GetItemInSlot(eInvSlot_PrimaryWeapon))
	{
		if (class'XComGameStateContext_Ability'.static.IsHitResultMiss(CurrentResult))
		{
			//`LOG ("Grazing Fire 3");
			RandRoll = `SYNC_RAND(100);
			if (Randroll <= SuccessChance)
			{
				//`LOG ("Grazing Fire 4");
				NewHitResult = eHit_Graze;
				return true;
			}
		}
	}
	return false;
}