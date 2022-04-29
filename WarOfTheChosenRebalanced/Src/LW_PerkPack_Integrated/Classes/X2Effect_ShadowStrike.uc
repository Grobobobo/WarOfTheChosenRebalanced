class X2Effect_Shadowstrike extends X2Effect_Persistent;

var int SS_AimBonus;
var float SS_DamageBonus;

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ShotInfo;

	if (ShouldApplyBonuses(EffectState, Target, AbilityState, Attacker))
	{
		ShotInfo.ModType = eHit_Success;
		ShotInfo.Reason = FriendlyName;
		ShotInfo.Value = SS_AimBonus;
		ShotModifiers.AddItem(ShotInfo);
	}
}


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
	local XComGameState_Unit TargetUnit;


	if (X2WeaponTemplate(AbilityState.GetSourceWeapon().GetMyTemplate()).WeaponCat == 'grenade')
	{
		return 0;
	}

	if (WeaponDamageEffect != none)
	{
		if (WeaponDamageEffect.bIgnoreBaseDamage)
		{
			return 0;
		}
	}


    if (class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult) && AbilityState.IsAbilityInputTriggered())
    {
        TargetUnit = XComGameState_Unit(TargetDamageable);
        if (TargetUnit != none && ShouldApplyBonuses(EffectState, TargetUnit, AbilityState, Attacker))
        {
            return CurrentDamage * SS_DamageBonus;
        }
    }


	return 0;
}


private function bool ShouldApplyBonuses(XComGameState_Effect EffectState, XComGameState_Unit Target, XComGameState_Ability AbilityState, XComGameState_Unit Attacker)
{
    return Attacker.IsConcealed() && AbilityState.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef;
}