//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_CloseEncounters
//  AUTHOR:  John Lumpkin (Pavonis Interactive)
//  PURPOSE: Grants action under certain conditions
//--------------------------------------------------------------------------------------- 

class X2Effect_ExtraConditioning extends X2Effect_Persistent;

var int TriggerChance;
var name TriggerEventName;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager			EventMgr;
	local XComGameState_Unit		UnitState;
	local Object					EffectObj;

	EventMgr = `XEVENTMGR;
	EffectObj = EffectGameState;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	EventMgr.RegisterForEvent(EffectObj, TriggerEventName, EffectGameState.TriggerAbilityFlyover, ELD_OnStateSubmitted, , UnitState);
}

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameState_Ability					AbilityState;
	local int									RandRoll;
	
	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));

    RandRoll = `SYNC_RAND(100);

    if (SourceUnit.NumActionPoints() != PreCostActionPoints.Length && PreCostActionPoints.Length > 0 && RandRoll < TriggerChance)
    {
        //`LOG ("CE10");
        SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);

        `XEVENTMGR.TriggerEvent(TriggerEventName, AbilityState, SourceUnit, NewGameState);
    }

	return false;
}

defaultproperties
{
    TriggerEventName = "ExtraConditioning"
}
