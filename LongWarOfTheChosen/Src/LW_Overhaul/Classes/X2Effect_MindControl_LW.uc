class X2Effect_MindControl_LW extends X2Effect_MindControl;

function ModifyTurnStartActionPoints(XComGameState_Unit UnitState, out array<name> ActionPoints, XComGameState_Effect EffectState)
{
    if(ActionPoints.Length > 1)
    {
        ActionPoints.Remove(0, 1);
    }
}