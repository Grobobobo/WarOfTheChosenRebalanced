Class X2Effect_MovingTarget_LW extends X2Effect_Persistent config (LW_SoldierSkills);

var int MovingTargetStartingDefensePenalty;
var int MovingTargetStartingDodgePenalty;
var int MovingTargetBonusDefensePerShot;
var int MovingTargetBonusDodgePerShot;

function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local X2EventManager EventMgr;
	local XComGameState_Unit UnitState;
	local Object EffectObj;

	EventMgr = `XEVENTMGR;

	EffectObj = EffectGameState;
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	EventMgr.RegisterForEvent(EffectObj, 'AbilityActivated', IncomingReactionFireCheck, ELD_OnStateSubmitted,,,, EffectObj);
	EventMgr.RegisterForEvent(EffectObj, 'TriggerLRLWFlyover', EffectGameState.TriggerAbilityFlyover, ELD_OnStateSubmitted,, UnitState);
}

static function EventListenerReturn IncomingReactionFireCheck(Object EventData, Object EventSource, XComGameState GameState, name EventID, Object CallbackData)
{
	local XComGameState_Unit			AttackingUnit, DefendingUnit, OwnerUnit;
	local XComGameState_Ability			ActivatedAbilityState;
	local XComGameState_Ability			LightningReflexesAbilityState;
	local XComGameStateContext_Ability	AbilityContext;
	local XComGameState_Effect			EffectState;
	local UnitValue						LightningReflexesCounterValue;
	local X2AbilityToHitCalc_StandardAim 	StandardAim;

	EffectState = XComGameState_Effect(CallbackData);
	AbilityContext = XComGameStateContext_Ability(GameState.GetContext());
	LightningReflexesAbilityState = XComGameState_Ability(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.AbilityStateObjectRef.ObjectID));
	DefendingUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
	OwnerUnit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));	
	if (DefendingUnit != none)
	{
		if (DefendingUnit.HasSoldierAbility('LightningReflexes_LW') && !DefendingUnit.IsImpaired(false) && !DefendingUnit.IsBurning() && !DefendingUnit.IsPanicked() && DefendingUnit.ObjectID == OwnerUnit.ObjectID)
		{
			AttackingUnit = class'X2TacticalGameRulesetDataStructures'.static.GetAttackingUnitState(GameState);
			if(AttackingUnit != none && AttackingUnit.IsEnemyUnit(DefendingUnit))
			{
				ActivatedAbilityState = XComGameState_Ability(EventData);
				if (ActivatedAbilityState != none)
				{
					StandardAim = X2AbilityToHitCalc_StandardAim(ActivatedAbilityState.GetMyTemplate().AbilityToHitCalc);
					if (StandardAim != none && StandardAim.bReactionFire)
					{
						// Update the Lightning Reflexes counter
						DefendingUnit.GetUnitValue('GTO_MovingTarget_Counter', LightningReflexesCounterValue);
						DefendingUnit.SetUnitFloatValue ('GTO_MovingTarget_Counter', LightningReflexesCounterValue.fValue + 1, eCleanup_BeginTurn);

						// Send event to trigger the flyover, but only for the first shot
						if (LightningReflexesCounterValue.fValue == 0)
						{
							`XEVENTMGR.TriggerEvent('TriggerLRLWFlyover', LightningReflexesAbilityState, DefendingUnit, GameState);
						}
					}
				}
			}
		}	
	}
	return ELR_NoInterrupt;
}

function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ShotInfo;
	local UnitValue LightningReflexesCounterValue;

	if (Target.IsImpaired(false) || Target.IsBurning() || Target.IsPanicked())
		return;

	if (X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc) != none)
	{
		if (X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc).bReactionFire)
		{
			Target.GetUnitValue('GTO_MovingTarget_Counter', LightningReflexesCounterValue);

			ShotInfo.ModType = eHit_Success;
			ShotInfo.Reason = FriendlyName;
			ShotInfo.Value = -(MovingTargetStartingDefensePenalty + (LightningReflexesCounterValue.fValue * MovingTargetBonusDefensePerShot));
			
			ShotModifiers.AddItem(ShotInfo);

			ShotInfo.ModType = eHit_Graze;
			ShotInfo.Reason = FriendlyName;
			ShotInfo.Value = MovingTargetStartingDefensePenalty + (LightningReflexesCounterValue.fValue * MovingTargetBonusDefensePerShot);
			
			ShotModifiers.AddItem(ShotInfo);

		}
	}
}
