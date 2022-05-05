//---------------------------------------------------------------------------------------
//  FILE:    X2HackReward_LWOverhaul.uc
//  AUTHOR:  Amineri / Pavonis Interactive
//  PURPOSE: Interface for adding new Hack Rewards to X-Com 2.
//---------------------------------------------------------------------------------------
class X2HackReward_LWOverhaul extends X2HackReward config(GameCore);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	`LWTrace("  >> X2HackReward_LWOverhaul.CreateTemplates()");

	Templates.AddItem(CreateHackLootTableReward('LootPCS_T1_LW'));
	Templates.AddItem(CreateHackLootTableReward('LootPCS_T2_LW'));
	Templates.AddItem(CreateHackLootTableReward('LootPCS_T3_LW'));

	return Templates;
}

static function X2HackRewardTemplate CreateHackLootTableReward (name TemplateName)
{
	local X2HackRewardTemplate Template;

	`CREATE_X2TEMPLATE(class'X2HackRewardTemplate', Template, TemplateName);
	switch (TemplateName)
	{
		case 'LootPCS_T1_LW': Template.ApplyHackRewardFn = ApplyPCSDropsBasic; break;
		case 'LootPCS_T2_LW': Template.ApplyHackRewardFn = ApplyPCSDropsRare; break;
		case 'LootPCS_T3_LW': Template.ApplyHackRewardFn = ApplyPCSDropsEpic; break;
		default: break;
	}
	Template.HackAbilityTemplateRestriction = 'FinalizeSKULLMINE';
	return Template;
}

static function ApplyPCSDropsBasic (XComGameState_Unit Hacker, XComGameState_BaseObject HackTarget, XComGameState NewGameState)
{
	local array<name> Loots;
	local X2LootTableManager LootTableManager;
	local XComGameState_BattleData BattleData;
    local XComGameState_Item NewItemState;
    local X2ItemTemplate ItemTemplate;
	local name LootTableName;

	LootTableManager = class'X2LootTableManager'.static.GetLootTableManager();
	LootTableName = 'PCSDropsBasic';
	LootTableManager.RollForLootTable(LootTableName, Loots);
	BattleData = XComGameState_BattleData(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
    BattleData = XComGameState_BattleData(NewGameState.CreateStateObject(class'XComGameState_BattleData', BattleData.ObjectID));
    NewGameState.AddStateObject(BattleData);
	if(Loots[0] != 'None')
	{
		ItemTemplate = class'X2ItemTemplateManager'.static.GetItemTemplateManager().FindItemTemplate(Loots[0]);
		NewItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(NewItemState);
		Hacker.AddLoot(NewItemState.GetReference(), NewGameState);
	}
}

static function ApplyPCSDropsRare (XComGameState_Unit Hacker, XComGameState_BaseObject HackTarget, XComGameState NewGameState)
{
	local array<name> Loots;
	local X2LootTableManager LootTableManager;
	local XComGameState_BattleData BattleData;
    local XComGameState_Item NewItemState;
    local X2ItemTemplate ItemTemplate;
	local name LootTableName;

	LootTableManager = class'X2LootTableManager'.static.GetLootTableManager();
	LootTableName = 'PCSDropsRare';
	LootTableManager.RollForLootTable(LootTableName, Loots);
	BattleData = XComGameState_BattleData(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
    BattleData = XComGameState_BattleData(NewGameState.CreateStateObject(class'XComGameState_BattleData', BattleData.ObjectID));
    NewGameState.AddStateObject(BattleData);
	if(Loots[0] != 'None')
	{
		ItemTemplate = class'X2ItemTemplateManager'.static.GetItemTemplateManager().FindItemTemplate(Loots[0]);
		NewItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(NewItemState);
		Hacker.AddLoot(NewItemState.GetReference(), NewGameState);
	}
}

static function ApplyPCSDropsEpic (XComGameState_Unit Hacker, XComGameState_BaseObject HackTarget, XComGameState NewGameState)
{
	local array<name> Loots;
	local X2LootTableManager LootTableManager;
	local XComGameState_BattleData BattleData;
    local XComGameState_Item NewItemState;
    local X2ItemTemplate ItemTemplate;
	local name LootTableName;

	LootTableManager = class'X2LootTableManager'.static.GetLootTableManager();
	LootTableName = 'PCSDropsEpic';
	LootTableManager.RollForLootTable(LootTableName, Loots);
	BattleData = XComGameState_BattleData(`XCOMHistory.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
    BattleData = XComGameState_BattleData(NewGameState.CreateStateObject(class'XComGameState_BattleData', BattleData.ObjectID));
    NewGameState.AddStateObject(BattleData);
	if(Loots[0] != 'None')
	{
		ItemTemplate = class'X2ItemTemplateManager'.static.GetItemTemplateManager().FindItemTemplate(Loots[0]);
		NewItemState = ItemTemplate.CreateInstanceFromTemplate(NewGameState);
		NewGameState.AddStateObject(NewItemState);
		Hacker.AddLoot(NewItemState.GetReference(), NewGameState);
	}
}
