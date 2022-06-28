//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_CloseEncounters
//  AUTHOR:  John Lumpkin (Pavonis Interactive)
//  PURPOSE: Grants action under certain conditions
//--------------------------------------------------------------------------------------- 

class X2Effect_InTheZone extends X2Effect_Persistent;

var name TriggerEventName;
var name UsesCounterName;
var int MaxUsesPerTurn;
var array<name> ApplicableAbilities;

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

// simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
// {
//     local XComGameState_Unit UnitState; 
//     local int OriginalHP;
// 	local int i;
//     super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);

// 	UnitState = XComGameState_Unit(kNewTargetState);

// 	for(i = UnitState.NumActionPoints(); i < 2; i++ )
// 	{
// 		UnitState.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
// 	}
    
// }


// simulated function AddX2ActionsForVisualizationSource(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, name EffectApplyResult)
// {
// 	local XComGameState_Unit TargetUnitState;
// 	local X2Action_ApplyWeaponDamageToUnit UnitAction;
// 	local X2Action_TeleportGetOverThere GetOverThereAction;

// 	TargetUnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);
// 	`assert(TargetUnitState != none);

// 	// Move the target to this space
// 	if (EffectApplyResult == 'AA_Success')
// 	{
// 		GetOverThereAction = X2Action_TeleportGetOverThere(class'X2Action_TeleportGetOverThere'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext()));//auto-parent to damage initiating action
// 		GetOverThereAction.Destination = `XWORLD.GetPositionFromTileCoordinates(TargetUnitState.TileLocation);
// 	}
// 	else
// 	{
// 		UnitAction = X2Action_ApplyWeaponDamageToUnit(class'X2Action_ApplyWeaponDamageToUnit'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext()));//auto-parent to damage initiating action
// 		UnitAction.OriginatingEffect = self;
// 	}
// }
function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability kAbility, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameState_Ability					AbilityState;
	local XComGameState_Unit					TargetUnit;
	local UnitValue								ITZUsesThisTurn;
	local int									iUsesThisTurn;
	local int i;
	// if (SourceUnit.IsUnitAffectedByEffectName(class'X2Effect_Serial'.default.EffectName))
	// 	return false;

	// if (SourceUnit.IsUnitAffectedByEffectName(class'X2Effect_DeathfromAbove'.default.EffectName))
	// 	return false;

	// if (PreCostActionPoints.Find('RunAndGun') != -1)
	// 	return false;

	// Don't proc on a Skirmisher interrupt turn (for example with Battle Lord)
	// if (class'Helpers_LW'.static.IsUnitInterruptingEnemyTurn(SourceUnit))
	// 	return false;
	
	// if (kAbility == none)
	// 	return false;

	if (kAbility.SourceWeapon != EffectState.ApplyEffectParameters.ItemStateObjectRef)
		return false;

	SourceUnit.GetUnitValue (UsesCounterName, ITZUsesThisTurn);
	iUsesThisTurn = int(ITZUsesThisTurn.fValue);


	if (iUsesThisTurn >= MaxUsesPerTurn)
		return false;

	// SourceUnit.GetUnitValue (class'X2Effect_CheapShot'.default.CheapShotUsesName, CheapShotUsesThisTurn);
	// iUsesThisTurn = int(CheapShotUsesThisTurn.fValue);
	// if (iUsesThisTurn >= 1)
	// 	return false;

	TargetUnit = XComGameState_Unit(NewGameState.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));  	

	if (TargetUnit == none)
		return false;

	//`LOG (string (SourceUnit.TileDistanceBetween(TargetUnit)));
	//`LOG (string (MaxTiles));

	// if (SourceUnit.TileDistanceBetween(TargetUnit) > MaxTiles + 1)
	// 	return false;

	//`LOG ("CE7");

	if (XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID)) == none)
		return false;

	//`LOG ("CE8");

	AbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));

	if (AbilityState != none)
	{
		if (ApplicableAbilities.Find(kAbility.GetMyTemplateName()) != -1)
		{
			//`LOG ("CE9");
			
			if (PreCostActionPoints.Length > 0)
			{

                for(i = SourceUnit.NumActionPoints(); i < PreCostActionPoints.Length; i++ )
                {
                    SourceUnit.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
                }
				//`LOG ("CE10");
				SourceUnit.SetUnitFloatValue (UsesCounterName, iUsesThisTurn + 1.0, eCleanup_BeginTurn);
				//NewGameState.AddStateObject(SourceUnit);
				`XEVENTMGR.TriggerEvent(TriggerEventName, AbilityState, SourceUnit, NewGameState);
			}
		}
	}
	return false;
}

defaultproperties
{
	TriggerEventName = "InTheZone"
	UsesCounterName = "InTheZoneUses"
	MaxUsesPerTurn = 2
}
