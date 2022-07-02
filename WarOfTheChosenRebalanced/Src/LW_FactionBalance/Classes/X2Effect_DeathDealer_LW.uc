//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_DeathDealer_LW
//  AUTHOR:  Peter Ledbrook
//  PURPOSE: Fixes Death Dealer so that it does not apply to damage that
//           ignores base weapon damage, such as bleed, burning, etc. Also
//           makes Death Dealer work at Squadsight range.
//---------------------------------------------------------------------------------------

class X2Effect_DeathDealer_LW extends X2Effect_Executioner;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local X2Effect_ApplyWeaponDamage DamageEffect;
	local WeaponDamageValue DamageValue;

	// Ignore damage that ignores base weapon damage
	DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
	if (DamageEffect != none && DamageEffect.bIgnoreBaseDamage)
		return 0;


	//  only add bonus damage on a crit, flanking, while in shadow
	if (AppliedData.AbilityResultContext.HitResult == eHit_Crit && Attacker.IsSuperConcealed())
	{
		// Double the Crit damage
		return class'X2Ability_ReaperAbilitySet_LW'.default.DEATH_DEALER_BONUS_DAMAGE_ON_CRIT;
	}

	return 0;
}

// function float GetPostDefaultAttackingDamageModifier_CH(
// 	XComGameState_Effect EffectState,
// 	XComGameState_Unit Attacker,
// 	Damageable TargetDamageable,
// 	XComGameState_Ability AbilityState,
// 	const out EffectAppliedData AppliedData,
// 	float CurrentDamage,
// 	X2Effect_ApplyWeaponDamage WeaponDamageEffect,
// 	XComGameState NewGameState)
// {
// 	local XComGameState_Item SourceWeapon;
// 	local XComGameState_Unit TargetUnit;

// 	if (WeaponDamageEffect.bIgnoreBaseDamage)
// 	{	
// 		return 0;		
// 	}

// 	if (AppliedData.AbilityResultContext.HitResult == eHit_Crit)
// 	{
// 		SourceWeapon = AbilityState.GetSourceWeapon();
// 		if(SourceWeapon != none) 
// 		{
// 			TargetUnit = XComGameState_Unit(TargetDamageable);
// 			if(TargetUnit != none)
// 			{
// 				if (Attacker.IsSuperConcealed())
// 				{
// 					return CurrentDamage * class'X2Ability_ReaperAbilitySet_LW'.default.DEATH_DEALER_BONUS_DAMAGE_ON_CRIT / 100;
// 				}
// 			}
// 		}
// 	}

// 	return 0;
// }

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
    local ShotModifierInfo ShotInfo;
    local UnitValue UnitValue;
	//if (Attacker.IsImpaired(false) || Attacker.IsBurning())
//		return;

	if (Attacker.IsSuperConcealed())
	{

		//Attacker.GetUnitValue(class'X2LWModTemplate_ReaperAbilities'.default.BanishFiredTimes, UnitValue);

		ShotInfo.ModType = eHit_Success;
		ShotInfo.Reason = FriendlyName;
		ShotInfo.Value = class'X2Ability_ReaperAbilitySet_LW'.default.DEATH_DEALER_BONUS_AIM * UnitValue.fValue;
		ShotModifiers.AddItem(ShotInfo);
	}
}
