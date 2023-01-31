//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_ArcWaveMultiDamage_LW
//  AUTHOR:  Grobobobo
//  PURPOSE: Updates the Arcwave effect so that its damage is dependent on weapon tier instead of focus
//---------------------------------------------------------------------------------------
class X2Effect_ArcWaveMultiDamage_LW extends X2Effect_ArcWaveMultiDamage;

var int T1Damage;
var int T2Damage;
var int T3Damage;
var int T4Damage;
var int T5Damage;
function WeaponDamageValue GetBonusEffectDamageValue(XComGameState_Ability AbilityState, XComGameState_Unit SourceUnit, XComGameState_Item SourceWeapon, StateObjectReference TargetRef)
{
	local WeaponDamageValue Damage;
	local X2WeaponTemplate Weapon;
	if (TargetRef.ObjectID > 0)
	{
		Weapon = X2WeaponTemplate(SourceWeapon.GetMyTemplate());

		switch(Weapon.WeaponTech)
		{
			case 'conventional':
				Damage.Damage = T1Damage;
				break;
			case 'laser_lw':
				Damage.Damage = T2Damage;
				break;
			case 'magnetic':
				Damage.Damage = T3Damage;
				break;
			case 'coilgun_lw':
				Damage.Damage = T4Damage;
				break;
			case 'beam':
				Damage.Damage = T5Damage;
				break;

			default:
				Damage.Damage = T1Damage;
		}
	}
	return Damage;
}
