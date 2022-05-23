class X2Item_AdvancedSchematics extends X2Item config(GameData_WeaponData);

var config int SIDEARMS_LASER_SUPPLYCOST;
var config int SIDEARMS_LASER_ALLOYCOST;
var config int SIDEARMS_LASER_ELERIUMCOST;

var config int SIDEARMS_MAG_SUPPLYCOST;
var config int SIDEARMS_MAG_ALLOYCOST;
var config int SIDEARMS_MAG_ELERIUMCOST;

var config int SIDEARMS_COIL_SUPPLYCOST;
var config int SIDEARMS_COIL_ALLOYCOST;
var config int SIDEARMS_COIL_ELERIUMCOST;

var config int SIDEARMS_BEAM_SUPPLYCOST;
var config int SIDEARMS_BEAM_ALLOYCOST;
var config int SIDEARMS_BEAM_ELERIUMCOST;

var config int LIGHTWEAPONS_LASER_SUPPLYCOST;
var config int LIGHTWEAPONS_LASER_ALLOYCOST;
var config int LIGHTWEAPONS_LASER_ELERIUMCOST;

var config int LIGHTWEAPONS_MAG_SUPPLYCOST;
var config int LIGHTWEAPONS_MAG_ALLOYCOST;
var config int LIGHTWEAPONS_MAG_ELERIUMCOST;

var config int LIGHTWEAPONS_COIL_SUPPLYCOST;
var config int LIGHTWEAPONS_COIL_ALLOYCOST;
var config int LIGHTWEAPONS_COIL_ELERIUMCOST;

var config int LIGHTWEAPONS_BEAM_SUPPLYCOST;
var config int LIGHTWEAPONS_BEAM_ALLOYCOST;
var config int LIGHTWEAPONS_BEAM_ELERIUMCOST;

var config int PRECISIONWEAPONS_LASER_SUPPLYCOST;
var config int PRECISIONWEAPONS_LASER_ALLOYCOST;
var config int PRECISIONWEAPONS_LASER_ELERIUMCOST;

var config int PRECISIONWEAPONS_MAG_SUPPLYCOST;
var config int PRECISIONWEAPONS_MAG_ALLOYCOST;
var config int PRECISIONWEAPONS_MAG_ELERIUMCOST;

var config int PRECISIONWEAPONS_COIL_SUPPLYCOST;
var config int PRECISIONWEAPONS_COIL_ALLOYCOST;
var config int PRECISIONWEAPONS_COIL_ELERIUMCOST;

var config int PRECISIONWEAPONS_BEAM_SUPPLYCOST;
var config int PRECISIONWEAPONS_BEAM_ALLOYCOST;
var config int PRECISIONWEAPONS_BEAM_ELERIUMCOST;

var config int HEAVYWEAPONS_LASER_SUPPLYCOST;
var config int HEAVYWEAPONS_LASER_ALLOYCOST;
var config int HEAVYWEAPONS_LASER_ELERIUMCOST;

var config int HEAVYWEAPONS_MAG_SUPPLYCOST;
var config int HEAVYWEAPONS_MAG_ALLOYCOST;
var config int HEAVYWEAPONS_MAG_ELERIUMCOST;

var config int HEAVYWEAPONS_COIL_SUPPLYCOST;
var config int HEAVYWEAPONS_COIL_ALLOYCOST;
var config int HEAVYWEAPONS_COIL_ELERIUMCOST;

var config int HEAVYWEAPONS_BEAM_SUPPLYCOST;
var config int HEAVYWEAPONS_BEAM_ALLOYCOST;
var config int HEAVYWEAPONS_BEAM_ELERIUMCOST;

var config int GENERALWEAPONS_LASER_SUPPLYCOST;
var config int GENERALWEAPONS_LASER_ALLOYCOST;
var config int GENERALWEAPONS_LASER_ELERIUMCOST;

var config int GENERALWEAPONS_MAG_SUPPLYCOST;
var config int GENERALWEAPONS_MAG_ALLOYCOST;
var config int GENERALWEAPONS_MAG_ELERIUMCOST;

