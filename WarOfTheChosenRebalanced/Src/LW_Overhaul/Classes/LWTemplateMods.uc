//---------------------------------------------------------------------------------------
//  FILE:    LWTemplateMods
//  AUTHOR:  tracktwo / Pavonis Interactive
//
//  PURPOSE: Mods to base XCOM2 templates
//--------------------------------------------------------------------------------------- 

class LWTemplateMods extends X2StrategyElement config(LW_Overhaul) dependson(X2Ability_DarkEvents_LW);

struct ItemTableEntry
{
	var name ItemTemplateName;
	var int Slots;
	var bool Starting;
	var bool Infinite;
	var bool Buildable;
	var name RequiredTech1;
	var name RequiredTech2;
	var int SupplyCost;
	var int AlloyCost;
	var int CrystalCost;
	var int CoreCost;
	var name SpecialItemTemplateName;
	var int SpecialItemCost;
	var int TradingPostValue;
	var int RequiredEngineeringScore;
	var int PointsToComplete;
	var int Weight;
	var int Tier;
	var string InventoryImage;
	
	structdefaultproperties
	{
		ItemTemplateName=None
		Slots=3
		Starting=false
		Infinite=false
		Buildable=false
		RequiredTech1=none
		RequiredTech2=none
		SupplyCost=0
		AlloyCost=0
		CrystalCost=0
		CoreCost=0
		SpecialItemTemplateName=None
		SpecialItemCost=0
		TradingPostValue=0
		RequiredEngineeringScore=0
		PointsToComplete=0
		Weight = 0
		Tier = -1
		InventoryImage = ""
	}
};

struct TechTableEntry
{
	var name TechTemplateName;
	var bool ProvingGround;
	var int ResearchPointCost;
	var bool ModPointsToCompleteOnly;
	var name PrereqTech1;
	var name PrereqTech2;
	var name PrereqTech3;
	var int SupplyCost;
	var int AlloyCost;
	var int CrystalCost;
	var int CoreCost;
	var name ReqItemTemplateName1;
	var int ReqItemCost1;
	var name ReqItemTemplateName2;
	var int ReqItemCost2;
	var name ItemGranted;
	var int RequiredScienceScore;
	var int RequiredEngineeringScore;

	structdefaultproperties
	{
		TechTemplateName=None
		ProvingGround=false
		ResearchPointCost=0
		ModPointsToCompleteOnly=true
		PrereqTech1=None
		PrereqTech2=None
		PrereqTech3=None
		SupplyCost=0
		AlloyCost=0
		CrystalCost=0
		CoreCost=0
		ReqItemTemplateName1=None
		ReqItemCost1=0
		ReqItemTemplateName2=None
		ReqItemCost2=0
		ItemGranted=none
		RequiredScienceScore=0
		RequiredEngineeringScore=0
	}
};

struct GTSTableEntry
{
	var name    GTSProjectTemplateName;
	var int     SupplyCost;
	var int     RankRequired;
	var bool    HideifInsufficientRank;
	var name    UniqueClass;
	structdefaultproperties
	{
		GTSProjectTemplateName=None
		SupplyCost=0
		RankRequired=0
		HideifInsufficientRank=false
		UniqueClass=none
	}
};

struct FacilityTableEntry
{
	var name FacilityTemplateName;
	var int BuildDays;
	var int Power;
	var int UpkeepCost;
	var name RequiredTech;
	var int SupplyCost;
	var int AlloyCost;
	var int CrystalCost;
	var int CoreCost;
	structdefaultproperties
	{
		FacilityTemplateName=none
		BuildDays=1
		Power=0
		UpkeepCost=0
		RequiredTech=none
		SupplyCost=0
		AlloyCost=0
		CrystalCost=0
		CoreCost=0
	}
};

struct FacilityUpgradeTableEntry
{
	var name FacilityUpgradeTemplateName;
	var int PointsToComplete;
	var int iPower;
	var int UpkeepCost;
	var int SupplyCost;
	var int AlloyCost;
	var int CrystalCost;
	var int CoreCost;
	var name RequiredTech;
	var name ReqItemTemplateName1;
	var int ReqItemCost1;
	var name ReqItemTemplateName2;
	var int ReqItemCost2;
	var int MaxBuild;
	var int RequiredEngineeringScore;
	var int RequiredScienceScore;
	structdefaultproperties
	{
		FacilityUpgradeTemplateName=none
		PointsToComplete=0
		iPower=0
		UpkeepCost=0
		SupplyCost=0
		AlloyCost=0
		CrystalCost=0
		CoreCost=0
		RequiredTech=none
		ReqItemTemplateName1=None
		ReqItemCost1=0
		ReqItemTemplateName2=None
		ReqItemCost2=0
		MaxBuild=1
		RequiredEngineeringScore=0
		RequiredScienceScore=0
	}
};

struct DamageStep
{
	var float DistanceRatio;
	var float DamageRatio;
};

struct FlashbangResistEntry
{
	var name UnitName;
	var int Chance;
};

var config int SPIDER_GRAPPLE_COOLDOWN;
var config int WRAITH_GRAPPLE_COOLDOWN;
var config int RAPIDFIRE_COOLDOWN;
var config int MEDIUM_PLATED_MITIGATION_AMOUNT;
var config int SHIELDWALL_MITIGATION_AMOUNT;
var config int SHIELDWALL_DEFENSE_AMOUNT;
var config int HAIL_OF_BULLETS_AMMO_COST;
var config int SATURATION_FIRE_AMMO_COST;
var config int DEMOLITION_AMMO_COST;
var config int THROW_GRENADE_COOLDOWN;
var config int AID_PROTOCOL_COOLDOWN;
var config int FUSE_COOLDOWN;
var config int INSANITY_MIND_CONTROL_DURATION;
var config bool INSANITY_ENDS_TURN;
var config int RUPTURE_CRIT_BONUS;
var config int FACEOFF_CHARGES;
var config int DRAGON_ROUNDS_APPLY_CHANCE;
var config int VENOM_ROUNDS_APPLY_CHANCE;
var config int FIREBOMB_FIRE_APPLY_CHANCE;
var config int FIREBOMB_2_FIRE_APPLY_CHANCE;
var config int CONCEAL_ACTION_POINTS;
var config bool CONCEAL_ENDS_TURN;
var config int SERIAL_CRIT_MALUS_PER_KILL;
var config int SERIAL_AIM_MALUS_PER_KILL;
var config bool SERIAL_DAMAGE_FALLOFF;
var config int FUSION_SWORD_FIRE_CHANCE;

var config array<ItemTableEntry> ItemTable;
var config array<TechTableEntry> TechTable;
var config array<GTSTableEntry> GTSTable;
var config array<FacilityTableEntry> FacilityTable;
var config array<FacilityUpgradeTableEntry> FacilityUpgradeTable;

var config array<name> GTSUnlocksToRemove;

var config int ResistanceCommunicationsIntelCost;
var config int ResistanceRadioIntelCost;
var config int AlienEncryptionIntelCost;
var config int CodexBrainPt1IntelCost;
var config int CodexBrainPt2IntelCost;
var config int BlacksiteDataIntelCost;
var config int ForgeStasisSuitIntelCost;
var config int PsiGateIntelCost;
var config int AutopsyAdventPsiWitchIntelCost;
var config int ALIEN_FACILITY_LEAD_RP_INCREMENT;
var config int ALIEN_FACILITY_LEAD_INTEL;

var config array<name> SchematicsToDisable;

var config array<name> UnlimitedItemsAdded;

var config bool EARLY_TURRET_SQUADSIGHT;
var config bool MID_TURRET_SQUADSIGHT;
var config bool LATE_TURRET_SQUADSIGHT;

var config bool EXPLOSIVES_NUKE_CORPSES;

var config float CIVILIAN_PANIC_RANGE;

var config array<float> UnitDistanceRatios;
var config array<float> UnitDamageRatios;

var config array<float> EnvironmentDistanceRatios;
var config array<float> EnvironmentDamageRatios;

var config array<DamageStep> UnitDamageSteps;
var config array<DamageStep> EnvironmentDamageSteps;

var config array<name> ExplosiveFalloffAbility_Exclusions;
var config array<name> ExplosiveFalloffAbility_Inclusions;
var config array<name> ExplosiveFalloffItem_Exclusions;

var config array<name> ABILITIES_TO_DISABLE_GRENADE_COOLDOWN;

var config int ALIEN_RULER_ACTION_BONUS_APPLY_CHANCE;

var config bool USE_ACTION_ICON_COLORS;

var config string ICON_COLOR_OBJECTIVE;
var config string ICON_COLOR_PSIONIC_2;
var config string ICON_COLOR_PSIONIC_END;
var config string ICON_COLOR_PSIONIC_1;
var config string ICON_COLOR_PSIONIC_FREE;
var config string ICON_COLOR_COMMANDER_ALL;
var config string ICON_COLOR_2;
var config string ICON_COLOR_END;
var config string ICON_COLOR_1;
var config string ICON_COLOR_FREE;

var config int SMALL_INTEL_CACHE_REWARD;
var config int LARGE_INTEL_CACHE_REWARD;

var config bool INSTANT_BUILD_TIMES;

var config array<Name> OffensiveReflexAbilities;
var config array<Name> DefensiveReflexAbilities;
var config array<Name> DoubleTapAbilities;

var config array<FlashbangResistEntry> ENEMY_FLASHBANG_RESIST;

var config WeaponDamageValue WARLOCKPSIM1_BASEDAMAGE;
var config WeaponDamageValue WARLOCKPSIM2_BASEDAMAGE;
var config WeaponDamageValue WARLOCKPSIM3_BASEDAMAGE;
var config WeaponDamageValue WARLOCKPSIM4_BASEDAMAGE;
var config WeaponDamageValue WARLOCKPSIM5_BASEDAMAGE;

var config WeaponDamageValue GREMLIN_CV_BASEDAMAGE;
var config WeaponDamageValue GREMLIN_MG_BASEDAMAGE;
var config WeaponDamageValue GREMLIN_BM_BASEDAMAGE;

var config float HUNKER_EXPLOSIVE_PCT_DR;
var config int HUNKER_DODGE_PER_TILE;

var config int GUARDIAN_BONUS_AMMO;


var config float HUNTERS_INSTINCT_DAMAGE_PCT;
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	`LWTrace("LWTemplateMods.CreateTemplates --------------------------------");

	Templates.AddItem(CreateDelayedEvacTemplate());
	Templates.Additem(CreateReconfigGearTemplate());
	Templates.Additem(CreateRewireTechTreeTemplate());
	Templates.AddItem(CreateEditGTSProjectsTemplate());
	Templates.AddItem(CreateModifyAbilitiesTemplate());
	Templates.AddItem(CreateModifyAbilitiesGeneralTemplate());
	Templates.AddItem(CreateSwapExplosiveDamageFalloff());
	Templates.AddItem(CreateModifyGrenadeEffects());
	Templates.AddItem(CreateReconfigFacilitiesTemplate());
	Templates.AddItem(CreateRecoverItemTemplate());
	Templates.AddItem(CreateRemovePPClassesTemplate());
	//Templates.AddItem(CreateUpdateQuestItemsTemplate());
	TEmplates.AddItem(CreateGeneralCharacterModTemplate());
	Templates.AddItem(CreateModifyPOIsTemplate());
	Templates.AddItem(CreateModifyHackRewardsTemplate());
	Templates.AddItem(CreateReconfigFacilityUpgradesTemplate());
	Templates.AddItem(CreateModifyStaffSlotsTemplate());
	Templates.AddItem(CreateModifyRewardsTemplate());
	Templates.AddItem(CreateModifyStrategyObjectivesTemplate());
	Templates.AddItem(CreateModifyCharactersTemplate());
	Templates.AddItem(CreateModifyCovertActionsTemplate());
	Templates.AddItem(CreateModifyCovertActionRisksTemplate());
	Templates.AddItem(CreateModifyDarkEventsTemplate());
	Templates.AddItem(CreateModifyMissionSourcesTemplate());
	Templates.AddItem(CreateModifySitRepsTemplate());
	Templates.AddItem(CreateModifySitRepEffectsTemplate());
	Templates.AddItem(CreateModifyResistanceOrdersTemplate());
	`Log("    Done");
	return Templates;
}

// Modify abilities to use graze band
static function X2LWTemplateModTemplate CreateModifyAbilitiesTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWAbilitiesModTemplate', Template, 'UpdateAbilities');
	return Template;
}

// Update existing strategic objective templates
static function X2LWTemplateModTemplate CreateModifyStrategyObjectivesTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWObjectivesModTemplate', Template, 'UpdateObjectives');
	return Template;
}

// Update existing character templates
static function X2LWTemplateModTemplate CreateModifyCharactersTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWCharactersModTemplate', Template, 'UpdateCharacters');
	return Template;
}

// Update existing covert action templates
static function X2LWTemplateModTemplate CreateModifyCovertActionsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWCovertActionsModTemplate', Template, 'UpdateCovertActions');
	return Template;
}

// Update existing covert action templates
static function X2LWTemplateModTemplate CreateModifyCovertActionRisksTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWCovertActionRisksModTemplate', Template, 'UpdateCovertActionRisks');
	return Template;
}

// Update existing dark event templates
static function X2LWTemplateModTemplate CreateModifyDarkEventsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWDarkEventsModTemplate', Template, 'UpdateDarkEvents');
	return Template;
}

// Update existing dark event templates
static function X2LWTemplateModTemplate CreateModifyMissionSourcesTemplate()
{
	local X2LWTemplateModTemplate Template;
	
	`CREATE_X2TEMPLATE(class'X2LWMissionSourcesModTemplate', Template, 'UpdateMissionSources');
	return Template;
}

// Update existing staff slot templates
static function X2LWTemplateModTemplate CreateModifyStaffSlotsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWStaffSlotsModTemplate', Template, 'UpdateStaffSlots');
	return Template;
}

// Update existing sit rep templates
static function X2LWTemplateModTemplate CreateModifySitRepsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWSitRepsModTemplate', Template, 'UpdateSitReps');
	return Template;
}

// Update existing sit rep templates
static function X2LWTemplateModTemplate CreateModifySitRepEffectsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWSitRepEffectsModTemplate', Template, 'UpdateSitRepEffects');
	return Template;
}

// Update existing strategic objective templates
static function X2LWTemplateModTemplate CreateModifyResistanceOrdersTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWResistanceOrdersModTemplate', Template, 'UpdateResistanceOrders');
	return Template;
}

// Update StaffSlotTemplates as needed
static function X2LWTemplateModTemplate CreateModifyRewardsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'UpdateRewards');

	// We need to modify grenade items and ability templates
	Template.StrategyElementTemplateModFn = UpdateRewardTemplate;
	return Template;
}

function GenerateRandomSoldierReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference RegionRef)
{
	local XComGameState_HeadquartersResistance ResistanceHQ;
	local XComGameStateHistory History;
	local XComGameState_Unit NewUnitState;
	local XComGameState_WorldRegion RegionState;
	local int idx, NewRank;
	local name nmCountry, SelectedClass;
	local array<name> arrActiveTemplates;
	local X2SoldierClassTemplateManager ClassMgr;
	local array<X2SoldierClassTemplate> arrClassTemplates;
	local X2SoldierClassTemplate ClassTemplate;
	local XComGameState_HeadquartersAlien AlienHQ;

	History = `XCOMHISTORY;
	nmCountry = '';
	RegionState = XComGameState_WorldRegion(History.GetGameStateForObjectID(RegionRef.ObjectID));

	if(RegionState != none)
	{
		nmCountry = RegionState.GetMyTemplate().GetRandomCountryInRegion();
	}

	//Use the character pool's creation method to retrieve a unit
	NewUnitState = `CHARACTERPOOLMGR.CreateCharacter(NewGameState, `XPROFILESETTINGS.Data.m_eCharPoolUsage, RewardState.GetMyTemplate().rewardObjectTemplateName, nmCountry);
	NewUnitState.RandomizeStats();
	NewGameState.AddStateObject(NewUnitState);

	ResistanceHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	if(!NewGameState.GetContext().IsStartState())
	{
		ResistanceHQ = XComGameState_HeadquartersResistance(NewGameState.CreateStateObject(class'XComGameState_HeadquartersResistance', ResistanceHQ.ObjectID));
		NewGameState.AddStateObject(ResistanceHQ);
	}
	
	// Pick a random class
	ClassMgr = class'X2SoldierClassTemplateManager'.static.GetSoldierClassTemplateManager();
	arrClassTemplates = ClassMgr.GetAllSoldierClassTemplates(true);
	foreach arrClassTemplates(ClassTemplate)
	{
		if (ClassTemplate.NuminDeck > 0)
		{
			arrActiveTemplates.AddItem(ClassTemplate.DataName);
		}
	}
	if (arrActiveTemplates.length > 0)
	{
		SelectedClass = arrActiveTemplates[`SYNC_RAND(arrActiveTemplates.length)];
	}
	else
	{
		SelectedClass = ResistanceHQ.SelectNextSoldierClass();
	}
	
	NewUnitState.ApplyInventoryLoadout(NewGameState);

	AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	NewRank = 1;

	for(idx = 0; idx < class'X2StrategyElement_DefaultRewards'.default.SoldierRewardForceLevelGates.Length; idx++)
	{
		if(AlienHQ.GetForceLevel() >= class'X2StrategyElement_DefaultRewards'.default.SoldierRewardForceLevelGates[idx])
		{
			NewRank++;
		}
	}

	NewUnitState.SetXPForRank(NewRank);
	NewUnitState.StartingRank = NewRank;
	for(idx = 0; idx < NewRank; idx++)
	{
		// Rank up to squaddie
		if(idx == 0)
		{
			NewUnitState.RankUpSoldier(NewGameState, SelectedClass);
			NewUnitState.ApplySquaddieLoadout(NewGameState);
			NewUnitState.bNeedsNewClassPopup = false;
		}
		else
		{
			NewUnitState.RankUpSoldier(NewGameState, NewUnitState.GetSoldierClassTemplate().DataName);
		}
	}   
	RewardState.RewardObjectReference = NewUnitState.GetReference();
}

function UpdateRewardTemplate(X2StrategyElementTemplate Template, int Difficulty)
{
	local X2RewardTemplate RewardTemplate;

	RewardTemplate = X2RewardTemplate(Template);
	if(RewardTemplate == none)
		return;
	
	switch (RewardTemplate.DataName)
	{
		case 'Reward_FacilityLead':
			// change reward string delegate so it returns the template DisplayName
			RewardTemplate.GetRewardStringFn = class'X2StrategyElement_DefaultRewards'.static.GetMissionRewardString; 
			break;
		case 'Reward_Soldier':
			RewardTemplate.GenerateRewardFn = GenerateRandomSoldierReward;
			break;
		case 'Reward_FindFaction':
			UpdateFactionSoldierReward(RewardTemplate, class'X2LWCovertActionsModTemplate'.default.FIND_SECOND_FACTION_REQ_RANK - 1);
			break;
		case 'Reward_FindFarthestFaction':
			UpdateFactionSoldierReward(RewardTemplate, class'X2LWCovertActionsModTemplate'.default.FIND_THIRD_FACTION_REQ_RANK - 1);
			break;
		case 'Reward_RescueSoldier':
			RewardTemplate.IsRewardAvailableFn = IsRescueSoldierRewardAvailableFixed;
			RewardTemplate.GenerateRewardFn = GenerateRescueSoldierRewardFixed;
			break;
		//Change the way The Resistance Cards are generated
		case 'Reward_ResistanceCard':
			RewardTemplate.GenerateRewardFn = GenerateResistanceCardReward;
			break;
		case 'Reward_IncreaseIncome':
			RewardTemplate.GiveRewardFn = GiveIncreaseIncomeReward;
			break;
		default:
			break;
	}
}

static function GiveIncreaseIncomeReward(XComGameState NewGameState, XComGameState_Reward RewardState, optional StateObjectReference AuxRef, optional bool bOrder = false, optional int OrderHours = -1)
{
	local XComGameState_WorldRegion RegionState;
	local int NegativeSupplyDifference;

	RegionState = XComGameState_WorldRegion(NewGameState.ModifyStateObject(class'XComGameState_WorldRegion', RewardState.RewardObjectReference.ObjectID));

	if (RewardState.Quantity < 0 && RegionState.GetSupplyDropReward() + RewardState.Quantity < 0)
	{
		NegativeSupplyDifference = RegionState.GetSupplyDropReward() + RewardState.Quantity;
		RegionState.POISupplyBonusDelta = RegionState.POISupplyBonusDelta - NegativeSupplyDifference;
	}
	else
	{
		RegionState.POISupplyBonusDelta += RewardState.Quantity;
	}
}

static function bool OnRescueCivilianRewardAcquired(XComGameState NewGameState, XComGameState_Item ItemState)
{
	local XComGameStateHistory History;
	local X2StrategyElementTemplateManager StratMgr;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_MissionSite MissionState;
	local XComGameState_Reward RewardState;
	local XComGameState_WorldRegion RegionState;
	local X2RewardTemplate RewardTemplate;
	local int RewardAmount;
	local XGParamTag ParamTag;
	History = `XCOMHISTORY;
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	MissionState = XComGameState_MissionSite(History.GetGameStateForObjectID(XComHQ.MissionRef.ObjectID));
	
	// This resource should only be given during loot after missions, so this should be valid
	if (MissionState != none)
	{
		//Also Count Resistance Civilian Militia being Dead
		RegionState = MissionState.GetWorldRegion();
		ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
		
		// Increase region income per civilian rescued
		RewardAmount = -100 + ItemState.Quantity * class'X2StrategyElement_XpackRewards'.static.GetRescueCivilianIncomeIncreaseReward();

		RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_IncreaseIncome'));
		RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
		RewardState.GenerateReward(NewGameState, , RegionState.GetReference());
		RewardState.SetReward(, RewardAmount); 
		RewardState.GiveReward(NewGameState);
		if(RewardAmount >= 0)
		{
			ParamTag.StrValue0 = RegionState.GetMyTemplate().DisplayName;
			class'XComGameState_HeadquartersResistance'.static.AddGlobalEffectString(NewGameState, `XEXPAND.ExpandString(class'UIRewardsRecap'.default.m_strIncreasedRegionSupplyOutput), false);
			ParamTag.StrValue0 = string(RewardAmount);
			class'XComGameState_HeadquartersResistance'.static.AddGlobalEffectString(NewGameState, `XEXPAND.ExpandString(class'UIRewardsRecap'.default.m_strIncreasedSupplyIncome), false);
		}
		else
		{
			ParamTag.StrValue0 = RegionState.GetMyTemplate().DisplayName;
			class'XComGameState_HeadquartersResistance'.static.AddGlobalEffectString(NewGameState, `XEXPAND.ExpandString(class'UIRewardsRecap'.default.m_strDecreasedRegionSupplyOutput), true);
			ParamTag.StrValue0 = string(-RewardAmount);
			class'XComGameState_HeadquartersResistance'.static.AddGlobalEffectString(NewGameState, `XEXPAND.ExpandString(class'UIRewardsRecap'.default.m_strDecreasedSupplyIncome), true);
		}
	}
			
	return true;
}


static function GenerateResistanceCardReward(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference AuxRef)
{
	local XComGameState_CovertAction ActionState;
	local XComGameState_ResistanceFaction FactionState;
	local XComGameState_StrategyCard CardState;

	ActionState = XComGameState_CovertAction(NewGameState.GetGameStateForObjectID(AuxRef.ObjectID));
	if (ActionState != none)
	{
		FactionState = ActionState.GetFaction();
		CardState = class'X2StrategyElement_DefaultRewards_LW'.static.DrawRandomPlayableCard(NewGameState, FactionState);
		
		// Save the generated card to the Action so it can easily be retrieved later
		if (CardState != none)
		{
			ActionState.StoredRewardRef = CardState.GetReference();
		}

		RewardState.RewardObjectReference = AuxRef;
	}
	else
	{
		`RedScreen("@jweinhoffer Tried to generate Resistance Card reward for non-covert action");
	}
}

static function UpdateFactionSoldierReward(X2RewardTemplate Template, int SoldierRank)
{
	local LWGiveSoldierRewardWrapper FnWrapper;

	`LWTrace("Updating faction soldier reward function");

	FnWrapper = new class'LWGiveSoldierRewardWrapper';
	FnWrapper.SoldierRank = SoldierRank;
	FnWrapper.OriginalDelegateFn = Template.GiveRewardFn;
	Template.GiveRewardFn = FnWrapper.GiveFactionSoldierReward;
}

// This is a modified version of `X2StrategyElement_XpackRewards.IsRescueSoldierRewardAvailable()`
// that adds a check for whether captured solders are already rewards on
// existing missions or covert actions.
static function bool IsRescueSoldierRewardAvailableFixed(
	optional XComGameState NewGameState,
	optional StateObjectReference AuxRef)
{
	local XComGameStateHistory History;
	local XComGameState_CampaignSettings CampaignSettings;
	local XComGameState_ResistanceFaction FactionState;
	local XComGameState_AdventChosen ChosenState;
	local StateObjectReference CapturedSoldierRef;
	
	History = `XCOMHISTORY;

	// If the XPack narrative is turned on, only allow a normal Rescue Soldier once Mox has been rescued
	CampaignSettings = XComGameState_CampaignSettings(History.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));
	if (!CampaignSettings.bXPackNarrativeEnabled || class'XComGameState_HeadquartersXCom'.static.IsObjectiveCompleted('XP0_M4_RescueMoxComplete'))
	{
		FactionState = class'X2StrategyElement_DefaultRewards'.static.GetFactionState(NewGameState, AuxRef);
		if (FactionState != none)
		{
			ChosenState = FactionState.GetRivalChosen();
			if (ChosenState.bMetXCom)
			{
				// Check whether any of the captured soldiers is *not* a reward
				// for an existing mission or covert action
				foreach ChosenState.CapturedSoldiers(CapturedSoldierRef)
				{
					if (!class'Helpers_LW'.static.IsRescueMissionAvailableForSoldier(CapturedSoldierRef, NewGameState))
						return true;
				}
			}
		}
		else
		{
			`Redscreen("@jweinhoffer RescueSoldierReward not available because FactionState was not found");
		}
	}

	return false;
}

