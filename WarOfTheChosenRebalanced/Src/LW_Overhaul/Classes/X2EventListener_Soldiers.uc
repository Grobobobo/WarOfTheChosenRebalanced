class X2EventListener_Soldiers extends X2EventListener config(LW_Overhaul);

var localized string OnLiaisonDuty;
var localized string OnInfiltrationMission;
var localized string UnitAlreadyInSquad;
var localized string UnitInSquad;
var localized string RankTooLow;
var localized string CannotModifyOnMissionSoldierTooltip;
var localized string ReasonClassAbilityPickedAtRank;

var config array<EInventorySlot> UNMODIFIABLE_SLOTS_WHILE_ON_MISSION;

var config bool TIERED_RESPEC_TIMES;
var config int PSI_SQUADDIE_BONUS_ABILITIES;
var config int NUM_HOURS_TO_DAYS;

var config int BLEEDOUT_CHANCE_BASE;
var config int DEATH_CHANCE_PER_OVERKILL_DAMAGE;

struct CustomAbilityCost
{
	var name AbilityName;
	var int AbilityCost;
};

var config array<CustomAbilityCost> CUSTOM_ABILITY_COSTS;
var config array<int> FACTION_ABILITY_COSTS;
var config float BASE_ABILITY_COST_MODIFIER;

var config array<int> INITIAL_PROMOTION_ABILITY_POINTS;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateEquipmentListeners());
	Templates.AddItem(CreateStatusListeners());
	Templates.AddItem(CreatePromotionListeners());
	Templates.AddItem(CreateTrainingListeners());
	Templates.AddItem(CreateTacticalListeners());

	return Templates;
}

////////////////
/// Strategy ///
////////////////

static function CHEventListenerTemplate CreateEquipmentListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'SoldierEquipmentListeners');
	// Template.AddCHEvent('OverrideItemUnequipBehavior', OnOverrideItemUnequipBehavior, ELD_Immediate);
	// Template.AddCHEvent('OverrideItemMinEquipped', OnOverrideItemMinEquipped, ELD_Immediate);
	// Template.AddCHEvent('SoldierCreatedEvent', EquipNewSoldier, ELD_OnStateSubmitted);
	// Template.AddCHEvent('RewardUnitGenerated', EquipNewSoldier, ELD_OnStateSubmitted);
	Template.AddCHEvent('OnGetPCSImage', GetPCSImage, ELD_Immediate);
	Template.RegisterInStrategy = true;

	return Template;
}

static function CHEventListenerTemplate CreateStatusListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'SoldierStatusListeners');
	// Template.AddCHEvent('OverridePersonnelStatusTime', OnOverridePersonnelStatusTime, ELD_Immediate);
	// Template.AddCHEvent('DSLShouldShowPsi', OnShouldShowPsi, ELD_Immediate);
	// Template.AddCHEvent('OverrideInjuryClearingFatigueBehavior', SeperateInjuryAndFatigueTimes, ELD_Immediate);


	Template.RegisterInStrategy = true;

	return Template;
}

static function CHEventListenerTemplate CreatePromotionListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'SoldierPromotionListeners');
	// Template.AddCHEvent('OverrideShowPromoteIcon', OnCheckForPsiPromotion, ELD_Immediate);
	// Template.AddCHEvent('OverridePromotionUIClass', OverridePromotionUIClass, ELD_Immediate, 50);
	// Template.AddCHEvent('OverridePromotionBlueprintTagPrefix', OverridePromotionBlueprintTagPrefix, ELD_Immediate);
	// Template.AddCHEvent('CPS_OverrideCanPurchaseAbility', OverrideCanPurchaseAbility, ELD_Immediate);
	// Template.AddCHEvent('CPS_OverrideAbilityPointCost', OverrideAbilityPointCost, ELD_Immediate);
	// Template.AddCHEvent('CPS_AbilityPurchased', UpdateAbilityCostMultiplier, ELD_Immediate);
	// Template.AddCHEvent('UnitRankUp', OverrideAPGain, ELD_Immediate);

	Template.RegisterInStrategy = true;

	return Template;
}

static function CHEventListenerTemplate CreateTrainingListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'SoldierTraining');
	//Template.AddCHEvent('OverrideRespecSoldierProjectPoints', OverrideRespecSoldierProjectPoints, ELD_Immediate);
	//Template.AddCHEvent('PsiProjectCompleted', OnPsiProjectCompleted, ELD_Immediate);
	Template.RegisterInStrategy = true;

	return Template;
}


////////////////
/// Tactical ///
////////////////

