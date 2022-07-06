class X2Effect_Serial_LW extends X2Effect_Serial;

var array<float> PCT_DMG_Reduction;


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
	local UnitValue UnitVal;
    local float DamageReduction;
	local float DamageMod;
	if (AbilityState.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef)
	{
		SourceUnit.GetUnitValue('SerialKills', UnitVal);

		if(UnitVal.fValue > 0)
		{

        DamageReduction = WeaponDamage;

		DamageMod = (1- PCT_DMG_Reduction[`STRATEGYDIFFICULTYSETTING])** UnitVal.fValue;

		DamageReduction = DamageReduction * (1-DamageMod);
		}
    }

	return -DamageReduction;
}

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameState_Unit TargetUnit;
	local X2EventManager EventMgr;
	local XComGameState_Ability AbilityState;
	local int i;
	//  match the weapon associated with Serial to the attacking weapon
	if (kAbility.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef)
	{
		//  check for a direct kill shot
		TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
		if (TargetUnit != none && TargetUnit.IsDead())
		{
			AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
			if (AbilityState != none)
			{
                for (i = 0; i < PreCostActionPoints.Length; i++)
                {
					SourceUnit.ActionPoints.AddItem(PreCostActionPoints[i]);
                }
				EventMgr = `XEVENTMGR;
				EventMgr.TriggerEvent('SerialKiller', AbilityState, SourceUnit, NewGameState);
				return true;
			}
			
		}
	}
	return false;
}