var config int GENERALWEAPONS_COIL_SUPPLYCOST;
var config int GENERALWEAPONS_COIL_ALLOYCOST;
var config int GENERALWEAPONS_COIL_ELERIUMCOST;

var config int GENERALWEAPONS_BEAM_SUPPLYCOST;
var config int GENERALWEAPONS_BEAM_ALLOYCOST;
var config int GENERALWEAPONS_BEAM_ELERIUMCOST;

var config int IMMOLATOR_CV_SUPPLYCOST;
var config int IMMOLATOR_CV_ALLOYCOST;
var config int IMMOLATOR_CV_ELERIUMCOST;

var config int IMMOLATOR_MG_SUPPLYCOST;
var config int IMMOLATOR_MG_ALLOYCOST;
var config int IMMOLATOR_MG_COIL_ELERIUMCOST;

var config int IMMOLATOR_BM_SUPPLYCOST;
var config int IMMOLATOR_BM_ALLOYCOST;
var config int IMMOLATOR_BM_ELERIUMCOST;

var config int WRISTBLADE_LASER_SUPPLYCOST;
var config int WRISTBLADE_LASER_ALLOYCOST;
var config int WRISTBLADE_LASER_ELERIUMCOST;

var config int WRISTBLADE_MAG_SUPPLYCOST;
var config int WRISTBLADE_MAG_ALLOYCOST;
var config int WRISTBLADE_MAG_ELERIUMCOST;

var config int WRISTBLADE_COIL_SUPPLYCOST;
var config int WRISTBLADE_COIL_ALLOYCOST;
var config int WRISTBLADE_COIL_ELERIUMCOST;

var config int WRISTBLADE_BEAM_SUPPLYCOST;
var config int WRISTBLADE_BEAM_ALLOYCOST;
var config int WRISTBLADE_BEAM_ELERIUMCOST;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;


	Weapons.AddItem(Sidearms_Laser_Schematic());
	Weapons.AddItem(Sidearms_Mag_Schematic());
	Weapons.AddItem(Sidearms_Coil_Schematic());
	Weapons.AddItem(Sidearms_Beam_Schematic());

	Weapons.AddItem(LightWeapons_Laser_Schematic());
	Weapons.AddItem(LightWeapons_Mag_Schematic());
	Weapons.AddItem(LightWeapons_Coil_Schematic());
	Weapons.AddItem(LightWeapons_Beam_Schematic());

	Weapons.AddItem(PrecisionWeapons_Laser_Schematic());
	Weapons.AddItem(PrecisionWeapons_Mag_Schematic());
	Weapons.AddItem(PrecisionWeapons_Coil_Schematic());
	Weapons.AddItem(PrecisionWeapons_Beam_Schematic());

	Weapons.AddItem(HeavyWeapons_Laser_Schematic());
	Weapons.AddItem(HeavyWeapons_Mag_Schematic());
	Weapons.AddItem(HeavyWeapons_Coil_Schematic());
	Weapons.AddItem(HeavyWeapons_Beam_Schematic());

	Weapons.AddItem(GeneralWeapons_Laser_Schematic());
	Weapons.AddItem(GeneralWeapons_Mag_Schematic());
	Weapons.AddItem(GeneralWeapons_Coil_Schematic());
	Weapons.AddItem(GeneralWeapons_Beam_Schematic());

	Weapons.AddItem(Immolator_CV_Schematic());
	Weapons.AddItem(Immolator_MG_Schematic());
	Weapons.AddItem(Immolator_BM_Schematic());

	Weapons.AddItem(WristBlade_LS_Schematic());

	return Weapons;
}

static function X2DataTemplate Sidearms_Laser_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'Sidearms_LS_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_LaserPack.Inv_Laser_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'Sidearm_LS';
	Template.HideIfPurchased = 'Sidearm_MG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('LaserWeapons');
	Template.Requirements.RequiredEngineeringScore = 5;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.SIDEARMS_LASER_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.SIDEARMS_LASER_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

   if( default.SIDEARMS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.SIDEARMS_LASER_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }

	return Template;
}