// This is a modified version of `X2StrategyElement_XpackRewards.GenerateRescueSoldierReward()`
// that adds a check for whether captured solders are already rewards on
// existing missions or covert actions.
static function GenerateRescueSoldierRewardFixed(XComGameState_Reward RewardState, XComGameState NewGameState, optional float RewardScalar = 1.0, optional StateObjectReference ActionRef)
{
	local XComGameState_CovertAction ActionState;
	local XComGameState_AdventChosen ChosenState;
	local XComGameState_Unit UnitState;
	local array<StateObjectReference> CapturedSoldiers, ChosenCapturedSoldiers;
	local StateObjectReference CapturedSoldierRef;

	ActionState = XComGameState_CovertAction(NewGameState.GetGameStateForObjectID(ActionRef.ObjectID));
	ChosenState = ActionState.GetFaction().GetRivalChosen();
	
	// pick a soldier to rescue and save as the Reward - we're relying on
	// FindAvailableCapturedSoldier() actually returning reward reference
	// on the basis that `IsRewardAvailableFn` returned true.
	CapturedSoldiers = class'Helpers_LW'.static.FindAvailableCapturedSoldiers(NewGameState);
	foreach CapturedSoldiers(CapturedSoldierRef)
	{
		// Check whether this soldier was captured by the required Chosen
		if (ChosenState.CapturedSoldiers.Find('ObjectID', CapturedSoldierRef.ObjectID) != INDEX_NONE)
			ChosenCapturedSoldiers.AddItem(CapturedSoldierRef);
	}
	CapturedSoldierRef = class'X2StrategyElement_RandomizedSoldierRewards'.static.PickCapturedSoldier(ChosenCapturedSoldiers);

	// This is for debugging
	if (CapturedSoldiers.Length == 0)
	{
		`LWTrace("[RescueSoldier] BUG!! No captured soldiers available to be rescued (GenerateRescueSoldierRewardFixed)");
	}

	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(CapturedSoldierRef.ObjectID));
	RewardState.RewardObjectReference = UnitState.GetReference();
	RewardState.RewardString = UnitState.GetName(eNameType_RankFull);
	`LWTrace("[RescueSoldier] Adding " $ RewardState.RewardString $ " as a rescue reward (GenerateRescueSoldierRewardFixed)");
}

// Update QuestItemTemplates to include the new _LW MissionTypes
static function X2LWTemplateModTemplate CreateUpdateQuestItemsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'UpdateQuestItems');

	// We need to modify grenade items and ability templates
	Template.ItemTemplateModFn = UpdateQuestItemsTemplate;
	return Template;
}

function UpdateQuestItemsTemplate(X2ItemTemplate Template, int Difficulty)
{
	local X2QuestItemTemplate QuestItemTemplate;
	local array<string> MissionTypes;
	local string MissionType;

	QuestItemTemplate = X2QuestItemTemplate(Template);
	if(QuestItemTemplate == none)
		return;
	
	MissionTypes = QuestItemTemplate.MissionType;
	foreach MissionTypes(MissionType)
	{
		QuestItemTemplate.MissionType.AddItem(MissionType $ "_LW");
	}
	if (QuestItemTemplate.RewardType.Length > 0)
		QuestItemTemplate.RewardType.AddItem('Reward_None');

	if (QuestItemTemplate.DataName == 'FlightDevice')
	{
		QuestItemTemplate.MissionSource.AddItem('MissionSource_RecoverFlightDevice'); // this will prevent FlightDevice from being selected for Activity-based missions - fixes TTP 335
	}
}

static function X2LWTemplateModTemplate CreateModifyGrenadeEffects()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'ModifyGrenadeEffects');

	// We need to modify grenade items and ability templates
	Template.ItemTemplateModFn = ModifyGrenadeEffects;
	return Template;
}


