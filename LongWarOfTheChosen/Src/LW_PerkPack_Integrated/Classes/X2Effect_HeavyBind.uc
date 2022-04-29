//--------------------------------------------------------------------------------------- 
//  FILE:    X2Effect_HeavyBind
//  AUTHOR:  Grobobobo
//  PURPOSE: Sets up armor  bonuses for Heavy Bind template definition
//---------------------------------------------------------------------------------------
class X2Effect_HeavyBind extends X2Effect_BonusArmor;

var int BonusArmor;

function int GetArmorMitigation(XComGameState_Effect EffectState, XComGameState_Unit UnitState)
{
	if (UnitState.AffectedByEffectNames.Find(class'X2Ability_Viper'.default.BindSustainedEffectName) != INDEX_NONE)
	{
	    return BonusArmor;		
	}
	return 0;
}
	
defaultproperties
{
    DuplicateResponse=eDupe_Ignore
    EffectName="HeavyBind"
}