//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_HEATGrenades.uc
//  AUTHOR:  Amineri (Pavonis Interactive)
//  PURPOSE: Grants grenades the ability to pierce armor
//---------------------------------------------------------------------------------------
class X2Effect_HEATGrenades extends X2Effect_Persistent;

var int Pierce;
var int Shred;

function int GetExtraArmorPiercing(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData)
{
	local XComGameState_Item SourceWeapon;
	local X2WeaponTemplate WeaponTemplate;

	SourceWeapon = AbilityState.GetSourceWeapon();
	WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
	
	if(WeaponTemplate == none)
		return 0;

	// make sure the weapon is explosive or primary
	if(AbilityState.GetMyTemplateName() == 'ThrowGrenade' || AbilityState.GetMyTemplateName() == 'LaunchGrenade' 
	|| AbilityState.GetMyTemplateName() == 'IRI_FireRocket' || AbilityState.GetMyTemplateName() == 'IRI_FireRocketLauncher'
	|| WeaponTemplate.InventorySlot == eInvSlot_PrimaryWeapon)
	{
		return Pierce;
	}
	return 0;
}

function int GetExtraShredValue(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData)
{
	local XComGameState_Item SourceWeapon;
	local X2WeaponTemplate WeaponTemplate,SourceWeaponAmmoTemplate;

	SourceWeapon = AbilityState.GetSourceWeapon();
	WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
	
	if(WeaponTemplate == none)
		return 0;

	// make sure the weapon is either a grenade or a grenade launcher
	if(X2GrenadeTemplate(WeaponTemplate) != none || X2GrenadeLauncherTemplate(WeaponTemplate) != none)
	{
		return Shred;
	}
	
	return 0;
}

DefaultProperties
{
	EffectName="HeatGrenadesEffect"
	DuplicateResponse = eDupe_Ignore
}