delegate name ResistFlashbang(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState)
{
	local int k;
	local XComGameState_Unit Target;

	Target = XComGameState_Unit(kNewTargetState);
	if (Target != none)
	{
		for (k = 0; k < default.ENEMY_FLASHBANG_RESIST.length; k++)
		{
			if (default.ENEMY_FLASHBANG_RESIST[k].UnitName == Target.GetMyTemplateName())
			{
				if (`SYNC_RAND(100) < default.ENEMY_FLASHBANG_RESIST[k].Chance)
				{
					return 'AA_EffectChanceFailed';
				}
			}
		}
	}
	return 'AA_Success';
}

// Modify grenade effects:
// Flashbangs and sting grenades get blue screen bombs effects (if the ability is
// present).
// Flashbangs, sting grenades, and advent grenadier flashbangs are not valid for
// volatile mix damage bonus (note: this damage bonus was from the original volatile
// mix, the damage bonus is now only applied to boosted cores).

function ModifyGrenadeEffects(X2ItemTemplate Template, int Difficulty)
{
	local X2GrenadeTemplate                             GrenadeTemplate;
	local int k;
	local X2Effect_Persistent                           Effect;
	local X2Condition_UnitProperty	UnitCondition;
	local X2Effect_PersistentStatChange DisorientedEffect;
	GrenadeTemplate = X2GrenadeTemplate(Template);

	if(GrenadeTemplate == none)
		return;

	switch(GrenadeTemplate.DataName)
	{
		case 'FlashbangGrenade':
		case 'StingGrenade':
			GrenadeTemplate.ThrownGrenadeEffects.AddItem(class'X2Ability_LW_GrenadierAbilitySet'.static.CreateBluescreenBombsHackReductionEffect());
			GrenadeTemplate.ThrownGrenadeEffects.AddItem(class'X2Ability_LW_GrenadierAbilitySet'.static.CreateBluescreenBombsDisorientEffect());        
			GrenadeTemplate.LaunchedGrenadeEffects.AddItem(class'X2Ability_LW_GrenadierAbilitySet'.static.CreateBluescreenBombsHackReductionEffect());
			GrenadeTemplate.LaunchedGrenadeEffects.AddItem(class'X2Ability_LW_GrenadierAbilitySet'.static.CreateBluescreenBombsDisorientEffect());
			GrenadeTemplate.bAllowVolatileMix = false;

			for (k = 0; k < GrenadeTemplate.ThrownGrenadeEffects.Length; k++)
			{
				Effect = X2Effect_Persistent (GrenadeTemplate.ThrownGrenadeEffects[k]);
				if (Effect != none)
				{
					if (Effect.EffectName == class'X2AbilityTemplateManager'.default.DisorientedName)
					{
						GrenadeTemplate.ThrownGrenadeEffects[k].ApplyChanceFn = ResistFlashbang;
					}
				}
			}
			for (k = 0; k < GrenadeTemplate.LaunchedGrenadeEffects.Length; k++)
			{
				Effect = X2Effect_Persistent (GrenadeTemplate.LaunchedGrenadeEffects[k]);
				if (Effect != none)
				{
					if (Effect.EffectName == class'X2AbilityTemplateManager'.default.DisorientedName)
					{
						GrenadeTemplate.LaunchedGrenadeEffects[k].ApplyChanceFn = ResistFlashbang;
					}
				}
			}
			break;
		case 'AdvGrenadierFlashbangGrenade':
			for (k = 0; k < GrenadeTemplate.ThrownGrenadeEffects.Length; k++)
			{
				Effect = X2Effect_Persistent (GrenadeTemplate.ThrownGrenadeEffects[k]);
				if (Effect != none)
				{
					if (Effect.EffectName == class'X2AbilityTemplateManager'.default.DisorientedName)
					{
						GrenadeTemplate.ThrownGrenadeEffects[k].ApplyChanceFn = ResistFlashbang;
					}
				}
			}
			for (k = 0; k < GrenadeTemplate.LaunchedGrenadeEffects.Length; k++)
			{
				Effect = X2Effect_Persistent (GrenadeTemplate.LaunchedGrenadeEffects[k]);
				if (Effect != none)
				{
					if (Effect.EffectName == class'X2AbilityTemplateManager'.default.DisorientedName)
					{
						GrenadeTemplate.LaunchedGrenadeEffects[k].ApplyChanceFn = ResistFlashbang;
					}
				}
			}
			GrenadeTemplate.bAllowVolatileMix = false;
			break;
		case 'EMPGrenade':
		case 'EMPGrenadeMk2':
			DisorientedEffect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect();
			for (k = 0; k < DisorientedEffect.TargetConditions.Length; k++)
			{
				// Modify the existing condition, which applies only to organics
				UnitCondition = X2Condition_UnitProperty(DisorientedEffect.TargetConditions[k]);
				if (UnitCondition != none)
				{
					UnitCondition.ExcludeOrganic = true;
					UnitCondition.ExcludeRobotic = false;
					UnitCondition.IncludeWeakAgainstTechLikeRobot = true;
					break;
				}
			}

			GrenadeTemplate.ThrownGrenadeEffects.AddItem(DisorientedEffect);
			GrenadeTemplate.LaunchedGrenadeEffects.AddItem(DisorientedEffect);
			break;
		case 'FrostBomb':
		GrenadeTemplate.ThrownGrenadeEffects.Length = 0;
		GrenadeTemplate.LaunchedGrenadeEffects.Length = 0;

		GrenadeTemplate.ThrownGrenadeEffects.AddItem(class'BitterfrostHelper'.static.FreezeEffect(,,true));
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(class'BitterfrostHelper'.static.FreezeCleanse(,,true));
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(class'BitterfrostHelper'.static.BitterChillEffect(, true));
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(class'BitterfrostHelper'.static.ChillEffect(true));

		GrenadeTemplate.ThrownGrenadeEffects.AddItem(class'BitterfrostHelper'.static.FreezeEffect(false,true));
		GrenadeTemplate.ThrownGrenadeEffects.AddItem(class'BitterfrostHelper'.static.FreezeCleanse(false,true));

		GrenadeTemplate.LaunchedGrenadeEffects = GrenadeTemplate.ThrownGrenadeEffects;
		break;
		default:
			break;
	}
}

// various small changes to vanilla abilities
static function X2LWTemplateModTemplate CreateModifyAbilitiesGeneralTemplate()
{
   local X2LWTemplateModTemplate Template;
   
   `CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'ModifyAbilitiesGeneral');
   Template.AbilityTemplateModFn = ModifyAbilitiesGeneral;
   return Template;
}

static function string GetIconColorByActionPoints(X2AbilityTemplate Template)
{
	local X2AbilityCost_ActionPoints ActionPoints;
	local int k, k2, ActionPointCost;
	local bool pass, found;
	local bool IsObjectiveAbility, IsFree, IsTurnEnding, IsPsionic;
	local string BackgroundColor, ForegroundColor;

	for (k = 0; k < Template.AbilityCosts.Length; ++k)
	{   
		ActionPoints = X2AbilityCost_ActionPoints(Template.AbilityCosts[k]);
		if (ActionPoints != none)
		{
			Found = true;
			ActionPointCost = ActionPoints.iNumPoints;
			IsTurnEnding = ActionPoints.bConsumeAllPoints;
			IsFree = ActionPoints.bFreeCost;

			if (Template.AbilityIconColor == "53b45e") //Objective
			{
				IsObjectiveAbility = true; // orange
			} 
			else  if (Template.AbilitySourceName == 'eAbilitySource_Psionic')
			{
				IsPsionic = true;
			}
			break;
		}
	}
	if (!found)
	{
		pass = false;
		for (k2 = 0; k2 < Template.AbilityTriggers.Length; k2++)
		{
		   if (Template.AbilityTriggers[k2].IsA('X2AbilityTrigger_PlayerInput'))
			{
				pass = true;
			}
		}
		if (pass)
		{
			IsFree = true;
			if (Template.AbilitySourceName == 'eAbilitySource_Psionic') 
			{
				IsPsionic = true;
			}
		}
	}

	class'Utilities_LW'.static.GetAbilityIconColor(IsObjectiveAbility, IsFree, IsPsionic, IsTurnEnding, ActionPointCost, BackgroundColor, ForegroundColor);
	return BackgroundColor;
}

function ModifyAbilitiesGeneral(X2AbilityTemplate Template, int Difficulty)
{
	local X2Effect_PersistentStatChange     PersistentStatChangeEffect;
	local X2Condition_UnitEffects           UnitEffects;
	local X2AbilityToHitCalc_StandardAim    StandardAim;
	local X2Condition_UnitInventory         InventoryCondition2;
	local X2Condition_UnitEffects           SuppressedCondition, UnitEffectsCondition, NotHaywiredCondition;
	local int                               k;
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2EFfect_HuntersInstinctDamage_LW DamageModifier;
	local X2AbilityCooldown                 Cooldown;
	local X2AbilityCost_QuickdrawActionPoints	QuickdrawActionPointCost;
	local X2Effect_Squadsight               Squadsight;
	local X2Effect_ToHitModifier            ToHitModifier;
	local X2Effect_Persistent               Effect, PersistentEffect, HaywiredEffect;
	local X2Effect_VolatileMix              MixEffect;
	local X2Effect_ModifyReactionFire       ReactionFire;
	local X2Effect_HunkerDown_LW            HunkerDownEffect;
	local X2Effect_CancelLongRangePenalty   DFAEffect;
	local X2Condition_Visibility            VisibilityCondition, TargetVisibilityCondition;
	local X2Condition_UnitProperty          UnitPropertyCondition;
	//local X2AbilityTarget_Single          PrimaryTarget;
	local X2AbilityMultiTarget_Radius     RadiusMultiTarget;
	local X2AbilityCharges                  Charges;
	local X2AbilityCost_Charges             ChargeCost;
	//local X2Effect_SoulSteal_LW           StealEffect;
	local X2Effect_Guardian_LW              GuardianEffect;
	local X2Effect_BonusClipSize			PrimaryAmmoEffect;
	local X2Effect                          ShotEffect;
	local X2Effect_MaybeApplyDirectionalWorldDamage WorldDamage;
	local X2Effect_DeathFromAbove_LW        DeathEffect;
	local X2Effect_ApplyWeaponDamage        WeaponDamageEffect;
	local X2Condition_AbilityProperty		AbilityCondition;
	local name 								 AbilityName;
	local X2Effect_SharpshooterAim_LW   	AimEffect;
	local X2AbilityMultiTarget_Cone			ConeMultiTarget;
	local X2AbilityCooldown_AllInstances 	AllInstancesCooldown;
	local X2Effect_RemoveEffects 			RemoveEffects;
	local X2Effect_InstantReactionTime		DodgeBonus;
	local X2Effect_Formidable				FormidableEffect;
	local X2Condition_ExcludeRuler RulerStasisCondition;

	if (Template.DataName == 'CivilianPanicked')
	{
		FixCivilianPanicOnApproach(Template);
	}

	if (Template.DataName == 'Grapple')
	{
		Template.AbilityCooldown.iNumTurns = default.SPIDER_GRAPPLE_COOLDOWN;
	}
	if (Template.DataName == 'GrapplePowered')
	{
		Template.AbilityCooldown.iNumTurns = default.WRAITH_GRAPPLE_COOLDOWN;
	}
	if (Template.DataName == 'MediumPlatedArmorStats')
	{
		PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
		PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
		PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorChance, 100.0);
		PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, float(default.MEDIUM_PLATED_MITIGATION_AMOUNT));
		Template.AddTargetEffect(PersistentStatChangeEffect);
	}
	//HighCoverGenerator()
	if (Template.DataName == 'HighCoverGenerator')
	{
		PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
		PersistentStatChangeEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
		PersistentStatChangeEffect.AddPersistentStatChange(eStat_Defense, default.SHIELDWALL_DEFENSE_AMOUNT);
		PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorChance, 100.0);
		PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.SHIELDWALL_MITIGATION_AMOUNT);
		Template.AddShooterEffect (PersistentStatChangeEffect);
	}

	if (Template.DataName == 'HailofBullets')
	{
		/*
		InventoryCondition = new class'X2Condition_UnitInventory';
		InventoryCondition.RelevantSlot=eInvSlot_PrimaryWeapon;
		InventoryCondition.ExcludeWeaponCategory = 'shotgun';
		Template.AbilityShooterConditions.AddItem(InventoryCondition);
		*/
		InventoryCondition2 = new class'X2Condition_UnitInventory';
		InventoryCondition2.RelevantSlot=eInvSlot_PrimaryWeapon;
		InventoryCondition2.ExcludeWeaponCategory = 'sniper_rifle';
		Template.AbilityShooterConditions.AddItem(InventoryCondition2);

		for (k = 0; k < Template.AbilityCosts.length; k++)
		{
			AmmoCost = X2AbilityCost_Ammo(Template.AbilityCosts[k]);
			if (AmmoCost != none)
			{
				X2AbilityCost_Ammo(Template.AbilityCosts[k]).iAmmo = default.HAIL_OF_BULLETS_AMMO_COST;
			}
		}
	}

	if (Template.DataName == 'Demolition')
	{
		for (k = 0; k < Template.AbilityCosts.length; k++)
		{
			AmmoCost = X2AbilityCost_Ammo(Template.AbilityCosts[k]);
			if (AmmoCost != none)
			{
				X2AbilityCost_Ammo(Template.AbilityCosts[k]).iAmmo = default.DEMOLITION_AMMO_COST;
			}
		}
	}
		/*
	if (Template.DataName == 'InTheZone')
	{
		SerialCritReduction = new class 'X2Effect_SerialCritReduction';
		SerialCritReduction.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnEnd);
		SerialCritReduction.CritReductionPerKill = default.SERIAL_CRIT_MALUS_PER_KILL;
		SerialCritReduction.AimReductionPerKill = default.SERIAL_AIM_MALUS_PER_KILL;
		SerialCritReduction.Damage_Falloff = default.SERIAL_DAMAGE_FALLOFF;
		SerialCritReduction.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage, true,, Template.AbilitySourceName);
		SerialCritReduction.EffectName = 'SerialCritReduction';
		Template.AbilityTargetEffects.AddItem(SerialCritReduction);
	}*/

	// Disables the effect so they get full turns on alien turn
	// if (Template.DataName == 'AlienRulerInitialState')
	// {
	// 	Template.AbilityTargetEffects.length = 0;
	// 	DamageImmunity = new class'X2Effect_DamageImmunity';
	// 	DamageImmunity.BuildPersistentEffect(1, true, true, true);
	// 	DamageImmunity.ImmuneTypes.AddItem('Unconscious');
	// 	DamageImmunity.EffectName = 'RulerImmunity';
	// 	Template.AddTargetEffect(DamageImmunity);

	// 	//Requires listeners set up so that "RULER REACTION" overlay gets removed
	// 	Template.AddTargetEffect(new class'X2Effect_DLC2_HideSpecialTurnOverlay');
	// }

	// Use alternate DFA effect so it's compatible with Double Tap 2, and add additional ability of canceling long-range sniper rifle penalty
	if (Template.DataName == 'DeathFromAbove')
	{
		Template.AbilityTargetEffects.Length = 0;
		DFAEffect = New class'X2Effect_CancelLongRangePenalty';
		DFAEffect.BuildPersistentEffect (1, true, false);
		DFAEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, false,, Template.AbilitySourceName);
		Template.AddTargetEffect(DFAEffect);
		DeathEffect = new class'X2Effect_DeathFromAbove_LW';
		DeathEffect.BuildPersistentEffect(1, true, false, false);
		DeathEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
		Template.AddTargetEffect(DeathEffect);
	}

	// and partial turns only sometimes
	// if (Template.DataName == 'AlienRulerActionSystem')
	// {
	// 	for (k = 0; k < Template.AbilityTargetEffects.length; k++)
	// 	{
	// 		if (Template.AbilityTargetEffects[k].IsA ('X2Effect_DLC_2RulerActionPoint'))
	// 		{
	// 			Template.AbilityTargetEffects[k].ApplyChance = default.ALIEN_RULER_ACTION_BONUS_APPLY_CHANCE;
	// 		}
	// 	}
	// }

	if (Template.DataName == 'Insanity' || Template.DataName == 'VoidRiftInsanity')
	{
		for (k = Template.AbilityTargetEffects.length - 1; k >= 0; k--)
		{
			// The following code reduces the chance for mind control from Insanity to around 7%
			// from around 40%, for a late-game Psi Offense. The algorithm for stat contests is
			// not the most intuitive, which is why it's not obvious what the following code does.
			if (Template.AbilityTargetEffects[k].IsA ('X2Effect_MindControl'))
			{
				X2Effect_MindControl(Template.AbilityTargetEffects[k]).iNumTurns = default.INSANITY_MIND_CONTROL_DURATION;
				X2Effect_MindControl(Template.AbilityTargetEffects[k]).MinStatContestResult = 25;
			}
	
			if (Template.AbilityTargetEffects[k].IsA ('X2Effect_RemoveEffects'))
			{
				X2Effect_RemoveEffects(Template.AbilityTargetEffects[k]).MinStatContestResult = 25;
			}
	
			if (Template.AbilityTargetEffects[k].IsA ('X2Effect_Panicked'))
			{
				X2Effect_Panicked(Template.AbilityTargetEffects[k]).MinStatContestResult = 4;
				X2Effect_Panicked(Template.AbilityTargetEffects[k]).MaxStatContestResult = 24;
			}
				//Remove the longer disorient effect,
			if (Template.AbilityTargetEffects[k].IsA ('X2Effect_PersistentStatChange') && Template.AbilityTargetEffects[k].MinStatContestResult == 2)
			{
				if (X2Effect_PersistentStatChange(Template.AbilityTargetEffects[k]).EffectName == class'X2AbilityTemplateManager'.default.DisorientedName)
					{
						Template.AbilityTargetEffects.Remove(k, 1);
					}
			}

			// Compensate for the stat contest dilution. It's still less than it used to be.
			if (Template.AbilityTargetEffects[k].IsA ('X2Effect_PersistentStatChange') && Template.AbilityTargetEffects[k].MinStatContestResult == 1)
			{
				X2Effect_PersistentStatChange(Template.AbilityTargetEffects[k]).MinStatContestResult = 1;
				X2Effect_PersistentStatChange(Template.AbilityTargetEffects[k]).MaxStatContestResult = 3;
			}
		}
		for (k = 0; k < Template.AbilityCosts.length; k++)
		{
			ActionPointCost = X2AbilityCost_ActionPoints(Template.AbilityCosts[k]);
			if (ActionPointCost != none)
			{
				X2AbilityCost_ActionPoints(Template.AbilityCosts[k]).bConsumeAllPoints = default.INSANITY_ENDS_TURN;
			}
		}
	}

	// Make Snap Shot and Death from Above mutually exclusive as they
	// constitute way too much power when combined together, for little
	// cost (and early).
	if (Template.DataName == 'SnapShot')
		Template.PrerequisiteAbilities.AddItem('NOT_DeathFromAbove');
	if (Template.DataName == 'DeathFromAbove')
		Template.PrerequisiteAbilities.AddItem('NOT_SnapShot');

	if (Template.DataName == 'Stasis' || Template.DataName == 'PriestStasis')
	{
		UnitPropertyCondition = new class 'X2Condition_UnitProperty';
		UnitPropertyCondition.ExcludeLargeUnits = true;
		UnitPropertyCondition.ExcludeFriendlyToSource = false;
		Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);
		Template.AdditionalAbilities.AddItem('StasisShield');
		Template.PrerequisiteAbilities.AddItem('Fuse');

		RulerStasisCondition = new class 'X2Condition_ExcludeRuler';
		Template.AbilityTargetConditions.AddItem(RulerStasisCondition);

	}

	if (Template.DataName == 'StasisShield')
	{
		Template.AbilityTargetEffects.Remove(0, 1); //Remove the display dummy effect
	}

	if (Template.DataName == 'Domination')
	{
		Template.PrerequisiteAbilities.AddItem('Fuse');
	}

	if (Template.DataName == 'VoidRift')
	{
		Template.PrerequisiteAbilities.AddItem('SoulSteal');
	}

	if (Template.DataName == 'NullLance')
	{
		Template.PrerequisiteAbilities.AddItem('Solace_LW');
	}

	if (Template.DataName == 'SoulSteal')
	{
		// This is an ugly fix for a bug in vanilla that results in Soul Steal
		// occasionally appearing twice in the "choose psi ability to train"
		// screen. This hack is OK because all psi operatives have Soulfire.
		Template.PrerequisiteAbilities.RemoveItem('Soulfire');
	}

	// if (Template.DataName == 'Soulfire')
	// {
	// 	Cooldown = new class 'X2AbilityCooldown_Soulfire';
	// 	Template.AbilityCooldown = Cooldown;
	// }
	
	if (Template.DataName == 'PoisonSpit' || Template.DataName == 'MicroMissiles')
	{
		VisibilityCondition = new class'X2Condition_Visibility';
		VisibilityCondition.bVisibletoAnyAlly = true;
		VisibilityCondition.bAllowSquadsight = true;
		Template.AbilityTargetConditions.AddItem(VisibilityCondition);
		Template.AbilityMultiTargetConditions.AddItem(VisibilityCondition);
	}

	// should allow covering fire at micromissiles and ADVENT rockets
	if (Template.DataName == 'MicroMissiles' || Template.DataName == 'RocketLauncher')
	{
		Template.BuildInterruptGameStateFn = class'X2Ability'.static.TypicalAbility_BuildInterruptGameState;
	}

	if (Template.DataName == 'Stealth' && default.CONCEAL_ACTION_POINTS > 0)
	{
		for (k = 0; k < Template.AbilityCosts.length; k++)
		{
			ActionPointCost = X2AbilityCost_ActionPoints(Template.AbilityCosts[k]);
			if (ActionPointCost != none)
			{
				X2AbilityCost_ActionPoints(Template.AbilityCosts[k]).iNumPoints = default.CONCEAL_ACTION_POINTS;
				X2AbilityCost_ActionPoints(Template.AbilityCosts[k]).bConsumeAllPoints = default.CONCEAL_ENDS_TURN;
				X2AbilityCost_ActionPoints(Template.AbilityCosts[k]).bFreeCost = false;
			}
		}
	}

	// get rid of barfy screen shake on Berserker Rage
	if (Template.DataName == 'TriggerRage')
	{
		Template.CinescriptCameraType = "Archon_Frenzy";
	}

	// bugfix for Flashbangs doing damage
	if (Template.DataName == 'HuntersInstinct')
	{
		Template.AbilityTargetEffects.length = 0;
		DamageModifier = new class'X2Effect_HuntersInstinctDamage_LW';
		DamageModifier.HUNTERS_INSTINCT_DAMAGE_PCT = default.HUNTERS_INSTINCT_DAMAGE_PCT;
		DamageModifier.BuildPersistentEffect(1, true, false, true);
		DamageModifier.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, Template.AbilitySourceName);
		Template.AddTargetEffect(DamageModifier);
	}

	// bugfix for several vanilla perks being lost after bleeding out/revive
	if (Template.DataName == 'Squadsight')
	{
		Template.AbilityTargetEffects.length = 0;
		Squadsight = new class'X2Effect_Squadsight';
		Squadsight.BuildPersistentEffect(1, true, false, true);
		Squadsight.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,, Template.AbilitySourceName);
		Template.AddTargetEffect(Squadsight);
	}

	if (Template.DataName == 'HitWhereItHurts')
	{
		Template.AbilityTargetEffects.length = 0;
		ToHitModifier = new class'X2Effect_ToHitModifier';
		ToHitModifier.BuildPersistentEffect(1, true, false, true);
		ToHitModifier.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,, Template.AbilitySourceName);
		ToHitModifier.AddEffectHitModifier(eHit_Crit, class'X2Ability_SharpshooterAbilitySet'.default.HITWHEREITHURTS_CRIT, Template.LocFriendlyName,, false, true, true, true);
		Template.AddTargetEffect(ToHitModifier);
	}

	if (Template.DataName == 'HoloTargeting')
	{
		Template.AbilityTargetEffects.length = 0;
		PersistentEffect = new class'X2Effect_Persistent';
		PersistentEffect.BuildPersistentEffect(1, true, false);
		PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
		Template.AddTargetEffect(PersistentEffect);
	}

	if (Template.DataName == 'VolatileMix')
	{
		Template.AbilityTargetEffects.length = 0;
		MixEffect = new class'X2Effect_VolatileMix';
		MixEffect.BuildPersistentEffect(1, true, false, true);
		MixEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,, Template.AbilitySourceName);
		MixEffect.BonusDamage = class'X2Ability_GrenadierAbilitySet'.default.VOLATILE_DAMAGE;
		Template.AddTargetEffect(MixEffect);
	}   
	
	if (Template.DataName == 'CoolUnderPressure')
	{
		Template.AbilityTargetEffects.length = 0;
		ReactionFire = new class'X2Effect_ModifyReactionFire';
		ReactionFire.bAllowCrit = true;
		ReactionFire.ReactionModifier = class'X2Ability_SpecialistAbilitySet'.default.UNDER_PRESSURE_BONUS;
		ReactionFire.BuildPersistentEffect(1, true, false, true);
		ReactionFire.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,, Template.AbilitySourceName);
		Template.AddTargetEffect(ReactionFire);
	}   

	if (Template.DataName == 'BulletShred')
	{
		StandardAim = new class'X2AbilityToHitCalc_StandardAim';
		StandardAim.bHitsAreCrits = false;
		StandardAim.BuiltInCritMod = default.RUPTURE_CRIT_BONUS;
		Template.AbilityToHitCalc = StandardAim;
		Template.AbilityToHitOwnerOnMissCalc = StandardAim;

		for (k = 0; k < Template.AbilityTargetConditions.Length; k++)
		{
			TargetVisibilityCondition = X2Condition_Visibility(Template.AbilityTargetConditions[k]);
			if (TargetVisibilityCondition != none)
			{
				// Allow rupture to work from SS
				TargetVisibilityCondition = new class'X2Condition_Visibility';
				TargetVisibilityCondition.bRequireGameplayVisible  = true;
				TargetVisibilityCondition.bAllowSquadsight = true;
				Template.AbilityTargetConditions[k] = TargetVisibilityCondition;
			}
		}
	}

	// Bump up skulljack damage, the default 20 will fail to kill advanced units
	// and glitches out the animations.
	if (Template.DataName == 'FinalizeSKULLJACK' || Template.DataName == 'FinalizeSKULLMINE')
	{
		for (k = 0; k < Template.AbilityTargetEffects.Length; ++k)
		{
			WeaponDamageEffect = X2Effect_ApplyWeaponDamage(Template.AbilityTargetEffects[k]);
			if (WeaponDamageEffect != none)
			{
				WeaponDamageEffect.EffectDamageValue.Pierce = 99;
				WeaponDamageEffect.EffectDamageValue.Damage = 99;
			}
		}
	}



	if (Template.DataName == 'KillZone' || Template.DataName == 'Deadeye' || Template.DataName == 'BulletShred')
	{
		if (Template.DataName == 'KillZone')
		{
			ConeMultiTarget = new class'X2AbilityMultiTarget_Cone';
			ConeMultiTarget.bUseWeaponRadius = true;
			ConeMultiTarget.ConeEndDiameter = 12 * class'XComWorldData'.const.WORLD_StepSize;
			ConeMultiTarget.ConeLength = 18 * class'XComWorldData'.const.WORLD_StepSize;
			Template.AbilityMultiTargetStyle = ConeMultiTarget;
		}
		if (Template.DataName == 'Deadeye')
		{
			// Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_ShowIfAvailable;
			// CooldownShared = new class'X2AbilityCooldown_Shared';
			// CooldownShared.iNumTurns = class'X2Ability_SharpshooterAbilitySet'.default.DEADEYE_COOLDOWN;
			// CooldownShared.SharingCooldownsWith.AddItem('DeadeyeSnapShot');
			// Template.AbilityCooldown = CooldownShared;
		
			// Template.AdditionalAbilities.AddItem('DeadeyeSnapShot');
		}
		for (k = 0; k < Template.AbilityCosts.length; k++)
		{
			ActionPointCost = X2AbilityCost_ActionPoints(Template.AbilityCosts[k]);
			if (ActionPointCost != none)
			{
				X2AbilityCost_ActionPoints(Template.AbilityCosts[k]).iNumPoints = 0;
				X2AbilityCost_ActionPoints(Template.AbilityCosts[k]).bAddWeaponTypicalCost = true;
			}
		}
	}

	if (Template.DataName == 'RapidFire') 
	{
		Cooldown = new class'X2AbilityCooldown';
		Cooldown.iNumTurns = default.RAPIDFIRE_COOLDOWN;
		Template.AbilityCooldown = Cooldown;
	}
	// Steady Hands
	// Stasis Vest
	// Air Controller

	//if (Template.DataName == 'HunterProtocolShot')
	//{
		//Cooldown = new class'X2AbilityCooldown';
		//Cooldown.iNumTurns = 1;
		//Template.AbilityCooldown = Cooldown;
	//}


	// adds config to ammo cost and fixes vanilla bug in which 
	if (Template.DataName == 'SaturationFire')
	{
		for (k = 0; k < Template.AbilityCosts.length; k++)
		{
			AmmoCost = X2AbilityCost_Ammo(Template.AbilityCosts[k]);
			if (AmmoCost != none)
			{
				X2AbilityCost_Ammo(Template.AbilityCosts[k]).iAmmo = default.SATURATION_FIRE_AMMO_COST;
			}
		}

		Template.AbilityMultiTargetEffects.length = 0;
		Template.AddMultiTargetEffect(class'X2Ability_GrenadierAbilitySet'.static.ShredderDamageEffect());
		WorldDamage = new class'X2Effect_MaybeApplyDirectionalWorldDamage';
		WorldDamage.bUseWeaponDamageType = true;
		WorldDamage.bUseWeaponEnvironmentalDamage = false;
		WorldDamage.EnvironmentalDamageAmount = 30;
		WorldDamage.bApplyOnHit = true;
		WorldDamage.bApplyOnMiss = true;
		WorldDamage.bApplyToWorldOnHit = true;
		WorldDamage.bApplyToWorldOnMiss = true;
		WorldDamage.bHitAdjacentDestructibles = true;
		WorldDamage.PlusNumZTiles = 1;
		WorldDamage.bHitTargetTile = true;
		WorldDamage.ApplyChance = class'X2Ability_GrenadierAbilitySet'.default.SATURATION_DESTRUCTION_CHANCE;
		Template.AddMultiTargetEffect(WorldDamage);
	}

	if (Template.DataName == 'CarryUnit' || Template.DataName == 'Interact_OpenChest' || Template.DataName == 'Interact_StasisTube')
	{
		Template.ConcealmentRule = eConceal_Never;
	}

	// can't shoot when on FIRE
	if (class'X2Ability_PerkPackAbilitySet'.default.NO_STANDARD_ATTACKS_WHEN_ON_FIRE)
	{
		switch (Template.DataName)
		{
			case 'StandardShot':
			case 'PistolStandardShot':
			case 'SniperStandardFire':
			case 'Shadowfall':
			// Light Em Up and Snap Shot are handled in the template
				UnitEffects = new class'X2Condition_UnitEffects';
				UnitEffects.AddExcludeEffect(class'X2StatusEffects'.default.BurningName, 'AA_UnitIsBurning');
				Template.AbilityShooterConditions.AddItem(UnitEffects);
				break;
			default:
				break;
		}   
	}
	if (class'X2Ability_PerkPackAbilitySet'.default.NO_MELEE_ATTACKS_WHEN_ON_FIRE)
	{
		if (Template.IsMelee())
		{           
			UnitEffects = new class'X2Condition_UnitEffects';
			UnitEffects.AddExcludeEffect(class'X2StatusEffects'.default.BurningName, 'AA_UnitIsBurning');
			Template.AbilityShooterConditions.AddItem(UnitEffects);
		}
	}


	// Gives names to unnamed effects so they can later be referenced)
	switch (Template.DataName)
	{
		case 'HackRewardBuffEnemy':
			for (k = 0; k < Template.AbilityTargetEffects.length; k++)
			{
				Effect = X2Effect_Persistent (Template.AbilityTargetEffects[k]);
				if (Effect != none)
				{
					if (k == 0)
					{
						X2Effect_Persistent(Template.AbilityTargetEffects[k]).EffectName = 'HackRewardBuffEnemy0';
					}
					if (k == 1)
					{
						X2Effect_Persistent(Template.AbilityTargetEffects[k]).EffectName = 'HackRewardBuffEnemy1';
					}
				}
			}
			break;
		default:
			break;
	}

	// centralizing suppression rules. first batch is new vanilla abilities restricted by suppress.
	// second batch is abilities affected by vanilla suppression that need area suppression change
	// Third batch are vanilla abilities that need suppression limits AND general shooter effect exclusions
	// Mod abilities have restrictions in template defintions
	switch (Template.DataName)
	{
		case 'ThrowGrenade':
		case 'LaunchGrenade':
		case 'MicroMissiles':
		case 'RocketLauncher':
		case 'PoisonSpit':
		case 'GetOverHere':
		case 'Bind':
		case 'AcidBlob':
		case 'BlazingPinionsStage1':
		case 'HailOfBullets':
		case 'SaturationFire':
		case 'Demolition':
		case 'PlasmaBlaster':
		case 'ShredderGun':
		case 'ShredstormCannon':
		case 'BladestormAttack':
		case 'TemplarBladestormAttack':
		case 'BerserkerBladestormAttack':
		case 'AssassinBladestormAttack':
		case 'LostBladestormAttack':
		case 'RetributionAttack':
		case 'Grapple':
		case 'GrapplePowered':
		case 'IntheZone':
		case 'Reaper':
		case 'Suppression':
		case 'PistolReturnFire':
		case 'PrimaryReturnFireShot':
			SuppressedCondition = new class'X2Condition_UnitEffects';
			SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
			SuppressedCondition.AddExcludeEffect(class'X2Effect_AreaSuppression'.default.EffectName, 'AA_UnitIsSuppressed');
			Template.AbilityShooterConditions.AddItem(SuppressedCondition);
			break;
		case 'Overwatch':
		case 'PistolOverwatch':
		case 'SniperRifleOverwatch':
		case 'LongWatch':
		case 'Killzone':        
			SuppressedCondition = new class'X2Condition_UnitEffects';
			SuppressedCondition.AddExcludeEffect(class'X2Effect_AreaSuppression'.default.EffectName, 'AA_UnitIsSuppressed');
			Template.AbilityShooterConditions.AddItem(SuppressedCondition);
			break;
		case 'MarkTarget':
		case 'EnergyShield':
		case 'EnergyShieldMk3':
		case 'BulletShred':
		case 'Stealth':
			Template.AddShooterEffectExclusions();
			SuppressedCondition = new class'X2Condition_UnitEffects';
			SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
			SuppressedCondition.AddExcludeEffect(class'X2Effect_AreaSuppression'.default.EffectName, 'AA_UnitIsSuppressed');
			Template.AbilityShooterConditions.AddItem(SuppressedCondition);
			break;
		default:
			break;
	}

	if (Template.DataName == 'Shadowfall')
	{
		StandardAim = X2AbilityToHitCalc_StandardAim(Template.AbilityToHitCalc);
		if (StandardAim != none)
		{
			StandardAim.bGuaranteedHit = false;
			StandardAim.bAllowCrit = true;
			Template.AbilityToHitCalc = StandardAim;
			Template.AbilityToHitOwnerOnMissCalc = StandardAim;
		}
	}

	if (Template.DataName == class'X2Ability_Viper'.default.BindAbilityName)
	{
		SuppressedCondition = new class'X2Condition_UnitEffects';
		SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
		SuppressedCondition.AddExcludeEffect(class'X2Effect_AreaSuppression'.default.EffectName, 'AA_UnitIsSuppressed');
		SuppressedCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.StunnedName, 'AA_UnitIsStunned');
		Template.AbilityTargetConditions.AddItem(SuppressedCondition);
	}

	if (Template.DataName == 'PistolReturnFireShot')
	{
		UnitEffectsCondition = new class'X2Condition_UnitEffects';
		UnitEffectsCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.DisorientedName, 'AA_UnitIsDisoriented');
		Template.AbilityTargetConditions.AddItem(UnitEffectsCondition);
	}

	if (Template.DataName == 'Mindspin' || Template.DataName == 'Domination' || Template.DataName == class'X2Ability_PsiWitch'.default.MindControlAbilityName)
	{
		UnitEffectsCondition = new class'X2Condition_UnitEffects';
		UnitEffectsCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.StunnedName, 'AA_UnitIsStunned');
		Template.AbilityTargetConditions.AddItem(UnitEffectsCondition);
	}

	if (Template.DataName == 'ThrowGrenade')
	{
		AllInstancesCooldown = new class'X2AbilityCooldown_AllInstances';
		foreach default.ABILITIES_TO_DISABLE_GRENADE_COOLDOWN(AbilityName)
		{
			AllInstancesCooldown.ExcludeIfTheSoldierHasAbility.AddItem(AbilityName);
		}
		AllInstancesCooldown.iNumTurns = default.THROW_GRENADE_COOLDOWN;
		Template.AbilityCooldown = AllInstancesCooldown;
		X2AbilityToHitCalc_StandardAim(Template.AbilityToHitCalc).bGuaranteedHit = true;

		RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
		RadiusMultiTarget.bUseWeaponRadius = true;
		RadiusMultiTarget.bUseWeaponBlockingCoverFlag = false;
		RadiusMultiTarget.bIgnoreBlockingCover = true;
		Template.AbilityMultiTargetStyle = RadiusMultiTarget;
	

	}

	if (Template.DataName == 'LaunchGrenade')
	{
		X2AbilityToHitCalc_StandardAim(Template.AbilityToHitCalc).bGuaranteedHit = true;
		Template.TargetingMethod = class'X2TargetingMethod_ConditionalBlasterLauncher';
		Template.SoldierAbilityPurchasedFn = none;
	}

	switch (Template.DataName)
	{
	case 'PistolStandardShot':
		// Update pistol shot so that Quickdraw makes it non turn ending. This is
		// required because the default quickdraw action point cost implementation
		// checks whether the source weapon is in the secondary weapon slot.
		for (k = 0; k < Template.AbilityCosts.Length; k++)
		{
			QuickdrawActionPointCost = X2AbilityCost_QuickdrawActionPoints(Template.AbilityCosts[k]);
			if (QuickdrawActionPointCost != none)
			{
				QuickdrawActionPointCost.DoNotConsumeAllSoldierAbilities.AddItem('Quickdraw');
			}
		}

		AmmoCost = new class'X2AbilityCost_Ammo';
		AmmoCost.iAmmo = 1;
		Template.AbilityCosts.AddItem(AmmoCost);
		// Deliberate fall through

	case 'PistolOverwatch':
		// Make sure the pistol abilities can't have duplicate sources
		Template.bUniqueSource = true;
		break;
	}

	if (Template.DataName == 'Faceoff')
	{
		//Template.AbilityCooldown = none;
		if (default.FACEOFF_CHARGES > 0)
		{
			Charges = new class'X2AbilityCharges';
			Charges.InitialCharges = default.FACEOFF_CHARGES;
			Template.AbilityCharges = Charges;
			ChargeCost = new class'X2AbilityCost_Charges';
			ChargeCost.NumCharges = 1;
			Template.AbilityCosts.AddItem(ChargeCost);
		}
		UnitPropertyCondition=new class'X2Condition_UnitProperty';
		UnitPropertyCondition.ExcludeConcealed = true;
		Template.AbilityShooterConditions.AddItem(UnitPropertyCondition);
	}

	if (Template.DataName == 'HunkerDown' || Template.DataName == 'HunkerDownNoAnim')
	{
		Template.AbilityTargetEffects.length = 0;
		HunkerDownEffect = new class 'X2Effect_HunkerDown_LW';
		HunkerDownEffect.EffectName = Template.DataName;
		HunkerDownEffect.DuplicateResponse = eDupe_Refresh;
		HunkerDownEffect.BuildPersistentEffect (1,,,, eGameRule_PlayerTurnBegin);
		HunkerDownEffect.SetDisplayInfo (ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
		Template.AddTargetEffect(HunkerDownEffect);

		//Replace the Aim effect with a LW one
		AimEffect = new class'X2Effect_SharpshooterAim_LW';
		AimEffect.BuildPersistentEffect(2, false, true, false, eGameRule_PlayerTurnEnd);
		AimEffect.SetDisplayInfo(ePerkBuff_Bonus, class'X2Ability_SharpshooterAbilitySet'.default.SharpshooterAimBonusName, class'X2Ability_SharpshooterAbilitySet'.default.SharpshooterAimBonusDesc, "img:///UILibrary_PerkIcons.UIPerk_aim");
	
		AbilityCondition = new class'X2Condition_AbilityProperty';
		AbilityCondition.OwnerHasSoldierAbilities.AddItem('SharpshooterAim');
		AimEffect.TargetConditions.AddItem(AbilityCondition);
		Template.AddTargetEffect(AimEffect);

		RemoveEffects = new class'X2Effect_RemoveEffects';
		RemoveEffects.EffectNamesToRemove.AddItem(class'X2StatusEffects'.default.BurningName);
		Template.AddTargetEffect(RemoveEffects);

		DodgeBonus = new class 'X2Effect_InstantReactionTime';
		DodgeBonus.DodgePerTile = default.HUNKER_DODGE_PER_TILE;
		DodgeBonus.SetDisplayInfo(ePerkBuff_Bonus, "Hunker Bonus dodge", "Lot more dodge", Template.IconImage, false,,Template.AbilitySourceName);
		DodgeBonus.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
		Template.AddTargetEffect(DodgeBonus);

		FormidableEffect = new class'X2Effect_Formidable';
		FormidableEffect.ExplosiveDamageReduction = default.HUNKER_EXPLOSIVE_PCT_DR;
		FormidableEffect.SetDisplayInfo(ePerkBuff_Bonus, "formidable boost", "exp resistance", Template.IconImage, false,,Template.AbilitySourceName);
		FormidableEffect.BuildPersistentEffect(1, false, true, false, eGameRule_PlayerTurnBegin);
		Template.AddTargetEffect(FormidableEffect);
		//Make advent not display sound and flyover when they don't see any enemies
		Template.BuildVisualizationFn = HunkerDownAbility_BuildVisualization_LW;
	}

	if (Template.DataName == 'Fuse' && default.FUSE_COOLDOWN > 0)
	{
		Cooldown = new class 'X2AbilityCooldown';
		Cooldown.iNumTurns = default.FUSE_COOLDOWN;
		Template.AbilityCooldown = Cooldown;
	}

	// Sets to one shot per target a turn
	if (Template.DataName == 'Sentinel')
	{
		Template.AbilityTargetEffects.length = 0;
		GuardianEffect = new class'X2Effect_Guardian_LW';
		GuardianEffect.BuildPersistentEffect(1, true, false);
		GuardianEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, Template.AbilitySourceName);
		GuardianEffect.ProcChance = class'X2Ability_SpecialistAbilitySet'.default.GUARDIAN_PROC;
		Template.AddTargetEffect(GuardianEffect);

		PrimaryAmmoEffect = new class'X2Effect_BonusClipSize';
		PrimaryAmmoEffect.iClipSizeModifier = default.GUARDIAN_BONUS_AMMO;
		PrimaryAmmoEffect.BuildPersistentEffect(1, true, false, false);
		PrimaryAmmoEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false,,Template.AbilitySourceName);
		Template.AddTargetEffect(PrimaryAmmoEffect);

	}
		
	// Adds shieldHP bonus
	if (Template.DataName == 'SoulSteal')
	{
		Template.AdditionalAbilities.AddItem('SoulStealTriggered2');
	}

	// When completeing a control robot hack remove any previous disorient effects as is done for dominate.
	if (Template.DataName == 'HackRewardControlRobot' || Template.DataName == 'HackRewardControlRobotWithStatBoost')
	{
		`Log("Adding disorient removal to " $ Template.DataName);
		Template.AddTargetEffect(class'X2StatusEffects'.static.CreateMindControlRemoveEffects());
		Template.AddTargetEffect(class'X2StatusEffects'.static.CreateStunRecoverEffect());
	}

	if (Template.DataName == 'FinalizeHaywire')
	{
		HaywiredEffect = new class'X2Effect_Persistent';
		HaywiredEffect.EffectName = 'Haywired';
		HaywiredEffect.BuildPersistentEffect(1, true, false);
		HaywiredEffect.bDisplayInUI = false;
		HaywiredEffect.bApplyOnMiss = true;
		Template.AddTargetEffect(HaywiredEffect);
	}

	if (Template.DataName == 'HaywireProtocol') 
	{
		NotHaywiredCondition = new class 'X2Condition_UnitEffects';
		NotHaywiredCondition.AddExcludeEffect ('Haywired', 'AA_NoTargets'); 
		Template.AbilityTargetConditions.AddItem(NotHaywiredCondition);
	}

	switch (Template.DataName)
	{
		case 'OverwatchShot':
		case 'LongWatchShot':
		case 'GunslingerShot':
		case 'KillZoneShot':
		case 'PistolOverwatchShot':
		case 'SuppressionShot_LW':
		case 'SuppressionShot':
		case 'AreaSuppressionShot_LW':
		case 'CloseCombatSpecialistAttack':
			ShotEffect = class'X2Ability_PerkPackAbilitySet'.static.CoveringFireMalusEffect();
			ShotEffect.TargetConditions.AddItem(class'X2Ability_DefaultAbilitySet'.static.OverwatchTargetEffectsCondition());
			Template.AddTargetEffect(ShotEffect);
			break;
	}

	if (default.USE_ACTION_ICON_COLORS && !class'Helpers_LW'.static.IsModInstalled("WOTC_CostBasedAbilityColors"))
	{
		for (k = 0; k < Template.AbilityCosts.length; k++)
		{
			ActionPointCost = X2AbilityCost_ActionPoints(Template.AbilityCosts[k]);
			if (ActionPointCost != none)
			{
				if (X2AbilityCost_ActionPoints(Template.AbilityCosts[k]).bAddWeaponTypicalCost)
				{
					Template.AbilityIconColor = "Variable";
				}
			}
		}

		switch (Template.DataName)
		{
			case 'LaunchGrenade':               // Salvo, Rapid Deployment, Grenadier
			case 'ThrowGrenade':                // Salvo, Rapid Deployment, Grenadier
			case 'LWFlamethrower':              // Quickburn
			case 'Roust':                       // Quickburn
			case 'Firestorm':                   // Quickburn
			case 'LWRocketLauncher':            // Salvo
			case 'LWBlasterLauncher':           // Salvo
			case 'IRI_FireRocketLauncher':      // Salvo
			case 'IRI_FireRocket':           	// Salvo
			case 'RocketLauncher':              // Salvo
			case 'ConcussionRocket':            // Salvo
			case 'ShredderGun':                 // Salvo
			case 'PlasmaBlaster':               // Salvo
			case 'ShredstormCannon':            // Salvo
			case 'Flamethrower':                // Salvo
			case 'FlamethrowerMk2':             // Salvo
			case 'Holotarget':                  // Rapid Targeting (passive)
			case 'Reload':                      // Weapon Upgrade
			case 'PlaceEvacZone':
			case 'PlaceDelayedEvacZone':
			case 'PistolStandardShot':          // Quickdraw
			case 'ClutchShot':                  // Quickdraw
			case 'KillZone':                    // Varies by weapon type
			case 'DeadEye':                     // Varies by weapon type
			case 'Flush':                       // Varies by weapon type
			case 'PrecisionShot':               // Varies by weapon type
			case 'BulletShred':                 // varies by weapon type
			case 'ArcthrowerStun':              // Quick Zap
			case 'EMPulser':              // Quick Zap
			case 'ChainLightning':              // Quick Zap
			case 'MedikitHeal':              // Paramedic
			case 'NanoMedikitHeal':              // Paramedic
				Template.AbilityIconColor = "Variable"; break; // This calls a function that changes the color on the fly
			case 'EVAC': 
				Template.AbilityIconColor = default.ICON_COLOR_FREE; break;
			case 'IntrusionProtocol':
			case 'IntrusionProtocol_Chest':
			case 'Hack_Chest':
				Template.AbilityIconColor = default.ICON_COLOR_1; break;
			case 'IntrusionProtocol_ObjectiveChest':
			case 'Hack_Workstation':
			case 'Hack_ObjectiveChest':
			case 'PlantExplosiveMissionDevice':
			case 'GatherEvidence':
			case 'Interact_PlantBomb':
			case 'Interact_TakeVial':
			case 'Interact_StasisTube':
			case 'IntrusionProtocol_Workstation':
			case 'Interact_SmashNGrab':
				Template.AbilityIconColor = default.ICON_COLOR_OBJECTIVE; break;
			case 'HaywireProtocol':
			case 'FullOverride':
			case 'SKULLJACKAbility':
			case 'SKULLMINEAbility':
			case 'Bombard':
				Template.AbilityIconColor = default.ICON_COLOR_END; break;
			default:
				if (Template.AbilityIconColor != "Variable")
				{
					Template.AbilityIconColor = GetIconColorByActionPoints(Template);
				}
				break;
		}
	}
	

	if (DoubleTapAbilities.Find(Template.DataName) >= 0)
	{
		`LOG ("Adding Double Tap to" @ Template.DataName);
		AddDoubleTapActionPoint (Template, class'X2Ability_LW_SharpshooterAbilitySet'.default.DoubleTapActionPoint);
	}

	// bugfix, hat tip to BountyGiver, needs test
	if (Template.DataName == 'SkullOuch')
	{
		Template.BuildNewGameStateFn = SkullOuch_BuildGameState;
	}
}