static function CHEventListenerTemplate CreateTacticalListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'TacticalEvents');
	Template.AddCHEvent('OverrideAbilityIconColorImproved', OnOverrideAbilityIconColor, ELD_Immediate);
	Template.AddCHEvent('OverrideBleedoutChance', OnOverrideBleedOutChance, ELD_Immediate);
	//Template.AddCHEvent('OverrideCollectorActivation', OverrideCollectorActivation, ELD_Immediate);
	Template.AddCHEvent('OverrideScavengerActivation', OverrideScavengerActivation, ELD_Immediate);
	
	Template.AddCHEvent('SerialKiller', OnSerialKill, ELD_OnStateSubmitted);
	Template.RegisterInTactical = true;

	return Template;
}

// allows overriding of unequipping items, allowing even infinite utility slot items to be unequipped
static protected function EventListenerReturn OnOverrideItemUnequipBehavior(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComLWTuple			OverrideTuple;
	local XComGameState_Item	ItemState;
	local X2EquipmentTemplate	EquipmentTemplate;

	OverrideTuple = XComLWTuple(EventData);
	if(OverrideTuple == none)
	{
		`REDSCREEN("OverrideItemUnequipBehavior event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	ItemState = XComGameState_Item(EventSource);
	if(ItemState == none)
	{
		`REDSCREEN("OverrideItemUnequipBehavior event triggered with invalid source data.");
		return ELR_NoInterrupt;
	}

	if(OverrideTuple.Id != 'OverrideItemUnequipBehavior')
		return ELR_NoInterrupt;

	//check if item is a utility or pistol slot item
	EquipmentTemplate = X2EquipmentTemplate(ItemState.GetMyTemplate());
	if(EquipmentTemplate != none)
	{
		if(EquipmentTemplate.InventorySlot == eInvSlot_Utility || ItemState.InventorySlot == eInvSlot_Pistol)
		{
			OverrideTuple.Data[0].i = eCHSUB_AllowEmpty;  // item can be unequipped
		}
	}

	return ELR_NoInterrupt;
}

// Allows for completely empty utility slots for soldiers
static protected function EventListenerReturn OnOverrideItemMinEquipped(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComLWTuple			OverrideTuple;
	local XComGameState_Unit	UnitState;

	OverrideTuple = XComLWTuple(EventData);
	if (OverrideTuple == none)
	{
		`REDSCREEN("OverrideItemMinEquipped event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
	{
		`REDSCREEN("OverrideItemMinEquipped event triggered with invalid source data.");
		return ELR_NoInterrupt;
	}

	if (OverrideTuple.Id != 'OverrideItemMinEquipped')
	{
		return ELR_NoInterrupt;
	}

	switch (OverrideTuple.Data[1].i)
	{
		case eInvSlot_Utility:
		case eInvSlot_GrenadePocket:
			OverrideTuple.Data[0].i = 0;
			break;
			
		default:
			break;
	}

	return ELR_NoInterrupt;
}

static function EventListenerReturn OnOverridePersonnelStatusTime(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComLWTuple			OverrideTuple;
	local XComGameState_Unit	UnitState;
	local int					Hours, Days;

	OverrideTuple = XComLWTuple(EventData);
	if (OverrideTuple == none)
	{
		`REDSCREEN("OverridePersonnelStatusTime event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
	{
		`REDSCREEN("OverridePersonnelStatusTime event triggered with invalid source data.");
		return ELR_NoInterrupt;
	}

	if (OverrideTuple.Id != 'OverridePersonnelStatusTime')
	{
		return ELR_NoInterrupt;
	}

	Hours = OverrideTuple.Data[2].i;
	if (Hours < 0 || Hours > 24 * 30 * 12) // Ignore year long missions
	{
		OverrideTuple.Data[1].s = "";
		OverrideTuple.Data[2].i = 0;
		return ELR_NoInterrupt;
	}

	if (Hours > default.NUM_HOURS_TO_DAYS)
	{
		Days = FCeil(float(Hours) / 24.0f);
		OverrideTuple.Data[1].s = class'UIUtilities_Text'.static.GetDaysString(Days);
		OverrideTuple.Data[2].i = Days;
	}
	else
	{
		OverrideTuple.Data[1].s = class'UIUtilities_Text'.static.GetHoursString(Hours);
		OverrideTuple.Data[2].i = Hours;
	}
}

static function EventListenerReturn OnShouldShowPsi(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit UnitState;
	local LWTuple Tuple;

	Tuple = LWTuple(EventData);
	if (Tuple == none)
	{
		`REDSCREEN("OnShouldShowPsi event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
	{
		`REDSCREEN("OnShouldShowPsi event triggered with invalid source data.");
		return ELR_NoInterrupt;
	}

	if (Tuple.Id != 'ShouldShowPsi')
	{
		return ELR_NoInterrupt;
	}
	
	if (class'UIUtilities_LW'.static.ShouldShowPsiOffense(UnitState))
	{
		Tuple.Data[0].b = true;
	}

	return ELR_NoInterrupt;
}


