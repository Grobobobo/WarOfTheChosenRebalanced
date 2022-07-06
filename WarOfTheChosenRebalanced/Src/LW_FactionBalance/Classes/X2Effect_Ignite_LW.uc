class X2Effect_Ignite_LW extends X2Effect;


simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
    local XComGameState_Unit				SourceUnit;
	local UnitValue							MaxHeatValue;
	//local int								iValue;

    SourceUnit = XComGameState_Unit(kNewTargetState);
	SourceUnit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_MAX_NAME, MaxHeatValue);

	SourceUnit.SetUnitFloatValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, MaxHeatValue.fValue, eCleanup_BeginTactical);

}