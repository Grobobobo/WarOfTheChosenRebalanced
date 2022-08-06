//---------------------------------------------------------------------------------------
//  FILE:    SeqAct_ControlCivilian.uc
//  AUTHOR:  tracktwo / LWS
//  PURPOSE: Swaps an approached civilian to the xcom team to be controllable for evac.
//---------------------------------------------------------------------------------------

class X2StrategyElement_DefaultRewards_LW extends X2StrategyElement_DefaultRewards config(GameData);

const REBEL_REWARD_NAME='Reward_Rebel';
const RESISTANCE_MEC_REWARD_NAME='Reward_ResistanceMEC';
const NEW_RESOURCES_REWARD_NAME='Reward_NewResources';
const CORPSE_REWARD_NAME='Reward_EnemyCorpses';

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Rewards;

	`LWTrace("  >> X2StrategyElement_DefaultRewards_LW.CreateTemplates()");
	
	Rewards.AddItem(CreatePOIRewardTemplate());
	Rewards.AddItem(CreateDummyEnemyMaterielRewardTemplate());
	Rewards.AddItem(CreateDummyUnknownRewardTemplate());
	Rewards.AddItem(CreateDummyUnhinderedRewardTemplate());
	Rewards.AddItem(CreateDummyPOIRewardTemplate());
	Rewards.AddItem(CreateDummyRegionalNetworkTowerRewardTemplate());
	Rewards.AddItem(CreateRadioRelayRewardTemplate());
	Rewards.AddItem(CreateFactionInfluenceRewardTemplate());
	Rewards.AddItem(CreateEnemyCorpsesRewardTemplate());
	Rewards.AddItem(CreateDummyStatBoostRewardTemplate());
	Rewards.AddItem(CreateResistanceCardRewardTemplate_LW());

	
	return Rewards;
}

static function bool AlwaysFalseAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
    return false;
}

static function bool AlwaysFalseNeeded()
{
    return false;
}

static function bool AvailableForCovertActionsOnly(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
    return XComGameState_ResistanceFaction(`XCOMHISTORY.GetGameStateForObjectID(AuxRef.ObjectID)) != none;
}

static function X2DataTemplate CreatePOIRewardTemplate()
{
    local X2RewardTemplate Template;

   	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_POI_LW');
	Template.rewardObjectTemplateName = 'POI';

	Template.GenerateRewardFn = GeneratePOIReward;
	Template.SetRewardFn = SetPOIReward;
	Template.GiveRewardFn = GivePOIReward;
	Template.GetRewardStringFn = GetPOIRewardString;
	
	Template.GetRewardIconFn = class'X2StrategyElement_DefaultRewards'.static.GetGenericRewardIcon;

    return Template;
}

function string GetPOIRewardString(XComGameState_Reward RewardState)
{
	return RewardState.GetMyTemplate().DisplayName;
}

function GeneratePOIReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference RegionRef)
{
	RewardState.Quantity = 1;
}

function SetPOIReward(XComGameState_Reward RewardState, optional StateObjectReference RewardObjectRef, optional int Amount)
{
	RewardState.Quantity = Amount;
}

function GivePOIReward(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool border = false, optional int OrderHours = -1)
{
}

function string GetSimpleRewardString(XComGameState_Reward RewardState)
{
	return RewardState.GetMyTemplate().DisplayName;
}

static function X2DataTemplate CreateDummyEnemyMaterielRewardTemplate()
{
    local X2RewardTemplate Template;

   	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_Dummy_Materiel');

	Template.GenerateRewardFn = none;
	Template.SetRewardFn = none;
	Template.GiveRewardFn = none;
	Template.GetRewardStringFn = GetSimpleRewardString;
	Template.GetRewardIconFn = class'X2StrategyElement_DefaultRewards'.static.GetGenericRewardIcon;

    return Template;
}

static function X2DataTemplate CreateDummyUnknownRewardTemplate()
{
    local X2RewardTemplate Template;

   	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_Dummy_Unknown');
	Template.GenerateRewardFn = none;
	Template.SetRewardFn = none;
	Template.GiveRewardFn = none;
	Template.GetRewardStringFn = GetSimpleRewardString;
	Template.GetRewardIconFn = class'X2StrategyElement_DefaultRewards'.static.GetGenericRewardIcon;

    return Template;
}


static function X2DataTemplate CreateDummyRegionalNetworkTowerRewardTemplate()
{
    local X2RewardTemplate Template;

   	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_Dummy_RegionalTower');
	Template.GenerateRewardFn = none;
	Template.SetRewardFn = none;
	Template.GiveRewardFn = none;
	Template.GetRewardStringFn = GetSimpleRewardString;
	Template.GetRewardIconFn = class'X2StrategyElement_DefaultRewards'.static.GetGenericRewardIcon;

    return Template;
}

