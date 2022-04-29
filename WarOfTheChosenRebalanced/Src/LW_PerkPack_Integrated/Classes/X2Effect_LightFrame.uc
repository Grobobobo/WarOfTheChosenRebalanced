
//---------------------------------------------------------------------------------------
//  FILE:    Helpers_LW
//  AUTHOR:  Grobobobo
//
//  PURPOSE: Light frame's Damage reduction
//          
//---------------------------------------------------------------------------------------

class X2Effect_LightFrame extends X2Effect_Persistent;

var float PCT_DMG_Reduction;


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
    local X2WeaponTemplate WeaponTemplate;

    WeaponTemplate = X2WeaponTemplate(AbilityState.GetSourceWeapon().GetMyTemplate());

    if(WeaponTemplate.WeaponCat == 'lwcanister' || WeaponTemplate.WeaponCat == 'lwchemthrower')
    {
        return -WeaponDamage * PCT_DMG_Reduction;
    }
        
    return 0;
}