static function EventListenerReturn SeperateInjuryAndFatigueTimes(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit UnitState;
	local XComLWTuple Tuple;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
	{
		`REDSCREEN("SeperateInjuryAndFatigueTimes event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
	{
		`REDSCREEN("SeperateInjuryAndFatigueTimes event triggered with invalid source data.");
		return ELR_NoInterrupt;
	}

	if (Tuple.Id != 'OverrideInjuryClearingFatigueBehavior')
	{
		return ELR_NoInterrupt;
	}
	

	Tuple.Data[0].b = true;
	
	return ELR_NoInterrupt;
}


static function EventListenerReturn OnCheckForPsiPromotion(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit UnitState;

	Tuple = XComLWTuple(EventData);
	if(Tuple == none)
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(EventSource);
	if(UnitState == none)
	{
		`REDSCREEN("OnCheckForPsiPromotion event triggered with invalid event source.");
		return ELR_NoInterrupt;
	}

	if (Tuple.Data[0].kind != XComLWTVBool)
		return ELR_NoInterrupt;

	if (UnitState.IsPsiOperative())
	{
		if (class'Utilities_PP_LW'.static.CanRankUpPsiSoldier(UnitState))
		{
			Tuple.Data[0].B = true;
		}
	}
	return ELR_NoInterrupt;
}

// This function makes sure that the camera is placed in the right place
// on the After Action screen when a unit is being promoted from there.
// It basically sets the promotion blueprint tag to the hero one for all
// soldiers, since we're using the hero promotion screen for all of them.
static function EventListenerReturn OverridePromotionUIClass(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	if (class'Helpers_LW'.static.IsModInstalled("XCOM2RPGOverhaul"))
	{
		// Prevent CPS from overriding RPGO's promotion screen.
		return ELR_InterruptListeners;
	}
	else
	{
		return ELR_NoInterrupt;
	}
}

//Makes the resistance heroes have normal AP growths instead of whatever the fuck they get
static function EventListenerReturn OverrideAPGain(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComGameState_Unit UnitState;
//	local XComGameState NewGameState;
	local UnitValue FreePromotionValue;

	if (GameState.GetContext().InterruptionStatus == eInterruptionStatus_Interrupt)
	{
		return ELR_NoInterrupt;
	}

	UnitState = XComGameState_Unit(EventData);

	//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Change AP Gain");
	UnitState = XComGameState_Unit(GameState.GetGameStateForObjectID(UnitState.ObjectID));

	UnitState.GetUnitValue('GTO_FreePromotionAP',FreePromotionValue);
	//Redundant checks because I don't want to spam gamestates in the strategy
	if(FreePromotionValue.fValue < 1.0f || UnitState.IsResistanceHero())
	{
		//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Change AP Gain");
		UnitState = XComGameState_Unit(GameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));

	//Add Some starting AP to soldiers
		if(FreePromotionValue.fValue < 1.0f)
		{
			UnitState.AbilityPoints = UnitState.AbilityPoints + default.INITIAL_PROMOTION_ABILITY_POINTS[UnitState.Comint];
			UnitState.SetUnitFloatValue('GTO_FreePromotionAP', 2.0f, eCleanup_Never);

		}
		if( UnitState.IsResistanceHero())
		{
			UnitState.AbilityPoints = UnitState.AbilityPoints + UnitState.GetBaseSoldierAPAmount(UnitState.Comint);
			UnitState.AbilityPoints = UnitState.AbilityPoints - UnitState.GetResistanceHeroAPAmount(UnitState.GetSoldierRank(), UnitState.ComInt);
		}
	//	`GAMERULES.SubmitGameState(NewGameState);
	}


	return ELR_NoInterrupt;

}

// This function makes sure that the camera is placed in the right place
// on the After Action screen when a unit is being promoted from there.
// It basically sets the promotion blueprint tag to the hero one for all
// soldiers, since we're using the hero promotion screen for all of them.
static function EventListenerReturn OverridePromotionBlueprintTagPrefix(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	// If RPGO is installed, we'll leave it to that mod to handle the
	// After Action blueprint tags.
	if (class'Helpers_LW'.static.IsModInstalled("XCOM2RPGOverhaul"))
	{
		// Prevent CPS from overriding RPGO's promotion screen.
		return ELR_InterruptListeners;
	}

	return ELR_NoInterrupt;
}