static function X2DataTemplate Sidearms_Mag_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'Sidearms_MG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_MG_Schematic'
	Template.strImage = "img:///UILibrary_LWSecondariesLWOTC.Inv_Mag_SawedOffShotgun";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'Sidearm_MG';
	Template.HideIfPurchased = 'Sidearm_CG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.SIDEARMS_MAG_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.SIDEARMS_MAG_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.SIDEARMS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.SIDEARMS_MAG_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}


static function X2DataTemplate Sidearms_Coil_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'Sidearms_CG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'Sidearm_CG';
	Template.HideIfPurchased = 'Sidearm_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('CoilGuns');
	Template.Requirements.RequiredEngineeringScore = 15;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.SIDEARMS_COIL_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.SIDEARMS_COIL_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.SIDEARMS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.SIDEARMS_COIL_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate Sidearms_Beam_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'Sidearms_BM_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'Sidearm_CG';
	Template.HideIfPurchased = 'Sidearm_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.SIDEARMS_BEAM_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.SIDEARMS_BEAM_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.SIDEARMS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.SIDEARMS_BEAM_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate LightWeapons_Laser_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'LightWeapons_LS_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'SMG_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_LaserPack.LaserSMG_Base";
//END AUTOGENERATED CODE: Template Overrides 'SMG_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'SMG_LS';
	Template.HideIfPurchased = 'SMG_MG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('LaserWeapons');
	Template.Requirements.RequiredEngineeringScore = 5;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.LIGHTWEAPONS_LASER_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.LIGHTWEAPONS_LASER_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

   if( default.LIGHTWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.LIGHTWEAPONS_LASER_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }

	return Template;
}

static function X2DataTemplate LightWeapons_Mag_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'LightWeapons_MG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'SMG_MG_Schematic'
	Template.strImage = "img:///UILibrary_SMG.magnetic.LWMagSMG_Base";
//END AUTOGENERATED CODE: Template Overrides 'SMG_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'SMG_MG';
	Template.HideIfPurchased = 'SMG_CG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.LIGHTWEAPONS_MAG_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.LIGHTWEAPONS_MAG_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.LIGHTWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.LIGHTWEAPONS_MAG_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}


static function X2DataTemplate LightWeapons_Coil_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'LightWeapons_CG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'SMG_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_Base";
//END AUTOGENERATED CODE: Template Overrides 'SMG_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'SMG_CG';
	Template.HideIfPurchased = 'SMG_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('CoilGuns');
	Template.Requirements.RequiredEngineeringScore = 15;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.LIGHTWEAPONS_COIL_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.LIGHTWEAPONS_COIL_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.LIGHTWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.LIGHTWEAPONS_COIL_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate LightWeapons_Beam_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'LightWeapons_BM_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'SMG_MG_Schematic'
	Template.strImage = "img:///UILibrary_SMG.Beam.LWBeamSMG_Base";
//END AUTOGENERATED CODE: Template Overrides 'SMG_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'SMG_CG';
	Template.HideIfPurchased = 'SMG_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.LIGHTWEAPONS_BEAM_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.LIGHTWEAPONS_BEAM_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.LIGHTWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.LIGHTWEAPONS_BEAM_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate PrecisionWeapons_Laser_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'PrecisionWeapons_LS_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'SniperRifle_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_LaserPack.Inv_Laser_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'SniperRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'SniperRifle_LS';
	Template.HideIfPurchased = 'SniperRifle_MG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('LaserWeapons');
	Template.Requirements.RequiredEngineeringScore = 5;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.PRECISIONWEAPONS_LASER_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.PRECISIONWEAPONS_LASER_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

   if( default.PRECISIONWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.PRECISIONWEAPONS_LASER_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }

	return Template;
}

static function X2DataTemplate PrecisionWeapons_Mag_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'PrecisionWeapons_MG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'SniperRifle_MG_Schematic'
	Template.strImage = "img:///UILibrary_LWSecondariesLWOTC.Inv_Mag_SawedOffShotgun";