static function X2DataTemplate CreateDummyUnhinderedRewardTemplate()
{
    local X2RewardTemplate Template;

   	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_Dummy_Unhindered');
	Template.GenerateRewardFn = none;
	Template.SetRewardFn = none;
	Template.GiveRewardFn = none;
	Template.GetRewardStringFn = GetSimpleRewardString;
	Template.GetRewardIconFn = class'X2StrategyElement_DefaultRewards'.static.GetGenericRewardIcon;

    return Template;
}

static function X2DataTemplate CreateDummyPOIRewardTemplate()
{
    local X2RewardTemplate Template;

   	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_Dummy_POI');
	Template.GenerateRewardFn = none;
	Template.SetRewardFn = none;
	Template.GiveRewardFn = none;
	Template.GetRewardStringFn = GetPOIRewardString;
	Template.GetRewardIconFn = class'X2StrategyElement_DefaultRewards'.static.GetGenericRewardIcon;

    return Template;
}

function GiveRadioRelayReward(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
    local XComGameStateHistory History;
    local XComGameState_WorldRegion Region;

	History = `XCOMHISTORY;
    Region = XComGameState_WorldRegion(History.GetGameStateForObjectID(AuxRef.ObjectID));
	Region.SetResistanceLevel(NewGameState, eResLevel_Outpost);
}

static function X2DataTemplate CreateRadioRelayRewardTemplate()
{
    local X2RewardTemplate Template;

    `CREATE_X2Reward_TEMPLATE(Template, 'Reward_Radio_Relay');
    Template.IsRewardAvailableFn = AlwaysFalseAvailable;
    Template.IsRewardNeededFn = AlwaysFalseNeeded;
    Template.GiveRewardFn = GiveRadioRelayReward;
    Template.GetRewardStringFn = GetSimpleRewardString;
    Template.GetRewardIconFn = class'X2StrategyElement_DefaultRewards'.static.GetGenericRewardIcon;
    return Template;
}

static function X2DataTemplate CreateFactionInfluenceRewardTemplate()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_FactionInfluence_LW');

	Template.IsRewardAvailableFn = AlwaysFalseAvailable;
	Template.IsRewardNeededFn = AlwaysFalseNeeded;
	Template.GenerateRewardFn = GenerateFactionInfluenceReward;
	Template.GiveRewardFn = GiveFactionInfluenceReward;
	Template.GetRewardImageFn = GetFactionInfluenceRewardImage;
	Template.GetRewardStringFn = GetFactionInfluenceRewardString;
	Template.CleanUpRewardFn = class'X2StrategyElement_DefaultRewards'.static.CleanUpRewardWithoutRemoval;

	return Template;
}

static function GenerateFactionInfluenceReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference RegionRef)
{
	RewardState.RewardObjectReference = RegionRef;
}

static function GiveFactionInfluenceReward(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference RegionRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameState_ResistanceFaction FactionState;

	FactionState = XComGameState_ResistanceFaction(NewGameState.ModifyStateObject(
        class'XComGameState_ResistanceFaction', class'Helpers_LW'.static.GetFactionFromRegion(RegionRef).ObjectID));
	FactionState.IncreaseInfluenceLevel(NewGameState);
}

static function string GetFactionInfluenceRewardImage(XComGameState_Reward RewardState)
{
	local XComGameState_AdventChosen ChosenState;

	ChosenState = class'Helpers_LW'.static.GetFactionFromRegion(RewardState.RewardObjectReference).GetRivalChosen();

	return ChosenState.GetHuntChosenImage(0);
}

static function string GetFactionInfluenceRewardString(XComGameState_Reward RewardState)
{
	return RewardState.GetMyTemplate().DisplayName;
}

