//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_TheLost_LW.uc
//  AUTHOR:  Grobobobo
//  PURPOSE: Defines all Long War lost-specific Characters
//---------------------------------------------------------------------------------------
class X2Character_TheLost_LW extends X2Character;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateTemplate_TheLostBrute('TheLostBrute_LW', 'TheLostBruteTier1_Loadout'));

	Templates.AddItem(CreateTemplate_TheLostGrappler('TheLostGrappler_LW', 'TheLostGrapplerTier1_Loadout'));

	Templates.AddItem(class'X2Character_DefaultCharacters'.static.CreateTemplate_TheLost('TheLost_LW', 'TheLostTier1_Loadout'));

	Templates.AddItem(CreateTemplate_TheLostDasher_LW('TheLostDasher_LW', 'TheLostTier1_Loadout'));

    return Templates;
}

static function X2CharacterTemplate CreateTemplate_TheLostDasher_LW(name LostName, name LoadoutName)
{
	local X2CharacterTemplate CharTemplate;

	CharTemplate = class'X2Character_DefaultCharacters'.static.CreateTemplate_TheLostDasher(LostName, LoadoutName);
	CharTemplate.CharacterGroupName = 'TheLostDasher';

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_TheLostGrappler(name LostName, name LoadoutName)
{
	local X2CharacterTemplate CharTemplate;

	CharTemplate = class'X2Character_DefaultCharacters'.static.CreateTemplate_TheLost(LostName, LoadoutName);
	CharTemplate.CharacterGroupName = 'TheLostGrappler';
	CharTemplate.strPawnArchetypes.Length = 0;
	CharTemplate.strPawnArchetypes.AddItem("GameUnit_TheLost.ARC_GameUnit_TheLost_Howler");
	CharTemplate.AIOrderPriority = 100;

	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_TheLostBrute(name LostName, name LoadoutName)
{
	local X2CharacterTemplate CharTemplate;

	CharTemplate = class'X2Character_DefaultCharacters'.static.CreateTemplate_TheLost(LostName, LoadoutName);
	CharTemplate.CharacterGroupName = 'TheLostBrute';
	CharTemplate.SightedNarrativeMoments.Length = 0;
	CharTemplate.Abilities.AddItem('WallBreaking');
	CharTemplate.strPawnArchetypes.Length = 0;
	if (class'Helpers_LW'.static.IsModInstalled("WorldWarLost"))
	{
		CharTemplate.strPawnArchetypes.AddItem("CX_Extra_Lost_Brute.Archetypes.ARC_GameUnit_TheLost_CXBrute"); //Brute Lost
	}
	else
	{
		CharTemplate.strPawnArchetypes.AddItem("GameUnit_TheLost.ARC_GameUnit_TheLost_Howler");
	}

	return CharTemplate;
}