//END AUTOGENERATED CODE: Template Overrides 'SniperRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'SniperRifle_MG';
	Template.HideIfPurchased = 'SniperRifle_CG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.PRECISIONWEAPONS_MAG_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.PRECISIONWEAPONS_MAG_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.PRECISIONWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.PRECISIONWEAPONS_MAG_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}


static function X2DataTemplate PrecisionWeapons_Coil_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'PrecisionWeapons_CG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'SniperRifle_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'SniperRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'SniperRifle_CG';
	Template.HideIfPurchased = 'SniperRifle_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('CoilGuns');
	Template.Requirements.RequiredEngineeringScore = 15;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.PRECISIONWEAPONS_COIL_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.PRECISIONWEAPONS_COIL_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.PRECISIONWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.PRECISIONWEAPONS_COIL_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate PrecisionWeapons_Beam_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'PrecisionWeapons_BM_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'SniperRifle_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'SniperRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'SniperRifle_CG';
	Template.HideIfPurchased = 'SniperRifle_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.PRECISIONWEAPONS_BEAM_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.PRECISIONWEAPONS_BEAM_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.PRECISIONWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.PRECISIONWEAPONS_BEAM_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate HeavyWeapons_Laser_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'HeavyWeapons_LS_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'Cannon_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_LaserPack.Inv_Laser_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'Cannon_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'Cannon_LS';
	Template.HideIfPurchased = 'Cannon_MG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('LaserWeapons');
	Template.Requirements.RequiredEngineeringScore = 5;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.HEAVYWEAPONS_LASER_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.HEAVYWEAPONS_LASER_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

   if( default.HEAVYWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.HEAVYWEAPONS_LASER_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }

	return Template;
}

static function X2DataTemplate HeavyWeapons_Mag_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'HeavyWeapons_MG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'Cannon_MG_Schematic'
	Template.strImage = "img:///UILibrary_LWSecondariesLWOTC.Inv_Mag_SawedOffShotgun";
//END AUTOGENERATED CODE: Template Overrides 'Cannon_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'Cannon_MG';
	Template.HideIfPurchased = 'Cannon_CG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.HEAVYWEAPONS_MAG_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.HEAVYWEAPONS_MAG_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.HEAVYWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.HEAVYWEAPONS_MAG_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}


static function X2DataTemplate HeavyWeapons_Coil_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'HeavyWeapons_CG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'Cannon_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'Cannon_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'Cannon_CG';
	Template.HideIfPurchased = 'Cannon_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('CoilGuns');
	Template.Requirements.RequiredEngineeringScore = 15;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.HEAVYWEAPONS_COIL_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.HEAVYWEAPONS_COIL_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.HEAVYWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.HEAVYWEAPONS_COIL_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate HeavyWeapons_Beam_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'HeavyWeapons_BM_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'Cannon_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'Cannon_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'Cannon_CG';
	Template.HideIfPurchased = 'Cannon_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.HEAVYWEAPONS_BEAM_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.HEAVYWEAPONS_BEAM_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.HEAVYWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.HEAVYWEAPONS_BEAM_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate GeneralWeapons_Laser_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'GeneralWeapons_LS_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_LaserPack.Inv_Laser_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'AssaultRifle_LS';
	Template.HideIfPurchased = 'AssaultRifle_MG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('LaserWeapons');
	Template.Requirements.RequiredEngineeringScore = 5;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.GENERALWEAPONS_LASER_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.GENERALWEAPONS_LASER_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

   if( default.GENERALWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.GENERALWEAPONS_LASER_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }

	return Template;
}

static function X2DataTemplate GeneralWeapons_Mag_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'GeneralWeapons_MG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "img:///UILibrary_LWSecondariesLWOTC.Inv_Mag_SawedOffShotgun";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'AssaultRifle_MG';
	Template.HideIfPurchased = 'AssaultRifle_CG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('MagnetizedWeapons');
	Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.GENERALWEAPONS_MAG_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.GENERALWEAPONS_MAG_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.GENERALWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.GENERALWEAPONS_MAG_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}


