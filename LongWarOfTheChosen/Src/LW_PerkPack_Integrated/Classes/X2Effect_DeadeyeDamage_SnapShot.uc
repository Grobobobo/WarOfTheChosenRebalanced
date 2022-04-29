//---------------------------------------------------------------------------------------
//  FILE:   X2Effect_DeadeyeDamage_SnapShot.uc
//  AUTHOR:  Grobobobo
//  PURPOSE: Effect that does the same think as deadeye, but for its snapshot variant.
//---------------------------------------------------------------------------------------
class X2Effect_DeadeyeDamage_SnapShot extends X2Effect_Persistent config(LW_SoldierSKills);

var config float DamageMultiplier;

function float GetPostDefaultAttackingDamageModifier_CH(
	XComGameState_Effect EffectState,
	XComGameState_Unit Attacker,
	Damageable TargetDamageable,
	XComGameState_Ability AbilityState,
	const out EffectAppliedData AppliedData,
	float CurrentDamage,
	X2Effect_ApplyWeaponDamage WeaponDamageEffect,
	XComGameState NewGameState)
{
	local float ExtraDamage;

	if (AbilityState.GetMyTemplateName() == 'DeadeyeSnapShot' && class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
	{
		ExtraDamage = CurrentDamage * DamageMultiplier;
	}

	return ExtraDamage;
}

defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
}
