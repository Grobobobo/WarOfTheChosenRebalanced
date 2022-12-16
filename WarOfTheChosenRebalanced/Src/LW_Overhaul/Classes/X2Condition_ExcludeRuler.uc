class X2Condition_ExcludeRuler extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget) 
{ 
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(kTarget);
	if(class'LWDLCHelpers'.static.IsAlienRuler(TargetUnit.GetMyTemplateName()))
		return 'AA_UnitIsImmune';

	return 'AA_Success'; 
}