static function X2DataTemplate GeneralWeapons_Coil_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'GeneralWeapons_CG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'AssaultRifle_CG';
	Template.HideIfPurchased = 'AssaultRifle_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('CoilGuns');
	Template.Requirements.RequiredEngineeringScore = 15;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.GENERALWEAPONS_COIL_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.GENERALWEAPONS_COIL_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.GENERALWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.GENERALWEAPONS_COIL_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate GeneralWeapons_Beam_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate_LW', Template, 'GeneralWeapons_BM_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'AssaultRifle_CG';
	Template.HideIfPurchased = 'AssaultRifle_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('PlasmaRifle');
	Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.GENERALWEAPONS_BEAM_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.GENERALWEAPONS_BEAM_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.GENERALWEAPONS_MAG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.GENERALWEAPONS_BEAM_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}


static function X2DataTemplate Immolator_CV_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'Immolator_CV_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "img:///IRIClausImmolator.UI.Flamethrower_CV";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'LWImmollator_CV';
	Template.HideIfPurchased = 'LWImmollator_MG';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventOfficer');
	Template.Requirements.RequiredEngineeringScore = 5;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.IMMOLATOR_CV_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.IMMOLATOR_CV_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

   if( default.IMMOLATOR_CV_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.IMMOLATOR_CV_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }

	return Template;
}

static function X2DataTemplate Immolator_MG_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'Immolator_MG_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "IRIClausImmolator.Archetypes.WP_Immolator_MG";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'LWImmolator_MG';
	Template.HideIfPurchased = 'LWImmolator_BM';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventPurifier');
	Template.Requirements.RequiredEngineeringScore = 10;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.IMMOLATOR_MG_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.IMMOLATOR_MG_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.IMMOLATOR_MG_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.IMMOLATOR_MG_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}


static function X2DataTemplate Immolator_BM_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'Immolator_BM_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "img:///IRIClausImmolator.UI.Flamethrower_BM";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'LWImmolator_BM';
	//Template.HideIfPurchased = 'LWImmolator_T4';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyGatekeeper');
	Template.Requirements.RequiredEngineeringScore = 20;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.IMMOLATOR_BM_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.IMMOLATOR_BM_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.IMMOLATOR_BM_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.IMMOLATOR_BM_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate WristBlade_LS_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'WristBlade_LS_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "img:///IRI_Ripjack_LS.UI.laser_ripjack";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'WristBlade_LS';
	//Template.HideIfPurchased = 'LWImmolator_T4';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventStunLancer');
	Template.Requirements.RequiredEngineeringScore = 5;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.WRISTBLADE_LASER_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.WRISTBLADE_LASER_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.WRISTBLADE_LASER_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.WRISTBLADE_LASER_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}

static function X2DataTemplate WristBlade_LS_Schematic()
{
	local X2SchematicTemplate_LW Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2SchematicTemplate', Template, 'WristBlade_LS_Schematic');

	Template.ItemCat = 'weapon';
//BEGIN AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.strImage = "img:///IRI_Ripjack_LS.UI.laser_ripjack";
//END AUTOGENERATED CODE: Template Overrides 'AssaultRifle_MG_Schematic'
	Template.PointsToComplete = 0;
	Template.Tier = 1;
	Template.OnBuiltFn = class'X2Item_DefaultSchematics'.static.UpgradeItems;

	// Reference Item
	Template.ReferenceItemTemplate = 'WristBlade_LS';
	//Template.HideIfPurchased = 'LWImmolator_T4';

	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAdventStunLancer');
	Template.Requirements.RequiredEngineeringScore = 5;
	Template.Requirements.bVisibleIfPersonnelGatesNotMet = true;

	// Cost
	Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = default.WRISTBLADE_LASER_SUPPLYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Resources.ItemTemplateName = 'AlienAlloy';
    Resources.Quantity = default.WRISTBLADE_LASER_ALLOYCOST;
	Template.Cost.ResourceCosts.AddItem(Resources);

    if( default.WRISTBLADE_LASER_ELERIUMCOST > 0)
    {
        Resources.ItemTemplateName = 'EleriumDust';
        Resources.Quantity = default.WRISTBLADE_LASER_ELERIUMCOST;
        Template.Cost.ResourceCosts.AddItem(Resources);
    }


	return Template;
}