// Rather than having the loss of squad concealment panic all civilians on the
// map, only panic those that XCOM get close to. This has the added benefit of
// working on missions with either concealed or unconcealed starts.
static function FixCivilianPanicOnApproach(X2AbilityTemplate Template)
{
	local X2AbilityMultiTarget_Radius RadiusMultiTarget;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2AbilityTrigger_EventListener EventListener;
	
	// Clear the 'SquadConcealmentBroken' ability trigger first
	Template.AbilityTriggers.Length = 0;
	
	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.bUseWeaponRadius = false;
	RadiusMultiTarget.fTargetRadius = `TILESTOMETERS(default.CIVILIAN_PANIC_RANGE);
	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	// Only triggers from player controlled units moving in range
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.IsPlayerControlled = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.ExcludeConcealed = true;
	Template.AbilityMultiTargetConditions.AddItem(UnitPropertyCondition);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.CheckForVisibleMovementInRadius_Self;
	EventListener.ListenerData.EventID = 'UnitMoveFinished';
	Template.AbilityTriggers.AddItem(EventListener);
}

static function XComGameState SkullOuch_BuildGameState (XComGameStateContext context)
{
	local XComGameState NewGameState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Unit UnitState;

	NewGameState = class'X2Ability'.static.TypicalAbility_BuildGameState(context);
	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext()); // or should it be just context
	UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));
	UnitState.Abilities.RemoveItem(AbilityContext.InputContext.AbilityRef);
	NewGameState.AddStateObject(UnitState);
	return NewGameState;
}


function AddReflexActionPoint(X2AbilityTemplate Template, Name ActionPointName)
{
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityCost                     Cost;

	foreach Template.AbilityCosts(Cost)
	{
		ActionPointCost = X2AbilityCost_ActionPoints(Cost);
		if (ActionPointCost != none)
		{
			ActionPointCost.AllowedTypes.AddItem(ActionPointName);
			`LWTrace("Adding reflex action point " $ ActionPointName $ " to " $ Template.DataName);
			return;
		}
	}

	`Log("Cannot add reflex ability " $ Template.DataName $ ": Has no action point cost");
}

function AddDoubleTapActionPoint(X2AbilityTemplate Template, Name ActionPointName)
{
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityCost                     Cost;

	foreach Template.AbilityCosts(Cost)
	{
		ActionPointCost = X2AbilityCost_ActionPoints(Cost);
		if (ActionPointCost != none)
		{
			ActionPointCost.AllowedTypes.AddItem(ActionPointName);
		}
	}
}
//cyan 9acbcb
//red bf1e2e
//yellow fdce2b
//orange e69831
//green 53b45e
//gray 828282
//purple b6b3e3


// Replace the base game X2Effect_ApplyWeaponDamage with the new X2Effect_ApplyExplosiveFalloffWeaponDamage.
static function X2LWTemplateModTemplate CreateSwapExplosiveDamageFalloff()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'SwapExplosiveDamageFalloff');

	// We need to modify grenade items and ability templates
	Template.ItemTemplateModFn = SwapExplosiveFalloffItem;
	Template.AbilityTemplateModFn = SwapExplosiveFalloffAbility;
	return Template;
}

function SwapExplosiveFalloffItem(X2ItemTemplate Template, int Difficulty)
{
	local X2GrenadeTemplate                             GrenadeTemplate;
	local X2Effect_ApplyWeaponDamage                    ThrownDamageEffect, LaunchedDamageEffect;
	local X2Effect_ApplyExplosiveFalloffWeaponDamage    FalloffDamageEffect;
	local X2Effect                                      GrenadeEffect;

	GrenadeTemplate = X2GrenadeTemplate(Template);
	if(GrenadeTemplate == none)
		return;
	foreach GrenadeTemplate.ThrownGrenadeEffects(GrenadeEffect)
	{
		ThrownDamageEffect = X2Effect_ApplyWeaponDamage(GrenadeEffect);
		if (ThrownDamageEffect != none)
		{
			break;
		}
	}
	foreach GrenadeTemplate.LaunchedGrenadeEffects(GrenadeEffect)
	{
		LaunchedDamageEffect = X2Effect_ApplyWeaponDamage(GrenadeEffect);
		if (LaunchedDamageEffect != none)
		{
			break;
		}
	}
	if ((ThrownDamageEffect != none || LaunchedDamageEffect != none) &&
		ClassIsChildOf(class'X2Effect_ApplyExplosiveFalloffWeaponDamage', ThrownDamageEffect.Class))
	{
		`LWTrace("Applying explosive falloff to item " $ Template.DataName);

		FalloffDamageEffect = new class'X2Effect_ApplyExplosiveFalloffWeaponDamage' (ThrownDamageEffect);

		//Falloff-specific settings
		FalloffDamageEffect.UnitDamageAbilityExclusions.AddItem('TandemWarheads'); // if has any of these abilities, skip any falloff
		FalloffDamageEffect.EnvironmentDamageAbilityExclusions.AddItem('CombatEngineer'); // if has any of these abilities, skip any falloff
		FalloffDamageEffect.UnitDamageSteps = default.UnitDamageSteps;
		FalloffDamageEffect.EnvironmentDamageSteps = default.EnvironmentDamageSteps;

		if (ThrownDamageEffect != none)
		{
			//`LOG("Swapping ThrownGrenade DamageEffect for item " $ Template.DataName $ ", Difficulty=" $ Difficulty);
			GrenadeTemplate.ThrownGrenadeEffects.RemoveItem(ThrownDamageEffect);
			GrenadeTemplate.ThrownGrenadeEffects.AddItem(FalloffDamageEffect);
		}
		if (LaunchedDamageEffect != none)
		{
			//`LOG("Swapping LaunchedGrenade DamageEffect for item " $ Template.DataName $ ", Difficulty=" $ Difficulty);
			GrenadeTemplate.LaunchedGrenadeEffects.RemoveItem(ThrownDamageEffect);
			GrenadeTemplate.LaunchedGrenadeEffects.AddItem(FalloffDamageEffect);
		}
	}
}

function SwapExplosiveFalloffAbility(X2AbilityTemplate Template, int Difficulty)
{
	local X2Effect_ApplyWeaponDamage                    DamageEffect;
	local X2Effect_ApplyExplosiveFalloffWeaponDamage    FalloffDamageEffect;
	local X2Effect                                      MultiTargetEffect;

	//`LOG("Testing Ability " $ Template.DataName);

	foreach Template.AbilityMultiTargetEffects(MultiTargetEffect)
	{
		DamageEffect = X2Effect_ApplyWeaponDamage(MultiTargetEffect);
		if (DamageEffect != none)
		{
			break;
		}
	}
	if (DamageEffect != none && ValidExplosiveFalloffAbility(Template, DamageEffect))
	{
		FalloffDamageEffect = new class'X2Effect_ApplyExplosiveFalloffWeaponDamage' (DamageEffect);

		//Falloff-specific settings
		FalloffDamageEffect.UnitDamageAbilityExclusions.AddItem('TandemWarheads'); // if has any of these abilities, skip any falloff
		FalloffDamageEffect.EnvironmentDamageAbilityExclusions.AddItem('CombatEngineer'); // if has any of these abilities, skip any falloff
		FalloffDamageEffect.UnitDamageSteps=default.UnitDamageSteps;
		FalloffDamageEffect.EnvironmentDamageSteps=default.EnvironmentDamageSteps;

		`LWTrace("Swapping AbilityMultiTargetEffects DamageEffect for item " $ Template.DataName);
		Template.AbilityMultiTargetEffects.RemoveItem(DamageEffect);
		Template.AbilityMultiTargetEffects.AddItem(FalloffDamageEffect);
	}
	else
	{
		//`LOG("Ability " $ Template.DataName $ " : Not Valid");
	}
}

