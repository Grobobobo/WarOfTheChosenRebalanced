class X2Effect_Vengeance_LW extends X2Effect_Persistent;

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
    local float Ratio, DamageMultiplier;

    Ratio = class'Helpers_LW'.static.GetVengeanceSoldierKillRatio();

    DamageMultiplier =  (1 + Ratio) ** 3.5 / 10;
    
    return CurrentDamage * DamageMultiplier;

}

function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{

    local ShotModifierInfo					ShotInfo1;
    local float Ratio;

	Ratio = class'Helpers_LW'.static.GetVengeanceSoldierKillRatio();

    ShotInfo1.ModType = eHit_Graze;
    ShotInfo1.Reason = FriendlyName;
    ShotInfo1.Value = FFloor(Ratio * 100);
    ShotModifiers.AddItem(ShotInfo1);

    // ShotInfo2.ModType = eHit_Crit;
    // ShotInfo2.Reason = FriendlyName;
    // ShotInfo2.Value = -1 * FFloor(Ratio * 100);
    // ShotModifiers.AddItem(ShotInfo2);

}
DefaultProperties
{
	EffectName = "Vengeance_LW"
	DuplicateResponse = eDupe_Refresh
}