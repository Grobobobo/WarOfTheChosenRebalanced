class X2AbilityCost_SharedCharges extends X2AbilityCost_Charges;

simulated function ApplyCost(XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_BaseObject AffectState, XComGameState_Item AffectWeapon, XComGameState NewGameState)
{
    local StateObjectReference     AbilityRef;
    local XComGameState_Unit     UnitState;
    local XComGameStateHistory     History;
    local XComGameState_Ability AbilityState;
    local StateObjectReference     BondmateRef;
    local ETeam                    FiringUnitTeam;
    local name                    AbilityName;

    History = `XCOMHISTORY;
    AbilityName = kAbility.GetMyTemplateName();
    
    UnitState = XComGameState_Unit(NewGameState.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
    if (UnitState == None)
    {
        UnitState = XComGameState_Unit(History.GetGameStateForObjectID(kAbility.OwnerStateObject.ObjectID));
    }
    FiringUnitTeam = UnitState.GetTeam();
    
    foreach History.IterateByClassType(class'XComGameState_Unit', UnitState)
    {
        if (UnitState != None && UnitState.GetTeam() == FiringUnitTeam)
        {
            AbilityRef = UnitState.FindAbility(AbilityName);
            if (AbilityRef.ObjectID > 0)
            {
                AbilityState = XComGameState_Ability(NewGameState.ModifyStateObject(class'XComGameState_Ability', AbilityRef.ObjectID));
                AbilityState.iCharges -= NumCharges;
            }
        }
    }
}