static function X2DataTemplate CreateEnemyCorpsesRewardTemplate()
{
    local X2RewardTemplate Template;

    `CREATE_X2Reward_TEMPLATE(Template, const.CORPSE_REWARD_NAME);
    Template.rewardObjectTemplateName = 'EnemyCorpses';

    // Corpses are never available or needed. This isn't checked by the activity manager system, only the black market and
    // resistance HQ. This prevents corpses from appearing for purchase in these places.
    Template.IsRewardAvailableFn = IsCorpseRewardAvailable;
    Template.IsRewardNeededFn = AlwaysFalseNeeded;
    Template.SetRewardByTemplateFn = SetLootTableReward;
    Template.GiveRewardFn = GiveLootTableReward;
    Template.GetRewardStringFn = GetLootTableRewardString;

    return Template;
}

static function bool IsCorpseRewardAvailable(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	local XComGameState_HeadquartersAlien AlienHQ;

	AlienHQ = XComGameState_HeadquartersAlien(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
    return AuxRef.ObjectID != 0 && AlienHQ.GetForceLevel() >= 5;
}

static function X2DataTemplate CreateDummyStatBoostRewardTemplate()
{
    local X2RewardTemplate Template;

    `CREATE_X2Reward_TEMPLATE(Template, 'Reward_Dummy_StatBoost');
    Template.GenerateRewardFn = none;
    Template.SetRewardFn = none;
    Template.GiveRewardFn = none;
    Template.GetRewardStringFn = none;
    Template.GetRewardIconFn = class'X2StrategyElement_DefaultRewards'.static.GetGenericRewardIcon;

    return Template;
}

