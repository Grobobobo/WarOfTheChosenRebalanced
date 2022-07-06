class X2Effect_MindControl_LW extends X2Effect_MindControl;



simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit ControllerState;
	local XComGameState_Unit UnitState;
	local Object EffectObj;
	local int i;

	super(X2Effect_Persistent).OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);

	ControllerState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));
	UnitState = XComGameState_Unit(kNewTargetState);
	UnitState.SetControllingPlayer(ControllerState.ControllingPlayer);

	// if(UnitState.IsTurret()) // Turret hacked ability.
	// {
	// 	// Give the turret immediate action points for the current turn when hacked.
	// 	UnitState.ActionPoints.Length = 0;
	// 	for( i = 0; i < class'X2CharacterTemplateManager'.default.StandardActionsPerTurn; ++i )
	// 	{
	// 		UnitState.ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
	// 	}

	// 	// Also remove any residual 'stunned' action points if this unit was just activated and is in its 'AI warm-up' time.
	// 	UnitState.StunnedActionPoints = 0;
	// 	UnitState.UpdateTurretState(false);
	// }

	UpdateAIData(NewGameState, UnitState, true);

	EffectObj = NewEffectState;

	`XEVENTMGR.TriggerEvent('MindControlled', UnitState, UnitState, NewGameState);

	//Typically, mind-control should get removed when the source is impaired, like a sustained effect.
	//Because mind-control impairs a unit momentarily when being added or removed,
	//this means we don't have to propagate team changes if we have a mind-control train.
	//(For extra fun, consider an acyclic graph of Sectoids mind-controlling each other and raising Psi Zombies.)
	//-btopp 2015-10-16
	if (!bInfiniteDuration)
		`XEVENTMGR.RegisterForEvent(EffectObj, 'ImpairingEffect', NewEffectState.OnSourceBecameImpaired, ELD_OnStateSubmitted, , ControllerState);
}

function ModifyTurnStartActionPoints(XComGameState_Unit UnitState, out array<name> ActionPoints, XComGameState_Effect EffectState)
{
    if(ActionPoints.Length > 1)
    {
        ActionPoints.Remove(0, 1);
    }
}