class X2Effect_HeatListener_LW extends X2Effect_PersistentStatChange;


function RegisterForEvents(XComGameState_Effect EffectGameState)
{
	local XComGameState_Unit UnitState;
	local X2EventManager EventMgr;
	local Object ListenerObj;

	EventMgr = `XEVENTMGR;

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectGameState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	ListenerObj = EffectGameState;

	EventMgr.RegisterForEvent(ListenerObj, 'AbilityActivated', UpdateHeatEffects, ELD_OnStateSubmitted,, UnitState,, EffectGameState);
	EventMgr.RegisterForEvent(ListenerObj, 'UnitTakeEffectDamage', RemoveHeatOnHit, ELD_OnStateSubmitted,, UnitState,, EffectGameState);
	EventMgr.RegisterForEvent(ListenerObj, 'WOTC_APA_Skirmisher_UpdateHeatEffects', UpdateHeatEffects, ELD_OnStateSubmitted,, UnitState,, EffectGameState);
}

static function EventListenerReturn UpdateHeatEffects(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit				UnitState, NewUnitState;
	local XComGameState_Effect				EffectState, NewEffectState;
	local XComGameState_Ability				AbilityState;
	local XComGameStateContext_Ability		AbilityContext;
	local X2AbilityTemplate					AbilityTemplate;
	local X2AbilityToHitCalc_StandardAim	AbilityAimCalc;
	local XComGameState						NewGameState;
	local StatChange						NewStatChange;
	local UnitValue							CurrentHeatValue, MaxHeatValue;
	local bool								bHeatChanged;
	local int								AddHeat, NewHeat, StatAmount;

	EffectState = XComGameState_Effect(CallbackData);
	if (EffectState == none)
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
		return ELR_NoInterrupt;

	UnitState.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, CurrentHeatValue);
	UnitState.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_MAX_NAME, MaxHeatValue);
	NewHeat = CurrentHeatValue.fValue;

	// Handle gain of Heat from primary weapon shots: Called from 'AbilityActivated'
	AbilityState = XComGameState_Ability(EventData);
	if (AbilityState != none)
	{

		AbilityTemplate = AbilityState.GetMyTemplate();
		AbilityAimCalc = X2AbilityToHitCalc_StandardAim(AbilityTemplate.AbilityToHitCalc);

		AbilityContext = XComGameStateContext_Ability(GameState.GetContext());

		// Only apply post-attack
		if (AbilityContext != none && AbilityContext.InterruptionStatus != eInterruptionStatus_Interrupt)
		{
			// Unit must not already be at their maximum Heat level
			if (CurrentHeatValue.fValue < MaxHeatValue.fValue)
			{
				// Activated ability must be tied to the unit's primary weapon
				if (AbilityState.SourceWeapon == UnitState.GetItemInSlot(eInvSlot_PrimaryWeapon).GetReference())
				{

					// Check that the ability is a shot ability - looking for bAllowAmmoEffects should catch pretty much everything
					if (AbilityTemplate.bAllowAmmoEffects)
					{


						// Add direct shot Heat unless the ability is a reaction shot
						AddHeat = class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_GAIN_DIRECT_SHOT;
						if (AbilityAimCalc.bReactionFire)
							AddHeat = class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_GAIN_REACTION_SHOT;
			


						NewHeat = Min(CurrentHeatValue.fValue + AddHeat, MaxHeatValue.fValue);
						bHeatChanged = true;					
		}	}	}	}

		// If listener was triggered from 'AbilityActivated' but Heat was not changed, exit
		if (!bHeatChanged)
			return ELR_NoInterrupt;
	}

	// Handle applying Heat changes from above or from direct 'WOTC_APA_Skirmisher_UpdateHeatEffects' triggers
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Conditional Stat Change");
	NewUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
	NewUnitState.SetUnitFloatValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, NewHeat, eCleanup_BeginTactical);

	NewUnitState.UnApplyEffectFromStats(EffectState, NewGameState);
	EffectState.StatChanges.Length = 0;
	NewEffectState = XComGameState_Effect(NewGameState.ModifyStateObject(class'XComGameState_Effect', EffectState.ObjectID));

	if (NewUnitState.HasSoldierAbility('FireAndFury_LW'))
	{
		StatAmount = (int(NewHeat) / class'X2Ability_SkirmisherAbilitySet_LW'.default.FIRE_FURY_MOBILITY_BONUS_CHARGE_DIVISOR) * class'X2Ability_SkirmisherAbilitySet_LW'.default.FIRE_FURY_MOBILITY_BONUS;
		NewStatChange.StatType = eStat_Mobility;
		NewStatChange.StatAmount = StatAmount;
		NewStatChange.ModOp = MODOP_Addition;
		NewEffectState.StatChanges.AddItem(NewStatChange);
	}
	if (NewUnitState.HasSoldierAbility('BattlefieldAwareness2'))
	{
		StatAmount = (NewHeat * class'X2Ability_SkirmisherAbilitySet_LW'.default.BATTLEFIELD_AWARENESS_DODGE_PER_HEAT);
		NewStatChange.StatType = eStat_Dodge;
		NewStatChange.StatAmount = StatAmount;
		NewStatChange.ModOp = MODOP_Addition;
		NewEffectState.StatChanges.AddItem(NewStatChange);
	}
	NewUnitState.ApplyEffectToStats(NewEffectState, NewGameState);
	`GAMERULES.SubmitGameState(NewGameState);
			
	return ELR_NoInterrupt;
}

