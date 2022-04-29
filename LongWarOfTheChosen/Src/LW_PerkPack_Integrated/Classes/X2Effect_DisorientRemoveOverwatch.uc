class X2Effect_DisorientRemoveOverwatch extends X2Effect_PersistentStatChange;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
    local XComGameState_Unit UnitState;
    UnitState = XComGameState_Unit(kNewTargetState);

    UnitState.ReserveActionPoints.Length = 0;

    super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);

}