function bool ValidExplosiveFalloffAbility(X2AbilityTemplate Template, X2Effect_ApplyWeaponDamage DamageEffect)
{
	if (!ClassIsChildOf(class'X2Effect_ApplyExplosiveFalloffWeaponDamage', DamageEffect.Class))
	{
		// Make
		//`REDSCREEN("Can't apply explosive falloff to" @ DamageEffect.Class @ "as it's not a super class of X2Effect_ApplyExplosiveFalloffWeaponDamage");
		return false;
	}

	//check specific exclusions
	if(default.ExplosiveFalloffAbility_Exclusions.Find(Template.DataName) != -1)
	{
		`LWTrace("Ability " $ Template.DataName $ " : Explicitly Excluded");
		return false;
	}
	//exclude any psionic ability
	if(Template.AbilitySourceName == 'eAbilitySource_Psionic')
	{
		`LWTrace("Ability " $ Template.DataName $ " : Excluded Because Psionic Source");
		return false;
	}
	//check for MultiTargetRadius
	if(X2AbilityMultiTarget_Radius(Template.AbilityMultiTargetStyle) != none)
	{
		if(DamageEffect.bExplosiveDamage)
			return true;
		else
			`LWTrace("Ability " $ Template.DataName $ " : Not bExplosiveDamage");

		if(DamageEffect.EffectDamageValue.DamageType == 'Explosion')
			return true;
		else
			`LWTrace("Ability " $ Template.DataName $ " : DamageType Not Explosion");

	}
	//check for specific inclusions
	if(default.ExplosiveFalloffAbility_Inclusions.Find(Template.DataName) != -1)
	{
		return true;
	}

	`LWTrace("Ability " $ Template.DataName $ " : Excluded By Default");
	return false;
}

// Replace the base game "PlaceEvacZone" ability with a new "PlaceDelayedEvacZone" ability.
static function X2LWTemplateModTemplate CreateDelayedEvacTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'DelayedEvacMod');

	// We need to modify character templates
	Template.CharacterTemplateModFn = ReplacePlaceEvacAbility;
	return Template;
}

// Remove the 'PlaceEvacZone' ability from all characters. This has been replaced by
// the 'PlaceDelayedEvacZone', which is technically an item-granted ability to permit
// it to be visualized as a thrown flare (grenade). See X2Item_EvacFlare.
function ReplacePlaceEvacAbility(X2CharacterTemplate Template, int Difficulty)
{
	if (Template.Abilities.Find('PlaceEvacZone') != -1)
	{
		Template.Abilities.RemoveItem('PlaceEvacZone');
	}
}

static function X2LWTemplateModTemplate CreateGeneralCharacterModTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'GeneralCharacterMod');

	// We need to modify character templates
	Template.CharacterTemplateModFn = GeneralCharacterMod;
	return Template;
}

function GeneralCharacterMod(X2CharacterTemplate Template, int Difficulty)
{
	local LootReference Loot;
	local DarkEventAbilityDefinition AbilityDefinition;
	local bool bApplyToUnit;
	local int k;

	
	if(Template.bCanTakeCover && !Template.bIsSoldier && !Template.bIsCivilian && Template.DataName != 'CivilianMilitia')
	{
		if(Template.bIsAlien)
		{
			Template.Abilities.AddItem('HunkerDownNoAnim');
		}
		else
		{
			Template.Abilities.AddItem('HunkerDown');
		}
	}

	switch (Template.DataName)
	{
		// Give ADVENT the hunker down ability
		case 'AdvTrooper_Leader':
			Template.Abilities.AddItem('ChangeForm_Shoggoth');
		case 'AdvTrooperM1':
		case 'AdvSergeantM1':
			Template.Abilities.AddItem('SkirmisherStrike');
		//Template.Abilities.AddItem('Suppression');
		break;
		case 'AdvCaptainM1':
			Template.Abilities.AddItem('ChangeForm_Shoggoth');
			Template.Abilities.AddItem('Defilade');
			Template.Abilities.AddItem('ReadyForAnything');
			break;
		case 'AdvGeneralM1':
			Template.Abilities.AddItem('Defilade');
			Template.Abilities.AddItem('ReadyForAnything');
			Template.Abilities.AddItem('Formidable');
			Template.Abilities.AddItem('Fortified');
		//Template.Abilities.AddItem('Suppression');
		break;

		case 'Muton_Leader':
		case 'MutonM2_Leader':
			Template.Abilities.AddItem('Salvo');
			Template.CharacterGroupName = 'Muton_Leader';
		case 'Muton':
		case 'MutonM2_LW':
			Template.Abilities.AddItem('FirstInLine');
		break;
		case 'Viper':
		case 'ViperM2_LW':
		case 'ViperM3_LW':
		case 'ViperM4_LW':
		case 'ViperM5_LW':
		Template.ImmuneTypes.RemoveItem('Poison');
		break;

		case 'Cyberus':
		//Template.Abilities.AddItem('Evasive');
		break;

		case 'FacelessCivilian':
			// Set 'FacelessCivilian' as being hostile. These are mostly only used
			// with the Infiltrators DE, and without this set it's trivial to detect
			// which civilians are faceless because they won't have stealth detection
			// tiles around them.
			Template.bIsHostileCivilian = true;
			// Add faceless loot to the faceless civilian template. Ensures a corpse
			// drops if you kill the civvy before they transform (e.g. by stunning them 
			// first, or doing enough damage to kill them from concealment).
			Loot.ForceLevel = 0;
			Loot.LootTableName = 'Faceless_BaseLoot';
			Template.Loot.LootReferences.AddItem(Loot);
		case 'Civilian':
			Template.Abilities.AddItem('ShadowStep');
			break;
		case 'Gatekeeper':
		case 'GatekeeperM2':
		case 'GatekeeperM3':
			//Template.ImmuneTypes.AddItem('Poison');
			//Template.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.ParthenogenicPoisonType);
			Template.ImmuneTypes.AddItem('Fire');
			Template.Abilities.AddItem('Mindshield');
			Template.Abilities.AddItem('AbsorptionFields');
			Template.bWeakAgainstTechLikeRobot = false;

			break;
		case 'AdvStunLancerM1':
			Template.Abilities.AddItem('Whirlwind2');
			Template.Abilities.AddItem('MovingTarget_LW');
			//Template.Abilities.AddItem('Resilience');
			break;
		
		case 'AdvPriest_Leader':
		//	Template.Abilities.AddItem('ChangeForm_Shoggoth');
		case 'AdvPriestM1':
			Template.Abilities.RemoveItem('Sustain');
			break;


			case 'AdvMec_Leader':
				Template.Abilities.AddItem('UnstoppableGunfire');

			case 'AdvMec_M1':
				Template.Abilities.AddItem('TandemWarheads');
				Template.Abilities.AddItem('DamageControl');
				Template.Abilities.AddItem('AbsorptionFields');
			break;
		case 'Sectoid':
			Template.Abilities.RemoveItem('VulnerabilityMelee');
			break;
		case 'AdvShielbearerM2':
			Template.Abilities.AddItem('FreeGrenades');
		break;	
	
		case 'Berserker':
		case 'Berserker_Leader':
			Template.DefaultLoadout='Berserker_Loadout';
			Template.Abilities.AddItem('AbsorptionFields');
			Template.Abilities.AddItem('BerserkerBladestorm');
		break;
		case 'AdvPurifier_Leader':
			Template.Abilities.AddItem('ChangeForm_Shoggoth');
		case 'AdvPurifierM1':
			Template.Abilities.AddItem('PhosphorusPassive');
			//Template.strScamperBT = "ScamperRoot_Purifier";
			break;

		case 'Chryssalid':
			Template.Abilities.RemoveItem('ChryssalidBurrow');
			Template.Abilities.RemoveItem('ChryssalidImmunities');
		case 'Chryssalid_Leader':
			Template.Abilities.AddItem('AbsorptionFields');
			Template.Abilities.AddItem('InstantReactionTime');
			Template.Abilities.AddItem('Evasive');
			break;

		case 'Andromedon':
		case 'Andromedon_Leader':
			Template.Abilities.RemoveItem('BigDamnPunch');
			Template.Abilities.AddItem('FirstInLine');
			break;


		case 'AndromedonRobot':
		case 'AndromedonRobotM2':
		case 'AndromedonRobotM3':
		case 'AndromedonRobot_Leader':
		//Template.Abilities.AddItem('DamageControl');
		break;

		case 'Archon':
		case 'Archon_Leader':
		Template.Abilities.AddItem('CloseCombatSpecialist');
		Template.Abilities.AddItem('AbsorptionFields');
		break;

		case 'Sectopod':
		Template.Abilities.AddItem('ProtectiveServos');
		Template.Abilities.AddItem('UnstoppableGunFire');
		Template.Abilities.AddItem('AbsorptionFields');
		break;

		case 'SpectreM1':
		Template.Abilities.RemoveItem('LightningReflexes');
		Template.Abilities.AddItem('MovingTarget_LW');
			break;
				// Should turn off tick damage every action
		case 'ViperKing':
		case 'BerserkerQueen':
		case 'ArchonKing':
			// LWOTC: Kaen and co. want ticks every action to apply to Rulers
			// as well.
			// Template.bCanTickEffectsEveryAction = false;
			break;
		case 'LostTowersSpark':
		case 'SparkSoldier':
			Template.bIgnoreEndTacticalHealthMod = false;       // This means Repair perk won't permanently fix Sparks
			Template.OnEndTacticalPlayFn = none;
 			Template.ImmuneTypes.AddItem('HeavyMental'); //CHOSEN CHANGES
			break;
		//CHOSEN CHANGES
		case 'TemplarSoldier':
		//	Template.bCanTakeCover = false;
		case 'Soldier': 
		case 'ReaperSoldier':
		case 'SkirmisherSoldier':
			Template.CharacterGroupName = 'XCOMSoldier';
			Template.Abilities.AddItem('Vengeance_LW');

		case 'RebelSoldierProxy':
		case 'RebelSoldierProxyM2':
		case 'RebelSoldierProxyM3':
			Template.Abilities.AddItem('MC_Stock_Strike');
			Template.Abilities.AddItem('GetUp');
			Template.Abilities.AddItem('ThreatAssessmentTrigger');
			break;
		case 'CivilianMilitia':
			Template.bDisplayUIUnitFlag=true;
			Template.bIsCivilian=false;
			break;
		case 'FriendlyVIPCivilian':
		case 'Soldier_VIP':
		case 'Scientist_VIP':
		case 'Engineer_VIP':
			Template.CharacterBaseStats[eStat_HP] = 8;
			Template.CharacterBaseStats[eStat_Offense] = 80;
			Template.CharacterBaseStats[eStat_Mobility] = 15;
			Template.CharacterBaseStats[eStat_SightRadius]=27;
			Template.CharacterBaseStats[eStat_DetectionRadius]=12;
			Template.CanFlankUnits = true;
			Template.Abilities.AddItem('TacticalSense');
			break;

		//Need to rescale the loadouts of these templates, and can't think of a better way since it needs to be by hp basis 
		default:
			break;
	}

	// Allow the Lost to climb walls
	if (InStr(Template.DataName, "TheLost") == 0)
	{
		//Template.Abilities.AddItem('LostHpPctBuff');
		Template.bCanUse_eTraversal_WallClimb = true;
		Template.ImmuneTypes.AddItem('Acid');
	}
	if (Template.CharacterGroupName == 'ChosenWarlock')
	{
		Template.Abilities.RemoveItem('ChosenKidnapMove');
		Template.Abilities.RemoveItem('ChosenExtractKnowledgeMove');
		Template.Abilities.RemoveItem('ChosenExtractKnowledge');
		Template.Abilities.RemoveItem('SpectralArmy');

		Template.Abilities.AddItem('CombatReadiness');
		Template.Abilities.AddItem('ChosenKidnap');
		//Template.Abilities.AddItem('CloseCombatSpecialist');
		//Template.Abilities.AddItem('GrazingFire');
		Template.Abilities.AddItem('WarlockReaction');
		//Template.Abilities.AddItem('AmmoDump_LW');
//		Template.Abilities.AddItem('ChosenCritImmune');
		
		Template.Abilities.AddItem('ChosenLootAbility');
		Template.Abilities.AddItem('TriggerDamagedTeleport_LW');
		Template.Abilities.AddItem('MovingTarget_LW');

		Template.strScamperBT = "ScamperRoot_ChosenWarlock";
		Template.ScamperActionPoints = 3;

		Template.InitiativePriority = -100;

		//Since they no longer have the ability by default
		Template.Abilities.AddItem('ChosenSummonFollowers');

		Template.ImmuneTypes.AddItem('Frost');


	}
	if (Template.CharacterGroupName == 'ChosenSniper')
	{
		Template.Abilities.RemoveItem('ChosenKidnapMove');
		Template.Abilities.RemoveItem('ChosenExtractKnowledgeMove');
		Template.Abilities.RemoveItem('ChosenExtractKnowledge');

		Template.Abilities.AddItem('HunterReaction');
		Template.Abilities.AddItem('CombatReadiness');
		//Template.Abilities.AddItem('LowProfile');
		Template.Abilities.AddItem('ChosenKidnap');
		//Template.Abilities.AddItem('ChosenCritImmune');
		//Template.Abilities.AddItem('LongWatch');
		Template.Abilities.AddItem('quickdraw');
		Template.Abilities.AddItem('ChosenImmuneMelee');
		
		Template.Abilities.AddItem('FreeGrenades');
		//Template.Abilities.AddItem('Infighter');
		//Template.Abilities.AddItem('Disabler');
		Template.Abilities.AddItem('ChosenLootAbility');
		Template.Abilities.AddItem('TriggerDamagedTeleport_LW');
		Template.Abilities.AddItem('MovingTarget_LW');

		Template.ImmuneTypes.AddItem('Frost');
		Template.InitiativePriority = -100;

	}
	if (Template.CharacterGroupName == 'ChosenAssassin')
	{
		Template.Abilities.RemoveItem('ChosenKidnapMove');
		Template.Abilities.RemoveItem('ChosenExtractKnowledgeMove');
		Template.Abilities.RemoveItem('ChosenExtractKnowledge');
		Template.Abilities.RemoveItem('BendingReed');

//		Template.Abilities.AddItem('ChosenCritImmune');
		Template.Abilities.AddItem('CombatReadiness');
		Template.Abilities.AddItem('ChosenKidnap');
		Template.Abilities.AddItem('AssassinReaction');
		Template.Abilities.AddItem('BloodThirst_LW');
		Template.Abilities.AddItem('Hitandrun');
		Template.Abilities.AddItem('FreeGrenades');
		
		Template.Abilities.AddItem('AssassinSlash_LW');
		Template.Abilities.AddItem('ImpactCompensation_LW');
		//Template.Abilities.AddItem('Infighter');
		Template.Abilities.AddItem('ChosenLootAbility');
		Template.Abilities.AddItem('Unstoppable_LW');
		Template.Abilities.AddItem('TriggerDamagedTeleport_LW');
		Template.Abilities.AddItem('MovingTarget_LW');

		Template.ImmuneTypes.AddItem('Frost');
		Template.InitiativePriority = -100;

		//Template.strScamperBT = "GenericScamperRoot";
	}
	// Any soldier templates get the Interact_SmashNGrab ability
	if (Template.bIsSoldier)
	{
		Template.Abilities.AddItem('Interact_SmashNGrab');
	}
	else if (Template.bIsAlien || Template.bIsAdvent)
	{
		// Add the dark event abilities to all alien/ADVENT units
		foreach class'X2Ability_DarkEvents_LW'.default.DarkEventAbilityDefinitions(AbilityDefinition)
		{
			switch (AbilityDefinition.ApplicationRules)
			{
			case eAR_ADVENTClones:
				bApplyToUnit = Template.bIsAdvent && !Template.bIsRobotic;
				break;
			case eAR_AllADVENT:
				bApplyToUnit = Template.bIsAdvent;
				break;
			case eAR_Robots:
				bApplyToUnit = Template.bIsAdvent && Template.bIsRobotic;
				break;
			case eAR_Aliens:
				bApplyToUnit = Template.bIsAlien;
				break;
			case eAR_AllEnemies:
				bApplyToUnit = Template.bIsAdvent || Template.bIsAlien;
				break;
			case eAR_CustomList:
				bApplyToUnit = AbilityDefinition.ApplicationTargetArray.Find(Template.DataName) != INDEX_NONE;
				break;
			default:
				bApplyToUnit = false;
				break;
			}

			if (bApplyToUnit)
			{
				Template.Abilities.AddItem(AbilityDefinition.AbilityName);
			}
		}
	}

	Template.Abilities.AddItem('MindControlCleanse');
	Template.Abilities.AddItem('SmokeFlankingCritProtection');
	Template.Abilities.AddItem('ReactionFireAgainstCoverBonus');

	// LWOTC Grant reaction fire a bonus against units in cover (the
	// effect applies to the *target* of such shots) unless Revert
	// Overwatch Rules mod is being used.
	if (!class'Helpers_LW'.static.IsModInstalled("WOTCRevertOverwatchRules") && Template.bCanTakeCover)
	{
		Template.Abilities.AddItem('ReactionFireAgainstCoverBonus');
	}
	
	for (k = 0; k < default.ENEMY_FLASHBANG_RESIST.length; k++)
	{
		if (default.ENEMY_FLASHBANG_RESIST[k].UnitName == Template.DataName)
		{
			Template.Abilities.AddItem('FlashbangResistancePassive');
			break;
		}
	}	
}

static function X2LWTemplateModTemplate CreateReconfigGearTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'ReconfigGear');
	Template.ItemTemplateModFn = ReconfigGear;
	return Template;
}

function ReconfigGear(X2ItemTemplate Template, int Difficulty)
{
	local X2WeaponTemplate WeaponTemplate;
	local X2SchematicTemplate SchematicTemplate;
	local X2EquipmentTemplate EquipmentTemplate;
	local X2WeaponUpgradeTemplate WeaponUpgradeTemplate;
	local X2GrenadeTemplate GrenadeTemplate;
	local X2AmmoTemplate AmmoTemplate;
	local int i, k;
	local ArtifactCost Resources;
	local X2ArmorTemplate ArmorTemplate;
	local StrategyRequirement AltReq;
	local X2GremlinTemplate GremlinTemplate, GremlinTemplate2;
	//local delegate<X2StrategyGameRulesetDataStructures.SpecialRequirementsDelegate> SpecialRequirement;
	local X2Effect_Persistent Effect;
	local UIStatMarkup Markup;
	local X2CharacterTemplateManager CharMgr;
	local X2CharacterTemplate CharTemplate;
	local array<X2DataTemplate>             DifficultyVariants;
    local X2DataTemplate                    DifficultyVariant;
	local array<X2DataTemplate>             DifficultyVariants2;
    local X2DataTemplate                    DifficultyVariant2;
    local X2ItemTemplateManager				ItemMgr;

	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	CharMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	// Reconfig Weapons and Weapon Schematics

	if(Template.DataName == 'RescueCivilianReward')
	{
		Template.OnAcquiredFn = OnRescueCivilianRewardAcquired;
	}

	WeaponTemplate = X2WeaponTemplate(Template);
	if (WeaponTemplate != none)
	{
		if(WeaponTemplate.InventorySlot == eInvSlot_PrimaryWeapon)
		{
			WeaponTemplate.Abilities.AddItem('OutOfAmmoFlyover');
		}
		// Pistols don't have PistolStandardShot because it was originally just an
		// ability for Sharpshooters. Add it here if the LWOTC pistol slot is enabled.
		if (WeaponTemplate.WeaponCat == 'pistol' && !class'CHItemSlot_PistolSlot_LW'.default.DISABLE_LW_PISTOL_SLOT)
			WeaponTemplate.Abilities.AddItem('PistolStandardShot');

		if(WeaponTemplate.WeaponCat == 'cannon'
		|| WeaponTemplate.WeaponCat == 'rifle'
		|| WeaponTemplate.WeaponCat == 'sniper_rifle'
		|| WeaponTemplate.WeaponCat == 'vektor_rifle'
		|| WeaponTemplate.WeaponCat == 'bullpup'
		|| WeaponTemplate.WeaponCat == 'smg'
		|| WeaponTemplate.WeaponCat == 'grenade_launcher'
		)
		{
			WeaponTemplate.Abilities.AddItem('Stock_LW_Bsc_Ability');
		}
		// substitute cannon range table
		if (WeaponTemplate.WeaponCat == 'cannon')
		{
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.LMG_ALL_RANGE;
			WeaponTemplate.Abilities.AddItem('HeavyWeaponsMobPenalty');
			//WeaponTemplate.Abilities.AddItem('CannonSprayAndPray');
			WeaponTemplate.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_LW_GearAbilities'.default.HEAVY_WEAPONS_MOB_PENALTY);
		}
		if (WeaponTemplate.WeaponCat == 'lwchemthrower')
		{
			//WeaponTemplate.Abilities.AddItem('HeavyWeaponsMobPenalty');
			//WeaponTemplate.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_LW_GearAbilities'.default.HEAVY_WEAPONS_MOB_PENALTY);
			WeaponTemplate.Abilities.AddItem('Stock_LW_Bsc_Ability');
		}
		if (WeaponTemplate.WeaponCat == 'Bullpup')
		{
			WeaponTemplate.Abilities.AddItem('SMG_LS_StatBonus');
		}
		if(WeaponTemplate.WeaponCat == 'sawedoffshotgun' || WeaponTemplate.WeaponCat == 'pistol' || WeaponTemplate.WeaponCat == 'sidearm')
		{
			WeaponTemplate.Abilities.AddItem('TakeThis');
		}
		if (WeaponTemplate.WeaponCat == 'vektor_rifle')
		{
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MID_LONG_ALL_RANGE;
		}
		if (WeaponTemplate.WeaponCat == 'rifle' 
		)
		{
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MEDIUM_ALL_RANGE;
		}
		if (WeaponTemplate.WeaponCat == 'sniper_rifle')
		{
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.LONG_ALL_RANGE;
			WeaponTemplate.Abilities.AddItem('HeavyWeaponsMobPenalty');
			WeaponTemplate.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_LW_GearAbilities'.default.HEAVY_WEAPONS_MOB_PENALTY);
		}
		if (WeaponTemplate.WeaponCat == 'bullpup'||
		WeaponTemplate.WeaponCat == 'pistol' ||
		WeaponTemplate.WeaponCat == 'smg' 
		)
		{		
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MIDSHORT_ALL_RANGE;
		}
		if(WeaponTemplate.WeaponCat == 'smg' )
		{
			WeaponTemplate.Abilities.AddItem('PrimarySprayAndPray');
		}
		if (WeaponTemplate.WeaponCat == 'shotgun' || WeaponTemplate.WeaponCat == 'sidearm' ||
		 WeaponTemplate.WeaponCat == 'arcthrower')
		{
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.SHORT_ALL_RANGE;
			if (WeaponTemplate.WeaponCat == 'shotgun')
			{
				WeaponTemplate.Abilities.AddItem('ShotgunFireControl');
			}
		}

		if (WeaponTemplate.DataName == 'Medikit')
		{
			WeaponTemplate.HideIfResearched = '';
		}
		if (WeaponTemplate.DataName == 'Medikit' || WeaponTemplate.DataName == 'NanoMedikit')
		{

			if(WeaponTemplate.DataName == 'Medikit')
			{
				WeaponTemplate.Abilities.AddItem('MedikitSelfHeal');
			}
			if(WeaponTemplate.DataName == 'NanoMedikit')
			{
				WeaponTemplate.Abilities.AddItem('NanoMedikitSelfHeal');
			}
			WeaponTemplate.Abilities.AddItem('ParaMedikitHeal');
			WeaponTemplate.Abilities.AddItem('ParaMedikitStabilize');
			//WeaponTemplate.Abilities.AddItem('Sedate');
			WeaponTemplate.Abilities.RemoveItem('MedikitBonus');
			WeaponTemplate.Abilities.RemoveItem('NanoMedikitBonus');

		}
		if ((WeaponTemplate.DataName == 'AdvTurretM1_WPN' || WeaponTemplate.DataName == 'AdvShortTurretM1_WPN') && default.EARLY_TURRET_SQUADSIGHT)
		{
			WeaponTemplate.Abilities.AddItem('Squadsight');
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MID_LONG_ALL_RANGE;
		}
		if ((WeaponTemplate.DataName == 'AdvTurretM2_WPN' || WeaponTemplate.DataName == 'AdvShortTurretM2_WPN') && default.MID_TURRET_SQUADSIGHT )
		{
			WeaponTemplate.Abilities.AddItem('Squadsight');
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MID_LONG_ALL_RANGE;
		}
		if ((WeaponTemplate.DataName == 'AdvTurretM3_WPN' || WeaponTemplate.DataName == 'AdvShortTurretM1_WPN') && default.LATE_TURRET_SQUADSIGHT )
		{
			WeaponTemplate.Abilities.AddItem('Squadsight');
			WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MID_LONG_ALL_RANGE;
		}
		if (WeaponTemplate.DataName == 'ANDROMEDONROBOT_MELEEATTACK')
		{
			WeaponTemplate.Abilities.RemoveItem('StandardMelee');
		}

			

		switch (WeaponTemplate.DataName)
		{

		case 'AcidBlob':
		case 'AcidBlobM2':
		case 'AcidBlobM3':
			X2GrenadeTemplate(WeaponTemplate).iRadius = 2;
			break;

		
		case 'SpectreM1_WPN':
		case 'SpectreM2_WPN':
			WeaponTemplate.InfiniteAmmo = false;
			break;
		case 'AdvPriestM1_PsiAmp':
			//WeaponTemplate.Abilities.AddItem('PriestPsiMindControl');
			break;
		case 'AdvPriestM3_PsiAmp':
			//WeaponTemplate.Abilities.AddItem('Solace');
			
		case 'AdvPriestM2_PsiAmp':
			//WeaponTemplate.Abilities.AddItem('MindShield');
			WeaponTemplate.Abilities.RemoveItem('PriestPsiMindControl');
			break;
		case 'AdvPurifierFlamethrower':
			WeaponTemplate.iIdealRange = 7;
			break;	

		case 'ChosenShotgun_CV':
		case 'ChosenShotgun_MG':
		case 'ChosenShotgun_BM':
		case 'ChosenShotgun_T4':
			WeaponTemplate.Abilities.RemoveItem('RapidFire');
			break;

		case 'ChosenSniperPistol_CV':
		case 'ChosenSniperPistol_MG':
		case 'ChosenSniperPistol_BM':
		case 'ChosenSniperPistol_T4':
			WeaponTemplate.Abilities.RemoveItem('LethalDose');
			break;
		case 'ChosenSniperRifle_CV':
		case 'ChosenSniperRifle_MG':
		case 'ChosenSniperRifle_BM':
		case 'ChosenSniperRifle_T4':
			//WeaponTemplate.Abilities.RemoveItem('TrackingShot');
			WeaponTemplate.Abilities.RemoveItem('HunterKillzone');
			break;

		case 'Warlock_PsiWeapon':
			WeaponTemplate.Abilities.AddItem('ShieldAllyM1');
			WeaponTemplate.BaseDamage = default.WARLOCKPSIM1_BASEDAMAGE;
			WeaponTemplate.Abilities.RemoveItem('SpectralArmy');
			WeaponTemplate.Abilities.RemoveItem('Corress');
			break;

		case 'WarlockM2_PsiWeapon':
			WeaponTemplate.Abilities.AddItem('ShieldAllyM2');
			WeaponTemplate.BaseDamage = default.WARLOCKPSIM2_BASEDAMAGE;
			WeaponTemplate.Abilities.RemoveItem('SpectralArmyM2');
			WeaponTemplate.Abilities.RemoveItem('CorressM2');
			break;

		case 'WarlockM3_PsiWeapon':
			WeaponTemplate.Abilities.AddItem('ShieldAllyM3');
			WeaponTemplate.BaseDamage = default.WARLOCKPSIM3_BASEDAMAGE;
			WeaponTemplate.Abilities.RemoveItem('SpectralArmyM3');
			WeaponTemplate.Abilities.RemoveItem('CorressM3');
			break;

		case 'WarlockM4_PsiWeapon':
			WeaponTemplate.Abilities.AddItem('ShieldAllyM4');
			WeaponTemplate.BaseDamage = default.WARLOCKPSIM4_BASEDAMAGE;
			WeaponTemplate.Abilities.RemoveItem('SpectralArmyM4');
			WeaponTemplate.Abilities.RemoveItem('CorressM4');
			break;
		case 'WarlockM5_PsiWeapon':
			WeaponTemplate.Abilities.AddItem('ShieldAllyM5');
			WeaponTemplate.BaseDamage = default.WARLOCKPSIM5_BASEDAMAGE;
			break;

		case 'ChosenRifle_XCOM':
			WeaponTemplate.Abilities.AddItem('OverbearingSuperiority_LW');
			WeaponTemplate.OnAcquiredFn = none;
			//WeaponTemplate.SetUIStatMarkup(class'XLocalizedData'.default.AimLabel, eStat_Offense, class'X2Item_XpackWeapons'.default.CHOSENRIFLE_XCOM_AIM);
			break;
		case 'ChosenSniperRifle_XCOM':
			WeaponTemplate.iTypicalActionCost = 2;
			WeaponTemplate.Abilities.AddItem('XCOMHunterMark_LW');
			//WeaponTemplate.Abilities.RemoveItem('Reload');
			//WeaponTemplate.Abilities.AddItem('ComplexReload_LW'); 
			WeaponTemplate.OnAcquiredFn = none;
			break;
		case 'ChosenSword_XCOM':
			WeaponTemplate.Abilities.AddItem('XCOMBloodThirst_LW');
			//Remove the armor piercing UI stat markup
			foreach WeaponTemplate.UIStatMarkups(Markup)
			{
				if (Markup.StatLabel == class'XLocalizedData'.default.PierceLabel)
				{
					WeaponTemplate.UIStatMarkups.RemoveItem(Markup);
				}
			}
			WeaponTemplate.OnAcquiredFn = none;
			break;
		case 'ChosenShotgun_XCOM':
			//WeaponTemplate.Abilities.AddItem('Brawler');
			WeaponTemplate.Abilities.AddItem('Vampirism_LW');
			WeaponTemplate.Abilities.AddItem('ImpactCompensation_LW');
			WeaponTemplate.OnAcquiredFn = none;
			break;
		case 'ChosenSniperPistol_XCOM':
			WeaponTemplate.Abilities.AddItem('Fatality_LW');
			//Remove the armor piercing UI stat markup
			foreach WeaponTemplate.UIStatMarkups(Markup)
			{
				if (Markup.StatLabel == class'XLocalizedData'.default.PierceLabel)
				{
					WeaponTemplate.UIStatMarkups.RemoveItem(Markup);
				}
			}
			break;
		case 'Gremlin_CV':
		WeaponTemplate.BaseDamage = default.GREMLIN_CV_BASEDAMAGE;
		break;
		case 'Gremlin_MG':
		WeaponTemplate.BaseDamage = default.GREMLIN_MG_BASEDAMAGE;
		break;
		case 'Gremlin_BM':
		WeaponTemplate.BaseDamage = default.GREMLIN_MG_BASEDAMAGE;
		break;

		default:
			break;
		}

		//if (WeaponTemplate.Abilities.Find('StandardShot') != -1)
		//{
			//WeaponTemplate.Abilities.AddItem('ReflexShot');
			//`LWTRACE ("Adding ReflexShot to" @ WeaponTemplate.DataName);
		//}

		//switch (WeaponTemplate.DataName)
		//{
			//case 'MutonM2_LW_WPN':
			//case 'MutonM3_LW_WPN':
			//case 'NajaM1_WPN':
			//case 'NajaM2_WPN':
			//case 'NajaM3_WPN':
			//case 'SidewinderM1_WPN':
			//case 'SidewinderM2_WPN':
			//case 'SidewinderM3_WPN':
				//break;
			//default;
				//break;
		//}
		for (i=0; i < ItemTable.Length; ++i)
		{
			if (WeaponTemplate.DataName == ItemTable[i].ItemTemplateName)
			{
				WeaponTemplate.NumUpgradeSlots = ItemTable[i].Slots;
			}
		}
		switch (WeaponTemplate.DataName)
		{
			case 'Viper_Tongue_WPN':
			WeaponTemplate.Aim = 10;
			case 'Muton_MeleeAttack':
			case 'AndromedonRobot_MeleeAttack':
			case 'ArchonStaff':
			case 'PsiZombie_MeleeAttack':
				WeaponTemplate.iEnvironmentDamage = 0;
				WeaponTemplate.iRange = 0;
				break;
			case 'Faceless_MeleeAoE':
				WeaponTemplate.iEnvironmentDamage = 5;
				break;
			case 'ChosenSniperRifle_CV':
			case 'ChosenSniperRifle_MG':
			case 'ChosenSniperRifle_BM':
			case 'ChosenSniperRifle_T4':
				WeaponTemplate.iIdealRange =25;
				break;
			case 'Muton_WPN':
				WeaponTemplate.Abilities.RemoveItem('Suppression');
				break;
			default:
				break;
		}

		if (WeaponTemplate.DataName == 'Sword_BM' || WeaponTemplate.DataName == 'WristBlade_BM' || WeaponTemplate.DataName =='WristBladeLeft_BM' || WeaponTemplate.DataName == 'AlienHunterAxe_Beam' || WeaponTemplate.DataName == 'AlienHunterAxeThrown_Beam')
		{
			for (k = 0; k < WeaponTemplate.BonusWeaponEffects.length; k++)
			{
				Effect = X2Effect_Persistent(WeaponTemplate.BonusWeaponEffects[k]);
				if (Effect != none)
				{
					if (Effect.EffectName == class'X2StatusEffects'.default.BurningName)
					{
						`LWTrace("!!!!! UPDATING FUSION SWORD CHANCE !!!!");
						Effect.ApplyChance = default.FUSION_SWORD_FIRE_CHANCE;
					}
				}
			}
		}
	}   

	GremlinTemplate = X2GremlinTemplate(Template);
	if (GremlinTemplate != none)
	{
        ItemMgr.FindDataTemplateAllDifficulties(Template.DataName, DifficultyVariants);

        foreach DifficultyVariants(DifficultyVariant)
        {
            GremlinTemplate2 = X2GremlinTemplate(DifficultyVariant);

            if (GremlinTemplate2 != none)
            {
                if (GremlinTemplate2.weaponcat == 'gremlin')
				{
					//`LOG("Gremlin Animation Patch - found gremlin template" @ GremlinTemplate);
					//`LOG("Gremlin Animation Patch - now looking for" @ GremlinTemplate.CosmeticUnitTemplate);
				    CharMgr.FindDataTemplateAllDifficulties(name(GremlinTemplate2.CosmeticUnitTemplate), DifficultyVariants2);

					foreach DifficultyVariants2(DifficultyVariant2)
    				{
        				CharTemplate = X2CharacterTemplate(DifficultyVariant2);
        				if (CharTemplate != none)
				        {
							//`LOG("Gremlin Animation Patch - patched animations onto" @ CharTemplate);
							CharTemplate.AdditionalAnimSets.AddItem(AnimSet(`CONTENT.RequestGameArchetype("WotC_APA_GremlinAnims.AS_APA_Gremlin")));
				        }
				    }

				}
            }
		}
		if (GremlinTemplate.DataName == 'Gremlin_MG')
		{
			//To get the radius increase for blinding protocol
			GremlinTemplate.Abilities.AddItem('LW_T2GremlinIndicator');

			GremlinTemplate.RevivalChargesBonus = 1;
			GremlinTemplate.ScanningChargesBonus = 1;
			GremlinTemplate.AidProtocolBonus = 5;

		}
		if (GremlinTemplate.DataName == 'Gremlin_BM')
		{
			//To get the radius increase for blinding protocol
			GremlinTemplate.Abilities.AddItem('LW_T3GremlinIndicator');

			GremlinTemplate.RevivalChargesBonus = 2;
			GremlinTemplate.ScanningChargesBonus = 2;
			GremlinTemplate.AidProtocolBonus = 10;
		}
		if (GremlinTemplate.DataName == 'SparkBit_MG')
		{
			GremlinTemplate.HealingBonus = 1;
		}
		if (GremlinTemplate.DataName == 'SparkBit_BM')
		{
			GremlinTemplate.HealingBonus = 2;
		}
	}
	
	// KILL SCHEMATICS
	SchematicTemplate = X2SchematicTemplate(Template);
	if (SchematicTemplate != none && default.SchematicsToDisable.Find(SchematicTemplate.DataName) != -1)
	{
		SchematicTemplate.CanBeBuilt = false;
		SchematicTemplate.PointsToComplete = 999999;
		SchematicTemplate.Requirements.RequiredEngineeringScore = 999999;
		SchematicTemplate.Requirements.bVisibleifPersonnelGatesNotMet = false;
		SchematicTemplate.OnBuiltFn = none;
		SchematicTemplate.Cost.ResourceCosts.Length = 0;
		SchematicTemplate.Cost.ArtifactCosts.Length = 0;
	}
	// special handling of DLC2 schematics so that they can't be used when units with them are deployed
	if (SchematicTemplate != none)
	{
		switch (SchematicTemplate.DataName)
		{
			//Make the schemacit costs in strategy tuning config
			case 'Pistol_MG_Schematic':
			case 'SideArm_MG_Schematic':
			Template.Cost.ResourceCosts.Length = 0;

			Template.Requirements.RequiredSoldierClass = '';

			Resources.ItemTemplateName = 'Supplies';
			Resources.Quantity = 20;
			Template.Cost.ResourceCosts.AddItem(Resources);
		
			Resources.ItemTemplateName = 'AlienAlloy';
			Resources.Quantity = 1;
			Template.Cost.ResourceCosts.AddItem(Resources);
			
			Resources.ItemTemplateName = 'EleriumDust';
			Resources.Quantity = 1;
			Template.Cost.ResourceCosts.AddItem(Resources);
		
			break;
			case 'Pistol_BM_Schematic':
			case 'SideArm_BM_Schematic':
			Template.Cost.ResourceCosts.Length = 0;

			Resources.ItemTemplateName = 'Supplies';
			Resources.Quantity = 35;
			Template.Cost.ResourceCosts.AddItem(Resources);
		
			Resources.ItemTemplateName = 'AlienAlloy';
			Resources.Quantity = 2;
			Template.Cost.ResourceCosts.AddItem(Resources);
			
			Resources.ItemTemplateName = 'EleriumDust';
			Resources.Quantity = 2;
			Template.Cost.ResourceCosts.AddItem(Resources);
			Template.Requirements.RequiredSoldierClass = '';
			break;

			// case 'HunterRifle_MG_Schematic':
			// case 'HunterRifle_BM_Schematic':
			// case 'HunterPistol_MG_Schematic':
			// case 'HunterPistol_BM_Schematic':
			// case 'HunterAxe_MG_Schematic':
			// case 'HunterAxe_BM_Schematic':
			// 	class'LWDLCHelpers'.static.GetAlienHunterWeaponSpecialRequirementFunction(SpecialRequirement, SchematicTemplate.DataName);
			// 	SchematicTemplate.Requirements.SpecialRequirementsFn = SpecialRequirement;
			// 	SchematicTemplate.AlternateRequirements[0].SpecialRequirementsFn = SpecialRequirement;
			// 	break;
			default:
				break;
		}

	}
	// ALL ITEMS, including resources -- config art and trading post value
	for (i=0; i < ItemTable.Length; ++i)
	{           
		if (Template.DataName == ItemTable[i].ItemTemplateName)
		{
			if (ItemTable[i].TradingPostValue != 0)
				Template.TradingPostValue = ItemTable[i].TradingPostValue;
			if (ItemTable[i].InventoryImage != "")
				Template.strInventoryImage = ItemTable[i].InventoryImage;
			if (ItemTable[i].Tier > -1)
			{
				Template.Tier = ItemTable[i].Tier;
			}
		}
	}

	if (default.EXPLOSIVES_NUKE_CORPSES)
	{
		// NOTE: Leaving off Codex and Avatar for plot reasons
		switch (Template.DataName)
		{
			case 'CorpseSectoid':
			case 'CorpseViper':
			case 'CorpseMuton':
			case 'CorpseBerserker':
			case 'CorpseArchon':
			case 'CorpseAndromedon':
			case 'CorpseFaceless':
			case 'CorpseChryssalid':
			case 'CorpseGatekeeper':
			case 'CorpseAdventTrooper':
			case 'CorpseAdventOfficer':
			case 'CorpseAdventTurret':
			case 'CorpseAdventMEC':
			case 'CorpseAdventStunLancer':
			case 'CorpseAdventShieldbearer':
			case 'CorpseDrone':
			case 'CorpseMutonElite':
			case 'CorpseSpectre':
			case 'CorpseAdventPurifier':
			case 'CorpseAdventPriest':
			case 'CorpseTheLost':
				Template.LeavesExplosiveRemains = false;
				break;
			default:
				break;
		}
	}

	if (Template.DataName == 'SmallIntelCache')
	{
		Template.ResourceQuantity = default.SMALL_INTEL_CACHE_REWARD;
		`LWTRACE("SETTING SMALL INTEL CACHE REWARD TO" @ Template.ResourceQuantity);
	}
	if (Template.DataName == 'BigIntelCache')
	{
		Template.ResourceQuantity = default.LARGE_INTEL_CACHE_REWARD;
		`LWTRACE("SETTING LARGE INTEL CACHE REWARD TO" @ Template.ResourceQuantity);
	}

	EquipmentTemplate = X2EquipmentTemplate(Template);
	if (EquipmentTemplate != none)
	{
		if (EquipmentTemplate.DataName == 'HazmatVest') // BUGFIX TO INCLUDE ACID IMMUNITY
		{
			EquipmentTemplate.Abilities.Length = 0;
			EquipmentTemplate.Abilities.AddItem ('HazmatVestBonus_LW');
			EquipmentTemplate.UIStatMarkups.Length = 0;
			EquipmentTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, 2);
		}
		if (EquipmentTemplate.DataName == 'NanofiberVest') // THIS JUST MAKES IT BETTER
		{
			EquipmentTemplate.Abilities.Length = 0;
			EquipmentTemplate.Abilities.AddItem ('NanofiberVestBonus_LW');
			//remove the HP bonuses in favor of ablative
			EquipmentTemplate.UIStatMarkups.Length = 0;
			EquipmentTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, 2);
		}
		if (EquipmentTemplate.DataName == 'PlatedVest') 
		{
			EquipmentTemplate.Abilities.AddItem ('Alloy_Plating_Ability');
			//remove the HP bonuses in favor of ablative
			EquipmentTemplate.UIStatMarkups.Length = 0;
			EquipmentTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, 3);
			EquipmentTemplate.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, eStat_ArmorMitigation, class'X2Ability_ItemGrantedAbilitySet'.default.PLATED_VEST_MITIGATION_AMOUNT);

		}
		if (EquipmentTemplate.DataName == 'StasisVest')
		{
			EquipmentTemplate.Abilities.AddItem ('Alloy_Plating_Ability');
			//remove the HP bonuses in favor of ablative
			EquipmentTemplate.UIStatMarkups.Length = 0;
			EquipmentTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, 3);
		}
		if (EquipmentTemplate.DataName == 'HellWeave')
		{
			EquipmentTemplate.Abilities.AddItem ('Chitin_Plating_Ability');
			//remove the HP bonuses in favor of ablative
			EquipmentTemplate.UIStatMarkups.Length = 0;
			EquipmentTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, 4);
		}

			
		///Add an ability icon for all of these so people can keep ammo straight
		if (EquipmentTemplate.DataName == 'APRounds')
		{
			if (EquipmentTemplate.Abilities.Find('AP_Rounds_Ability_PP') == -1)
			{
				EquipmentTemplate.Abilities.AddItem('AP_Rounds_Ability_PP');
			//	EquipmentTemplate.Abilities.AddItem('APRoundsCritPenalty');
			}
		}
		if (EquipmentTemplate.DataName == 'TalonRounds')
		{
			if (EquipmentTemplate.Abilities.Find('Talon_Rounds_Ability_PP') == -1)
			{
				EquipmentTemplate.Abilities.AddItem('Talon_Rounds_Ability_PP');
			}
		}
		if (EquipmentTemplate.DataName == 'VenomRounds')
		{
			if (EquipmentTemplate.Abilities.Find('Venom_Rounds_Ability_PP') == -1)
			{
				EquipmentTemplate.Abilities.AddItem('Venom_Rounds_Ability_PP');
			}
		}
		if (EquipmentTemplate.DataName == 'IncendiaryRounds')
		{
			if (EquipmentTemplate.Abilities.Find('Dragon_Rounds_Ability_PP') == -1)
			{
				EquipmentTemplate.Abilities.AddItem('Dragon_Rounds_Ability_PP');
			}
		}
		if (EquipmentTemplate.DataName == 'BluescreenRounds')
		{
			if (EquipmentTemplate.Abilities.Find('Bluescreen_Rounds_Ability_PP') == -1)
			{
				EquipmentTemplate.Abilities.AddItem('BluescreenRoundsDisorient');
				EquipmentTemplate.Abilities.AddItem('Bluescreen_Rounds_Ability_PP');
			}
		}
		if (EquipmentTemplate.DataName == 'TracerRounds')
		{
			if (EquipmentTemplate.Abilities.Find('Tracer_Rounds_Ability_PP') == -1)
			{
				EquipmentTemplate.Abilities.AddItem('Tracer_Rounds_Ability_PP');
			}
		}
		if (EquipmentTemplate.DataName == 'FalconRounds')
		{
			EquipmentTemplate.Abilities.AddItem('ShredderRoundsPenalty');
		}

			
		// Adds stat markup for medium plated armor
		ArmorTemplate = X2ArmorTemplate(Template);
		if (ArmorTemplate != none)
		{
			switch (ArmorTemplate.DataName)
			{
				case 'KevlarArmor_DLC_Day0':
				ArmorTemplate.bAddsUtilitySlot = true;
				ArmorTemplate.ItemCat = 'armor';
				ArmorTemplate.Abilities.AddItem('LightKevlarArmorStats');
				ArmorTemplate.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_LW_GearAbilities'.default.LIGHT_KEVLAR_MOBILITY_BONUS);
				ArmorTemplate.strImage = "img:///UILibrary_HeavyAndLightKevlarArmors.LightArmor";
				ArmorTemplate.Abilities.AddItem('Light_Kevlar_Plating_Ability');
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.LIGHT_KEVLAR_PLATING_HP);

				break;

				case 'HeavyPlatedArmor':
				ArmorTemplate.CreatorTemplateName = 'HeavyPlatedArmor_Schematic';
				ArmorTemplate.Abilities.AddItem('Predator_Plating_Ability');
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.PREDATOR_PLATING_HP);
				ArmorTemplate.Abilities.AddItem('ExoskeletonServos');
				ArmorTemplate.bHeavyWeapon = false;
				break;

				case 'HeavyAlienArmor':
				ArmorTemplate.Abilities.RemoveItem('RagePanic');
				ArmorTemplate.Abilities.AddItem('Predator_Plating_Ability');
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.PREDATOR_PLATING_HP);
				ArmorTemplate.Abilities.AddItem('ExoskeletonServos');
				ArmorTemplate.bHeavyWeapon = false;
				break;

				case 'HeavyPoweredArmor':
				ArmorTemplate.CreatorTemplateName = 'HeavyPoweredArmor_Schematic';
				ArmorTemplate.Abilities.AddItem('Warden_Plating_Ability');
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.WARDEN_PLATING_HP);
				ArmorTemplate.Abilities.AddItem('ExoskeletonServos');
				ArmorTemplate.bHeavyWeapon = false;
				break;

				case 'HeavyAlienArmorMk2':
				ArmorTemplate.Abilities.RemoveItem('RagePanic');
				ArmorTemplate.Abilities.AddItem('Warden_Plating_Ability');
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.WARDEN_PLATING_HP);
				ArmorTemplate.Abilities.AddItem('ExoskeletonServos');
				ArmorTemplate.bHeavyWeapon = false;
				break;

				case 'LightPlatedArmor':
				ArmorTemplate.CreatorTemplateName = 'LightPlatedArmor_Schematic';
				ArmorTemplate.bAddsUtilitySlot = true;
				ArmorTemplate.Abilities.AddItem('Spider_Plating_Ability');
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.SPIDER_PLATING_HP);
				break;

				case 'LightAlienArmor':
				ArmorTemplate.bAddsUtilitySlot = true;
				ArmorTemplate.Abilities.RemoveItem('SerpentPanic');
				ArmorTemplate.Abilities.AddItem('Spider_Plating_Ability');
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.SPIDER_PLATING_HP);
				break;

				case 'LightPoweredArmor':
				ArmorTemplate.CreatorTemplateName = 'LightPoweredArmor_Schematic';
				ArmorTemplate.Abilities.AddItem('Wraith_Plating_Ability');
				ArmorTemplate.bAddsUtilitySlot = true;
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.WRAITH_PLATING_HP);
				break;

				case 'LightAlienArmorMk2':
				ArmorTemplate.Abilities.AddItem('Wraith_Plating_Ability');
				ArmorTemplate.Abilities.RemoveItem('SerpentPanic');
				ArmorTemplate.bAddsUtilitySlot = true;
				ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.WRAITH_PLATING_HP);
				break;

				case 'KevlarArmor':
				case 'ReaperArmor':
				case 'SkirmisherArmor':
				case 'TemplarArmor':
					ArmorTemplate.Abilities.AddItem('Kevlar_Plating_Ability');
					ArmorTemplate.bAddsUtilitySlot = true;
					ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.KEVLAR_PLATING_HP);
					break;

				// Let all soldier armors provide an extra utility slot
				case 'MediumPoweredArmor':
				case 'PoweredReaperArmor':
				case 'PoweredSkirmisherArmor':
				case 'PoweredTemplarArmor':
					ArmorTemplate.bAddsUtilitySlot = true;
					ArmorTemplate.Abilities.AddItem('Warden_Plating_Ability');
					ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.WARDEN_PLATING_HP);
					break;
				
				case 'PlatedReaperArmor':
				case 'PlatedSkirmisherArmor':
				case 'PlatedTemplarArmor':
					ArmorTemplate.bAddsUtilitySlot = true;
				case 'MediumPlatedArmor':
					ArmorTemplate.Abilities.AddItem('Predator_Plating_Ability');
					ArmorTemplate.SetUIStatMarkup(class'XLocalizedData'.default.ArmorLabel, 14, default.MEDIUM_PLATED_MITIGATION_AMOUNT);
					ArmorTemplate.SetUIStatMarkup(class'X2Ability_LW_GearAbilities'.default.AblativeHPLabel, eStat_ShieldHP, class'X2Ability_LW_GearAbilities'.default.PREDATOR_PLATING_HP);
					break;

				case 'SparkArmor':
				case 'PlatedSparkArmor':
				case 'PoweredSparkArmor':
					ArmorTemplate.Abilities.AddItem('Carapace_Plating_Ability');
					break;
				
				default:
					// Assume any other armors we don't know about should get the extra
					// utility slot. (Issue #89)
					ArmorTemplate.bAddsUtilitySlot = true;
					break;
			}
		}

		GrenadeTemplate = X2GrenadeTemplate(Template);
		if (GrenadeTemplate != none)
		{
			if (GrenadeTemplate.DataName == 'ProximityMine')
			{
				GrenadeTemplate.iEnvironmentDamage = class'X2Item_DefaultWeaponMods_LW'.default.PROXIMITYMINE_iENVIRONMENTDAMAGE;
			}
			if (GrenadeTemplate.DataName == 'MutonGrenade')
			{
				GrenadeTemplate.iEnvironmentDamage = class'X2Item_DefaultWeaponMods_LW'.default.MUTONGRENADE_iENVIRONMENTDAMAGE;
				GrenadeTemplate.iRange = class'X2Item_DefaultWeaponMods_LW'.default.MUTONGRENADE_RANGE;
			}
			if (GrenadeTemplate.DataName == 'FragGrenade')
			{
				GrenadeTemplate.HideIfResearched = '';
			}
			if (GrenadeTemplate.DataName == 'SmokeGrenade')
			{
				GrenadeTemplate.HideIfResearched = '';
			}
			if (GrenadeTemplate.DataName == 'EMPGrenade')
			{
				GrenadeTemplate.HideIfResearched = '';
			}
			if (GrenadeTemplate.DataName == 'FireBomb')
			{
				for (k = 0; k < GrenadeTemplate.ThrownGrenadeEffects.length; k++)
				{
					if (GrenadeTemplate.ThrownGrenadeEffects[k].IsA ('X2Effect_Burning'))
					{
						GrenadeTemplate.ThrownGrenadeEffects[k].ApplyChance = default.FIREBOMB_FIRE_APPLY_CHANCE;
					}
				}
				for (k = 0; k < GrenadeTemplate.LaunchedGrenadeEffects.length; k++)
				{
					if (GrenadeTemplate.LaunchedGrenadeEffects[k].IsA ('X2Effect_Burning'))
					{
						GrenadeTemplate.LaunchedGrenadeEffects[k].ApplyChance = default.FIREBOMB_FIRE_APPLY_CHANCE;
					}
				}
			}
			if (GrenadeTemplate.DataName == 'FireBombMk2')
			{
				for (k = 0; k < GrenadeTemplate.ThrownGrenadeEffects.length; k++)
				{
					if (GrenadeTemplate.ThrownGrenadeEffects[k].IsA ('X2Effect_Burning'))
					{
						GrenadeTemplate.ThrownGrenadeEffects[k].ApplyChance = default.FIREBOMB_2_FIRE_APPLY_CHANCE;
					}
				}
				for (k = 0; k < GrenadeTemplate.LaunchedGrenadeEffects.length; k++)
				{
					if (GrenadeTemplate.LaunchedGrenadeEffects[k].IsA ('X2Effect_Burning'))
					{
						GrenadeTemplate.LaunchedGrenadeEffects[k].ApplyChance = default.FIREBOMB_2_FIRE_APPLY_CHANCE;
					}
				}
			}


			switch (GrenadeTemplate.DataName) 
			{
				case 'AlienGrenade' :
				case 'MutonGrenade' :
				case 'MutonM2_LWGrenade' :
				case 'MutonM3_LWGrenade' :
					GrenadeTemplate.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_LW_Overhaul.UIPerk_grenade_aliengrenade");
					GrenadeTemplate.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_LW_Overhaul.UIPerk_grenade_aliengrenade");
					`LWTRACE("Added Ability Icon Override for Alien Grenade");
					break;
				default :
					break;
			}
		}

		AmmoTemplate = X2AmmoTemplate(Template);
		if (AmmoTemplate != none)
		{
			if (AmmoTemplate.DataName == 'IncendiaryRounds')
			{
				for (k = 0; k < AmmoTemplate.TargetEffects.length; k++)
				{
					if (AmmoTemplate.TargetEffects[k].IsA ('X2Effect_Burning'))
					{
						AmmoTemplate.TargetEffects[k].ApplyChance = default.DRAGON_ROUNDS_APPLY_CHANCE;
					}
				}
			}
			if (AmmoTemplate.DataName == 'VenomRounds')
			{
				for (k = 0; k < AmmoTemplate.TargetEffects.length; k++)
				{
					if (AmmoTemplate.TargetEffects[k].IsA ('X2Effect_PersistentStatChange'))
					{
						AmmoTemplate.TargetEffects[k].ApplyChance = default.VENOM_ROUNDS_APPLY_CHANCE;
					}
				}
			}
		}



		switch (EquipmentTemplate.DataName)
		{
			case 'Pistol_MG':
				X2WeaponTemplate(EquipmentTemplate).CreatorTemplateName = 'Sidearms_MG_Schematic';
				X2WeaponTemplate(EquipmentTemplate).InventorySlot = eInvSlot_Pistol;
				X2WeaponTemplate(EquipmentTemplate).Abilities.RemoveItem('PistolOverwatch');
			//	X2WeaponTemplate(EquipmentTemplate).Abilities.AddItem('TakeThis');
				
				break;
			case 'Pistol_BM':
				X2WeaponTemplate(EquipmentTemplate).CreatorTemplateName = 'Sidearms_BM_Schematic';
				X2WeaponTemplate(EquipmentTemplate).InventorySlot = eInvSlot_Pistol;
				X2WeaponTemplate(EquipmentTemplate).Abilities.RemoveItem('PistolOverwatch');
				//X2WeaponTemplate(EquipmentTemplate).Abilities.AddItem('TakeThis');

				break;
			case 'Pistol_CV':
				//X2WeaponTemplate(EquipmentTemplate).Abilities.AddItem('TakeThis');
			case 'TLE_Pistol_CV':
			case 'TLE_Pistol_MG':
			case 'TLE_Pistol_BM':
			case 'ChosenSniperPistol_XCOM':
			case 'AlienHunterPistol_CV':
			case 'AlienHunterPistol_MG':
			case 'AlienHunterPistol_BM':
				X2WeaponTemplate(EquipmentTemplate).InventorySlot = eInvSlot_Pistol;
			case 'LWPistol_LS':
			case 'LWPistol_CG':
				X2WeaponTemplate(EquipmentTemplate).Abilities.RemoveItem('PistolOverwatch');
				break;
			case 'Cannon_CV': // replace archetype with non-suppression shaking variant
				EquipmentTemplate.GameArchetype = "Cannon_NoShake_LW.Archetypes.WP_Cannon_NoShake_CV";
				break;
			case 'Cannon_MG': // replace archetype with non-suppression shaking variant
				EquipmentTemplate.GameArchetype = "Cannon_NoShake_LW.Archetypes.WP_Cannon_NoShake_MG";
				Template.CreatorTemplateName = 'HeavyWeapons_MG_Schematic';
				break;
			case 'Cannon_BM': // replace archetype with non-suppression shaking variant
				EquipmentTemplate.GameArchetype = "Cannon_NoShake_LW.Archetypes.WP_Cannon_NoShake_BM";
				Template.CreatorTemplateName = 'HeavyWeapons_BM_Schematic';
				break;
			case 'Shotgun_MG':
				Template.CreatorTemplateName = 'HeavyWeapons_MG_Schematic';
				break;
			case 'Shotgun_BM':
				Template.CreatorTemplateName = 'HeavyWeapons_BM_Schematic';
				break;
			case 'AssaultRifle_MG':
				Template.CreatorTemplateName = 'GeneralWeapons_MG_Schematic';
				break;
			case 'AssaultRifle_BM':
				Template.CreatorTemplateName = 'GeneralWeapons_BM_Schematic';
				break;
			case 'SniperRifle_MG':
				Template.CreatorTemplateName = 'PrecisionWeapons_MG_Schematic';
				break;
			case 'SniperRifle_BM':
				Template.CreatorTemplateName = 'PrecisionWeapons_BM_Schematic';
				break;

			default:
				break;
		}
		// KILL THE SCHEMATICS! (but only the schematics we want to kill)
		if (EquipmentTemplate.CreatorTemplateName != '' && default.SchematicsToDisable.Find(EquipmentTemplate.CreatorTemplateName) != -1)
		{
			EquipmentTemplate.CreatorTemplateName = '';

			// LWOTC: At least one mod depends on `BaseItem` having a value, so don't
			// clear it. And `UpgradeItem is a deprecated property. It should be safe
			// to skip clearing them as the schematic-specific stuff is handled with
			// checks on `CreatorTemplateName`. Keeping this here just in case any
			// bugs crop up because we've commented out the lines below.
			// EquipmentTemplate.BaseItem = '';
			// EquipmentTemplate.UpgradeItem = '';
		}
		// Mod
		for (i=0; i < ItemTable.Length; ++i)
		{           
			if (EquipmentTemplate.DataName == ItemTable[i].ItemTemplateName)
			{
				EquipmentTemplate.StartingItem = ItemTable[i].Starting;
				EquipmentTemplate.bInfiniteItem = ItemTable[i].Infinite;
				if (!ItemTable[i].Buildable)
					EquipmentTemplate.CanBeBuilt = false;

				if (ItemTable[i].Buildable)
				{
					EquipmentTemplate.CanBeBuilt = true;
					EquipmentTemplate.Requirements.RequiredEngineeringScore = ItemTable[i].RequiredEngineeringScore;
					EquipmentTemplate.PointsToComplete = ItemTable[i].PointsToComplete;
					if (default.INSTANT_BUILD_TIMES)
					{
						EquipmentTemplate.PointsToComplete = 0;
					}
					EquipmentTemplate.Requirements.bVisibleifPersonnelGatesNotMet = true;
					EquipmentTemplate.Cost.ResourceCosts.Length = 0;
					EquipmentTemplate.Cost.ArtifactCosts.Length = 0;
					EquipmentTemplate.Requirements.RequiredTechs.Length = 0;
					if (ItemTable[i].RequiredTech1 != '')
						EquipmentTemplate.Requirements.RequiredTechs.AddItem(ItemTable[i].RequiredTech1);
					if (ItemTable[i].RequiredTech2 != '')
						EquipmentTemplate.Requirements.RequiredTechs.AddItem(ItemTable[i].RequiredTech2);
					if (ItemTable[i].SupplyCost > 0)
					{
						Resources.ItemTemplateName = 'Supplies';
						Resources.Quantity = ItemTable[i].SupplyCost;
						EquipmentTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (ItemTable[i].AlloyCost > 0)
					{
						Resources.ItemTemplateName = 'AlienAlloy';
						Resources.Quantity = ItemTable[i].AlloyCost;
						EquipmentTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (ItemTable[i].CrystalCost > 0)
					{
						Resources.ItemTemplateName = 'EleriumDust';
						Resources.Quantity = ItemTable[i].CrystalCost;
						EquipmentTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (ItemTable[i].CoreCost > 0)
					{
						Resources.ItemTemplateName = 'EleriumCore';
						Resources.Quantity = ItemTable[i].CoreCost;
						EquipmentTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (ItemTable[i].SpecialItemTemplateName != '' && ItemTable[i].SpecialItemCost > 0)
					{
						Resources.ItemTemplateName = ItemTable[i].SpecialItemTemplateName;
						Resources.Quantity = ItemTable[i].SpecialItemCost;
						EquipmentTemplate.Cost.ArtifactCosts.AddItem(Resources);
					}
					if (EquipmentTemplate.InventorySlot == eInvSlot_CombatSim)
					{
						EquipmentTemplate.Requirements.RequiredFacilities.AddItem('OfficerTrainingSchool');
					}
				}
				if (EquipmentTemplate.Abilities.Find('SmallItemWeight') == -1)
				{
					if (ItemTable[i].Weight > 0)
					{
						EquipmentTemplate.Abilities.AddItem ('SmallItemWeight');
						EquipmentTemplate.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, -ItemTable[i].Weight, true);

						//`LOG ("Adding Weight to" @ EquipmentTemplate.DataName);
					}
				}

				switch (EquipmentTemplate.DataName)
				{
					//special handling for SLG DLC items
					case 'SparkRifle_MG':
					case 'SparkRifle_BM':
					case 'PlatedSparkArmor':
					case 'PoweredSparkArmor':
					case 'SparkBit_MG':
					case 'SparkBit_BM':
						AltReq.SpecialRequirementsFn = class'LWDLCHelpers'.static.IsLostTowersNarrativeContentComplete;
						if (ItemTable[i].RequiredTech1 != '')
							AltReq.RequiredTechs.AddItem(ItemTable[i].RequiredTech1);
						Template.AlternateRequirements.AddItem(AltReq);
						break;

					default:
						break;
				}

				switch (EquipmentTemplate.DataName)
				{
					//special handling for SLG DLC items
					case 'AlienHunterRifle_CV':
					case 'AlienHunterRifle_MG':
					case 'AlienHunterRifle_BM':
						EquipmentTemplate.Abilities.Additem('BoltCasterPassive');
						X2WeaponTemplate(EquipmentTemplate).BonusWeaponEffects.Length = 0;
						X2WeaponTemplate(EquipmentTemplate).BonusWeaponEffects.AddItem(BoltCasterStunEffect_LW());
						break;	

					case 'AlienHunterAxe_CV':
					case 'AlienHunterAxe_MG':
					case 'AlienHunterAxe_BM':
						EquipmentTemplate.Abilities.Additem('HuntersAxePassive');
						break;

					case 'AlienHunterPistol_CV':
					case 'AlienHunterPistol_MG':
					case 'AlienHunterPistol_BM':
						EquipmentTemplate.Abilities.Additem('HuntersPistolPassive');
						EquipmentTemplate.Abilities.RemoveItem('ShadowFall');
						break;
					default:
						break;
				}
			}
		}
	}
	
	WeaponUpgradeTemplate = X2WeaponUpgradeTemplate(Template);
	if (WeaponUpgradeTemplate != none)
	{

				//specific alterations
		if (WeaponUpgradeTemplate.DataName == 'AimUpgrade_Bsc')
		{
			WeaponUpgradeTemplate.bInfiniteItem = true;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('WeaponHandling_LongRange');			
		}

		//specific alterations
		if (WeaponUpgradeTemplate.DataName == 'Critupgrade_bsc')
		{
			WeaponUpgradeTemplate.bInfiniteItem = true;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('WeaponHandling_ShortRange');			
		}
		if (WeaponUpgradeTemplate.DataName == 'AimUpgrade_Adv')
		{
			WeaponUpgradeTemplate.AimBonus = 0;
			//WeaponUpgradeTemplate.AimBonusNoCover = 0;
			WeaponUpgradeTemplate.AddHitChanceModifierFn = none;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.BonusAbilities.length = 0;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('Scope_LW_Adv_Ability');
		}
		if (WeaponUpgradeTemplate.DataName == 'AimUpgrade_Sup')
		{
			WeaponUpgradeTemplate.AimBonus = 0;
			//WeaponUpgradeTemplate.AimBonusNoCover = 0;
			WeaponUpgradeTemplate.AddHitChanceModifierFn = none;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.BonusAbilities.length = 0;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('Scope_LW_Sup_Ability');
		}

		if (WeaponUpgradeTemplate.DataName == 'FreeFireUpgrade_Bsc')
		{
			WeaponUpgradeTemplate.FreeFireChance = 0;
			WeaponUpgradeTemplate.FreeFireCostFn = none;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.BonusAbilities.length = 0;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('HyperReactivePupils_HT');
			WeaponUpgradeTemplate.bInfiniteItem = true;
		}
		if (WeaponUpgradeTemplate.DataName == 'FreeFireUpgrade_Adv')
		{
			WeaponUpgradeTemplate.FreeFireChance = 0;
			WeaponUpgradeTemplate.FreeFireCostFn = none;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.BonusAbilities.length = 0;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('Hair_Trigger_LW_Adv_Ability');
			WeaponUpgradeTemplate.bInfiniteItem = true;
		}
		if (WeaponUpgradeTemplate.DataName == 'FreeFireUpgrade_Sup')
		{
			WeaponUpgradeTemplate.FreeFireChance = 0;
			WeaponUpgradeTemplate.FreeFireCostFn = none;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.BonusAbilities.length = 0;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('Hair_Trigger_LW_Sup_Ability');
			WeaponUpgradeTemplate.bInfiniteItem = true;
		}

		if (WeaponUpgradeTemplate.DataName == 'MissDamageUpgrade_Bsc')
		{
			WeaponUpgradeTemplate.BonusDamage.Damage = 0;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.BonusAbilities.length = 0;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('GrazingFire');
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('StockSprayAndPray');
	
			WeaponUpgradeTemplate.bInfiniteItem = true;
		}
		if (WeaponUpgradeTemplate.DataName == 'MissDamageUpgrade_Adv')
		{
			WeaponUpgradeTemplate.BonusDamage.Damage = 0;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.BonusAbilities.length = 0;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('Stock_LW_Adv_Ability');
		}
		if (WeaponUpgradeTemplate.DataName == 'MissDamageUpgrade_Sup')
		{
			WeaponUpgradeTemplate.BonusDamage.Damage = 0;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.BonusAbilities.length = 0;
			WeaponUpgradeTemplate.BonusAbilities.AddItem ('Stock_LW_Sup_Ability');
		}
		
		if (WeaponUpgradeTemplate.DataName == 'FreeKillUpgrade_Bsc' || WeaponUpgradeTemplate.DataName == 'FreeKillUpgrade_Adv' || WeaponUpgradeTemplate.DataName == 'FreeKillUpgrade_Sup')
		{
			WeaponUpgradeTemplate.FreeKillChance = 0;
			WeaponUpgradeTemplate.FreeKillFn = none;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			//Abilities are caught elsewhere
			WeaponUpgradeTemplate.BonusAbilities.AddItem('SuppressorBonus');

			WeaponUpgradeTemplate.bInfiniteItem = true;
		}
		//make them mutually exclusive
		if (WeaponUpgradeTemplate.DataName == 'ReloadUpgrade_Bsc' || WeaponUpgradeTemplate.DataName == 'ReloadUpgrade_Adv' || WeaponUpgradeTemplate.DataName == 'ReloadUpgrade_Sup')
		{
			WeaponUpgradeTemplate.MutuallyExclusiveUpgrades.AddItem('ClipSizeUpgrade');
			WeaponUpgradeTemplate.MutuallyExclusiveUpgrades.AddItem('ClipSizeUpgrade_Bsc');
			WeaponUpgradeTemplate.MutuallyExclusiveUpgrades.AddItem('ClipSizeUpgrade_Adv');
			WeaponUpgradeTemplate.MutuallyExclusiveUpgrades.AddItem('ClipSizeUpgrade_Sup');
			WeaponUpgradeTemplate.FreeReloadCostFn = none;
			WeaponUpgradeTemplate.FriendlyRenameFn = none;
			WeaponUpgradeTemplate.GetBonusAmountFn = none;
			WeaponUpgradeTemplate.bInfiniteItem = true;

			WeaponUpgradeTemplate.BonusAbilities.AddItem('QuickReload');
		}
		if (WeaponUpgradeTemplate.DataName == 'ClipSizeUpgrade_Bsc' || WeaponUpgradeTemplate.DataName == 'ClipSizeUpgrade_Adv' || WeaponUpgradeTemplate.DataName == 'ClipSizeUpgrade_Sup')
		{
			WeaponUpgradeTemplate.MutuallyExclusiveUpgrades.AddItem('ReloadUpgrade');
			WeaponUpgradeTemplate.MutuallyExclusiveUpgrades.AddItem('ReloadUpgrade_Bsc');
			WeaponUpgradeTemplate.MutuallyExclusiveUpgrades.AddItem('ReloadUpgrade_Adv');
			WeaponUpgradeTemplate.MutuallyExclusiveUpgrades.AddItem('ReloadUpgrade_Sup');
			WeaponUpgradeTemplate.bInfiniteItem = true;
			WeaponUpgradeTemplate.BonusAbilities.AddItem('ExpandedMagMobilityPenalty');
			WeaponTemplate.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_LW_GearAbilities'.default.EXPANDED_MAG_MOB_PENALTY);

			
		}
		//Config-able items array -- Weapon Upgrades
		for (i=0; i < ItemTable.Length; ++i)
		{           
			if (WeaponUpgradeTemplate.DataName == ItemTable[i].ItemTemplateName)
			{
				WeaponUpgradeTemplate.StartingItem = ItemTable[i].Starting;
				WeaponUpgradeTemplate.bInfiniteItem = ItemTable[i].Infinite;
				if (!ItemTable[i].Buildable)
					WeaponUpgradeTemplate.CanBeBuilt = false;
				if (ItemTable[i].Buildable)
				{
					WeaponUpgradeTemplate.CanBeBuilt = true;
					WeaponUpgradeTemplate.Requirements.RequiredEngineeringScore = ItemTable[i].RequiredEngineeringScore;
					WeaponUpgradeTemplate.PointsToComplete = ItemTable[i].PointsToComplete;
					WeaponUpgradeTemplate.Requirements.bVisibleifPersonnelGatesNotMet = true;
					WeaponUpgradeTemplate.Cost.ResourceCosts.Length = 0;
					WeaponUpgradeTemplate.Cost.ArtifactCosts.Length = 0;
					WeaponUpgradeTemplate.Requirements.RequiredTechs.Length = 0;
					if (ItemTable[i].RequiredTech1 != '')
					{
						WeaponUpgradeTemplate.Requirements.RequiredTechs.AddItem(ItemTable[i].RequiredTech1);
					}
					if (ItemTable[i].RequiredTech2 != '')
						WeaponUpgradeTemplate.Requirements.RequiredTechs.AddItem(ItemTable[i].RequiredTech2);
					if (ItemTable[i].SupplyCost > 0)
					{
						Resources.ItemTemplateName = 'Supplies';
						Resources.Quantity = ItemTable[i].SupplyCost;
						WeaponUpgradeTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (ItemTable[i].AlloyCost > 0)
					{
						Resources.ItemTemplateName = 'AlienAlloy';
						Resources.Quantity = ItemTable[i].AlloyCost;
						WeaponUpgradeTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (ItemTable[i].CrystalCost > 0)
					{
						Resources.ItemTemplateName = 'EleriumDust';
						Resources.Quantity = ItemTable[i].CrystalCost;
						WeaponUpgradeTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (ItemTable[i].CoreCost > 0)
					{
						Resources.ItemTemplateName = 'EleriumCore';
						Resources.Quantity = ItemTable[i].CoreCost;
						WeaponUpgradeTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (ItemTable[1].SpecialItemTemplateName != '' && ItemTable[i].SpecialItemCost > 0)
					{
						Resources.ItemTemplateName = ItemTable[i].SpecialItemTemplateName;
						Resources.Quantity = ItemTable[i].SpecialItemCost;
						WeaponUpgradeTemplate.Cost.ArtifactCosts.AddItem(Resources);
					}

					if (default.INSTANT_BUILD_TIMES)
					{       
						WeaponUpgradeTemplate.PointsToComplete = 0;
					}

				}
			}
		}
	}
}

static function X2Effect_Stunned BoltCasterStunEffect_LW()
{
	local X2Effect_Stunned StunEffect;

	StunEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(1, 0, false);
	StunEffect.ApplyChanceFn = class'X2Item_DLC_Day60Weapons'.static.BoltCasterStunChance;
	return StunEffect;
}

static function X2LWTemplateModTemplate CreateRewireTechTreeTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'RewireTechTree');
	Template.StrategyElementTemplateModFn = RewireTechTree;
	return Template;
}

function RewireTechTree(X2StrategyElementTemplate Template, int Difficulty)
{
	local int                       i;
	local ArtifactCost              Resources;
	local X2TechTemplate            TechTemplate;
	
	TechTemplate=X2TechTemplate(Template);
	If (TechTemplate != none)
	{
		// Disable breakthrough projects for now
		if (TechTemplate.bBreakthrough)
		{
			TechTemplate.Requirements.RequiredScienceScore = 99999;
		}

		//required by objective rework
		if (TechTemplate.DataName == 'ResistanceCommunications')
		{
			TechTemplate.Requirements.RequiredObjectives.length = 0;
			Resources.ItemTemplateName = 'Intel';
			Resources.Quantity = default.ResistanceCommunicationsIntelCost;
			TechTemplate.Cost.ResourceCosts.AddItem(Resources);
		}

		if (TechTemplate.DataName == 'ResistanceRadio')
		{
			TechTemplate.Requirements.RequiredObjectives.length = 0;
			Resources.ItemTemplateName = 'Intel';
			Resources.Quantity = default.ResistanceRadioIntelCost;
			TechTemplate.Cost.ResourceCosts.AddItem(Resources);
		}

		switch (TechTemplate.DataName)
		{
			case 'AlienEncryption':
				Resources.ItemTemplateName = 'Intel';
				Resources.Quantity = default.AlienEncryptionIntelCost;
				if (Resources.Quantity > 0)
					TechTemplate.Cost.ResourceCosts.AddItem(Resources);
				break;
			case 'CodexBrainPt1':
				Resources.ItemTemplateName = 'Intel';
				Resources.Quantity = default.CodexBrainPt1IntelCost;
				if (Resources.Quantity > 0)
					TechTemplate.Cost.ResourceCosts.AddItem(Resources);
				break;
			case 'CodexBrainPt2':
				Resources.ItemTemplateName = 'Intel';
				Resources.Quantity = default.CodexBrainPt2IntelCost;
				if (Resources.Quantity > 0)
					TechTemplate.Cost.ResourceCosts.AddItem(Resources);
				break;
			case 'BlacksiteData':
				Resources.ItemTemplateName = 'Intel';
				Resources.Quantity = default.BlacksiteDataIntelCost;
				if (Resources.Quantity > 0)
					TechTemplate.Cost.ResourceCosts.AddItem(Resources);
				break;
			case 'ForgeStasisSuit':
				Resources.ItemTemplateName = 'Intel';
				Resources.Quantity = default.ForgeStasisSuitIntelCost;
				if (Resources.Quantity > 0)
					TechTemplate.Cost.ResourceCosts.AddItem(Resources);
				break;
			case 'PsiGate':
				Resources.ItemTemplateName = 'Intel';
				Resources.Quantity = default.PsiGateIntelCost;
				if (Resources.Quantity > 0)
					TechTemplate.Cost.ResourceCosts.AddItem(Resources);
				break;
			case 'AutopsyAdventPsiWitch':
				Resources.ItemTemplateName = 'Intel';
				Resources.Quantity = default.AutopsyAdventPsiWitchIntelCost;
				if (Resources.Quantity > 0)
					TechTemplate.Cost.ResourceCosts.AddItem(Resources);
				break;
			default:
				break;
		}
		
		if (TechTemplate.DataName == 'ResistanceRadio')
		{
			TechTemplate.ResearchCompletedFn = ActivateContinentBonuses;
		}

		if (TechTemplate.DataName == 'SpiderSuit')
			TechTemplate.bRepeatable = false;
		if (TechTemplate.DataName == 'ExoSuit')
			TechTemplate.bRepeatable = false;
		if (TechTemplate.DataName == 'WraithSuit')
			TechTemplate.bRepeatable = false;
		if (TechTemplate.DataName == 'WarSuit')
			TechTemplate.bRepeatable = false;
		if (TechTemplate.DataName == 'ShredstormCannonProject')
			TechTemplate.bRepeatable = false;
		if (TechTemplate.DataName == 'PlasmaBlasterProject')
			TechTemplate.bRepeatable = false;
		if (TechTemplate.DataName == 'Skulljack')
			TechTemplate.bRepeatable = false;

		if (TechTemplate.DataName == 'HeavyWeapons') // remove the alternative access to the heavy weapons proving ground project for sparks
			TechTemplate.AlternateRequirements.Length = 0;

		// Change the special requirements functions for Mechanized Warfare & SPARKs.
		if (TechTemplate.DataName == 'MechanizedWarfare')
			TechTemplate.Requirements.SpecialRequirementsFn = class'LWDLCHelpers'.static.IsMechanizedWarfareAvailable;
		if (TechTemplate.DataName == 'BuildSpark')
			TechTemplate.Requirements.SpecialRequirementsFn = class'LWDLCHelpers'.static.IsLostTowersNarrativeContentComplete;

		// remove the alternative access to the advanced heavy weapons proving ground project HeavyAlienArmorMk2_Schematic
		// from Alien Hunters.
		if (TechTemplate.DataName == 'AdvancedHeavyWeapons')
			TechTemplate.AlternateRequirements.Length = 0;

		// Purifiers should no longer provide the +1 HP vest bonus, which is granted
		// via a tech breakthrough.
		if (TechTemplate.DataName == 'AutopsyAdventPurifier')
		{
			TechTemplate.RewardName = '';
			TechTemplate.BreakthroughCondition = none;
			TechTemplate.ResearchCompletedFn = none;
		}

		if (TechTemplate.DataName == 'GaussWeapons')
		{
			TechTemplate.ResearchCompletedFn = AddT2Rockets;
		}

		if (TechTemplate.DataName == 'HeavyPlasma')
		{
			TechTemplate.ResearchCompletedFn = AddT3Rockets;
		}

		for (i=0; i < TechTable.Length; ++i)
		{
			if (TechTemplate.DataName == TechTable[i].TechTemplateName)
			{
				TechTemplate.bProvingGround = TechTable[i].ProvingGround;
				TechTemplate.PointsToComplete = TechTable[i].ResearchPointCost;
				TechTemplate.Requirements.RequiredScienceScore=TechTable[i].RequiredScienceScore;
				TechTemplate.Requirements.RequiredEngineeringScore=TechTable[i].RequiredEngineeringScore;
				if (TechTable[i].RequiredScienceScore >= 99999)
				{
					TechTemplate.Requirements.bVisibleIfPersonnelGatesNotMet = false;
				}
				else
				{
					TechTemplate.Requirements.bVisibleIfPersonnelGatesNotMet = true;
				}
				if (!TechTable[i].ModPointsToCompleteOnly)
				{
					TechTemplate.Cost.ResourceCosts.Length = 0;
					TechTemplate.Cost.ArtifactCosts.Length = 0;
					TechTemplate.Requirements.RequiredItems.Length = 0;
					if (TechTable[i].SupplyCost > 0)
					{
						Resources.ItemTemplateName = 'Supplies';
						Resources.Quantity = TechTable[i].SupplyCost;
						TechTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (TechTable[i].AlloyCost > 0)
					{
						Resources.ItemTemplateName = 'AlienAlloy';
						Resources.Quantity = TechTable[i].AlloyCost;
						TechTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (TechTable[i].CrystalCost > 0)
					{
						Resources.ItemTemplateName = 'EleriumDust';
						Resources.Quantity = TechTable[i].CrystalCost;
						TechTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (TechTable[i].CoreCost > 0)
					{
						Resources.ItemTemplateName = 'EleriumCore';
						Resources.Quantity = TechTable[i].CoreCost;
						TechTemplate.Cost.ResourceCosts.AddItem(Resources);
					}
					if (TechTable[i].ReqItemTemplateName1 != '' && TechTable[i].ReqItemCost1 > 0)
					{
						Resources.ItemTemplateName = TechTable[i].ReqItemTemplateName1;
						Resources.Quantity = TechTable[i].ReqItemCost1;
						TechTemplate.Cost.ArtifactCosts.AddItem(Resources);
						if (!TechTemplate.bProvingGround)
						{
							TechTemplate.Requirements.RequiredItems.AddItem(TechTable[i].ReqItemTemplateName1);
						}
					}
					TechTemplate.bCheckForceInstant = false;
					if (TechTable[i].ReqItemTemplateName2 != '' && TechTable[i].ReqItemCost2 > 0)
					{
						if (TechTable[i].ReqItemTemplateName2 == 'Instant')
						{
							Resources.ItemTemplateName = TechTable[i].ReqItemTemplateName1;
							Resources.Quantity = TechTable[i].ReqItemCost1 * TechTable[i].ReqItemCost2;
							TechTemplate.InstantRequirements.RequiredItemQuantities.AddItem(Resources);
							TechTemplate.bCheckForceInstant = true;
						}
						else
						{
							Resources.ItemTemplateName = TechTable[i].ReqItemTemplateName2;
							Resources.Quantity = TechTable[i].ReqItemCost2;
							TechTemplate.Cost.ArtifactCosts.AddItem(Resources);
							if (!TechTemplate.bProvingGround)
							{
								TechTemplate.Requirements.RequiredItems.AddItem(TechTable[i].ReqItemTemplateName2);
							}
						}
					}
					TechTemplate.Requirements.RequiredTechs.Length = 0;
					if (TechTable[i].PrereqTech1 != '')
						TechTemplate.Requirements.RequiredTechs.AddItem(TechTable[i].PrereqTech1);
					if (TechTable[i].PrereqTech2 != '')
						TechTemplate.Requirements.RequiredTechs.AddItem(TechTable[i].PrereqTech2);
					if (TechTable[i].PrereqTech3 != '')
						TechTemplate.Requirements.RequiredTechs.AddItem(TechTable[i].PrereqTech3);
					if (TechTable[i].ItemGranted != '')
					{
						if (TechTable[i].ItemGranted != 'nochange')
						{
							TechTemplate.ResearchCompletedFn = none;
							TechTemplate.ItemRewards.Length = 0;
							if (TechTable[i].ItemGranted != 'clear')
							{
								TechTemplate.ResearchCompletedFn = class'X2StrategyElement_DefaultTechs'.static.GiveRandomItemReward;
								TechTemplate.ItemRewards.AddItem(TechTable[i].ItemGranted);
							}
						}
					}
				}
			}
		}
	}
}

// Activates all eligible continent bonuses that aren't already
// active. Activation of a bonus normally happens when a region is
// contacted and there are sufficient radio relays on the continent,
//  but we prevent this from happening
// (see X2EventListener_StrategyMap.HandleContinentBonusActivation())
// if Resistance Radio hasn't first been researched. This is a follow
// up for those regions affected by blocked bonus activation.
static function ActivateContinentBonuses(XComGameState NewGameState, XComGameState_Tech TechState)
{
	local XComGameStateHistory History;
	local XComGameState_Continent ContinentState;

	History = `XCOMHISTORY;

	foreach History.IterateByClassType(class'XComGameState_Continent', ContinentState)
	{
		// This will activate or deactivate the continent bonus
		// depending on whether all the requirements have been met
		// or not.
		ContinentState.HandleRegionResistanceLevelChange(NewGameState);
	}
}

static function X2LWTemplateModTemplate CreateEditGTSProjectsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'EditGTSProjectsTree');
	Template.StrategyElementTemplateModFn = EditGTSProjects;
	return Template;
}

function EditGTSProjects(X2StrategyElementTemplate Template, int Difficulty)
{
	local int                       i;
	local ArtifactCost              Resources;
	local X2SoldierUnlockTemplate   GTSTemplate;

	GTSTemplate = X2SoldierUnlockTemplate (Template);
	if (GTSTemplate != none)
	{
		for (i=0; i < GTSTable.Length; ++i)
		{
			if (GTSTemplate.DataName == GTSTable[i].GTSProjectTemplateName)
			{
				GTSTemplate.Cost.ResourceCosts.Length=0;
				if (GTSTable[i].SupplyCost > 0)
				{
					Resources.ItemTemplateName = 'Supplies';
					Resources.Quantity = GTSTable[i].SupplyCost;
					GTSTemplate.Cost.ResourceCosts.AddItem(Resources);
				}
				GTSTemplate.Requirements.RequiredHighestSoldierRank = GTSTable[i].RankRequired;
				//bVisibleIfSoldierRankGatesNotMet does not work
				GTSTemplate.Requirements.bVisibleIfSoldierRankGatesNotMet = !GTSTable[i].HideIfInsufficientRank;
				GTSTemplate.AllowedClasses.Length = 0;
				GTSTemplate.Requirements.RequiredSoldierClass = '';
				if (GTSTable[i].UniqueClass != '')
				{
					GTSTemplate.Requirements.RequiredSoldierRankClassCombo = true;
					GTSTemplate.AllowedClasses.AddItem(GTSTable[i].UniqueClass);
					GTSTemplate.Requirements.RequiredSoldierClass = GTSTable[i].UniqueClass;
				}
				else
				{
					GTSTemplate.bAllClasses=true;
				}
			}
		}
	}
}

static function X2LWTemplateModTemplate CreateReconfigFacilitiesTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'ReconfigFacilities');
	Template.StrategyElementTemplateModFn = ReconfigFacilities;
	return Template;
}

function ReconfigFacilities(X2StrategyElementTemplate Template, int Difficulty)
{
	local int                       i;
	local ArtifactCost              Resources;
	local X2FacilityTemplate        FacilityTemplate;
	local StaffSlotDefinition       StaffSlotDef;

	FacilityTemplate = X2FacilityTemplate (Template);
	if (FacilityTemplate != none)
	{
		if (FacilityTemplate.DataName == 'OfficerTrainingSchool')
		{
			for (i = 0 ; i < default.GTSUnlocksToRemove.Length ; i++)
			{
    			FacilityTemplate.SoldierUnlockTemplates.RemoveItem(default.GTSUnlocksToRemove[i]);
			}
			//FacilityTemplate.SoldierUnlockTemplates.AddItem('VultureUnlock');
			//FacilityTemplate.SoldierUnlockTemplates.AddItem('VengeanceUnlock');
		//	FacilityTemplate.SoldierUnlockTemplates.AddItem('WetWorkUnlock');
		//	FacilityTemplate.SoldierUnlockTemplates.AddItem('LightningStrikeUnlock');
		//	FacilityTemplate.SoldierUnlockTemplates.AddItem('IntegratedWarfareUnlock');
		//	FacilityTemplate.SoldierUnlockTemplates.AddItem('StayWithMeUnlock');
			FacilityTemplate.SoldierUnlockTemplates.AddItem('XTP1');
			FacilityTemplate.SoldierUnlockTemplates.AddItem('XTP2');
			FacilityTemplate.SoldierUnlockTemplates.AddItem('XTP3');
			//FacilityTemplate.SoldierUnlockTemplates.AddItem('XTP4');
		}
		if (FacilityTemplate.DataName == 'Laboratory')
		{
			StaffSlotDef.StaffSlotTemplateName = 'LaboratoryStaffSlot';
			StaffSlotDef.bStartsLocked = true;
			FacilityTemplate.StaffSlotDefs.AddItem(StaffSlotDef);
			FacilityTemplate.StaffSlotDefs.AddItem(StaffSlotDef);
			FacilityTemplate.Upgrades.AddItem('Laboratory_AdditionalResearchStation2');
			FacilityTemplate.Upgrades.AddItem('Laboratory_AdditionalResearchStation3');
		}
		if (FacilityTemplate.DataName == 'ProvingGround')
		{
			StaffSlotDef.StaffSlotTemplateName = 'ProvingGroundStaffSlot';
			StaffSlotDef.bStartsLocked = false;
			FacilityTemplate.StaffSlotDefs.AddItem(StaffSlotDef);
		}
		if (FacilityTemplate.DataName == 'PsiChamber')
		{
			StaffSlotDef.StaffSlotTemplateName = 'PsiChamberScientistStaffSlot';
			StaffSlotDef.bStartsLocked = false;
			FacilityTemplate.StaffSlotDefs.InsertItem(1, StaffSlotDef);
		}
		if (FacilityTemplate.DataName == 'ResistanceRing')
		{
			// Add an extra engineer staff slot to reduce covert action duration
			StaffSlotDef.StaffSlotTemplateName = 'ResistanceRingStaffSlot';
			StaffSlotDef.bStartsLocked = true;
			FacilityTemplate.StaffSlotDefs.AddItem(StaffSlotDef);

			// Remove the second upgrade, since there's only the one staff slot to unlock
			FacilityTemplate.Upgrades.RemoveItem('ResistanceRing_UpgradeII');

			// No longer mark it as being a priority/requiring attention
			FacilityTemplate.bPriority = false;
		}
		//if (FacilityTemplate.DataName == 'Storage') Didn't work
		//{
			//FacilityTemplate.StaffSlots.AddItem('SparkStaffSlot');
			//FacilityTemplate.StaffSlots.AddItem('SparkStaffSlot');
			//FacilityTemplate.StaffSlotsLocked = 3;
		//}

		// --- HACK HACK HACK --- 
		//
		// To allow debugging XcomGame with AH installed you need to uncomment this to strip the aux map from the hangar template.
		// The game will loop forever in the avenger waiting for the aux content to load unless this is done, because the content
		// is provided only in a cooked seek-free package and debugging always loads -noseekfreepackages. Thus the package is never
		// loaded and the process will never complete. I am not leaving this uncommented because doing so will leave a gap in the
		// avenger map where the hangar is supposed to be. Even with this expect a bazillion redscreens about missing content for
		// DLC1/2/3. If you need to do a lot of debugging in XComGame consider uninstalling the DLCs first to cut down redscreen spam.
		//
		// --- HACK HACK HACK ---
		/*
		if (FacilityTemplate.DataName == 'Hangar')
		{
			`Log("Found hangar with " $ FacilityTemplate.AuxMaps.Length $ " aux maps");
			for( i = 0; i < FacilityTemplate.AuxMaps.length; ++i)
			{
				`Log("Aux map: " $ FacilityTemplate.AuxMaps[i].MapName);
				if (InStr(FacilityTemplate.AuxMaps[i].MapName, "DLC2") >= 0)
				{
					FacilityTemplate.AuxMaps.Remove(i, 1);
					--i;
				}
			}
			FacilityTemplate.AuxMaps.Length = 0;
		}
		*/

		for (i=0; i < FacilityTable.Length; ++i)
		{
			if (FacilityTemplate.DataName == FacilityTable[i].FacilityTemplateName)
			{
				FacilityTemplate.PointsToComplete = class'X2StrategyElement_DefaultFacilities'.static.GetFacilityBuildDays(FacilityTable[i].BuildDays);
				FacilityTemplate.iPower = FacilityTable[i].Power;
				FacilityTemplate.UpkeepCost = FacilityTable[i].UpkeepCost;
				FacilityTemplate.Requirements.RequiredTechs.length = 0;
				if (FacilityTable[i].RequiredTech != '')
					FacilityTemplate.Requirements.RequiredTechs.AddItem(FacilityTable[i].RequiredTech);
				
				FacilityTemplate.Cost.ResourceCosts.Length = 0;
				FacilityTemplate.Cost.ArtifactCosts.Length = 0;             

				if (FacilityTable[i].SupplyCost > 0)
				{
					Resources.ItemTemplateName = 'Supplies';
					Resources.Quantity = FacilityTable[i].SupplyCost;
					FacilityTemplate.Cost.ResourceCosts.AddItem(Resources);
				}
				if (FacilityTable[i].AlloyCost > 0)
				{
					Resources.ItemTemplateName = 'AlienAlloy';
					Resources.Quantity = FacilityTable[i].AlloyCost;
					FacilityTemplate.Cost.ResourceCosts.AddItem(Resources);
				}
				if (FacilityTable[i].CrystalCost > 0)
				{
					Resources.ItemTemplateName = 'EleriumDust';
					Resources.Quantity = FacilityTable[i].CrystalCost;
					FacilityTemplate.Cost.ResourceCosts.AddItem(Resources);
				}
				if (FacilityTable[i].CoreCost > 0)
				{
					Resources.ItemTemplateName = 'EleriumCore';
					Resources.Quantity = FacilityTable[i].CoreCost;
					FacilityTemplate.Cost.ResourceCosts.AddItem(Resources);
				}
			}
		}
	}
}

static function X2LWTemplateModTemplate CreateRecoverItemTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'RecoverItem');
	Template.MissionNarrativeTemplateModFn = RecoverItemNarrativeMod;
	return Template;
}

function bool ExpectNarrativeCount(X2MissionNarrativeTemplate Template, int Cnt)
{
	// We better have 24 items as the narrative # we want is in the objective map Kismet.
	if(Template.NarrativeMoments.Length != Cnt)
	{
		`redscreen("LWTemplateMods: Found too many narrative moments for " $ Template.DataName);
		`log("LWTemplateMods: Found too many narrative moments for " $ Template.DataName);
		return false;
	}

	return true;
}

function RecoverItemNarrativeMod(X2MissionNarrativeTemplate Template)
{
	switch(Template.DataName)
	{
	case 'DefaultRecover':
	case 'DefaultRecover_ADV':
	case 'DefaultRecover_Train':
	case 'DefaultRecover_Vehicle':
		if (ExpectNarrativeCount(Template, 24))
		{
			Template.NarrativeMoments[24] = "X2NarrativeMoments.TACTICAL.Blacksite.BlackSite_SecureRetreat";
		}
		break;
	case 'DefaultHack':
	case 'DefaultHack_ADV':
	case 'DefaultHack_Train':
		if (ExpectNarrativeCount(Template, 22))
		{
			Template.NarrativeMoments[22] = "X2NarrativeMoments.TACTICAL.Blacksite.BlackSite_SecureRetreat";
		}
		break;
	case 'DefaultDestroyRelay':
		if (ExpectNarrativeCount(Template, 20))
		{
			Template.NarrativeMoments[20] = "X2NarrativeMoments.TACTICAL.Blacksite.BlackSite_SecureRetreat";
			Template.NarrativeMoments[21] = "X2NarrativeMoments.TACTICAL.General.CEN_Gen_SecureRetreat_03";
		}
	default:
		break;
	}
}

static function X2LWTemplateModTemplate CreateRemovePPClassesTemplate()
{
	local X2LWTemplateModTemplate Template;

	//`LOG("PP: 0");
	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'RemovePPClasses');
	Template.SoldierClassTemplateModFn = RemovePPClasses;
	return Template;
}

//this makes sure perkpack classes do not show up
function RemovePPClasses(X2SoldierClassTemplate Template, int Difficulty)
{
	//`LOG ("PP: 1");
	if (Template != none)
	{
		//`LOG ("PP: 2");
		switch (Template.DataName)
		{
			case 'LW_Assault':
			case 'LW_Shinobi':
			case 'LW_Sharpshooter':
			case 'LW_Ranger':
			case 'LW_Gunner':
			case 'LW_Grenadier':
			case 'LW_Specialist':
				//`LOG ("PP: 3");
				Template.NumInForcedDeck = 0;
				Template.NumInDeck = 0;
				break;
			default:
				break;
		}
		Template.KillAssistsPerKill = 0;
	}
}

//---------------------------------------------------------------------------------------

function bool DisablePOI(XComGameState_PointOfInterest POIState)
{
	return false;
}

static function X2LWTemplateModTemplate CreateModifyPOIsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'ModifyPOIs');
	Template.StrategyElementTemplateModFn = ModifyPOIs;
	return Template;
}

function bool DelayGrenades(XComGameState_PointOfInterest POIState)
{
	local XComGameState_HeadquartersAlien AlienHQ;

	AlienHQ = XComGameState_HeadquartersAlien(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	if (AlienHQ == none)
	{
		return false;
	}
	if (AlienHQ.GetForceLevel() <= 10)
	{
		return false;
	}
	return true;
}

// This also modifies the description of the city center in invasion missions
function ModifyPOIs (X2StrategyElementTemplate Template, int Difficulty)
{
	local X2PointOfInterestTemplate POITemplate;

	POITemplate = X2PointofInterestTemplate(Template);
	if (POITemplate != none)
	{
		switch (POITemplate.DataName)
		{
			case 'POI_HeavyWeapon':
				POITemplate.CanAppearFn = DisablePOI;
				break;
			case 'POI_GrenadeAmmo':
				POITemplate.CanAppearFn = DelayGrenades;
				break;
			default:
				break;
		}
	}
}


static function X2LWTemplateModTemplate CreateModifyHackRewardsTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'ModifyHackRewards');
	Template.HackRewardTemplateModFn = ModifyHackRewards;
	return Template;
}

function ModifyHackRewards (X2HackRewardTemplate Template, int Difficulty)
{
	local X2HackRewardTemplate HackRewardTemplate;

	if (Template != none)
	{
		HackRewardTemplate = Template;
		if (HackRewardTemplate.DataName == 'PriorityData_T1' || HackRewardTemplate.DataName == 'PriorityData_T2')
		{
			HackRewardTemplate.ApplyHackRewardFn = none;
		}
	}
}

static function X2LWTemplateModTemplate CreateReconfigFacilityUpgradesTemplate()
{
	local X2LWTemplateModTemplate Template;

	`CREATE_X2TEMPLATE(class'X2LWTemplateModTemplate', Template, 'ModifyFacilityUpgrades');
	Template.StrategyElementTemplateModFn = ModifyFacilityUpgrades;
	return Template;
}

// THIS DOES NOT MODIFY REQUIREMENTS (TECHS, SPECIAL ARTIFACTS, RANK ACHIEVED) WHICH ARE HARDCODED, CAN ADD SCI/ENG SCORE REQUIREMENT IF SET
function ModifyFacilityUpgrades(X2StrategyElementTemplate Template, int Difficulty)
{
	local X2FacilityUpgradeTemplate FacilityUpgradeTemplate, BaseResearchStationTemplate;
	local X2StrategyElementTemplate StratTemplate;
	local int k;
	local ArtifactCost Resources;

	FacilityUpgradeTemplate = X2FacilityUpgradeTemplate(Template);
	if (FacilityUpgradeTemplate != none)
	{
		for (k = 0; k < FacilityUpgradeTable.length; k++)
		{
			If (FacilityUpgradeTable[k].FacilityUpgradeTemplateName == FacilityUpgradeTemplate.DataName)
			{
				FacilityUpgradeTemplate.PointsToComplete = FacilityUpgradeTable[k].PointsToComplete;
				FacilityUpgradeTemplate.iPower = FacilityUpgradeTable[k].iPower;
				FacilityUpgradeTemplate.UpkeepCost = FacilityUpgradeTable[k].UpkeepCost;
				
				FacilityUpgradeTemplate.Cost.ResourceCosts.Length = 0;
				FacilityUpgradeTemplate.Cost.ArtifactCosts.Length = 0;
				FacilityUpgradeTemplate.Requirements.RequiredTechs.Length = 0;

				if (FacilityUpgradeTable[k].RequiredTech != '')
				{
					FacilityUpgradeTemplate.Requirements.RequiredTechs.AddItem(FacilityUpgradeTable[k].RequiredTech);
				}
				if (FacilityUpgradeTable[k].SupplyCost > 0)
				{
					Resources.ItemTemplateName = 'Supplies';
					Resources.Quantity = FacilityUpgradeTable[k].SupplyCost;
					FacilityUpgradeTemplate.Cost.ResourceCosts.AddItem(Resources);                  
				}
				if (FacilityUpgradeTable[k].AlloyCost > 0)
				{
					Resources.ItemTemplateName = 'AlienAlloy';
					Resources.Quantity = FacilityUpgradeTable[k].AlloyCost;
					FacilityUpgradeTemplate.Cost.ResourceCosts.AddItem(Resources);                  
				}
				if (FacilityUpgradeTable[k].CrystalCost > 0)
				{
					Resources.ItemTemplateName = 'EleriumDust';
					Resources.Quantity = FacilityUpgradeTable[k].CrystalCost;
					FacilityUpgradeTemplate.Cost.ResourceCosts.AddItem(Resources);                  
				}
				if (FacilityUpgradeTable[k].CoreCost > 0)
				{
					Resources.ItemTemplateName = 'EleriumCore';
					Resources.Quantity = FacilityUpgradeTable[k].CoreCost;
					FacilityUpgradeTemplate.Cost.ResourceCosts.AddItem(Resources);                  
				}
				if (FacilityUpgradeTable[k].ReqItemCost1 > 0)
				{
					Resources.ItemTemplateName = FacilityUpgradeTable[k].ReqItemTemplateName1;
					Resources.Quantity = FacilityUpgradeTable[k].ReqItemCost1;
					FacilityUpgradeTemplate.Cost.ArtifactCosts.AddItem(Resources);
				}
				if (FacilityUpgradeTable[k].ReqItemCost2 > 0)
				{
					Resources.ItemTemplateName = FacilityUpgradeTable[k].ReqItemTemplateName2;
					Resources.Quantity = FacilityUpgradeTable[k].ReqItemCost2;
					FacilityUpgradeTemplate.Cost.ArtifactCosts.AddItem(Resources);
				}
				FacilityUpgradeTemplate.MaxBuild = FacilityUpgradeTable[k].MaxBuild;
				if (FacilityUpgradeTable[k].RequiredEngineeringScore > 0)
				{
					FacilityUpgradeTemplate.Requirements.RequiredEngineeringScore = FacilityUpgradeTable[k].RequiredEngineeringScore;
				}
				if (FacilityUpgradeTable[k].RequiredScienceScore > 0)
				{
					FacilityUpgradeTemplate.Requirements.RequiredScienceScore = FacilityUpgradeTable[k].RequiredScienceScore;
				}
			}
		}

		// Ensure the Laboratory research station upgrades get the standard localization text
		if (FacilityUpgradeTemplate.DataName == 'Laboratory_AdditionalResearchStation2' ||
			FacilityUpgradeTemplate.DataName == 'Laboratory_AdditionalResearchStation3')
		{
			// Configure the additional research stations in the Laboratory
			StratTemplate = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().FindStrategyElementTemplate('Laboratory_AdditionalResearchStation');
			BaseResearchStationTemplate = X2FacilityUpgradeTemplate(StratTemplate);
			FacilityUpgradeTemplate.DisplayName = BaseResearchStationTemplate.default.DisplayName;
			FacilityUpgradeTemplate.FacilityName = BaseResearchStationTemplate.default.FacilityName;
			FacilityUpgradeTemplate.Summary = BaseResearchStationTemplate.default.Summary;
		}

		if (FacilityUpgradeTemplate.DataName == 'ResistanceRing_UpgradeI')
		{
			// Modify the upgrade to simply unlock the extra engineer staff slot
			FacilityUpgradeTemplate.OnUpgradeAddedFn = class'X2StrategyElement_DefaultFacilityUpgrades'.static.OnUpgradeAdded_UnlockStaffSlot;
		}
	}
}



	

static function AddT2Rockets(XComGameState NewGameState, XComGameState_Tech TechState)
{
	local XComGameStateHistory History;
	local X2ItemTemplateManager ItemMgr;
	local XComGameState_Item ItemState;
	local X2ItemTemplate ItemTemplate;
	local XComGameState_HeadquartersXCom XComHQ;

	History = `XCOMHISTORY;

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	if (XComHQ == none)
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	}

	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	

	ItemTemplate = ItemMgr.FindItemTemplate('IRI_X2Rocket_Plasma');
	if (ItemTemplate != none && !XComHQ.HasItem(ItemTemplate))
	{
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		XComHQ.AddItemToHQInventory(ItemState);
	}

	ItemTemplate = ItemMgr.FindItemTemplate('IRI_X2Rocket_Shredder_T2');
	if (ItemTemplate != none && !XComHQ.HasItem(ItemTemplate))
	{
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		XComHQ.AddItemToHQInventory(ItemState);
	}

}

static function AddT3Rockets(XComGameState NewGameState, XComGameState_Tech TechState)
{
	local XComGameStateHistory History;
	local X2ItemTemplateManager ItemMgr;
	local XComGameState_Item ItemState;
	local X2ItemTemplate ItemTemplate;
	local XComGameState_HeadquartersXCom XComHQ;

	History = `XCOMHISTORY;

	foreach NewGameState.IterateByClassType(class'XComGameState_HeadquartersXCom', XComHQ)
	{
		break;
	}

	if (XComHQ == none)
	{
		XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
		XComHQ = XComGameState_HeadquartersXCom(NewGameState.ModifyStateObject(class'XComGameState_HeadquartersXCom', XComHQ.ObjectID));
	}

	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	

	ItemTemplate = ItemMgr.FindItemTemplate('IRI_X2Rocket_Elerium');
	if (ItemTemplate != none && !XComHQ.HasItem(ItemTemplate))
	{
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		XComHQ.AddItemToHQInventory(ItemState);
	}

	ItemTemplate = ItemMgr.FindItemTemplate('IRI_X2Rocket_Shredder_T3');
	if (ItemTemplate != none && !XComHQ.HasItem(ItemTemplate))
	{
		ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		XComHQ.AddItemToHQInventory(ItemState);
	}

	if(XComHQ.IsTechResearched('LockOnProject'))
	{
		ItemTemplate = ItemMgr.FindItemTemplate('IRI_X2Rocket_Lockon_T3');
		if (ItemTemplate != none && !XComHQ.HasItem(ItemTemplate))
		{
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			XComHQ.AddItemToHQInventory(ItemState);
		}
	}

	if(XComHQ.IsTechResearched('Flechette'))
	{
		ItemTemplate = ItemMgr.FindItemTemplate('IRI_X2Rocket_Flechette_T3');
		if (ItemTemplate != none && !XComHQ.HasItem(ItemTemplate))
		{
			ItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
			XComHQ.AddItemToHQInventory(ItemState);
		}
	}

}

simulated function HunkerDownAbility_BuildVisualization_LW(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local StateObjectReference          InteractingUnitRef;
	local X2AbilityTemplate             AbilityTemplate;
	local XComGameState_Unit            UnitState;

	local VisualizationActionMetadata        EmptyTrack;
	local VisualizationActionMetadata        ActionMetadata;
	local int EffectIndex;
	local name ApplyResult;

	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local array<X2Condition> RequiredConditions;
	local array<StateObjectReference> VisibleUnits;
	local bool EnemyVisible;
	local int Index;
	local X2GameRulesetVisibilityManager VisibilityMgr;	

	History = `XCOMHISTORY;
	VisibilityMgr = `TACTICALRULES.VisibilityMgr;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************	
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);
	
	//remove sound and flyover for hidden advent units in FOW
	EnemyVisible = false;

	RequiredConditions.AddItem(class'X2Condition_AnyEnemyVisible'.default.SquadsightVisibilityCondition);
	RequiredConditions.AddItem(class'X2Condition_AnyEnemyVisible'.default.AliveUnitPropertyCondition);
	VisibilityMgr.GetAllVisibleToSource(UnitState.ObjectID, VisibleUnits, class'XComGameState_Unit',, RequiredConditions);

	if( UnitState.GetTeam() != eTeam_XCom)
	{
		for( Index = VisibleUnits.Length - 1; Index > -1; --Index )
		{
			//Remove non-enemies from the list
			if( UnitState.TargetIsEnemy(VisibleUnits[Index].ObjectID, ) )
			{
				EnemyVisible = true;
				break;
			}
		}
	}

	if( UnitState.GetTeam() != eTeam_Neutral && EnemyVisible || UnitState.GetTeam() == eTeam_XCom)
	{
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		if (UnitState.HasSoldierAbility('SharpshooterAim'))
		{
			AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate('SharpshooterAim');
		}
		else if (UnitState.HasSoldierAbility('DeepCover') && XComGameState_Unit(ActionMetadata.StateObject_OldState).ActionPoints.Find(class'X2CharacterTemplateManager'.default.DeepCoverActionPoint) != INDEX_NONE)
		{
			AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate('DeepCover');
		}
		else
		{
			AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(Context.InputContext.AbilityTemplateName);
		}
		SoundAndFlyOver.SetSoundAndFlyOverParameters(SoundCue'SoundUI.HunkerDownCue', AbilityTemplate.LocFlyOverText, 'HunkerDown', eColor_Good, AbilityTemplate.IconImage, 1.0, true);
	}
	

	//****************************************************************************************

	//	this visualization handles the removal of burning effects
	AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(Context.InputContext.AbilityTemplateName);

	for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
	{
		ApplyResult = Context.FindTargetEffectApplyResult(AbilityTemplate.AbilityTargetEffects[EffectIndex]);
		AbilityTemplate.AbilityTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, ActionMetadata, ApplyResult);
	}
}
