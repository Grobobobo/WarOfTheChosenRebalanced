class X2Condition_RipAndTearRupture_LW extends X2Condition;


event name CallAbilityMeetsCondition(XComGameState_Ability kAbility, XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit	SourceUnit;
	local UnitValue				CurrentHeatValue;

	SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));

	// Source must have required Heat
	SourceUnit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, CurrentHeatValue);
	if (CurrentHeatValue.fValue < class'X2Ability_SkirmisherAbilitySet_LW'.default.HEAT_LEVEL_THRESHOLD_II)
		return 'AA_CannotAfford_Focus';


	return 'AA_Success';
}