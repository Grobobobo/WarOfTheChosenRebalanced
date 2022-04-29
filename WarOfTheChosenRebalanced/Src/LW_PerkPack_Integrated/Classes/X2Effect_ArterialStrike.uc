class X2Effect_ArterialStrike extends X2Effect_Persistent;

var int BleedingDamageIncrease;

function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

        WeaponDamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
        if (WeaponDamageEffect != none)
        {			
            if (WeaponDamageEffect.EffectDamageValue.DamageType == 'Bleeding')
            {	
                return BleedingDamageIncrease;		
            }
        }    
	return 0;
}