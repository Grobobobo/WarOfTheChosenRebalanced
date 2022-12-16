class X2Effect_SuicideVestDamage extends X2Effect_ApplyWeaponDamage;



var int T1Damage;
var int T2Damage;
var int T3Damage;
var int T4Damage;
var int T5Damage;

function WeaponDamageValue GetBonusEffectDamageValue(XComGameState_Ability AbilityState, XComGameState_Unit SourceUnit, XComGameState_Item SourceWeapon, StateObjectReference TargetRef)
{
	local WeaponDamageValue Damage;
    local XComGameState_Item PrimaryWeapon;

    PrimaryWeapon = SourceUnit.GetPrimaryWeapon();
    
    Damage.Damage = GetDamageFromPrimaryTechTier(X2WeaponTemplate(PrimaryWeapon.GetMyTemplate()).WeaponTech);
		
	return Damage;
}

function int GetDamageFromPrimaryTechTier(name TechName)
{
    	switch(TechName)
		{
			case 'conventional':
				return T1Damage;
			case 'laser_LW':
				return T2Damage;
			case 'magnetic':
				return T3Damage;
            case 'coilgun':
				return T4Damage;
            case 'beam':
				return T5Damage;
			default:
				return T1Damage;
		}
}


simulated function GetDamagePreview(StateObjectReference TargetRef, XComGameState_Ability AbilityState, bool bAsPrimaryTarget, out WeaponDamageValue MinDamagePreview, out WeaponDamageValue MaxDamagePreview, out int AllowsShield)
{
    local XComGameState_Item PrimaryWeapon;
    local XComGameState_Unit SourceUnit;

    Super.GetDamagePreview(TargetRef, AbilityState, bAsPrimaryTarget, MinDamagePreview, MaxDamagePreview, AllowsShield);

    SourceUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
    PrimaryWeapon = SourceUnit.GetPrimaryWeapon();
    
    MaxDamagePreview.Damage = GetDamageFromPrimaryTechTier(X2WeaponTemplate(PrimaryWeapon.GetMyTemplate()).WeaponTech);
    MaxDamagePreview.Damage = GetDamageFromPrimaryTechTier(X2WeaponTemplate(PrimaryWeapon.GetMyTemplate()).WeaponTech);

}