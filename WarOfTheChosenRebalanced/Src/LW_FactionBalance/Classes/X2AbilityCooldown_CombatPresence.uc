//---------------------------------------------------------------------------------------
//  FILE:    X2AbilityCooldown_LWFlamethrower.uc
//  AUTHOR:  Amineri / Pavonis Interactive
//  PURPOSE: Variable cooldown on flamethrower
//---------------------------------------------------------------------------------------
class X2AbilityCooldown_CombatPresence extends X2AbilityCooldown;

// var array<name> AbilityModifiers;
// var array<int> CooldownModifiers;

simulated function int GetNumTurns(XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
//	local name AbilityName;
	local int  TempTurns;
    local XComGameState_Unit SourceUnit;
    local UnitValue CurrentHeatValue;
	
    SourceUnit = XComGameState_Unit(AffectState);
	SourceUnit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, CurrentHeatValue);

    TempTurns = iNumTurns - int(CurrentHeatValue.fValue / class'X2Ability_SkirmisherAbilitySet_LW'.default.COMBAT_PRESENCE_COOLDOWN_REDUCTION_DIVISOR);

	return TempTurns;
}

DefaultProperties
{
	iNumTurns = 2;
}