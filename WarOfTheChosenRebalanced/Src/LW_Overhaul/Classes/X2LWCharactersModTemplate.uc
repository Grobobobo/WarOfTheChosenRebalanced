//---------------------------------------------------------------------------------------
//  FILE:    X2LWCharactersModTemplate.uc
//  AUTHOR:  Peter Ledbrook
//  PURPOSE: Modifies existing character templates, for example to add "sighted"
//           events to new LWOTC enemies so that the tutorial can hook into them.
//---------------------------------------------------------------------------------------
class X2LWCharactersModTemplate extends X2LWTemplateModTemplate config(LW_Overhaul);

var config array<name> EXCLUDED_CHARACTERS_FROM_GLOBAL_DIFF_MOD;
var config array<float> DIFFICULTY_HP_MODIFIER;
var config array<float> DIFFICULTY_AIM_MODIFIER;
var config array<float> DIFFICULTY_WILL_MODIFIER;
var config int GLOBAL_FLANKING_CRIT_CHANCE;


static function UpdateCharacters(X2CharacterTemplate Template, int Difficulty)
{
	switch (Template.DataName)
	{
	case 'LWDroneM1':
	case 'LWDroneM2':
		Template.SightedEvents.AddItem('DroneSighted');
		break;
	case 'AdvGrenadierM1':
	case 'AdvGrenadierM2':
	case 'AdvGrenadierM3':
		Template.SightedEvents.AddItem('EngineerSighted');
		break;
	case 'AdvSentryM1':
	case 'AdvSentryM2':
	case 'AdvSentryM3':
		Template.SightedEvents.AddItem('SentrySighted');
		break;
	case 'AdvGunnerM1':
	case 'AdvGunnerM2':
	case 'AdvGunnerM3':
		Template.SightedEvents.AddItem('GunnerSighted');
		break;
	case 'AdvRocketeerM1':
	case 'AdvRocketeerM2':
	case 'AdvRocketeerM3':
		Template.SightedEvents.AddItem('RocketeerSighted');
		break;
	case'ChosenAssassin':
	case'ChosenAssassinM2':
	case'ChosenAssassinM3':
	case'ChosenAssassinM4':
	case'ChosenAssassinM5':
		Template.SightedEvents.AddItem('ChosenSighted');
		Template.SightedEvents.AddItem('AssassinSighted');
		break;
	case'ChosenWarlock':
	case'ChosenWarlockM2':
	case'ChosenWarlockM3':
	case'ChosenWarlockM4':
	case'ChosenWarlockM5':
		Template.SightedEvents.AddItem('ChosenSighted');
		Template.SightedEvents.AddItem('WarlockSighted');
	break;
	case'ChosenHunter':
	case'ChosenHunterM2':
	case'ChosenHunterM3':
	case'ChosenHunterM4':
	case'ChosenHunterM5':
		Template.SightedEvents.AddItem('ChosenSighted');
		Template.SightedEvents.AddItem('HunterSighted');
	break;
	default:
		break;
	}
	StandarizeLootForUnits(Template,Difficulty);
	DoaGlobalStatModifierByDifficulty(Template,Difficulty);

	Template.CharacterBaseStats[eStat_FlankingCritChance] = default.GLOBAL_FLANKING_CRIT_CHANCE;
}

static function DoaGlobalStatModifierByDifficulty(X2CharacterTemplate Template, int Difficulty)
{
	local X2CharacterTemplate HighestDiffTemplate;
	local array<X2DataTemplate> DiffTemplates;
	local X2CharacterTemplateManager TemplateManager;
	local int i;



	if(default.EXCLUDED_CHARACTERS_FROM_GLOBAL_DIFF_MOD.Find(Template.DataName) != INDEX_NONE || Template.bIsSoldier || Template.bIsCivilian)
	{
		return;
	}

	TemplateManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	Template.Abilities.AddItem('EnemyResearchBonus');
	Template.Abilities.AddItem('EnemySighted');
	
	TemplateManager.FindDataTemplateAllDifficulties(Template.DataName, DiffTemplates);
	
	//Get The highest difficulty template
	HighestDiffTemplate = X2CharacterTemplate(DiffTemplates[3]);

	for (i = 0; i< DiffTemplates.length; i++)
	{
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_HP] = FCeil(HighestDiffTemplate.CharacterBaseStats[eStat_HP] * default.DIFFICULTY_HP_MODIFIER[i]);
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_Offense] = FCeil(HighestDiffTemplate.CharacterBaseStats[eStat_Offense] + default.DIFFICULTY_AIM_MODIFIER[i]);
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_Will] = FCeil(HighestDiffTemplate.CharacterBaseStats[eStat_Will] + default.DIFFICULTY_Will_MODIFIER[i]);
	
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_ArmorMitigation] = HighestDiffTemplate.CharacterBaseStats[eStat_ArmorMitigation];
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_CritChance] = HighestDiffTemplate.CharacterBaseStats[eStat_CritChance];
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_Defense] = HighestDiffTemplate.CharacterBaseStats[eStat_Defense];
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_Dodge] = HighestDiffTemplate.CharacterBaseStats[eStat_Dodge];
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_Mobility] = HighestDiffTemplate.CharacterBaseStats[eStat_Mobility];
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_PsiOffense] = HighestDiffTemplate.CharacterBaseStats[eStat_PsiOffense];
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_HackDefense] = HighestDiffTemplate.CharacterBaseStats[eStat_HackDefense];
		X2CharacterTemplate(DiffTemplates[i]).CharacterBaseStats[eStat_FlankingCritChance] = default.GLOBAL_FLANKING_CRIT_CHANCE;
		

	}

}

static function StandarizeLootForUnits(X2CharacterTemplate Template, int Difficulty)
{
	local LootReference  LootTimedEarly, LootVultureEarly, LootTimedMid, LootVultureMid, LootTimedLate, LootVultureLate; 

	if(default.EXCLUDED_CHARACTERS_FROM_GLOBAL_DIFF_MOD.Find(Template.DataName) != INDEX_NONE || Template.bIsSoldier || Template.bIsCivilian)
	{
		return;
	}

	Template.TimedLoot.LootReferences.length = 0;
	Template.VultureLoot.LootReferences.length = 0;
	

	LootTimedEarly.ForceLevel = 0;
	LootVultureEarly.ForceLevel = 0;

	LootTimedEarly.LootTableName='GenericEarlyAlienLoot_LW';
	LootVultureEarly.LootTableName='GenericEarlyAlienVultureLoot_LW';

	Template.TimedLoot.LootReferences.AddItem(LootTimedEarly);
	Template.VultureLoot.LootReferences.AddItem(LootVultureEarly);

	LootTimedMid.ForceLevel = 8;
	LootVultureMid.ForceLevel = 8;

	LootTimedMid.LootTableName='GenericMidAlienLoot_LW';
	LootVultureMid.LootTableName='GenericMidAlienVultureLoot_LW';

	Template.TimedLoot.LootReferences.AddItem(LootTimedMid);
	Template.VultureLoot.LootReferences.AddItem(LootVultureMid);

	LootTimedLate.ForceLevel = 16;
	LootVultureLate.ForceLevel = 16;

	LootTimedLate.LootTableName='GenericLateAlienLoot_LW';
	LootVultureLate.LootTableName='GenericLateAlienVultureLoot_LW';

	Template.TimedLoot.LootReferences.AddItem(LootTimedLate);
	Template.VultureLoot.LootReferences.AddItem(LootVultureLate);	

}

defaultproperties
{
	CharacterTemplateModFn=UpdateCharacters
}