// Prevents access to multiple class abilities at a single rank unless
// the 'AllowSameRankAbilities' second wave option is enabled. Also
// unlocks XCOM row and pistol row abilities at *all* ranks as soon as
// the Training Center has been built.
static function EventListenerReturn OverrideCanPurchaseAbility(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComGameState_Unit UnitState;
	local XComLWTuple Tuple;
	local int Rank, Branch;
	local int ClassAbilityRankCount; //Rank is 0 indexed but AbilityRanks is not. This means a >= comparison requires no further adjustments

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
		return ELR_NoInterrupt;

	Rank = Tuple.Data[1].i;
	Branch = Tuple.Data[2].i;
	ClassAbilityRankCount = Tuple.Data[11].i;

	// Don't allow purchase of other class abilities at same rank as an already
	// picked one (unless second wave option enabled)
	if (!`SecondWaveEnabled('AllowSameRankAbilities') && UnitState.HasPurchasedPerkAtRank(Rank, ClassAbilityRankCount) && Branch < ClassAbilityRankCount)
	{
		Tuple.Data[13].b = false; // CanPurchaseAbility
		Tuple.Data[15].s = default.ReasonClassAbilityPickedAtRank; // LocReasonLocked
		return ELR_NoInterrupt;
	}

	// All non-class abilities should be available for purchase as soon as the
	// training center has been built.
	if (Branch >= ClassAbilityRankCount)
	{
		if (`XCOMHQ.HasFacilityByName('RecoveryCenter'))
		{
			if(Tuple.Data[12].b)
			{
				Tuple.Data[13].b = true;
			}
			else
			{
				Tuple.Data[13].b = false;
				Tuple.Data[14].i = 3;   // Reason: Not enough AP
			}
		}
		else
		{
			Tuple.Data[13].b = false;
			Tuple.Data[14].i = 2;   // Reason: No Training Center
		}
	}

	return ELR_NoInterrupt;
}

// Handles the 'AllowSameRankAbilities' second wave option by applying
// the current ability cost multiplier for the given unit.
static function EventListenerReturn OverrideAbilityPointCost(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComGameState_Unit UnitState;
	local XComLWTuple Tuple;
	local name AbilityName;
	local int Branch, Rank, idx;
	local int AbilityCost, ClassAbilityRankCount;
	local UnitValue AbilityCostModifier;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
		return ELR_NoInterrupt;

	AbilityCost = Tuple.Data[12].i;
	AbilityName = Tuple.Data[0].n;
	Rank = Tuple.Data[1].i;
	Branch = Tuple.Data[2].i;
	ClassAbilityRankCount = Tuple.Data[11].i;

	// Skip custom ability costs if this is a free ability from promotion
	if (AbilityCost == 0)
		return ELR_NoInterrupt;

	// Default ability point costs used for XCOM-row abilities
	AbilityCost = class'X2StrategyGameRulesetDataStructures'.default.AbilityPointCosts[Rank];

	// If we get here for non-Resistance heroes, then the player is
	// attempting to purchase an ability, in which case the base ability
	// cost is the same as for faction soldiers. Faction soldiers need
	// to go through this route anyway.
	if (Branch < ClassAbilityRankCount)
	{
		AbilityCost = default.FACTION_ABILITY_COSTS[Rank];
	}
	else
	{
		idx = default.CUSTOM_ABILITY_COSTS.Find('AbilityName', AbilityName);
		if (idx != INDEX_NONE)
		{
			AbilityCost = default.CUSTOM_ABILITY_COSTS[idx].AbilityCost;
		}
	}

	if (UnitState.HasPurchasedPerkAtRank(Rank, ClassAbilityRankCount) && Branch < ClassAbilityRankCount)
	{
		AbilityCost = Max(0,40 - class'X2StrategyGameRulesetDataStructures'.default.AbilityPointCosts[Rank]); 
		// Increase cost of this perk by current ability cost modifier
		UnitState.GetUnitValue('LWOTC_AbilityCostModifier', AbilityCostModifier);
		if (AbilityCostModifier.fValue == 0)
		{
			AbilityCostModifier.fValue = 1.0 + default.BASE_ABILITY_COST_MODIFIER;
		}
		AbilityCost *= AbilityCostModifier.fValue;
	}

	Tuple.Data[12].i = AbilityCost;

	return ELR_NoInterrupt;
}

