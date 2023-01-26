class X2Condition_VariableRange extends X2Condition;

struct BonusRange{
	var name	BonusAbility;
	var int		RangeBonus;
};

var int Range;
var array<BonusRange> BonusRanges;

function AddBonusRange(name AbilityName, int RangeBonus)
{
	local BonusRange Bonus;

	Bonus.BonusAbility = AbilityName;
	Bonus.RangeBonus = RangeBonus;
	BonusRanges.AddItem(Bonus);
}


event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource) 
{
	local XComGameState_Unit	Target, Source;
	local int					CheckRange;
	local BonusRange			CheckBonus;

	Target = XComGameState_Unit(kTarget);
	Source = XComGameState_Unit(kSource);

	if ( Target != none && Source != none )
	{

		CheckRange = Range;

		foreach BonusRanges(CheckBonus)
		{
			if ( Source.HasSoldierAbility(CheckBonus.BonusAbility) ) { CheckRange += CheckBonus.RangeBonus; }
		}
		
		if ( Source.TileDistanceBetween(Target) <= CheckRange )
		{
			return 'AA_Success';
		}

		return 'AA_NotInRange';
	}

	return 'AA_NotAUnit';
}