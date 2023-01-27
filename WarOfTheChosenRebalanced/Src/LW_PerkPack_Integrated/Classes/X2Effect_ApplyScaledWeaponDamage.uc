//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_DoubleDamage.uc
//  AUTHOR:  Amineri (Pavonis Interactive)
//  PURPOSE: Effect that applies double the weapon's base damage
//---------------------------------------------------------------------------------------
class X2Effect_ApplyScaledWeaponDamage extends X2Effect_ApplyWeaponDamage;

var float Scalar;

simulated function bool ModifyDamageValue(out WeaponDamageValue DamageValue, Damageable Target, out array<Name> AppliedDamageTypes)
{
	local WeaponDamageValue EmptyDamageValue;
	local bool bIsImmune;
	
	bIsImmune = false;

	if( Target != None )
	{
		if( Target.IsImmuneToDamage(DamageValue.DamageType) )
		{
			`log("Target is immune to damage type" @ DamageValue.DamageType $ "!", true, 'XCom_HitRolls');
			DamageValue = EmptyDamageValue;
			bIsImmune = true;
		}
		else if( AppliedDamageTypes.Find(DamageValue.DamageType) == INDEX_NONE )
		{
			AppliedDamageTypes.AddItem(DamageValue.DamageType);
		}
	}
	
	DamageValue.Damage = int(DamageValue.Damage * Scalar);
	DamageValue.Crit *= int(DamageValue.Crit * Scalar);
	DamageValue.Spread *= int(DamageValue.Spread * Scalar);
	DamageValue.Pierce *= int(DamageValue.Pierce * Scalar);
	DamageValue.Shred *= int(DamageValue.Shred * Scalar);
	DamageValue.Rupture *= int(DamageValue.Rupture * Scalar);
	return bIsImmune;
}
