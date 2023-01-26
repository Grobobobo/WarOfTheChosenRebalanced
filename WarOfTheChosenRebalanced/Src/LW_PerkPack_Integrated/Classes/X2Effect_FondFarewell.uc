

class X2Effect_FondFarewell extends X2Effect_Persistent;

var float PCT_DAMAGE_BONUS;

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
    local XComGameState_Item WeaponState;
	local int						i;
	local X2AbilityCost_Ammo		AmmoCost;
	local X2AbilityTemplate			MyTemplate;

	WeaponState = AbilityState.GetSourceWeapon();
	if ( WeaponState == none || WeaponState.HasInfiniteAmmo() || SourceUnit.GetPrimaryWeapon().ObjectID != WeaponState.ObjectID) { return 0; }

	MyTemplate = AbilityState.GetMyTemplate();

    for (i = 0; i < MyTemplate.AbilityCosts.Length; ++i)
    {
        AmmoCost = X2AbilityCost_Ammo( MyTemplate.AbilityCosts[i] );
        
        if(AmmoCost.iAmmo == WeaponState.Ammo)
        {
            return WeaponDamage * PCT_DAMAGE_BONUS;
        }
    }

    return 0;
}


defaultproperties
{
	DuplicateResponse=eDupe_Ignore
	bDisplayInSpecialDamageMessageUI=true
}