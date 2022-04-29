class X2Effect_SilentMelee extends X2Effect_Persistent;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{	
	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}

simulated function AddX2ActionsForVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, name EffectApplyResult)
{
	local XComGameState_Effect SilentMeleeEffect, EffectState;
	local X2Action_StartStopSound SoundAction;

	if (EffectApplyResult != 'AA_Success' || ActionMetadata.VisualizeActor == none)
		return;

	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Effect', EffectState)
	{
		if (EffectState.GetX2Effect() == self)
		{
			SilentMeleeEffect = EffectState;
			break;
		}
	}
	`assert(SilentMeleeEffect != none);

	SoundAction = X2Action_StartStopSound(class'X2Action_StartStopSound'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext()));
	SoundAction.Sound = new class'SoundCue';
	SoundAction.Sound.AkEventOverride = AkEvent'SoundX2CharacterFX.MimicBeaconActivate';
	SoundAction.iAssociatedGameStateObjectId = SilentMeleeEffect.ObjectID;
	SoundAction.bStartPersistentSound = true;
	SoundAction.bIsPositional = false;
	SoundAction.vWorldPosition = SilentMeleeEffect.ApplyEffectParameters.AbilityInputContext.TargetLocations[0];
	class'X2Action_Conceal'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext());
}


simulated function AddX2ActionsForVisualization_Removed(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult, XComGameState_Effect RemovedEffect)
{
	local XComGameState_Effect		SilentMeleeEffect, EffectState;
	local X2Action_StartStopSound	SoundAction;

	super.AddX2ActionsForVisualization_Removed(VisualizeGameState, ActionMetadata, EffectApplyResult, RemovedEffect);

	if (EffectApplyResult != 'AA_Success' || ActionMetadata.VisualizeActor == none)
	{
		return;
	}

	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Effect', EffectState)
	{
		if (EffectState.GetX2Effect() == self)
		{
			SilentMeleeEffect = EffectState;
			break;
		}
	}
	`assert(SilentMeleeEffect != none);

	SoundAction = X2Action_StartStopSound(class'X2Action_StartStopSound'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext()));
	SoundAction.Sound = new class'SoundCue';
	SoundAction.Sound.AkEventOverride = AkEvent'SoundX2CharacterFX.MimicBeaconDeactivate';
	SoundAction.iAssociatedGameStateObjectId = SilentMeleeEffect.ObjectID;
	SoundAction.bStartPersistentSound = true;
	SoundAction.bIsPositional = false;
	SoundAction.vWorldPosition = SilentMeleeEffect.ApplyEffectParameters.AbilityInputContext.TargetLocations[0];
	class'X2Action_Reveal'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext());

}

defaultproperties
{
	EffectName = "SilentMeleeEffect"
}