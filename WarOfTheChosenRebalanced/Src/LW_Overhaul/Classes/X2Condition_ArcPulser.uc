class X2Condition_ArcPulser extends X2Condition;

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource) 
{
	local XComGameState_Unit	Target, Source;
	local int					Range;

	Target = XComGameState_Unit(kTarget);
	Source = XComGameState_Unit(kSource);

	if ( Target != none && Source != none )
	{
		
		if ( Source.HasSoldierAbility('EMPulser') )
		{
			return 'AA_Success';
		}

		return 'AA_UnitIsRobotic';
	}

	return 'AA_NotAUnit';
}