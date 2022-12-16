class X2Effect_DLC_Day60TurnStartRemoveActionPoints_Override extends X2Effect_DLC_Day60TurnStartRemoveActionPoints;

function ModifyTurnStartActionPoints(XComGameState_Unit UnitState, out array<name> ActionPoints, XComGameState_Effect EffectState)
{
	//local int UnusedPoints, GrantedPoints, Point;
	if( bApplyToRevealedAIOnly && UnitState.IsUnrevealedAI() )
		return;

	ActionPoints.Length = 0;

	// Kill the code that gives Rulers a free action for every action XCOM didn't take
	// Ability conflicts aside, it seems rather counterintuitive to penalise the player for not using actions in a system that reacts to their actions

	// Instead, give a Ruler two action points on their turn no matter what, which they can use to move back into LOS.
	ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
	ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);

	//`LOG("gave the ruler one action point");

	//UnusedPoints = class'Helpers'.static.GetRemainingXComActionPoints(true);
	//if( UnusedPoints > 0 )
	//{
	//	GrantedPoints = FCeil(UnusedPoints*0.5f);
	//	for( Point = 0; Point < GrantedPoints; ++Point )
	//	{
	//		ActionPoints.AddItem(class'X2CharacterTemplateManager'.default.StandardActionPoint);
	//	}
	//}
}