// Updates the unit value that keeps track of the multiplier use to
// increase the cost of class abilities when a class ability has already
// been purchased at a given rank.
static function EventListenerReturn UpdateAbilityCostMultiplier(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local XComGameState_Unit UnitState, PrevUnitState;
	local XComLWTuple Tuple;
	local int Branch, Rank;
	local int ClassAbilityRankCount;
	local UnitValue AbilityCostModifier;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
		return ELR_NoInterrupt;

	UnitState = XComGameState_Unit(EventSource);
	if (UnitState == none)
		return ELR_NoInterrupt;

	Rank = Tuple.Data[0].i;
	Branch = Tuple.Data[1].i;
	ClassAbilityRankCount = Tuple.Data[2].i;

	// We need to know whether the unit had already purchased a class ability
	// at this rank before this new ability was purchased. So we look in the
	// history (before the game state with the new purchase is submitted).
	PrevUnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitState.ObjectID));

	// Initialise the ability cost modifier for the unit if it hasn't been
	// done yet.
	PrevUnitState.GetUnitValue('LWOTC_AbilityCostModifier', AbilityCostModifier);
	if (AbilityCostModifier.fValue == 0)
	{
		AbilityCostModifier.fValue = 1.0 + default.BASE_ABILITY_COST_MODIFIER;
	}

	// For every extra perk that's purchased at a rank that already
	// has a perk purchased, increase its cost.
	if (PrevUnitState.HasPurchasedPerkAtRank(Rank, ClassAbilityRankCount) && Branch < ClassAbilityRankCount)
	{
		UnitState = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', UnitState.ObjectID));
		UnitState.SetUnitFloatValue('LWOTC_AbilityCostModifier', AbilityCostModifier.fValue + default.BASE_ABILITY_COST_MODIFIER, eCleanup_Never);
	}

	return ELR_NoInterrupt;
}

