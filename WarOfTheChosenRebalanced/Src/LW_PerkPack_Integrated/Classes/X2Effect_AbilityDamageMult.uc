//--------------------------------------------------------------------------------------- 
//  FILE:    X2Effect_AbilityDamageMult
//  AUTHOR:  John Lumpkin (Pavonis Interactive)
//  PURPOSE: Applies %-based OR flat damage increase/decrease when using an ability
//--------------------------------------------------------------------------------------

class X2Effect_AbilityDamageMult extends X2Effect_Persistent;

var bool Mult;
var bool Penalty;
var float DamageMod;
var name ActiveAbility;

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

	//`LOG ("X2EFFECT_ADM");
	ExtraDamage = 0.0;
	if (Mult && AbilityState.GetMyTemplateName() == ActiveAbility)
	{
		if (class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
		{
			if (Penalty)
			{
				ExtraDamage = -CurrentDamage * DamageMod;
				if (CurrentDamage - ExtraDamage < 1.0f)
					ExtraDamage = 1.0f - CurrentDamage;
			}
			else
			{
				ExtraDamage = CurrentDamage * DamageMod;
			}
		}
	}

	return ExtraDamage;
}

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local int ExtraDamage;

	//`LOG ("X2EFFECT_ADM");
	ExtraDamage = 0;
	if (!Mult && AbilityState.GetMyTemplateName() == ActiveAbility)
	{
		if (class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
		{
			if (Penalty)
			{
				ExtraDamage = -1 * int(DamageMod);
			}
			else
			{
				ExtraDamage = int(DamageMod);
			}
		}
    }

	return ExtraDamage;
}
