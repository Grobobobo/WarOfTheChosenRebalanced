//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_RapidDeployment.uc
//  AUTHOR:  Aminer (Pavonis Interactive)
//  PURPOSE: Grants an 1 turn effect that the next use of throw grenade for smoke or flash a free action
//--------------------------------------------------------------------------------------- 

class X2Effect_RapidDeployment extends X2Effect_Persistent config (LW_SoldierSkills);

var config int RAPID_DEPLOYMENT_COOLDOWN;
var config array<name> VALID_ABILITIES;
var config array<name> VALID_GRENADE_ABILITIES;
var config array<name> VALID_GRENADE_TYPES;

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local name						AbilityName;
//	local name						TestName;
	local XComGameState_Ability		AbilityState;
	local bool						bFreeActivation;
	local XComGameState_Item		SourceWeapon;
	local X2WeaponTemplate			SourceWeaponAmmoTemplate;

	if(kAbility == none)
		return false;

	SourceWeapon = kAbility.GetSourceWeapon();
	AbilityName = kAbility.GetMyTemplateName();

	if (SourceWeapon == none)
		return false;


	if (default.VALID_ABILITIES.Find(AbilityName) != -1)
		bFreeActivation = true;


	if(default.VALID_GRENADE_ABILITIES.Find(AbilityName) != -1)
	{
		bFreeActivation = true;
		
		SourceWeaponAmmoTemplate = X2WeaponTemplate(SourceWeapon.GetLoadedAmmoTemplate(kAbility));
		if (SourceWeaponAmmoTemplate != none )
		{
			if (default.VALID_GRENADE_TYPES.Find(SourceWeaponAmmoTemplate.DataName) != -1)
			{
				bFreeActivation = true;
			}
		}
	}
	if(bFreeActivation)
	{
		if (SourceUnit.ActionPoints.Length != PreCostActionPoints.Length)
		{
			AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
			if (AbilityState != none)
			{
				SourceUnit.ActionPoints = PreCostActionPoints;
				EffectState.RemoveEffect(NewGameState, NewGameState);

				`XEVENTMGR.TriggerEvent('RapidDeployment', AbilityState, SourceUnit, NewGameState);

				return true;
			}
		}
	}
	return false;
}