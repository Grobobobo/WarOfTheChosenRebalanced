class X2EventListener_StrategyMap extends X2EventListener config(LW_Overhaul);

var localized string strTimeRemainingHoursOnly;
var localized string strTimeRemainingDaysAndHours;
var localized string strDarkEventExpiredTitle;
var localized string strDarkEventExpiredText;
var localized string OpenResistanceManagementStr;
var localized string OpenHavenManagementStr;

var config int LISTENER_PRIORITY;

// Black market stuff
var config array<float> BLACK_MARKET_PROFIT_MARGIN;

var config int BLACK_MARKET_2ND_SOLDIER_FL;
var config int BLACK_MARKET_3RD_SOLDIER_FL;
var config float BLACK_MARKET_PERSONNEL_INFLATION_PER_FORCE_LEVEL;
var config float BLACK_MARKET_SOLDIER_DISCOUNT;

var config int SHADY_SCAVENGERS_ALLOY_AMOUNT;
var config int SHADY_SCAVENGERS_ALLOY_COST;

var config int SHADY_SCAVENGERS_ELERIUM_AMOUNT;
var config int SHADY_SCAVENGERS_ELERIUM_COST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateMiscellaneousListeners());
	Templates.AddItem(CreateCampaignStartListeners());
	Templates.AddItem(CreateMissionSiteListeners());

	return Templates;
}

////////////////
/// Strategy ///
////////////////


static function CHEventListenerTemplate CreateMiscellaneousListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'GeoscapeEntryListeners');
	//Template.AddCHEvent('OnGeoscapeEntry', ShowBlackMarket, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('OnGeoscapeEntry', FixBrokenObjectives, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('OnGeoscapeEntry', ClearSitRepsFromCardManager, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('BlackMarketGoodsReset', OnBlackMarketGoodsReset, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('RegionBuiltOutpost', OnRegionBuiltOutpost, ELD_OnStateSubmitted, GetListenerPriority());
	Template.AddCHEvent('PreDarkEventDeactivated', ShowDarkEventDeactivatedNotification, ELD_OnStateSubmitted, GetListenerPriority());
	Template.AddCHEvent('Geoscape_ResInfoButtonVisible', ShowOrHideResistanceOrdersButton, ELD_Immediate, GetListenerPriority());
	Template.AddCHEvent('ContinentBonusActivated', HandleContinentBonusActivation, ELD_OnStateSubmitted, GetListenerPriority());


	Template.RegisterInStrategy = true;

	return Template;
}

static function CHEventListenerTemplate CreateCampaignStartListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'CampaignStartListeners');
	Template.AddCHEvent('OverrideAllowStartingRegionLink', AllowOutOfContinentStartingRegionLinks, ELD_Immediate, GetListenerPriority());
	Template.RegisterInCampaignStart = true;

	return Template;
}

static function CHEventListenerTemplate CreateMissionSiteListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'MissionSiteListeners');
	Template.AddCHEvent('StrategyMapMissionSiteSelected', OnMissionSiteSelected, ELD_Immediate, GetListenerPriority());

	Template.RegisterInStrategy = true;

	return Template;
}


static protected function int GetListenerPriority()
{
	return default.LISTENER_PRIORITY != -1 ? default.LISTENER_PRIORITY : class'XComGameState_LWListenerManager'.default.DEFAULT_LISTENER_PRIORITY;
}

