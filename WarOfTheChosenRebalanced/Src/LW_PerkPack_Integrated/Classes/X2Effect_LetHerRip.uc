
//---------------------------------------------------------------------------------------
//  FILE:    Helpers_LW
//  AUTHOR:  Grobobobo
//
//  PURPOSE: Make Reaper Damage reduction based on %
//          
//---------------------------------------------------------------------------------------

class X2Effect_LetHerRip extends X2Effect_Persistent;

var float DMGBuff;
var int RangedAccPenalty;

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
	if (AbilityState.GetMyTemplate().IsMelee())
	{
        return WeaponDamage * DMGBuff;
    }
	return 0;
}



function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ShotInfo;

	if (!AbilityState.GetMyTemplate().IsMelee())
	{
		ShotInfo.ModType = eHit_Success;
		ShotInfo.Reason = FriendlyName;
		ShotInfo.Value = RangedAccPenalty;
		ShotModifiers.AddItem(ShotInfo);
	}
}