static function X2DataTemplate CreateResistanceCardRewardTemplate_LW()
{
	local X2RewardTemplate Template;

	`CREATE_X2Reward_TEMPLATE(Template, 'Reward_ResistanceCard_POI');
	Template.RewardImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Intel";

	Template.IsRewardAvailableFn = IsResistanceCardRewardAvailable_POI;
	Template.GenerateRewardFn = GenerateResistanceCardReward_POI;
	Template.GiveRewardFn = GiveResistanceCardReward_POI;
	Template.GetRewardImageFn = GetResistanceCardRewardImage_POI;
	Template.GetRewardStringFn = GetResistanceCardRewardString_POI;
	Template.GetRewardPreviewStringFn = GetResistanceCardRewardString_POI;
	Template.GetRewardDetailsStringFn = GetResistanceCardRewardDetailsString_POI;
	Template.CleanUpRewardFn = CleanUpResistanceCardReward_POI;
	Template.RewardPopupFn = ResistanceCardRewardPopup_POI;

	return Template;
}

static function bool IsResistanceCardRewardAvailable_POI(optional XComGameState NewGameState, optional StateObjectReference AuxRef)
{
	//local XComGameState_ResistanceFaction FactionState;
	//The condition i wanted is filled in the POI condition
	return true;
}

static function GenerateResistanceCardReward_POI(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference AuxRef)
{
	local XComGameState_ResistanceFaction FactionState;
	local XComGameState_StrategyCard CardState;
	local XComGameState_HeadquartersResistance ResHQ;
	local StateObjectReference FactionRef;
	local array<XComGameState_ResistanceFaction> FactionArray, ScrambledFactionArray;
	local int i;

	ResHQ = class'UIUtilities_Strategy'.static.GetResistanceHQ();

	//Shuffle the factions so the card reward is recieved by a random faction
	foreach ResHQ.Factions(FactionRef)
	{
		FactionState = XComGameState_ResistanceFaction(`XCOMHISTORY.GetGameStateForObjectID(FactionRef.ObjectID));

		FactionArray.AddItem(FactionState);
	}

	while (FactionArray.Length > 0)
	{
		i = `SYNC_RAND_STATIC(FactionArray.Length);
		ScrambledFactionArray.AddItem(FactionArray[i]);
		FactionArray.Remove(i,1);
	}

	foreach ScrambledFactionArray(FactionState)
	{
		if(FactionState.bMetXCom)
		{
			CardState = DrawRandomPlayableCard(NewGameState, FactionState);
			if(CardState != none)
			{
				break;
			}
		}
	}

		
	RewardState.RewardObjectReference = CardState.GetReference();
		// Save the generated card to the Action so it can easily be retrieved later
		// if (CardState != none)
		// {
		// 	ActionState.StoredRewardRef = CardState.GetReference();
		// }

	

}

static function XComGameState_StrategyCard DrawRandomPlayableCard(XComGameState NewGameState, XComGameState_ResistanceFaction FactionState)
{
	local XComGameState_StrategyCard CardState;
	//Make it select worse rewards than the covert action one
	CardState = GetRandomCardToMakePlayable(NewGameState, Max(FactionState.Influence, 1), FactionState);
	if (CardState != none)
	{
		CardState = XComGameState_StrategyCard(NewGameState.ModifyStateObject(class'XComGameState_StrategyCard', CardState.ObjectID));
		CardState.bDrawn = true;
	}

	return CardState;
}

static function XComGameState_StrategyCard GetRandomCardToMakePlayable(XComGameState NewGameState, int CardStrength, XComGameState_ResistanceFaction FactionState)
{
	local XComGameStateHistory History;
	local XComGameState_StrategyCard CardState, NewCardState;
	local array<XComGameState_StrategyCard> AllPlayableCards;

	if(CardStrength <= 0)
	{
		return none;
	}

	History = `XCOMHISTORY;
	AllPlayableCards.Length = 0;

	// Find and add all appropriate cards
	foreach History.IterateByClassType(class'XComGameState_StrategyCard', CardState)
	{
		if(IsCardAvailable(CardState, CardStrength, FactionState))
		{
			// Check to see if the available card was already modified in the NewGameState, and if it is still available
			NewCardState = XComGameState_StrategyCard(NewGameState.GetGameStateForObjectID(CardState.ObjectID));
			if (NewCardState == none || IsCardAvailable(NewCardState, CardStrength, FactionState))
			{
				AllPlayableCards.AddItem(CardState);
			}
		}
	}

	// If we came up empty, try to find a lower strength card
	if(AllPlayableCards.Length == 0)
	{
		return GetRandomCardToMakePlayable(NewGameState, CardStrength - 1, FactionState);
	}

	return AllPlayableCards[`SYNC_RAND_STATIC(AllPlayableCards.Length)];
}

//---------------------------------------------------------------------------------------
static function bool IsCardAvailable(XComGameState_StrategyCard CardState, int CardStrength, XComGameState_ResistanceFaction FactionState)
{
	if (CardState.IsResistanceCard() && CardState.GetAssociatedFactionName() == FactionState.GetMyTemplateName()
		&& CardState.GetMyTemplate().Strength <= CardStrength && CardState.CanBePlayed() && CardState.CanBeDrawn()
		&& FactionState.PlayableCards.Find('ObjectID', CardState.ObjectID) == INDEX_NONE)
	{
		return true;
	}

	return false;
}

static function GiveResistanceCardReward_POI(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	//local XComGameStateHistory History;
	local XComGameState_ResistanceFaction FactionState;
	local XComGameState_StrategyCard	NewCardState;

	//History = `XCOMHISTORY;

	NewCardState = XComGameState_StrategyCard(`XCOMHISTORY.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));

	FactionState = XComGameState_ResistanceFaction(NewGameState.ModifyStateObject(class'XComGameState_ResistanceFaction', NewCardState.GetAssociatedFaction().ObjectID));
	FactionState.AddPlayableCard(NewGameState, RewardState.RewardObjectReference);
}

static function string GetResistanceCardRewardImage_POI(XComGameState_Reward RewardState)
{
	local XComGameStateHistory History;
	local XComGameState_CovertAction ActionState;
	local XComGameState_StrategyCard CardState;

	History = `XCOMHISTORY;
	CardState = XComGameState_StrategyCard(History.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));

	return CardState.GetImagePath();
}

static function string GetResistanceCardRewardString_POI(XComGameState_Reward RewardState)
{
	local XComGameStateHistory History;
	local XComGameState_CovertAction ActionState;
	local XComGameState_StrategyCard CardState;

	History = `XCOMHISTORY;
	CardState = XComGameState_StrategyCard(History.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));
	
	return CardState.GetDisplayName();
}

static function string GetResistanceCardRewardDetailsString_POI(XComGameState_Reward RewardState)
{
	local XComGameStateHistory History;
	local XComGameState_CovertAction ActionState;
	local XComGameState_StrategyCard CardState;

	History = `XCOMHISTORY;
	ActionState = XComGameState_CovertAction(History.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));
	CardState = XComGameState_StrategyCard(History.GetGameStateForObjectID(ActionState.StoredRewardRef.ObjectID));

	return CardState.GetSummaryText();
}

static function CleanUpResistanceCardReward_POI(XComGameState NewGameState, XComGameState_Reward RewardState)
{
	local XComGameState_CovertAction ActionState;
	local XComGameState_StrategyCard CardState;
	
	CardState = XComGameState_StrategyCard(`XCOMHISTORY.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));
	CardState = XComGameState_StrategyCard(NewGameState.ModifyStateObject(class'XComGameState_StrategyCard', CardState.ObjectID));
	CardState.bDrawn = false; // Put the selected card back into the available pool
}

static function ResistanceCardRewardPopup_POI(XComGameState_Reward RewardState)
{
	local XComGameStateHistory History;
	local XComGameState_CovertAction ActionState;
	local XComGameState_StrategyCard CardState;

	History = `XCOMHISTORY;

	CardState = XComGameState_StrategyCard(History.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));
	if (CardState != none)
	{
		`HQPRES.UIStrategyCardReceived(CardState.GetReference());
	}

}