// function bool ReapplyHeatBonuses(XComGameState_Effect NewEffectState, XComGameState_Unit NewUnitState)
// {

// }

function bool PostAbilityCostPaid(XComGameState_Effect EffectState, XComGameStateContext_Ability AbilityContext, XComGameState_Ability AbilityState, XComGameState_Unit SourceUnit, XComGameState_Item AffectWeapon, XComGameState NewGameState, const array<name> PreCostActionPoints, const array<name> PreCostReservePoints)
{
	local XComGameState_Unit				NewSourceUnit;
	local UnitValue							CurrentHeatValue;
	//local int								iValue;

	SourceUnit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, CurrentHeatValue);

	// Handle loss of Heat from Grapple abilities: Activated ability must be a valid grapple ability
	if (class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CONSUME_GRAPPLE_ABILITIES.Find(AbilityState.GetMyTemplateName()) != Index_None)
	{
		// If there is Heat to remove, remove it.
		if (CurrentHeatValue.fValue > 0)
		{
			//iValue = Max(0, CurrentHeatValue.fValue - class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_LOSE_PER_GRAPPLE);
			NewSourceUnit = XComGameState_Unit(NewGameState.ModifyStateObject(SourceUnit.Class, SourceUnit.ObjectID));
			NewSourceUnit.SetUnitFloatValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, 0, eCleanup_BeginTactical);
		}
	}

	return false;
}



// function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
// {
// 	local UnitValue								HeatLevelValue;
// 	local int									BonusAmount;
// 	local X2Effect_ApplyWeaponDamage			DamageEffect;

// 	// Only apply when the damage effect is applying the weapon's base damage
// 	if (NewGameState != none)
// 	{
// 		DamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
// 		if (DamageEffect == none || DamageEffect.bIgnoreBaseDamage)
// 		{
// 			return 0;
// 	}	}

// 	if (AbilityState.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef)
// 	{
// 		if (class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
// 		{
// 			Attacker.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, HeatLevelValue);
// 			BonusAmount = int(HeatLevelValue.fValue / class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_DAMAGE_BONUS_CHARGE_DIVISOR) * class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_DAMAGE_BONUS;
// 			return BonusAmount;
// 		}
// 	}
	
// 	return 0;
// }

function float GetPostDefaultAttackingDamageModifier_CH(
	XComGameState_Effect EffectState,
	XComGameState_Unit Attacker,
	Damageable TargetDamageable,
	XComGameState_Ability AbilityState,
	const out EffectAppliedData AppliedData,
	float CurrentDamage,
	X2Effect_ApplyWeaponDamage WeaponDamageEffect,
	XComGameState NewGameState)
{
	local float DamageMultiplier;
	local UnitValue HeatLevelValue;
	if (AbilityState.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef)
	{	
		Attacker.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, HeatLevelValue);
		DamageMultiplier = HeatLevelValue.fValue * class'X2Ability_SkirmisherAbilitySet_LW'.default.RECKONING_BONUS_DAMAGE_PER_HEAT;
		if (AbilityState.GetMyTemplateName() == 'SkirmisherFleche' && class'XComGameStateContext_Ability'.static.IsHitResultHit(AppliedData.AbilityResultContext.HitResult))
		{
			return CurrentDamage * DamageMultiplier;
		}
	}
	return 0;
}