// Scale the respec time for soldiers based on their rank
static function EventListenerReturn OverrideRespecSoldierProjectPoints(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit UnitState;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
	{
		`LWTRACE("OverrideRespecSoldierProjectPoints event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	UnitState = XComGameState_Unit(Tuple.Data[0].o);
	if (UnitState == none)
	{
		`LWTRACE ("OverrideRespecSoldierProjectPoints was not passed a valid unit state.");
		return ELR_NoInterrupt;
	}

	if (default.TIERED_RESPEC_TIMES)
	{
		// Respec days = rank * difficulty setting
		Tuple.Data[1].i = UnitState.GetRank() * class'XComGameState_HeadquartersXCom'.default.XComHeadquarters_DefaultRespecSoldierDays[`STRATEGYDIFFICULTYSETTING] * 24;
	}

	return ELR_NoInterrupt;
}

// Grants bonus psi abilities after promotion to squaddie
static function EventListenerReturn OnPsiProjectCompleted(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;
	local XComGameState_Unit UnitState;
	local X2SoldierClassTemplate SoldierClassTemplate;
	local int BonusAbilityRank, BonusAbilityBranch, BonusAbilitiesGranted, Tries;
	local name BonusAbility;
	local XComGameState NewGameState;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none)
	{
		`LWTRACE("OnPsiProjectCompleted event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	UnitState = XComGameState_Unit(Tuple.Data[0].o);
	if (UnitState == none || UnitState.GetRank() != 1)
	{
		`LWTRACE ("OnPsiProjectCompleted could not find valid unit state.");
		return ELR_NoInterrupt;
	}

	BonusAbilitiesGranted = 0;
	SoldierClassTemplate = UnitState.GetSoldierClassTemplate();
	if (SoldierClassTemplate == none)
	{
		`LWTRACE ("OnPsiProjectCompleted could not find valid class template for unit.");
		return ELR_NoInterrupt;
	}

	Tries = 0;
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Granting Bonus Psi Starter abilities");
	while (BonusAbilitiesGranted < default.PSI_SQUADDIE_BONUS_ABILITIES)
	{
		BonusAbilityRank = `SYNC_RAND_STATIC(1 + (default.PSI_SQUADDIE_BONUS_ABILITIES / 2));
		BonusAbilityBranch = `SYNC_RAND_STATIC(2);
		BonusAbility = SoldierClassTemplate.GetAbilitySlots(BonusAbilityRank)[BonusAbilityBranch].AbilityType.AbilityName;
		Tries += 1;

		if (!UnitState.HasSoldierAbility(BonusAbility, true))
		{
			if (UnitState.BuySoldierProgressionAbility(NewGameState,BonusAbilityRank,BonusAbilityBranch))
			{
				BonusAbilitiesGranted += 1;
				`LWTRACE("OnPsiProjectCompleted granted bonus ability " $ string(BonusAbility));
			}
		}
		if (Tries > 999)
		{
			`LWTRACE ("OnPsiProjectCompleted Can't find an ability");
			break;
		}
	}

	if (BonusAbilitiesGranted > 0)
	{
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
		`LWTRACE("OnPsiProjectCompleted granted unit " $ UnitState.GetFullName() @ string(BonusAbilitiesGranted) $ " extra psi abilities.");
	}
	else
	{
		`XCOMHISTORY.CleanupPendingGameState(NewGameState);
	}

	return ELR_NoInterrupt;
}

static private function UIScreen GetScreenOrChild(name ScreenType)
{
	local UIScreenStack ScreenStack;
	local int Index;
	ScreenStack = `SCREENSTACK;
	for( Index = 0; Index < ScreenStack.Screens.Length;  ++Index)
	{
		if(ScreenStack.Screens[Index].IsA(ScreenType))
			return ScreenStack.Screens[Index];
	}
	return none;
}

static private function SetStatusTupleData(
	XComLWTuple Tuple,
	string Status,
	string TimeLabel,
	string TimeValueOverride,
	int TimeValue,
	EUIState State,
	bool HideTime)
{
	Tuple.Data[0].s = Status;
	Tuple.Data[1].s = TimeLabel;
	Tuple.Data[2].s = TimeValueOverride;
	Tuple.Data[3].i = TimeValue;
	Tuple.Data[4].i = int(State);
	Tuple.Data[5].b = HideTime;
	Tuple.Data[6].b = TimeValueOverride == "";
}

// This takes on a bunch of exceptions to color ability icons
static function EventListenerReturn OnOverrideAbilityIconColor(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComLWTuple					OverrideTuple;
	local Name							AbilityName;
	local XComGameState_Ability			AbilityState;
	local X2AbilityTemplate				AbilityTemplate;
	local X2AbilityCost_ActionPoints	ActionPoints;
	local XComGameState_Unit			UnitState;
	local XComGameState_Item			WeaponState;
	local array<X2WeaponUpgradeTemplate> WeaponUpgrades;
	local int k, k2, ActionPointCost;
	local bool IsFree, IsTurnEnding, IsPsionic;
	local UnitValue FreeReloadValue, CountUnitValue;
	local string ForegroundColor, BackgroundColor;

	OverrideTuple = XComLWTuple(EventData);
	if(OverrideTuple == none)
	{
		`REDSCREEN("OnOverrideAbilityIconColor event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	AbilityState = XComGameState_Ability(EventSource);
	if (AbilityState == none)
	{
		`LWTRACE ("No ability state fed to OnOverrideAbilityIconColor");
		return ELR_NoInterrupt;
	}

	// First check that we are colouring the action icons
	if (!class'LWTemplateMods'.default.USE_ACTION_ICON_COLORS ||
		class'Helpers_LW'.static.IsModInstalled("WOTC_CostBasedAbilityColors"))
	{
		return ELR_NoInterrupt;
	}

	// Easy handling of abilities that target objectives
	if (OverrideTuple.Data[0].b)
	{
		OverrideTuple.Data[1].s = class'LWTemplateMods'.default.ICON_COLOR_OBJECTIVE;
		return ELR_NoInterrupt;
	}

	// Drop out if the existing icon color is not "Variable"
	if (OverrideTuple.Data[1].s != "Variable")
	{
		return ELR_NoInterrupt;
	}

	// Now deal with the "Variable" ability icons
	AbilityTemplate = AbilityState.GetMyTemplate();
	AbilityName = AbilityState.GetMyTemplateName();
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.OwnerStateObject.ObjectID));
	WeaponState = AbilityState.GetSourceWeapon();
	IsPsionic = AbilityTemplate.AbilitySourceName == 'eAbilitySource_Psionic';
	BackgroundColor = OverrideTuple.Data[1].s;
	ForegroundColor = OverrideTuple.Data[2].s;

	if (UnitState == none)
	{
		`LWTRACE ("No UnitState found for OverrideAbilityIconColors");
		return ELR_NoInterrupt;
	}

	// Salvo, Quickburn, Holotarget
	for (k = 0; k < AbilityTemplate.AbilityCosts.Length; k++)
	{
		ActionPoints = X2AbilityCost_ActionPoints(AbilityTemplate.AbilityCosts[k]);
		if (ActionPoints != none)
		{
			ActionPointCost = ActionPoints.iNumPoints;
			if (ActionPoints.bAddWeaponTypicalCost)
			{
				ActionPointCost = X2WeaponTemplate(WeaponState.GetMyTemplate()).iTypicalActionCost;
			}

			IsFree = ActionPoints.bFreeCost;
			IsTurnEnding = ActionPoints.bConsumeAllPoints;

			if (IsTurnEnding)
			{
				// Handle DoNotConsumeAllSoldierAbilities
				for (k2 = 0; k2 < ActionPoints.DoNotConsumeAllSoldierAbilities.Length; k2++)
				{
					if (UnitState.HasSoldierAbility(ActionPoints.DoNotConsumeAllSoldierAbilities[k2], true))
					{
						IsTurnEnding = false;
						break;
					}
				}

				// Handle Quickdraw
				if (X2AbilityCost_QuickdrawActionPoints(ActionPoints) != none && UnitState.HasSoldierAbility('Quickdraw'))
				{
					IsTurnEnding = false;
				}
			}
		}
	}

	switch (AbilityName)
	{
		case 'ThrowGrenade':
			if (UnitState.AffectedByEffectNames.Find('RapidDeploymentEffect') != -1)
			{
				IsTurnEnding = false;
				IsFree = true;
			}
			if(UnitState.HasSoldierAbility('FreeGrenades'))
			{
				UnitState.GetUnitValue('GrenadierUses', CountUnitValue);
			
				if (CountUnitValue.fValue == 0)
				{
					IsFree = true;
					IsTurnEnding = false;
				}	
			}

			break;
		case 'LaunchGrenade':
			if (UnitState.AffectedByEffectNames.Find('RapidDeploymentEffect') != -1)
			{
				IsTurnEnding = false;
				IsFree = true;
			}
			if(UnitState.HasSoldierAbility('FreeGrenades'))
			{
				UnitState.GetUnitValue('GrenadierUses', CountUnitValue);
			
				if (CountUnitValue.fValue == 0)
				{
					IsFree = true;
					IsTurnEnding = false;
				}	
			}
			break;
		case 'ArcThrowerStun':
		case 'EMPulser':
		case 'ChainLightning':
			if (UnitState.AffectedByEffectNames.Find(class'X2Ability_XMBPerkAbilitySet'.default.QuickZapEffectName) != -1)
			{
				UnitState.GetUnitValue('QuickZap_LW_Uses', CountUnitValue);
				if (CountUnitValue.fValue == 0)
				{
					IsTurnEnding = false;
					IsFree = true;
				}
			}
			break;
		case 'LWFlamethrower':
		case 'Roust':
		case 'Firestorm':
			if (UnitState.AffectedByEffectNames.Find('QuickburnEffect') != -1)
			{
				IsTurnEnding = false;
				IsFree = true;
			}
			break;
		case 'Reload':
			WeaponUpgrades = WeaponState.GetMyWeaponUpgradeTemplates();
			for (k = 0; k < WeaponUpgrades.Length; k++)
			{
				if (WeaponUpgrades[k].NumFreeReloads > 0)
				{
					UnitState.GetUnitValue ('FreeReload', FreeReloadValue);
					if (FreeReloadValue.fValue < WeaponUpgrades[k].NumFreeReloads)
					{
						IsTurnEnding = false;
						IsFree = true;
					}
					break;
				}
			}
			break;
		case 'PlaceEvacZone':
		case 'PlaceDelayedEvacZone':
			`LWTRACE ("Attempting to change EVAC color");
			class'XComGameState_BattleData'.static.HighlightObjectiveAbility(AbilityName, true);
			return ELR_NoInterrupt;
			break;
		// case 'MedikitHeal':
		// case 'NanoMedikitHeal':
		// if(UnitState.HasSoldierAbility('Paramedic_LW'))
		// {
		// 	UnitState.GetUnitValue('ParamedicUses', CountUnitValue);
		
		// 	if (CountUnitValue.fValue == 0)
		// 	{
		// 		IsFree = true;
		// 	}	
		// }
		// break;
		default: break;
	}

	class'Utilities_LW'.static.GetAbilityIconColor(OverrideTuple.Data[0].b, IsFree, IsPsionic, IsTurnEnding, ActionPointCost, BackgroundColor, ForegroundColor);
	OverrideTuple.Data[1].s = BackgroundColor;
	OverrideTuple.Data[2].s = ForegroundColor;

	return ELR_NoInterrupt;
}

static function EventListenerReturn  OnOverrideBleedOutChance(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComLWTuple				OverrideTuple;
	local int						BleedOutChance;
	local XComGameState_HeadquartersXCom XComHQ;

	OverrideTuple = XComLWTuple(EventData);
	if(OverrideTuple == none)
	{
		`REDSCREEN("OnOverrideBleedOutChance event triggered with invalid event data.");
		return ELR_NoInterrupt;
	}

	BleedOutChance = default.BLEEDOUT_CHANCE_BASE - (OverrideTuple.Data[2].i * default.DEATH_CHANCE_PER_OVERKILL_DAMAGE);

	XComHQ = XComGameState_HeadquartersXCom(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
	
	if (XComHQ != none && XComHQ.SoldierUnlockTemplates.Find('StayWithMeUnlock') != INDEX_NONE)
	{
		`log("Applying bonus chance for StayWithMeUnlock...",,'XCom_HitRolls');
		BleedOutChance += class'X2StatusEffects'.default.BLEEDOUT_BONUS_ROLL;
	}

	// Tuple data consists of:
	//   0: Bleed out chance
	//   1: Size of die to roll
	//   2: Overkill damage, i.e. how much damage was dealt over and above what was needed
	//      to take the solider to 0 health.
	OverrideTuple.Data[0].i = BleedOutChance;

	return ELR_NoInterrupt;

}

// Equips new soldiers with the default utility items.
static function EventListenerReturn EquipNewSoldier(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Unit Unit, UpdatedUnit;
	local XComGameState NewGameState;

	Unit = XComGameState_Unit(EventData);
	if (Unit == none)
	{
		`REDSCREEN("OnSoldierCreatedEvent with no UnitState EventData");
		return ELR_NoInterrupt;
	}

	//Build NewGameState change container
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Update newly created soldier");
	UpdatedUnit = XComGameState_Unit(NewGameState.ModifyStateObject(class'XComGameState_Unit', Unit.ObjectID));
	class'Utilities_LW'.static.GiveDefaultUtilityItemsToSoldier(UpdatedUnit, NewGameState);
	`GAMERULES.SubmitGameState(NewGameState);

	return ELR_NoInterrupt;
}

static function EventListenerReturn OverrideCollectorActivation(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local LWTuple OverrideActivation;

	OverrideActivation = LWTuple(EventData);
	`assert(OverrideActivation != none);
	`assert(OverrideActivation.Id == 'OverrideCollectorActivation');
	`assert(OverrideActivation.Data[0].kind == LWTVBool);

	OverrideActivation.Data[0].b = class'Utilities_LW'.static.KillXpIsCapped();

	return ELR_NoInterrupt;
}

static function EventListenerReturn OverrideScavengerActivation(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local LWTuple OverrideActivation;

	OverrideActivation = LWTuple(EventData);
	`assert(OverrideActivation != none);
	`assert(OverrideActivation.Id == 'OverrideScavengerActivation');
	`assert(OverrideActivation.Data[0].kind == LWTVBool);

	OverrideActivation.Data[0].b = class'Utilities_LW'.static.KillXpIsCapped();

	return ELR_NoInterrupt;
}

// Provide images for all the new PCSes LWOTC adds.
static function EventListenerReturn GetPCSImage(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComLWTuple			OverridePCSImageTuple;
	local XComGameState_Item	ItemState;

	OverridePCSImageTuple = XComLWTuple(EventData);
	`assert(OverridePCSImageTuple != none);

	ItemState = XComGameState_Item(OverridePCSImageTuple.Data[0].o);
	if (ItemState == none)
	{
		return ELR_NoInterrupt;
	}

	switch (ItemState.GetMyTemplateName())
	{
		case 'DepthPerceptionPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_depthperception"; break;
		case 'HyperReactivePupilsPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_hyperreactivepupils"; break;
		case 'CombatAwarenessPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_threatassessment"; break;
		case 'DamageControlPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_damagecontrol"; break;
		case 'AbsorptionFieldsPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_impactfield"; break;
		case 'BodyShieldPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_bodyshield"; break;
		case 'EmergencyLifeSupportPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_emergencylifesupport"; break;
		case 'IronSkinPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_ironskin"; break;
		case 'SmartMacrophagesPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_smartmacrophages"; break;
		case 'CombatRushPCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_combatrush"; break;
		case 'CommonPCSDefense': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_defense"; break;
		case 'RarePCSDefense': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_defense"; break;
		case 'EpicPCSDefense': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_defense"; break;
		case 'CommonPCSAgility': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_dodge"; break;
		case 'RarePCSAgility': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_dodge"; break;
		case 'EpicPCSAgility': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_dodge"; break;
		case 'CommonPCSHacking': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_hacking"; break;
		case 'RarePCSHacking': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_hacking"; break;
		case 'EpicPCSHacking': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_hacking"; break;
		case 'FireControl25PCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_firecontrol"; break;
		case 'FireControl50PCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_firecontrol"; break;
		case 'FireControl75PCS': OverridePCSImageTuple.Data[1].s = "img:///UILibrary_LW_Overhaul.implants_firecontrol"; break;

		default: break;
	}

	return ELR_NoInterrupt;
}

// Attempt to tame Serial by tracking kills and reducing crit for each kill.
static function EventListenerReturn OnSerialKill(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit ShooterState;
    local UnitValue UnitVal;

	ShooterState = XComGameState_Unit (EventSource);
	if (ShooterState == none)
	{
		return ELR_NoInterrupt;
	}

	ShooterState.GetUnitValue ('SerialKills', UnitVal);
	ShooterState.SetUnitFloatValue ('SerialKills', UnitVal.fValue + 1.0, eCleanup_BeginTurn);
	return ELR_NoInterrupt;
}