// This function cleans up some weird objective states by firing specific events
static function EventListenerReturn FixBrokenObjectives(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_MissionSite MissionState;

	if (`XCOMHQ.GetObjectiveStatus('T2_M1_S1_ResearchResistanceComms') <= eObjectiveState_InProgress)
	{
		if (`XCOMHQ.IsTechResearched ('ResistanceCommunications'))
		{
			foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_MissionSite', MissionState)
			{
				if (MissionState.GetMissionSource().DataName == 'MissionSource_Blacksite')
				{
					`XEVENTMGR.TriggerEvent('ResearchCompleted',,, NewGameState);
					break;
				}
			}
		}
	}

	if (`XCOMHQ.GetObjectiveStatus('T2_M1_S2_MakeContactWithBlacksiteRegion') <= eObjectiveState_InProgress)
	{
		foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_MissionSite', MissionState)
		{
			if (MissionState.GetMissionSource().DataName == 'MissionSource_Blacksite')
			{
				if (MissionState.GetWorldRegion().ResistanceLevel >= eResLevel_Contact)
				{
					`XEVENTMGR.TriggerEvent('OnBlacksiteContacted',,, NewGameState);
					break;
				}
			}
		}
	}

	return ELR_NoInterrupt;
}

static function EventListenerReturn ShowBlackMarket(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameStateHistory History;
	local XComGameState_BlackMarket BlackMarket;
	local bool AddGameStateToHistory;

	History = `XCOMHISTORY;
	BlackMarket = XComGameState_BlackMarket(History.GetSingleGameStateObjectForClass(class'XComGameState_BlackMarket'));

	// Check whether the black market is already visible on the geoscape or not
	if(!BlackMarket.bIsOpen && !BlackMarket.bNeedsScan)
	{
		// It's not, so force it to show now
		if (NewGameState.bReadOnly)
		{
			NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Opening up Black Market");
			AddGameStateToHistory = true;
		}
		
		BlackMarket = XComGameState_BlackMarket(NewGameState.ModifyStateObject(class'XComGameState_BlackMarket', BlackMarket.ObjectID));
		BlackMarket.ShowBlackMarket(NewGameState, true);

		if (AddGameStateToHistory)
		{
			History.AddGameStateToHistory(NewGameState);
		}
	}

	return ELR_NoInterrupt;
}

static function EventListenerReturn ClearSitRepsFromCardManager(
	Object EventData,
	Object EventSource,
	XComGameState NewGameState,
	Name InEventID,
	Object CallbackData)
{
	local X2CardManager CardMgr;
	local array<string> SitRepCards;
	local int i;

	// The SitReps deck seems to be prepopulated with several sit reps
	// that we may not want (like Surgical), so this hack clears the
	// deck of unwanted sit reps before it's used.
	CardMgr = class'X2CardManager'.static.GetCardManager();
	CardMgr.GetAllCardsInDeck('SitReps', SitRepCards);
	for (i = 0; i < SitRepCards.Length; i++)
	{
		if (class'X2LWSitRepsModTemplate'.default.SIT_REP_EXCLUSIONS.Find(name(SitRepCards[i])) != INDEX_NONE)
		{
			CardMgr.RemoveCardFromDeck('SitReps', SitRepCards[i]);
		}
	}

	return ELR_NoInterrupt;
}

// Override the Black Market to make items purchasable with supplies and
// remove the supplies reward from inventory
static function EventListenerReturn OnBlackMarketGoodsReset(Object EventData, Object EventSource, XComGameState NewGameState, Name EventID, Object CallbackData)
{
	// local XComGameStateHistory History;
	// local XComGameState_BlackMarket BlackMarket;
	// local XComGameState_Reward RewardState;
	// local int ResourceIdx, Idx, ItemIdx;
 	// local bool bStartState;
	// local XComGameState_Item ItemState;
	// local X2StrategyElementTemplateManager StratMgr;
	// local X2RewardTemplate RewardTemplate;
	// local array<XComGameState_Tech> TechList;
	// local Commodity ForSaleItem, EmptyForSaleItem;
	// local array<name> PersonnelRewardNames;
	// local array<XComGameState_Item> ItemList;
	// local ArtifactCost ResourceCost;
	// local XComGameState_HeadquartersAlien AlienHQ;
	// //local array<StateObjectReference> AllItems, InterestCandidates;
	// //local name InterestName;
	// //local int i,k;

	// BlackMarket = XComGameState_BlackMarket(EventData);

	// if (BlackMarket == none)
	// {
	// 	`REDSCREEN("BlackMarketGoodsReset called with no object");
	// 	return ELR_NoInterrupt;
	// }

	// if (NewGameState == none)
	// {
	// 	`REDSCREEN("No game state context provided for BlackMarketGoodsReset");
	// 	return ELR_NoInterrupt;
	// }

	// // We can't use the event data as our BlackMarket game state as the event
	// // manager is providing us with the last state in the history, rather than
	// // the one `ResetBlackMarketGoods` sends us. So we have to pull the game state
	// // from `NewGameState` instead.	
	// BlackMarket = XComGameState_BlackMarket(NewGameState.ModifyStateObject(class'XComGameState_BlackMarket', BlackMarket.ObjectID));
	// History = `XCOMHISTORY;
	// bStartState = (NewGameState.GetContext().IsStartState());

	// StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	// BlackMarket.ForSaleItems.Length = 0;

	// RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_TechRush'));
	// TechList = BlackMarket.RollForTechRushItems();

	// // Tech Rush Rewards
	// for(idx = 0; idx < TechList.Length; idx++)
	// {
	// 	ForSaleItem = EmptyForSaleItem;
	// 	RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	// 	RewardState.SetReward(TechList[idx].GetReference());
	// 	ForSaleItem.RewardRef = RewardState.GetReference();

	// 	ForSaleItem.Title = RewardState.GetRewardString();
	// 	ForSaleItem.Cost = BlackMarket.GetTechRushCost(TechList[idx], NewGameState);
	// 	for (ResourceIdx = 0; ResourceIdx < ForSaleItem.Cost.ResourceCosts.Length; ResourceIdx ++)
	// 	{
	// 		if (ForSaleItem.Cost.ResourceCosts[ResourceIdx].ItemTemplateName == 'Intel')
	// 		{
	// 			ForSaleItem.Cost.ResourceCosts[ResourceIdx].ItemTemplateName = 'Supplies';
	// 		}
	// 	}
	// 	ForSaleItem.Desc = RewardState.GetBlackMarketString();
	// 	ForSaleItem.Image = RewardState.GetRewardImage();
	// 	ForSaleItem.CostScalars = BlackMarket.GoodsCostScalars;
	// 	ForSaleItem.DiscountPercent = BlackMarket.GoodsCostPercentDiscount;

	// 	BlackMarket.ForSaleItems.AddItem(ForSaleItem);
	// }

	// // Dudes, one each per month
	// PersonnelRewardNames.AddItem('Reward_Scientist');
	// PersonnelRewardNames.AddItem('Reward_Engineer');
	// PersonnelRewardNames.AddItem('Reward_Soldier');

	// AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	// if (AlienHQ.GetForceLevel() >= default.BLACK_MARKET_2ND_SOLDIER_FL)
	// 	PersonnelRewardNames.AddItem('Reward_Soldier');

	// if (AlienHQ.GetForceLevel() >= default.BLACK_MARKET_3RD_SOLDIER_FL)
	// 	PersonnelRewardNames.AddItem('Reward_Soldier');

	// for (idx=0; idx < PersonnelRewardNames.Length; idx++)
	// {
	// 	ForSaleItem = EmptyForSaleItem;
	// 	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate(PersonnelRewardNames[idx]));
	// 	RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	// 	RewardState.GenerateReward(NewGameState,, BlackMarket.Region);
	// 	ForSaleItem.RewardRef = RewardState.GetReference();
	// 	ForSaleItem.Title = RewardState.GetRewardString();
	// 	ForSaleItem.Cost = BlackMarket.GetPersonnelForSaleItemCost();

	// 	for (ResourceIdx = 0; ResourceIdx < ForSaleItem.Cost.ResourceCosts.Length; ResourceIdx ++)
	// 	{
	// 		if (ForSaleItem.Cost.ResourceCosts[ResourceIdx].ItemTemplateName == 'Intel')
	// 		{
	// 			ForSaleItem.Cost.ResourceCosts[ResourceIdx].ItemTemplateName = 'Supplies'; // add 10% per force level, soldiers 1/4 baseline, baseline
	// 			ForSaleItem.Cost.ResourceCosts[ResourceIdx].Quantity *= 1 + ((AlienHQ.GetForceLevel() - 1) * default.BLACK_MARKET_PERSONNEL_INFLATION_PER_FORCE_LEVEL);
	// 			if (PersonnelRewardNames[idx] == 'Reward_Soldier')
	// 				ForSaleItem.Cost.ResourceCosts[ResourceIdx].Quantity *= default.BLACK_MARKET_SOLDIER_DISCOUNT;
	// 		}
	// 	}

	// 	ForSaleItem.Desc = RewardState.GetBlackMarketString();
	// 	ForSaleItem.Image = RewardState.GetRewardImage();
	// 	ForSaleItem.CostScalars = BlackMarket.GoodsCostScalars;
	// 	ForSaleItem.DiscountPercent = BlackMarket.GoodsCostPercentDiscount;
	// 	if(ForSaleItem.Image == "")
	// 	{
	// 		`HQPRES.GetPhotoboothAutogen().AddHeadshotRequest(
	// 				RewardState.RewardObjectReference,
	// 				512, 512,
	// 				None);
	// 		`HQPRES.GetPhotoboothAutogen().RequestPhotos();
	// 	}
	// 	BlackMarket.ForSaleItems.AddItem(ForSaleItem);
	// }

	// ItemList = BlackMarket.RollForBlackMarketLoot (NewGameState);

	// //`LOG ("ItemList Length:" @ string(ItemList.Length));

	// RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Item'));
	// for (Idx = 0; idx < ItemList.Length; idx++)
	// {
	// 	ForSaleItem = EmptyForSaleItem;
	// 	RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	// 	RewardState.SetReward(ItemList[Idx].GetReference());
	// 	ForSaleItem.RewardRef = RewardState.GetReference();
	// 	ForSaleItem.Title = RewardState.GetRewardString();

	// 	//ForSaleItem.Title = class'UIUtilities_Text_LW'.static.StripHTML (ForSaleItem.Title); // StripHTML not needed and doesn't work yet

	// 	ItemState = XComGameState_Item (History.GetGameStateForObjectID(RewardState.RewardObjectReference.ObjectID));
	// 	ForSaleItem.Desc = RewardState.GetBlackMarketString() $ "\n\n" $ ItemState.GetMyTemplate().GetItemBriefSummary();// REPLACE WITH ITEM DESCRIPTION!
	// 	ForSaleItem.Image = RewardState.GetRewardImage();
	// 	ForSaleItem.CostScalars = BlackMarket.GoodsCostScalars;
	// 	ForSaleItem.DiscountPercent = BlackMarket.GoodsCostPercentDiscount;

	// 	ResourceCost.ItemTemplateName = 'Supplies';
	// 	ResourceCost.Quantity = ItemState.GetMyTemplate().TradingPostValue * default.BLACK_MARKET_PROFIT_MARGIN[`STRATEGYDIFFICULTYSETTING];

	// 	`LWTRACE (ForSaleItem.Title @ ItemState.Quantity);

	// 	if (ItemState.Quantity > 1)
	// 	{
	// 		ResourceCost.Quantity *= ItemState.Quantity;
	// 	}
	// 	ForSaleItem.Cost.ResourceCosts.AddItem (ResourceCost);
	// 	BlackMarket.ForSaleItems.AddItem(ForSaleItem);
	// }

	// // switch to supplies cost, fix items sale price to TPV
	// for (ItemIdx = BlackMarket.ForSaleItems.Length - 1; ItemIdx >= 0; ItemIdx--)
	// {
	// 	if (bStartState)
	// 	{
	// 		RewardState = XComGameState_Reward(NewGameState.GetGameStateForObjectID(BlackMarket.ForSaleItems[ItemIdx].RewardRef.ObjectID));
	// 	}
	// 	else
	// 	{
	// 		RewardState = XComGameState_Reward(History.GetGameStateForObjectID(BlackMarket.ForSaleItems[ItemIdx].RewardRef.ObjectID));
	// 	}
	// 	if (RewardState.GetMyTemplateName() == 'Reward_Supplies')
	// 	{
	// 		BlackMarket.ForSaleItems.Remove(ItemIdx, 1);
	// 		RewardState.CleanUpReward(NewGameState);
	// 		NewGameState.RemoveStateObject(RewardState.ObjectID);
	// 	}
	// }

	if (class'Helpers_LW'.static.IsResistanceOrderActive('ResCard_ShadyScavengers_LW')){
		AddItemToBlackMarket('AlienAlloy', default.SHADY_SCAVENGERS_ALLOY_AMOUNT, default.SHADY_SCAVENGERS_ALLOY_COST, EventData, EventSource, NewGameState, EventID, CallbackData);
		AddItemToBlackMarket('EleriumDust', default.SHADY_SCAVENGERS_ELERIUM_AMOUNT, default.SHADY_SCAVENGERS_ELERIUM_COST, EventData, EventSource, NewGameState, EventID, CallbackData);
	}

	return ELR_NoInterrupt;
}


static function AddItemToBlackMarket(
		name ItemToAdd, int NumToAdd, int Price,
		Object EventData, Object EventSource, XComGameState NewGameState, Name Event, Object CallbackData){
	local X2StrategyElementTemplateManager StratMgr;
	local X2ItemTemplateManager ItemTemplateMgr;
	local XComGameState_BlackMarket MarketState;
	local XComGameState_Reward RewardState;
	local X2RewardTemplate RewardTemplate;
	local XComGameState_Item ItemState;
	local X2ItemTemplate ItemTemplate;
	local Commodity ForSaleItem;

	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	MarketState = XComGameState_BlackMarket(EventData);
	
	if (MarketState == none) return;

	// Get the latest pending state
	MarketState = XComGameState_BlackMarket(NewGameState.ModifyStateObject(class'XComGameState_BlackMarket', MarketState.ObjectID));

	// Create the item
	ItemTemplateMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	ItemTemplate = ItemTemplateMgr.FindItemTemplate(ItemToAdd);
	ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
	ItemState.Quantity = NumToAdd;
	
	// Create the reward
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_Item'));
	RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	
	RewardState.SetReward(ItemState.GetReference());
	

	// Fill out the commodity (default)
	ForSaleItem.RewardRef = RewardState.GetReference();
	ForSaleItem.Image = RewardState.GetRewardImage();
	ForSaleItem.CostScalars = MarketState.GoodsCostScalars;
	ForSaleItem.DiscountPercent = MarketState.GoodsCostPercentDiscount;

	// Fill out the commodity (custom)
	ForSaleItem.Title = string(NumToAdd) $ " " $ ItemTemplate.GetItemFriendlyName();
	ForSaleItem.Desc = "Not generally available via the black market, but for a resourceful commander, such things are possible."; //todo: figure out localization
	ForSaleItem.Cost = GetForSaleItemCost(Price); 

	// Add to sale
	MarketState.ForSaleItems.AddItem(ForSaleItem);
	// We are done
	return;
}

static function StrategyCost GetForSaleItemCost(int IntelAmount)
{
	local StrategyCost Cost;
	local ArtifactCost ResourceCost;
	
	ResourceCost.ItemTemplateName = 'Intel';
	ResourceCost.Quantity = IntelAmount;
	Cost.ResourceCosts.AddItem(ResourceCost);

	return Cost;
}


static function EventListenerReturn OnRegionBuiltOutpost(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
    local XComGameStateHistory History;
    local XComGameState_WorldRegion Region;
    local XComGameState NewGameState;

    History = `XCOMHISTORY;
    foreach History.IterateByClassType(class'XComGameState_WorldRegion', Region)
    {
        // Look for regions that have an outpost built, which have their "bScanforOutpost" flag reset
        // (this is cleared by XCGS_WorldRegion.Update() when the scan finishes) and the scan has begun.
        // For these regions, reset the scan. This will reset the scanner UI to "empty". The reset
        // call will reset the scan started flag so subsequent triggers will not redo this change
        // for this region.
        if (Region.ResistanceLevel == eResLevel_Outpost &&
            !Region.bCanScanForOutpost &&
            Region.GetScanPercentComplete() > 0)
        {
            NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Reset outpost scanner");
            Region = XComGameState_WorldRegion(NewGameState.ModifyStateObject(class'XComGameState_WorldRegion', Region.ObjectID));
            Region.ResetScan();
            `GAMERULES.SubmitGameState(NewGameState);
        }
    }

    return ELR_NoInterrupt;
}

static function EventListenerReturn ShowDarkEventDeactivatedNotification(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name InEventID,
	Object CallbackData)
{
	local XComGameState_DarkEvent DarkEventState;

	DarkEventState = XComGameState_DarkEvent(EventSource);
	if (DarkEventState == none)
		return ELR_NoInterrupt;

	`HQPRES.NotifyBanner(
			default.strDarkEventExpiredTitle,
			class'UIUtilities_Image'.const.EventQueue_Alien,
			DarkEventState.GetMyTemplate().DisplayName,
			default.strDarkEventExpiredText,
			eUIState_Bad);

	return ELR_NoInterrupt;
}

static function EventListenerReturn ShowOrHideResistanceOrdersButton(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name EventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none) return ELR_NoInterrupt;

	// The event expects `true` to show the button, or `false` to hide it
	Tuple.Data[0].b = class'Helpers_LW'.static.AreResistanceOrdersEnabled();

	return ELR_NoInterrupt;
}

// Checks whether Resistance Radio has been researched and, if not, deactivates
// the continent bonus again. It will get activated again once the player has
// researched Resistance Radio via an ResearchCompletedFn.
static function EventListenerReturn HandleContinentBonusActivation(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name EventID,
	Object CallbackData)
{
	local XComGameState NewGameState;
	local XComGameState_Continent ContinentState;

	ContinentState = XComGameState_Continent(EventData);
	if (ContinentState == none)
	{
		`REDSCREEN("Continent bonus activated but no associated continent found");
		return ELR_NoInterrupt;
	}

	// If Resistance Radio has been researched, we don't need to do anything
	// since that's LWOTC's new condition for allowing the activation of
	// continent bonuses.
	if (`XCOMHQ.IsTechResearched('ResistanceRadio')) return ELR_NoInterrupt;

	// Deactivate the continent bonus because it shouldn't be active yet
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Deactivate continent bonus");
	ContinentState = XComGameState_Continent(
		NewGameState.ModifyStateObject(class'XComGameState_Continent', ContinentState.ObjectID));
	ContinentState.DeactivateContinentBonus(NewGameState);
	ContinentState.bHasHadContinentBonus = false;

	if (NewGameState.GetNumGameStateObjects() > 0)
		`GAMERULES.SubmitGameState(NewGameState);
	else
		`XCOMHISTORY.CleanupPendingGameState(NewGameState);

	// Don't propagate the event as we have effectively rolled back the change
	// that triggered it. This does require other listeners to come after us
	// otherwise they'll think the continent bonus is active.
	return ELR_InterruptListeners;
}


static function EventListenerReturn AllowOutOfContinentStartingRegionLinks(
	Object EventData,
	Object EventSource,
	XComGameState GameState,
	Name EventID,
	Object CallbackData)
{
	local XComLWTuple Tuple;

	Tuple = XComLWTuple(EventData);
	if (Tuple == none) return ELR_NoInterrupt;

	// A starting region can be linked to any other neighbouring region.
	// No restrictions.
	Tuple.Data[1].b = true;

	return ELR_NoInterrupt;
}

static function EventListenerReturn OnMissionSiteSelected(Object EventData, Object EventSource, XComGameState NewGameState, Name InEventID, Object CallbackData)
{
	local XComGameState_MissionSite		MissionSite;
	local XComHQPresentationLayer       HQPres;
	local UIMission_ChosenAmbush_LW     Screen;

	MissionSite = XComGameState_MissionSite(EventData);
	if(MissionSite == none)
		return ELR_NoInterrupt;

	if (MissionSite.IsA('XComGameState_MissionSiteChosenAmbush_LW'))
	{
		HQPres = `HQPRES;
		Screen = HQPres.Spawn(class'UIMission_ChosenAmbush_LW', HQPres);
		Screen.MissionRef.ObjectID = MissionSite.ObjectID;
		`SCREENSTACK.Push(Screen);
	}

	return ELR_NoInterrupt;
}
