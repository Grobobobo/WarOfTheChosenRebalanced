//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_AddAmmo.uc
//  AUTHOR:  Amineri (Pavonis Interactive)
//  PURPOSE: Effect adds a specified amount of charges to a specified ability
//---------------------------------------------------------------------------------------
class X2Effect_AddChargesToAbility extends X2Effect;

var int ExtraChargesAmount;
var name AbilityName;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit TargetUnit;
    local StateObjectReference  AbilityRef; 
    local XComGameState_Ability AbilityState, NewAbilityState;
   
	TargetUnit = XComGameState_Unit(kNewTargetState);
	if (TargetUnit != none)
	{
        AbilityRef = TargetUnit.FindAbility(AbilityName);
        if (AbilityRef.ObjectID != 0)
        {
            //`log("has overwatch ability",, 'NewEverVigilant');
            AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(AbilityRef.ObjectID));

            if (AbilityState != none)
            {
                NewAbilityState = XComGameState_Ability(NewGameState.ModifyStateObject(class'XComGameState_Ability', AbilityState.ObjectID));
                NewAbilityState.iCharges += ExtraChargesAmount;
            }
        }
	}
}
