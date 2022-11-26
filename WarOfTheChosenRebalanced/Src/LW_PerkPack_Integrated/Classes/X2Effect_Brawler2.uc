//--------------------------------------------------------------------------------------- 
//  FILE:    X2Effect_Brawler2
//  AUTHOR:  Grobobobo
//  PURPOSE: Sets up Damage reduction for the new brawler
//---------------------------------------------------------------------------------------
class X2Effect_Brawler2 extends X2Effect_Persistent config (LW_SoldierSkills);

var float DRPerTile;
var float MaxDR;

function float GetPostDefaultDefendingDamageModifier_CH(
	XComGameState_Effect EffectState,
	XComGameState_Unit Attacker,
	XComGameState_Unit Target,
	XComGameState_Ability AbilityState,
	const out EffectAppliedData AppliedData,
	float CurrentDamage,
	X2Effect_ApplyWeaponDamage WeaponDamageEffect,
	XComGameState NewGameState)
{
	local int Tiles;
	local float TilesPenalty;
	local float DamageReduction;
	local float DrPenalty;

	Tiles = Attacker.TileDistanceBetween(Target);

	TilesPenalty = AbilityState.IsMeleeAbility()? 0 : Max(Tiles-1,0);

	DrPenalty = TilesPenalty * DRPerTile;

	DamageReduction = (MaxDR - DrPenalty) > 0 ? MaxDR - DrPenalty : 0.0f;

    return -CurrentDamage * DamageReduction;
}


function float GetPostDefaultAttackingDamageModifier_CH(
	XComGameState_Effect EffectState,
	XComGameState_Unit SourceUnit,
	Damageable Target,
	XComGameState_Ability AbilityState,
	const out EffectAppliedData ApplyEffectParameters,
	float WeaponDamage,
	X2Effect_ApplyWeaponDamage WeaponDamageEffect,
	XComGameState NewGameState)
{
	local int Tiles;
	local float TilesPenalty;
	local float DamageIncrease;
	local float DamagePenalty;
	local XComGameState_Unit TargetUnit;

	TargetUnit = XComGameState_Unit(Target);
	if (AbilityState.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef && TargetUnit != none) 
	{
		Tiles = SourceUnit.TileDistanceBetween(TargetUnit);

		TilesPenalty = AbilityState.IsMeleeAbility()? 0 : Max(Tiles-1,0);

		DamagePenalty = TilesPenalty * DRPerTile;

		DamageIncrease = (MaxDR - DamagePenalty) > 0 ? MaxDR - DamagePenalty : 0.0f;
    }

	return WeaponDamage * DamageIncrease;
}
defaultproperties
{
	DuplicateResponse=eDupe_Ignore
	EffectName="Brawler2"
	bDisplayInSpecialDamageMessageUI=false
}
