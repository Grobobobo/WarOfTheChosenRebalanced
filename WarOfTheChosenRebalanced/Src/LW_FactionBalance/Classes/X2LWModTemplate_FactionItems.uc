//---------------------------------------------------------------------------------------
//  FILE:    X2LWModTemplate_FactionItems.uc
//  AUTHOR:  Peter Ledbrook
//  PURPOSE: Modifies existing item templates related to faction soldiers.
//---------------------------------------------------------------------------------------
class X2LWModTemplate_FactionItems extends X2LWTemplateModTemplate config(LW_FactionBalance);

var config array<WeaponDamageValue> WHIPLASH_CONVENTIONAL_DAMAGE;
var config array<WeaponDamageValue> WHIPLASH_LASER_DAMAGE;
var config array<WeaponDamageValue> WHIPLASH_MAGNETIC_DAMAGE;
var config array<WeaponDamageValue> WHIPLASH_COIL_DAMAGE;
var config array<WeaponDamageValue> WHIPLASH_BEAM_DAMAGE;

static function UpdateItems(X2ItemTemplate Template, int Difficulty)
{
	local X2WeaponTemplate WeaponTemplate;

	WeaponTemplate = X2WeaponTemplate(Template);
	if (WeaponTemplate != none)
	{
		UpdateWeapons(WeaponTemplate, Difficulty);
	}
}

static function UpdateWeapons(X2WeaponTemplate WeaponTemplate, int Difficulty)
{
	switch (WeaponTemplate.DataName)
	{
	case 'Reaper_Claymore':
		WeaponTemplate.iRange = `METERSTOTILES(class'X2Ability_ReaperAbilitySet'.default.ClaymoreRange);
		break;
	case 'VektorRifle_CV':
		// WOTC sets this to 2 for some reason, which is inconsistent with the
		// _MG and _BM variants.
		WeaponTemplate.iTypicalActionCost = 1;
		break;
	case 'VektorRifle_MG':
		WeaponTemplate.CreatorTemplateName = 'PrecisionWeapons_MG_Schematic'; // The schematic which creates this item
		break;

	case 'VektorRifle_BM':
		WeaponTemplate.CreatorTemplateName = 'PrecisionWeapons_BM_Schematic'; // The schematic which creates this item
		break;

	case 'Bullpup_CV':
		WeaponTemplate.Abilities.AddItem('Bullpup_CV_StatBonus');
		WeaponTemplate.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_FactionWeaponAbilities'.default.BULLPUP_CONVENTIONAL_MOBILITY_BONUS);
		//WeaponTemplate.RangeAccuracy = class'X2Item_FactionWeapons'.default.SKIRMISHER_SMG_RANGE;
		break;
	case 'Bullpup_MG':
		WeaponTemplate.Abilities.AddItem('Bullpup_MG_StatBonus');
		WeaponTemplate.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_FactionWeaponAbilities'.default.BULLPUP_MAGNETIC_MOBILITY_BONUS);
		//WeaponTemplate.RangeAccuracy = class'X2Item_FactionWeapons'.default.SKIRMISHER_SMG_RANGE;
		WeaponTemplate.CreatorTemplateName = 'LightWeapons_MG_Schematic'; // The schematic which creates this item
		break;
	case 'Bullpup_BM':
		WeaponTemplate.Abilities.AddItem('Bullpup_BM_StatBonus');
		WeaponTemplate.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_FactionWeaponAbilities'.default.BULLPUP_BEAM_MOBILITY_BONUS);
		//WeaponTemplate.RangeAccuracy = class'X2Item_FactionWeapons'.default.SKIRMISHER_SMG_RANGE;
		WeaponTemplate.CreatorTemplateName = 'LightWeapons_BM_Schematic'; // The schematic which creates this item
		break;
	case 'ShardGauntlet_BM':
		WeaponTemplate.Abilities.AddItem('SupremeFocus');
	case 'ShardGauntlet_MG':
		WeaponTemplate.Abilities.AddItem('DeepFocus');
	case 'ShardGauntlet_CV':
		break;
	case 'Wristblade_CV':
		WeaponTemplate.ExtraDamage = default.WHIPLASH_CONVENTIONAL_DAMAGE;
		WeaponTemplate.Abilities.AddItem('Justice');
		WeaponTemplate.Abilities.AddItem('SkirmisherFleche');
		break;
	case 'Wristblade_LS':
		WeaponTemplate.ExtraDamage = default.WHIPLASH_LASER_DAMAGE;
		break;
	case 'Wristblade_MG':
		WeaponTemplate.ExtraDamage = default.WHIPLASH_MAGNETIC_DAMAGE;
		break;
	case 'Wristblade_CG':
		WeaponTemplate.ExtraDamage = default.WHIPLASH_COIL_DAMAGE;
		break;
	case 'Wristblade_BM':
		WeaponTemplate.ExtraDamage = default.WHIPLASH_BEAM_DAMAGE;
		break;
	case 'Sidearm_CV':
	case 'Sidearm_LS':
	case 'Sidearm_CG':
		WeaponTemplate.Abilities.AddItem('SprayAndPray');
		WeaponTemplate.Abilities.RemoveItem('PistolOverwatch');
		//WeaponTemplate.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
		break;
	case 'GrenadeLauncher_CV':
	    //WeaponTemplate.Abilities.AddItem('LaunchGrenade');
	    WeaponTemplate.Abilities.AddItem('AdventGrenadeLauncher');
	    WeaponTemplate.Abilities.AddItem('Salvo');
	    WeaponTemplate.Abilities.AddItem('FullKit');
		break;

	case 'Sidearm_MG':
		WeaponTemplate.BaseItem = 'Sidearm_LS';
		WeaponTemplate.Abilities.AddItem('SprayAndPray');
		WeaponTemplate.Abilities.RemoveItem('PistolOverwatch');
		WeaponTemplate.CreatorTemplateName = 'Sidearms_MG_Schematic'; // The schematic which creates this item

		break;
	case 'Sidearm_BM':
		WeaponTemplate.BaseItem = 'Sidearm_CG';
		WeaponTemplate.Abilities.AddItem('SprayAndPray');
		WeaponTemplate.Abilities.RemoveItem('PistolOverwatch');
		WeaponTemplate.CreatorTemplateName = 'Sidearms_BM_Schematic';
		break;

	default:
		break;
	}
}

defaultproperties
{
	ItemTemplateModFn=UpdateItems
}