function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo		ShotInfo;
	local UnitValue				HeatLevelValue;
	local int					BonusCritAmount, BonusAimAmount;



	if (AbilityState.SourceWeapon == EffectState.ApplyEffectParameters.ItemStateObjectRef)
	{

		Attacker.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, HeatLevelValue);
		BonusCritAmount = class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CRIT_CHANCE_BONUS * HeatLevelValue.fValue;
		BonusAimAmount = class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_AIM_BONUS * HeatLevelValue.fValue;

		if (BonusCritAmount > 0)
		{
			ShotInfo.ModType = eHit_Crit;
			ShotInfo.Reason = FriendlyName;
			ShotInfo.Value = BonusCritAmount;
			ShotModifiers.AddItem(ShotInfo);

			ShotInfo.ModType = eHit_Success;
			ShotInfo.Reason = FriendlyName;
			ShotInfo.Value = BonusAimAmount;
			ShotModifiers.AddItem(ShotInfo);
		}

	}
}


static function EventListenerReturn RemoveHeatOnHit(Object EventData, Object EventSource, XComGameState GameState, Name Event, Object CallbackData)
{
	local XComGameState_Effect EffectState, NewEffectState;
//	local AvailableTarget Target;
	local XComGameStateHistory History;
	local XComGameState_Unit    TargetUnit, EffectOwner, NewUnitState;
//	local bool TookNormalWeaponDamage;
	local XComGameState NewGameState;
	local UnitValue CurrentHeatValue, MaxHeatValue;
	local float NewHeat;
	local StatChange						NewStatChange;
	local int StatAmount;
	if (GameState.GetContext().InterruptionStatus == eInterruptionStatus_Interrupt)
		return ELR_NoInterrupt;

	EffectState = XComGameState_Effect(CallbackData);

	TargetUnit = XComGameState_Unit(EventData);


	History = `XCOMHISTORY;
	EffectOwner = XComGameState_Unit(History.GetGameStateForObjectID(EffectState.ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	if(TargetUnit != none)
	{
		if(TargetUnit.ObjectId == EffectOwner.ObjectId)
		{
			TargetUnit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, CurrentHeatValue);
			TargetUnit.GetUnitValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_MAX_NAME, MaxHeatValue);
			NewHeat = CurrentHeatValue.fValue;

			if (!TargetUnit.HasSoldierAbility('BattlefieldAwareness2'))
			{
				NewHeat = Max(0, NewHeat - class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_LOSS_ON_DAMAGE);
			}

			// Handle applying Heat changes from above or from direct 'WOTC_APA_Skirmisher_UpdateHeatEffects' triggers
			NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Conditional Stat Change");
			NewUnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', TargetUnit.ObjectID));
			NewUnitState.SetUnitFloatValue(class'X2Ability_SkirmisherAbilitySet_LW'.default.HEATSINK_CURRENT_NAME, NewHeat, eCleanup_BeginTactical);

			NewUnitState.UnApplyEffectFromStats(EffectState, NewGameState);
			EffectState.StatChanges.Length = 0;
			NewEffectState = XComGameState_Effect(NewGameState.ModifyStateObject(class'XComGameState_Effect', EffectState.ObjectID));

			if (NewUnitState.HasSoldierAbility('FireAndFury_LW'))
			{
				StatAmount = (int(NewHeat) / class'X2Ability_SkirmisherAbilitySet_LW'.default.FIRE_FURY_MOBILITY_BONUS_CHARGE_DIVISOR) * class'X2Ability_SkirmisherAbilitySet_LW'.default.FIRE_FURY_MOBILITY_BONUS;
				NewStatChange.StatType = eStat_Mobility;
				NewStatChange.StatAmount = StatAmount;
				NewStatChange.ModOp = MODOP_Addition;
				NewEffectState.StatChanges.AddItem(NewStatChange);
			}
			if (NewUnitState.HasSoldierAbility('BattlefieldAwareness2'))
			{
				StatAmount = (NewHeat * class'X2Ability_SkirmisherAbilitySet_LW'.default.BATTLEFIELD_AWARENESS_DODGE_PER_HEAT);
				NewStatChange.StatType = eStat_Dodge;
				NewStatChange.StatAmount = StatAmount;
				NewStatChange.ModOp = MODOP_Addition;
				NewEffectState.StatChanges.AddItem(NewStatChange);
			}

			NewUnitState.ApplyEffectToStats(NewEffectState, NewGameState);
			`GAMERULES.SubmitGameState(NewGameState);

		}
	}




	return ELR_NoInterrupt;
}