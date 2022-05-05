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
