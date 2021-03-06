//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_ManualOverride_LW.uc
//  AUTHOR:  martox
//  PURPOSE: Modified version of the base WOTC effect for Skirmisher's Manual Override
//           ability. This reduces the cooldown of all abilities on the targeted unit
//           by a configurable number of turns. If the reduction is greater than the
//           remaining cooldown on an ability, then that ability immediately becomes
//           available to use again.
//---------------------------------------------------------------------------------------
class X2Effect_ManualOverride_LW extends X2Effect config(LW_FactionBalance);

var config int OVERRIDE_REDUCTION;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameStateHistory History;
	local XComGameState_Unit UnitState;
	local XComGameState_Ability AbilityState;
	local int i;
    local XComGameState_Unit SourceUnit;
    local UnitValue CurrentHeatValue;
	
    SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	SourceUnit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, CurrentHeatValue);

	History = `XCOMHISTORY;
	UnitState = XComGameState_Unit(kNewTargetState);
	for (i = 0; i < UnitState.Abilities.Length; ++i)
	{
		AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(UnitState.Abilities[i].ObjectID));
		if (AbilityState != none && AbilityState.iCooldown > 0)
		{
			AbilityState = XComGameState_Ability(NewGameState.ModifyStateObject(AbilityState.Class, AbilityState.ObjectID));
			AbilityState.iCooldown = AbilityState.iCooldown - (default.OVERRIDE_REDUCTION + int(CurrentHeatValue.fValue / class'X2Ability_SkirmisherAbilitySet_LW'.default.MANUAL_OVERRIDE_COOLDOWN_REDUCTION_DIVISOR));
			if (AbilityState.iCooldown < 0)
			AbilityState.iCooldown = 0;
		}
	}
}
