class YAF1_InfoScreenStyleTemplate extends X2StrategyElementTemplate config(UI);

// for stat images and ui elements
var config string PrimaryColor;
// for small text like item descriptions
var config string TextColor;
// for ability and effect headers
var config string HeaderColor;
// icons
var config string AbilityIconColor;
var config string PassiveIconColor;
var config string BuffIconColor;
var config string DebuffIconColor;

// if the unit is of this character group, apply this template
// match scores 1 << 1 = 2
var config array<name> ApplyToCharacterGroup;
// if the unit has one of these abilities, apply the template
// match scores 1 << 2 = 4
var config array<name> RequireAbility;
// if the unit is of this Character Template, apply template
// match scores 1 << 3 = 8
var config array<name> ApplyToCharacterTemplate;

// by default, templates fail on friendly units
var config bool RequireFriendly;
var config bool RequireEnemy;



function bool ScoreTarget(XComGameState_BaseObject TargetState, bool Friendly, out int Score)
{
	local int i;
	local bool hasAbility;
	local XComGameState_Unit Unit;
	
	Score = 0;
	if ((RequireFriendly && !Friendly) || (RequireEnemy && Friendly))
	{
		return false;
	}
	
	// Tiebreaker
	if ((RequireFriendly && Friendly) || (RequireEnemy && !Friendly))
	{
		Score += 1 << 0;
	}

	Unit = XComGameState_Unit(TargetState);

	if (Unit != none)
	{
		if (ApplyToCharacterGroup.Length > 0)
		{
			if (ApplyToCharacterGroup.Find(Unit.GetMyTemplate().CharacterGroupName) != INDEX_NONE)
			{
				Score += 1 << 1;
			}
			else
			{
				return false;
			}
		}
		hasAbility = false;
		for (i = 0; i < RequireAbility.Length; i++)
		{
			if (Unit.HasSoldierAbility(RequireAbility[i]))
			{
				Score += 1 << 2;
				hasAbility = true;
				break;
			}
		}
		if (RequireAbility.Length > 0 && !hasAbility)
		{
			return false;
		}
		if (ApplyToCharacterTemplate.Length > 0)
		{
			if (ApplyToCharacterTemplate.Find(Unit.GetMyTemplateName()) != INDEX_NONE)
			{
				Score += 1 << 3;
			}
			else
			{
				return false;
			}
		}
	}

	return true;
}
