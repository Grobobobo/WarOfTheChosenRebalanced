// This is an Unreal Script
class X2Effect_HunterMarkAdvent extends X2Effect_Persistent;


simulated function AddX2ActionsForVisualization_Tick(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const int TickIndex, XComGameState_Effect EffectState)
{
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, VisualizeGameState.GetContext(), false, ActionMetadata.LastActionAdded));
	SoundAndFlyOver.SetSoundAndFlyOverParameters(None, FriendlyName, '', eColor_Bad);
}

defaultproperties
{
	bDisplayInSpecialDamageMessageUI = true
	EffectName = "HunterMarkAdvent_LW"
	DuplicateResponse = eDupe_Refresh;
	bApplyOnHit = true;
	bApplyOnMiss = false;
}