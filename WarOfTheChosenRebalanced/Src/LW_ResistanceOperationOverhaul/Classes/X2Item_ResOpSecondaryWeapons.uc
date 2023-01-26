class X2Item_ResOpSecondaryWeapons extends X2Item_ResOpPrimaryWeapons config(GameData_WeaponData);

var config int PISTOL_TLE_CONVENTIONAL_AIM;
var config int PISTOL_TLE_CONVENTIONAL_CRITCHANCE;
var config int PISTOL_TLE_CONVENTIONAL_ICLIPSIZE;

var config int PISTOL_TLE_MAGNETIC_AIM;
var config int PISTOL_TLE_MAGNETIC_CRITCHANCE;
var config int PISTOL_TLE_MAGNETIC_ICLIPSIZE;

var config int PISTOL_TLE_BEAM_AIM;
var config int PISTOL_TLE_BEAM_CRITCHANCE;
var config int PISTOL_TLE_BEAM_ICLIPSIZE;

var config int SWORD_TLE_CONVENTIONAL_AIM;
var config int SWORD_TLE_CONVENTIONAL_CRITCHANCE;
var config int SWORD_TLE_CONVENTIONAL_ICLIPSIZE;

var config int SWORD_TLE_MAGNETIC_AIM;
var config int SWORD_TLE_MAGNETIC_CRITCHANCE;
var config int SWORD_TLE_MAGNETIC_ICLIPSIZE;

var config int SWORD_TLE_BEAM_AIM;
var config int SWORD_TLE_BEAM_CRITCHANCE;
var config int SWORD_TLE_BEAM_ICLIPSIZE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;

	Weapons.AddItem(CreateTLE1Pistol('TLE_Pistol_CV_1',1));

	Weapons.AddItem(CreateTemplate_Pistol_Conventional_RO('Pistol_CV_1',1));
	Weapons.AddItem(CreateTemplate_Pistol_Conventional_RO('Pistol_CV_2',2));
	Weapons.AddItem(CreateTemplate_Pistol_Conventional_RO('Pistol_CV_3',3));

	Weapons.AddItem(CreateTemplate_Pistol_Laser('Pistol_LS_2',2));
	Weapons.AddItem(CreateTemplate_Pistol_Laser('Pistol_LS_3',3));
	Weapons.AddItem(CreateTemplate_Pistol_Laser('Pistol_LS_4',4));
	Weapons.AddItem(CreateTemplate_Pistol_Laser('Pistol_LS_5',5));

	Weapons.AddItem(CreateTemplate_Pistol_Magnetic_RO('Pistol_MG_2',2));
	Weapons.AddItem(CreateTemplate_Pistol_Magnetic_RO('Pistol_MG_3',3));
	Weapons.AddItem(CreateTemplate_Pistol_Magnetic_RO('Pistol_MG_4',4));
	Weapons.AddItem(CreateTemplate_Pistol_Magnetic_RO('Pistol_MG_5',5));

	//Weapons.AddItem(CreateTemplate_Pistol_Coil('Pistol_CG_2',2));
	Weapons.AddItem(CreateTemplate_Pistol_Coil('Pistol_CG_3',3));
	Weapons.AddItem(CreateTemplate_Pistol_Coil('Pistol_CG_4',4));
	Weapons.AddItem(CreateTemplate_Pistol_Coil('Pistol_CG_5',5));

	//Weapons.AddItem(CreateTemplate_Pistol_Beam_RO('Pistol_BM_2',2));
	Weapons.AddItem(CreateTemplate_Pistol_Beam_RO('Pistol_BM_3',3));
	Weapons.AddItem(CreateTemplate_Pistol_Beam_RO('Pistol_BM_4',4));
	Weapons.AddItem(CreateTemplate_Pistol_Beam_RO('Pistol_BM_5',5));

	Weapons.AddItem(CreateTLE2Pistol('TLE_Pistol_MG_2',2));
	Weapons.AddItem(CreateTLE2Pistol('TLE_Pistol_MG_3',3));
	Weapons.AddItem(CreateTLE2Pistol('TLE_Pistol_MG_4',4));
	Weapons.AddItem(CreateTLE2Pistol('TLE_Pistol_MG_5',5));

	Weapons.AddItem(CreateTLE3Pistol('TLE_Pistol_BM_3',3));
	Weapons.AddItem(CreateTLE3Pistol('TLE_Pistol_BM_4',4));
	Weapons.AddItem(CreateTLE3Pistol('TLE_Pistol_BM_5',5));

	Weapons.AddItem(CreateTemplate_Sidearm_Conventional('Sidearm_CV_1',1));
	Weapons.AddItem(CreateTemplate_Sidearm_Conventional('Sidearm_CV_2',2));
	Weapons.AddItem(CreateTemplate_Sidearm_Conventional('Sidearm_CV_3',3));

	Weapons.AddItem(CreateTemplate_Sidearm_Laser('Sidearm_LS_2',2));
	Weapons.AddItem(CreateTemplate_Sidearm_Laser('Sidearm_LS_3',3));
	Weapons.AddItem(CreateTemplate_Sidearm_Laser('Sidearm_LS_4',4));
	Weapons.AddItem(CreateTemplate_Sidearm_Laser('Sidearm_LS_5',5));

	Weapons.AddItem(CreateTemplate_Sidearm_Magnetic('Sidearm_MG_2',2));
	Weapons.AddItem(CreateTemplate_Sidearm_Magnetic('Sidearm_MG_3',3));
	Weapons.AddItem(CreateTemplate_Sidearm_Magnetic('Sidearm_MG_4',4));
	Weapons.AddItem(CreateTemplate_Sidearm_Magnetic('Sidearm_MG_5',5));

	//Weapons.AddItem(CreateTemplate_Sidearm_Coil('Sidearm_CG_2',2));
	Weapons.AddItem(CreateTemplate_Sidearm_Coil('Sidearm_CG_3',3));
	Weapons.AddItem(CreateTemplate_Sidearm_Coil('Sidearm_CG_4',4));
	Weapons.AddItem(CreateTemplate_Sidearm_Coil('Sidearm_CG_5',5));

	//Weapons.AddItem(CreateTemplate_Sidearm_Beam('Sidearm_BM_2',2));
	Weapons.AddItem(CreateTemplate_Sidearm_Beam('Sidearm_BM_3',3));
	Weapons.AddItem(CreateTemplate_Sidearm_Beam('Sidearm_BM_4',4));
	Weapons.AddItem(CreateTemplate_Sidearm_Beam('Sidearm_BM_5',5));

	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Conventional('SawedOffShotgun_CV_1',1));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Conventional('SawedOffShotgun_CV_2',2));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Conventional('SawedOffShotgun_CV_3',3));

	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Laser('SawedOffShotgun_LS_2',2));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Laser('SawedOffShotgun_LS_3',3));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Laser('SawedOffShotgun_LS_4',4));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Laser('SawedOffShotgun_LS_5',5));

	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Magnetic('SawedOffShotgun_MG_2',2));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Magnetic('SawedOffShotgun_MG_3',3));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Magnetic('SawedOffShotgun_MG_4',4));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Magnetic('SawedOffShotgun_MG_5',5));

	//Weapons.AddItem(CreateTemplate_SawedOffShotgun_Coil('SawedOffShotgun_CG_2',2));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Coil('SawedOffShotgun_CG_3',3));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Coil('SawedOffShotgun_CG_4',4));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Coil('SawedOffShotgun_CG_5',5));

	//Weapons.AddItem(CreateTemplate_SawedOffShotgun_Beam('SawedOffShotgun_BM_2',2));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Beam('SawedOffShotgun_BM_3',3));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Beam('SawedOffShotgun_BM_4',4));
	Weapons.AddItem(CreateTemplate_SawedOffShotgun_Beam('SawedOffShotgun_BM_5',5));

	Weapons.AddItem(CreateTemplate_CombatKnife_Conventional('CombatKnife_CV_1',1));
	Weapons.AddItem(CreateTemplate_CombatKnife_Conventional('CombatKnife_CV_2',2));
	Weapons.AddItem(CreateTemplate_CombatKnife_Conventional('CombatKnife_CV_3',3));

	Weapons.AddItem(CreateTemplate_CombatKnife_Laser('CombatKnife_LS_2',2));
	Weapons.AddItem(CreateTemplate_CombatKnife_Laser('CombatKnife_LS_3',3));
	Weapons.AddItem(CreateTemplate_CombatKnife_Laser('CombatKnife_LS_4',4));
	Weapons.AddItem(CreateTemplate_CombatKnife_Laser('CombatKnife_LS_5',5));

	Weapons.AddItem(CreateTemplate_CombatKnife_Magnetic('CombatKnife_MG_2',2));
	Weapons.AddItem(CreateTemplate_CombatKnife_Magnetic('CombatKnife_MG_3',3));
	Weapons.AddItem(CreateTemplate_CombatKnife_Magnetic('CombatKnife_MG_4',4));
	Weapons.AddItem(CreateTemplate_CombatKnife_Magnetic('CombatKnife_MG_5',5));

	//Weapons.AddItem(CreateTemplate_CombatKnife_Coil('CombatKnife_CG_2',2));
	Weapons.AddItem(CreateTemplate_CombatKnife_Coil('CombatKnife_CG_3',3));
	Weapons.AddItem(CreateTemplate_CombatKnife_Coil('CombatKnife_CG_4',4));
	Weapons.AddItem(CreateTemplate_CombatKnife_Coil('CombatKnife_CG_5',5));

	//Weapons.AddItem(CreateTemplate_CombatKnife_Beam('CombatKnife_BM_2',2));
	Weapons.AddItem(CreateTemplate_CombatKnife_Beam('CombatKnife_BM_3',3));
	Weapons.AddItem(CreateTemplate_CombatKnife_Beam('CombatKnife_BM_4',4));
	Weapons.AddItem(CreateTemplate_CombatKnife_Beam('CombatKnife_BM_5',5));

	Weapons.AddItem(CreateTemplate_Sword_Conventional_RO('Sword_CV_1',1));
	Weapons.AddItem(CreateTemplate_Sword_Conventional_RO('Sword_CV_2',2));
	Weapons.AddItem(CreateTemplate_Sword_Conventional_RO('Sword_CV_3',3));

	Weapons.AddItem(CreateTemplate_Sword_Laser('Sword_LS_2',2));
	Weapons.AddItem(CreateTemplate_Sword_Laser('Sword_LS_3',3));
	Weapons.AddItem(CreateTemplate_Sword_Laser('Sword_LS_4',4));
	Weapons.AddItem(CreateTemplate_Sword_Laser('Sword_LS_5',5));

	Weapons.AddItem(CreateTemplate_Sword_Magnetic_RO('Sword_MG_2',2));
	Weapons.AddItem(CreateTemplate_Sword_Magnetic_RO('Sword_MG_3',3));
	Weapons.AddItem(CreateTemplate_Sword_Magnetic_RO('Sword_MG_4',4));
	Weapons.AddItem(CreateTemplate_Sword_Magnetic_RO('Sword_MG_5',5));

	//Weapons.AddItem(CreateTemplate_Sword_Coil('Sword_CG_2',2));
	Weapons.AddItem(CreateTemplate_Sword_Coil('Sword_CG_3',3));
	Weapons.AddItem(CreateTemplate_Sword_Coil('Sword_CG_4',4));
	Weapons.AddItem(CreateTemplate_Sword_Coil('Sword_CG_5',5));

	//Weapons.AddItem(CreateTemplate_Sword_Beam_RO('Sword_BM_2',2));
	Weapons.AddItem(CreateTemplate_Sword_Beam_RO('Sword_BM_3',3));
	Weapons.AddItem(CreateTemplate_Sword_Beam_RO('Sword_BM_4',4));
	Weapons.AddItem(CreateTemplate_Sword_Beam_RO('Sword_BM_5',5));

	Weapons.AddItem(CreateTLE1Sword('TLE_Sword_CV_1',1));

	Weapons.AddItem(CreateTLE2Sword('TLE_Sword_MG_2',2));
	Weapons.AddItem(CreateTLE2Sword('TLE_Sword_MG_3',3));
	Weapons.AddItem(CreateTLE2Sword('TLE_Sword_MG_4',4));
	Weapons.AddItem(CreateTLE2Sword('TLE_Sword_MG_5',5));

	Weapons.AddItem(CreateTLE3Sword('TLE_Sword_BM_3',3));
	Weapons.AddItem(CreateTLE3Sword('TLE_Sword_BM_4',4));
	Weapons.AddItem(CreateTLE3Sword('TLE_Sword_BM_5',5));


	Weapons.AddItem(CreateTemplate_PsiAmp_Frayer('Psiamp_Frayer_1',1));
	Weapons.AddItem(CreateTemplate_PsiAmp_Frayer('Psiamp_Frayer_2',2));
	Weapons.AddItem(CreateTemplate_PsiAmp_Frayer('Psiamp_Frayer_3',3));
	Weapons.AddItem(CreateTemplate_PsiAmp_Frayer('Psiamp_Frayer_4',4));
	Weapons.AddItem(CreateTemplate_PsiAmp_Frayer('Psiamp_Frayer_5',5));

	// Weapons.AddItem(CreateTemplate_PsiAmp_Meteoric('Psiamp_Meteoric_1',1));
	// Weapons.AddItem(CreateTemplate_PsiAmp_Meteoric('Psiamp_Meteoric_2',2));
	Weapons.AddItem(CreateTemplate_PsiAmp_Meteoric('Psiamp_Meteoric_3',3));
	Weapons.AddItem(CreateTemplate_PsiAmp_Meteoric('Psiamp_Meteoric_4',4));
	Weapons.AddItem(CreateTemplate_PsiAmp_Meteoric('Psiamp_Meteoric_5',5));

	Weapons.AddItem(CreateTemplate_PsiAmp_Madman('Psiamp_Madman_3',3));
	Weapons.AddItem(CreateTemplate_PsiAmp_Madman('Psiamp_Madman_4',4));
	Weapons.AddItem(CreateTemplate_PsiAmp_Madman('Psiamp_Madman_5',5));

	Weapons.AddItem(CreateTemplate_PsiAmp_Puppeteer('Psiamp_Puppeteer_5',5));

	Weapons.AddItem(Create_IRI_RocketLauncher_Standard('IRI_RocketLauncher_Standard_2',2));
	Weapons.AddItem(Create_IRI_RocketLauncher_Standard('IRI_RocketLauncher_Standard_3',3));
	Weapons.AddItem(Create_IRI_RocketLauncher_Standard('IRI_RocketLauncher_Standard_4',4));
	Weapons.AddItem(Create_IRI_RocketLauncher_Standard('IRI_RocketLauncher_Standard_5',5));

	Weapons.AddItem(Create_IRI_RocketLauncher_Shredder('IRI_RocketLauncher_Shredder_2',2));
	Weapons.AddItem(Create_IRI_RocketLauncher_Shredder('IRI_RocketLauncher_Shredder_3',3));
	Weapons.AddItem(Create_IRI_RocketLauncher_Shredder('IRI_RocketLauncher_Shredder_4',4));
	Weapons.AddItem(Create_IRI_RocketLauncher_Shredder('IRI_RocketLauncher_Shredder_5',5));
	//Weapons.AddItem(Create_IRI_RocketLauncher_Shredder('IRI_RocketLauncher_Shredder_5',5));
	Weapons.AddItem(Create_IRI_RocketLauncher_Ejector('IRI_RocketLauncher_Ejector_3',3));
	Weapons.AddItem(Create_IRI_RocketLauncher_Ejector('IRI_RocketLauncher_Ejector_4',4));
	Weapons.AddItem(Create_IRI_RocketLauncher_Ejector('IRI_RocketLauncher_Ejector_5',5));


	Weapons.AddItem(CreateTemplate_Wristblade_Laser('Wristblade_LS_2',2));
	Weapons.AddItem(CreateTemplate_Wristblade_Laser('Wristblade_LS_3',3));
	Weapons.AddItem(CreateTemplate_Wristblade_Laser('Wristblade_LS_4',4));
	Weapons.AddItem(CreateTemplate_Wristblade_Laser('Wristblade_LS_5',5));

	Weapons.AddItem(CreateTemplate_Wristblade_Magnetic('Wristblade_MG_2',2));
	Weapons.AddItem(CreateTemplate_Wristblade_Magnetic('Wristblade_MG_3',3));
	Weapons.AddItem(CreateTemplate_Wristblade_Magnetic('Wristblade_MG_4',4));
	Weapons.AddItem(CreateTemplate_Wristblade_Magnetic('Wristblade_MG_5',5));

	//Weapons.AddItem(CreateTemplate_Wristblade_Coil('Wristblade_CG_2',2));
	Weapons.AddItem(CreateTemplate_Wristblade_Coil('Wristblade_CG_3',3));
	Weapons.AddItem(CreateTemplate_Wristblade_Coil('Wristblade_CG_4',4));
	Weapons.AddItem(CreateTemplate_Wristblade_Coil('Wristblade_CG_5',5));

	//Weapons.AddItem(CreateTemplate_Wristblade_Beam('Wristblade_BM_2',2));
	Weapons.AddItem(CreateTemplate_Wristblade_Beam('Wristblade_BM_3',3));
	Weapons.AddItem(CreateTemplate_Wristblade_Beam('Wristblade_BM_4',4));
	Weapons.AddItem(CreateTemplate_Wristblade_Beam('Wristblade_BM_5',5));

	Weapons.AddItem(CreateTemplate_ThrowingKnife_Magnetic('ThrowingKnife_MG_2',2));
	Weapons.AddItem(CreateTemplate_ThrowingKnife_Magnetic('ThrowingKnife_MG_3',3));
	Weapons.AddItem(CreateTemplate_ThrowingKnife_Magnetic('ThrowingKnife_MG_4',4));
	Weapons.AddItem(CreateTemplate_ThrowingKnife_Magnetic('ThrowingKnife_MG_5',5));

	Weapons.AddItem(CreateTemplate_ThrowingKnife_Beam('ThrowingKnife_BM_3',3));
	Weapons.AddItem(CreateTemplate_ThrowingKnife_Beam('ThrowingKnife_BM_4',4));
	Weapons.AddItem(CreateTemplate_ThrowingKnife_Beam('ThrowingKnife_BM_5',5));

	Weapons.AddItem(CreateTemplate_GremlinDrone_Magnetic_RO('Gremlin_MG_2',2));
	Weapons.AddItem(CreateTemplate_GremlinDrone_Magnetic_RO('Gremlin_MG_3',3));
	Weapons.AddItem(CreateTemplate_GremlinDrone_Magnetic_RO('Gremlin_MG_4',4));
	Weapons.AddItem(CreateTemplate_GremlinDrone_Magnetic_RO('Gremlin_MG_5',5));

	//Weapons.AddItem(CreateTemplate_GremlinDrone_Beam_RO('Gremlin_BM_2',2));
	Weapons.AddItem(CreateTemplate_GremlinDrone_Beam_RO('Gremlin_BM_3',3));
	Weapons.AddItem(CreateTemplate_GremlinDrone_Beam_RO('Gremlin_BM_4',4));
	Weapons.AddItem(CreateTemplate_GremlinDrone_Beam_RO('Gremlin_BM_5',5));


	return Weapons;
}

struct PsiAmpExtraDamage{
	var name Tag;
	var float DamageMod;
	var float CritDamageMod;
	var float BonusSpread;
	var bool FlatDamage;

	structdefaultproperties{
		CritDamageMod=0.5f
	}
};
var config array<GauntletExtraDamage> PSIAMP_EXTRADAMAGE_TAGS;


static function array<WeaponDamageValue> GetPsiAmpWeaponDamage(int WeaponTier){
    local WeaponDamageValue WeaponDamage;
    local float FloatBaseDamage;
    local int IntBaseDamage;
	local array<WeaponDamageValue> ExtraDamages;
	local GauntletExtraDamage TagValue;

	foreach default.PSIAMP_EXTRADAMAGE_TAGS(TagValue){
		FloatBaseDamage = WeaponTier  * TagValue.DamageMod;
		IntBaseDamage = int(FloatBaseDamage);
		
		WeaponDamage.Tag = TagValue.Tag;
		WeaponDamage.Damage = IntBaseDamage;
		WeaponDamage.Spread = Max(1 + int(FloatBaseDamage / 5) + TagValue.BonusSpread,0);
		WeaponDamage.PlusOne = int((FloatBaseDamage - IntBaseDamage) * 100);
		WeaponDamage.Crit = int(FloatBaseDamage * TagValue.CritDamageMod);
		WeaponDamage.DamageType = 'Psi';
		ExtraDamages.AddItem(WeaponDamage);

	}


    return ExtraDamages;
}


static function X2DataTemplate CreateTLE1Pistol(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Pistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier, 0.75f);
	Template.Aim = default.PISTOL_TLE_CONVENTIONAL_AIM;
	Template.CritChance = default.PISTOL_TLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.PISTOL_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.InfiniteAmmo = true;
	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
		Template.Abilities.AddItem('PistolStandardShot');
	// Template.Abilities.AddItem('PistolOverwatch');
	// Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotConvA');	

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Pistol.WP_TLE1Pistol";

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Pistol_Conventional_RO(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.ConvPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.PISTOL_CONVENTIONAL_AIM;
	Template.CritChance = default.PISTOL_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.PISTOL_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 1;

	Template.InfiniteAmmo = true;
	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
		Template.Abilities.AddItem('PistolStandardShot');

	// Template.Abilities.AddItem('PistolOverwatch');
	// Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.Abilities.AddItem('Fatality_LW');
	Template.Abilities.AddItem('QuickDraw');
	Template.Abilities.AddItem('Takethis');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotConvA');	
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_CV.WP_Pistol_CV";

	Template.iPhysicsImpulse = 5;
	
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Pistol_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_LW_LaserPack.Inv_Laser_Pistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_LaserWeapons'.default.MIDSHORT_LASER_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f);
	Template.Aim = class'X2Item_LWPistol'.default.LWPistol_LASER_AIM;
	Template.CritChance = class'X2Item_LWPistol'.default.LWPistol_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWPistol'.default.LWPistol_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWPistol'.default.LWPistol_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWPistol'.default.LWPistol_LASER_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 0;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	Template.Abilities.AddItem('TakeThis');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('Fatality_LW');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWPistol_LS.Archetype.WP_Pistol_LS";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Sidearms_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Pistol_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';  

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Pistol_Magnetic_RO(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = Tier;

	Template.RangeAccuracy = default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.PISTOL_MAGNETIC_AIM;
	Template.CritChance = default.PISTOL_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.PISTOL_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	// Template.Abilities.AddItem('PistolOverwatch');
	// Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('Takethis');
	Template.Abilities.AddItem('quickdraw');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_MG.WP_Pistol_MG";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Pistol_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Pistol_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Pistol_Coil(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_LW_Overhaul.InventoryArt.Inv_Coil_Pistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_Coilguns'.default.MIDSHORT_COIL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f);
	Template.Aim = class'X2Item_LWPistol'.default.LWPistol_COIL_AIM;
	Template.CritChance = class'X2Item_LWPistol'.default.LWPistol_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWPistol'.default.LWPistol_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWPistol'.default.LWPistol_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWPistol'.default.LWPistol_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	// PistolStandardShot is added by LWTemplateMods
	Template.Abilities.AddItem('PistolStandardShot');
	//Template.Abilities.AddItem('PistolOverwatch');
	//Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('TakeThis');
	Template.Abilities.AddItem('Fatality_LW');
	Template.Abilities.AddItem('Quickdraw');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWPistol_CG.Archetypes.WP_Pistol_CG";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Sidearms_CG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Pistol_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';  

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Pistol_Beam_RO(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPistol";
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = Tier;

	Template.RangeAccuracy = default.SHORT_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f);
	Template.Aim = default.PISTOL_BEAM_AIM;
	Template.CritChance = default.PISTOL_BEAM_CRITCHANCE;
	Template.iClipSize = default.PISTOL_BEAM_ICLIPSIZE;
	Template.iSoundRange = default.PISTOL_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.PISTOL_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PlasmaPistolShot');
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotBeamA');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Pistol_BM.WP_Pistol_BM";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Pistol_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Pistol_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;
	
	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTLE2Pistol(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Pistol_Laser";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,,0.75f);
	Template.Aim = default.PISTOL_TLE_MAGNETIC_AIM;
	Template.CritChance = default.PISTOL_TLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.PISTOL_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Pistol.WP_TLE2Pistol";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Pistol_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Pistol_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTLE3Pistol(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'pistol';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Pistol_Plasma";
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,,0.75f,,1);
	Template.Aim = default.PISTOL_TLE_BEAM_AIM;
	Template.CritChance = default.PISTOL_TLE_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.PISTOL_BEAM_IENVIRONMENTDAMAGE;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotBeamA');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Pistol.WP_TLE3Pistol";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Pistol_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Pistol_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}


static function X2DataTemplate CreateTemplate_Sidearm_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sidearm';
	Template.WeaponTech = GetWeaponTech(Tier);
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_CV'
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvTPistol_Base";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_CV'
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.5f,1.0f);
	Template.Aim = class'X2Item_XpackWeapons'.default.SIDEARM_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SIDEARM_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_XpackWeapons'.default.SIDEARM_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SIDEARM_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SIDEARM_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 0;

	Template.InfiniteAmmo = true;
	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	// Template.Abilities.AddItem('PistolOverwatch');
	// Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('FanFire');
	Template.Abilities.AddItem('SprayAndPray');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotConvA');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarAutoPistol_CV.WP_TemplarAutoPistol_CV";

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	Template.bHideClipSizeStat = true;

	return Template;
}


static function X2DataTemplate CreateTemplate_Sidearm_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sidearm';
	Template.WeaponTech = GetWeaponTech(Tier);
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_MG'
	Template.strImage = "img:///IRI_AutoPistol_LS.Sidearm_LS_Inv";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_MG'
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.5f,1.0f);
	Template.Aim = class'X2Item_FactionWeapons'.default.SIDEARM_LASER_AIM;
	Template.CritChance = class'X2Item_FactionWeapons'.default.SIDEARM_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_FactionWeapons'.default.SIDEARM_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_FactionWeapons'.default.SIDEARM_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_FactionWeapons'.default.SIDEARM_LASER_IENVIRONMENTDAMAGE;

//	Template.UIArmoryCameraPointTag = "UIPawnLocation_WeaponUpgrade_Shotgun";
	Template.NumUpgradeSlots = 0;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	// Template.Abilities.AddItem('PistolOverwatch');
	// Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('LightningHands');
	Template.Abilities.AddItem('SprayAndPray');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotBeam');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "IRI_AutoPistol_CG.Archetypes.WP_AutoPistol_LS";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Sidearms_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Sidearm_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}


static function X2DataTemplate CreateTemplate_Sidearm_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sidearm';
	Template.BaseDamage = GetWeaponDamage(Tier,0.5f,1.0f);
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_MG'
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_MagTPistol_Base";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_MG'
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.5f,1.0f);
	Template.Aim = class'X2Item_XpackWeapons'.default.SIDEARM_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SIDEARM_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_XpackWeapons'.default.SIDEARM_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SIDEARM_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SIDEARM_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 0;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	// Template.Abilities.AddItem('PistolOverwatch');
	// Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('FanFire');
	Template.Abilities.AddItem('SprayAndPray');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMagA');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarAutoPistol_MG.WP_TemplarAutoPistol_MG";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Sidearm_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Sidearm_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}

static function X2DataTemplate CreateTemplate_Sidearm_Coil(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sidearm';
	Template.WeaponTech = GetWeaponTech(Tier);
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_MG'
	Template.strImage = "img:///IRI_AutoPistol_CG.CoilAutopistol_base";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_MG'
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.5f,1.0f);
	Template.Aim = class'X2Item_FactionWeapons'.default.SIDEARM_COIL_AIM;
	Template.CritChance = class'X2Item_FactionWeapons'.default.SIDEARM_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_FactionWeapons'.default.SIDEARM_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_FactionWeapons'.default.SIDEARM_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_FactionWeapons'.default.SIDEARM_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 0;
//	Template.UIArmoryCameraPointTag = "UIPawnLocation_WeaponUpgrade_Shotgun";

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	// Template.Abilities.AddItem('PistolOverwatch');
	// Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('FanFire');
	Template.Abilities.AddItem('SprayAndPray');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotMag');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "IRI_AutoPistol_CG.Archetypes.WP_AutoPistol_CG";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Sidearms_CG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Sidearm_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}


static function X2DataTemplate CreateTemplate_Sidearm_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Pistol";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sidearm';
	Template.WeaponTech = GetWeaponTech(Tier);
//BEGIN AUTOGENERATED CODE: Template Overrides 'Sidearm_BM'
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_BeamTPistol_Base";
//END AUTOGENERATED CODE: Template Overrides 'Sidearm_BM'
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,1.0f);
	Template.Aim = class'X2Item_XpackWeapons'.default.SIDEARM_BEAM_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SIDEARM_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_XpackWeapons'.default.SIDEARM_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SIDEARM_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SIDEARM_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 0;

	Template.OverwatchActionPoint = class'X2CharacterTemplateManager'.default.PistolOverwatchReserveActionPoint;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('PistolStandardShot');
	Template.Abilities.AddItem('PistolOverwatch');
	Template.Abilities.AddItem('PistolOverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('LightningHands');
	Template.Abilities.AddItem('SprayAndPray');

	Template.SetAnimationNameForAbility('FanFire', 'FF_FireMultiShotBeamA');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarAutoPistol_BM.WP_TemplarAutoPistol_BM";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Sidearm_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Sidearm_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	Template.bHideClipSizeStat = true;

	return Template;
}


static function X2DataTemplate CreateTemplate_SawedOffShotgun_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sawedoffshotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_CV_UIImage; 
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.Tier = Tier;
	Template.RangeAccuracy = class'X2Item_LWSawedOffShotgun'.default.SAWED_OFF_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.iRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_CONVENTIONAL_RANGE;
	Template.NumUpgradeSlots = 1;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LW_SawedoffShotgunLWOTC.Archetypes.WP_SawedOffShotgun_CV";

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	
	Template.Abilities.AddItem('PointBlank');
	Template.Abilities.AddItem('BothBarrels');
	Template.Abilities.AddItem('SawedOffReload');

	Template.DamageTypeTemplateName = 'Electrical';
	
	return Template;
}

static function X2DataTemplate CreateTemplate_SawedOffShotgun_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sawedoffshotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_LS_UIImage; 
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.Tier = Tier;
	Template.RangeAccuracy = class'X2Item_LWSawedOffShotgun'.default.SAWED_OFF_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.5f);
	Template.Aim = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_LASER_AIM;
	Template.CritChance = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_LASER_IENVIRONMENTDAMAGE;
	Template.iRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_LASER_RANGE;
	Template.NumUpgradeSlots = 1;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LW_SawedoffShotgunLWOTC.Archetypes.WP_SawedOffShotgun_CV";

	Template.iPhysicsImpulse = 5;

	
	Template.CreatorTemplateName = 'Sidearms_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SawedoffShotgun_CV'; // Which item this will be upgraded from

	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	
	Template.Abilities.AddItem('BothBarrels');
	Template.Abilities.AddItem('HotLoadAmmo');
	//Template.Abilities.AddItem('SawedOffReload');

	Template.DamageTypeTemplateName = 'Electrical';
	
	return Template;
}

static function X2DataTemplate CreateTemplate_SawedOffShotgun_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'sawedoffshotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_MG_UIImage; 
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_LWSawedOffShotgun'.default.SAWED_OFF_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.5f);
	Template.Aim = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_MAGNETIC_RANGE;
	Template.NumUpgradeSlots = 1;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LW_SawedoffShotgunLWOTC.Archetypes.WP_SawedOffShotgun_MG";

	Template.iPhysicsImpulse = 5;
	
	Template.CreatorTemplateName = 'Sidearms_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SawedoffShotgun_LS'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.Abilities.AddItem('PointBlank');
	Template.Abilities.AddItem('SawedOffReload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.DamageTypeTemplateName = 'Electrical';

	return Template;
}


static function X2DataTemplate CreateTemplate_SawedOffShotgun_Coil(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sawedoffshotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_CG_UIImage; 
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.Tier = Tier;
	Template.RangeAccuracy = class'X2Item_LWSawedOffShotgun'.default.SAWED_OFF_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_COIL_AIM;
	Template.CritChance = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_COIL_IENVIRONMENTDAMAGE;
	Template.iRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_COIL_RANGE;
	Template.NumUpgradeSlots = 1;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LW_SawedoffShotgunLWOTC.Archetypes.WP_SawedOffShotgun_CV";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Sidearms_CG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SawedoffShotgun_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;
	
	Template.Abilities.AddItem('PointBlank');
	Template.Abilities.AddItem('SawedOffReload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.DamageTypeTemplateName = 'Electrical';
	
	return Template;
}


static function X2DataTemplate CreateTemplate_SawedOffShotgun_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'sawedoffshotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_BM_UIImage; 
	Template.EquipSound = "Secondary_Weapon_Equip_Beam";
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_LWSawedOffShotgun'.default.SAWED_OFF_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.5f);
	Template.Aim = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_BEAM_AIM;
	Template.CritChance = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_BEAM_IENVIRONMENTDAMAGE;
	Template.iRange = class'X2Item_LWSawedOffShotgun'.default.SawedOffShotgun_BEAM_RANGE;
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LW_SawedoffShotgunLWOTC.Archetypes.WP_SawedOffShotgun_BM";

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Sidearms_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SawedoffShotgun_CG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;
	Template.InfiniteAmmo = true;

	Template.Abilities.AddItem('PointBlank');
	//Template.Abilities.AddItem('SawedOffReload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.DamageTypeTemplateName = 'Electrical';

	return Template;
}


static function X2DataTemplate CreateTemplate_CombatKnife_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'combatknife';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = class'X2Item_LWCombatKnife'.default.CombatKnife_CV_UIImage; 
	//Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.Sword"; 
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.Tier = Tier;
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_LWCombatKnife'.default.CombatKnife_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_LWCombatKnife'.default.CombatKnife_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWCombatKnife'.default.CombatKnife_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWCombatKnife'.default.CombatKnife_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWCombatKnife'.default.CombatKnife_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.bHideClipSizeStat = true;
	Template.InfiniteAmmo = true;
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LW_CombatKnifeLWOTC.Archetypes.WP_CombatKnife_CV";

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	
	Template.DamageTypeTemplateName = 'Melee';

	Template.Abilities.AddItem('KnifeFighter');
	Template.Abilities.AddItem('SlashAndDashRs_LW');
	//Template.Abilities.AddItem('Bladestorm');

	
	return Template;
}


static function X2DataTemplate CreateTemplate_CombatKnife_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'combatknife';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.EquipSound = "Sword_Equip_Beam";
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_LWCombatKnife'.default.CombatKnife_LASER_AIM;
	Template.CritChance = class'X2Item_LWCombatKnife'.default.CombatKnife_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWCombatKnife'.default.CombatKnife_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWCombatKnife'.default.CombatKnife_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWCombatKnife'.default.CombatKnife_LASER_IENVIRONMENTDAMAGE;
	Template.bHideClipSizeStat = true;
	Template.InfiniteAmmo = true;
	
	
	Template.GameArchetype = "LW_CombatKnifeLWOTC.Archetypes.WP_CombatKnife_CV";

	Template.CreatorTemplateName = 'CombatKnife_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'CombatKnife_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	Template.Abilities.AddItem('KnifeFighter');
	Template.Abilities.AddItem('DisarmingStrike_LW');

	return Template;
}


static function X2DataTemplate CreateTemplate_CombatKnife_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'combatknife';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = class'X2Item_LWCombatKnife'.default.CombatKnife_MG_UIImage; 
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_LWCombatKnife'.default.CombatKnife_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_LWCombatKnife'.default.CombatKnife_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWCombatKnife'.default.CombatKnife_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWCombatKnife'.default.CombatKnife_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWCombatKnife'.default.CombatKnife_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.bHideClipSizeStat = true;
	Template.InfiniteAmmo = true;

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, default.RANGERSWORD_MAGNETIC_STUNCHANCE, false));
	Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , default.RANGERSWORD_MAGNETIC_STUNCHANCE, , , "%");

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LW_CombatKnifeLWOTC.Archetypes.WP_CombatKnife_MG";
	
	Template.CreatorTemplateName = 'CombatKnife_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'CombatKnife_CV'; // Which item this will be upgraded from

	Template.Abilities.AddItem('KnifeFighter');
	Template.Abilities.AddItem('QuickSlash_LW');
	Template.Abilities.AddItem('Combatives');

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}

static function X2DataTemplate CreateTemplate_CombatKnife_Coil(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'combatknife';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.EquipSound = "Sword_Equip_Beam";
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_LWCombatKnife'.default.CombatKnife_COIL_AIM;
	Template.CritChance = class'X2Item_LWCombatKnife'.default.CombatKnife_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWCombatKnife'.default.CombatKnife_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWCombatKnife'.default.CombatKnife_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWCombatKnife'.default.CombatKnife_COIL_IENVIRONMENTDAMAGE;
	Template.bHideClipSizeStat = true;
	Template.InfiniteAmmo = true;
	
	
	Template.GameArchetype = "LW_CombatKnifeLWOTC.Archetypes.WP_CombatKnife_CV";

	Template.CreatorTemplateName = 'CombatKnife_CG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'CombatKnife_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;
	Template.Abilities.AddItem('KnifeFighter');
	Template.Abilities.AddItem('SlashAndDashRs_LW');

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}


static function X2DataTemplate CreateTemplate_CombatKnife_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'combatknife';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = class'X2Item_LWCombatKnife'.default.CombatKnife_BM_UIImage; 
	Template.EquipSound = "Sword_Equip_Beam";
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f);
	Template.Aim = class'X2Item_LWCombatKnife'.default.CombatKnife_BEAM_AIM;
	Template.CritChance = class'X2Item_LWCombatKnife'.default.CombatKnife_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_LWCombatKnife'.default.CombatKnife_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LWCombatKnife'.default.CombatKnife_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWCombatKnife'.default.CombatKnife_BEAM_IENVIRONMENTDAMAGE;
	Template.bHideClipSizeStat = true;
	Template.InfiniteAmmo = true;
	
	Template.Abilities.AddItem('SlashAndDashRs_LW');
	Template.Abilities.AddItem('Bladestorm');

	Template.GameArchetype = "LW_CombatKnifeLWOTC.Archetypes.WP_CombatKnife_CV";

	Template.CreatorTemplateName = 'CombatKnife_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'CombatKnife_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}


static function X2DataTemplate CreateTemplate_Sword_Conventional_RO(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.Sword";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sword_CV.WP_Sword_CV";
	Template.AddDefaultAttachment('Sheath', "ConvSword.Meshes.SM_ConvSword_Sheath", true);
	Template.Tier = Tier;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.RANGERSWORD_CONVENTIONAL_AIM;
	Template.CritChance = default.RANGERSWORD_CONVENTIONAL_CRITCHANCE;
	Template.iSoundRange = default.RANGERSWORD_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.RANGERSWORD_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';
	
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}

static function X2DataTemplate CreateTemplate_Sword_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///IRI_Sword_LS.UI.Inv_Laser_Sword";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "IRI_Sword_LS.Archetypes.WP_Sword_LS";
	Template.Tier = Tier;


	Template.CreatorTemplateName = 'Sword_LS_Schematic';

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_LWSwords'.default.RANGERSWORD_LASER_AIM;
	Template.CritChance = class'X2Item_LWSwords'.default.RANGERSWORD_LASER_CRITCHANCE;
	Template.iSoundRange = class'X2Item_LWSwords'.default.RANGERSWORD_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWSwords'.default.RANGERSWORD_LASER_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';
	
	return Template;
}



static function X2DataTemplate CreateTemplate_Sword_Magnetic_RO(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagSword";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sword_MG.WP_Sword_MG";
	Template.AddDefaultAttachment('R_Back', "MagSword.Meshes.SM_MagSword_Sheath", false);
	Template.Tier = Tier;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.RANGERSWORD_MAGNETIC_AIM;
	Template.CritChance = default.RANGERSWORD_MAGNETIC_CRITCHANCE;
	Template.iSoundRange = default.RANGERSWORD_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.RANGERSWORD_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';


	Template.CreatorTemplateName = 'Sword_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Sword_CV'; // Which item this will be upgraded from
	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, default.RANGERSWORD_MAGNETIC_STUNCHANCE, false));
	Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , default.RANGERSWORD_MAGNETIC_STUNCHANCE, , , "%");

	return Template;
}

static function X2DataTemplate CreateTemplate_Sword_Coil(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///IRI_Sword_CG.UI.Coil_Sword";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sword_BM.WP_Sword_BM";
	Template.Tier = Tier;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_LWSwords'.default.RANGERSWORD_COIL_AIM;
	Template.CritChance = class'X2Item_LWSwords'.default.RANGERSWORD_COIL_CRITCHANCE;
	Template.iSoundRange = class'X2Item_LWSwords'.default.RANGERSWORD_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWSwords'.default.RANGERSWORD_COIL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	Template.CreatorTemplateName = 'Sword_CG_Schematic';

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';
	
	return Template;
}


static function X2DataTemplate CreateTemplate_Sword_Beam_RO(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamSword";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sword_BM.WP_Sword_BM";
	Template.AddDefaultAttachment('R_Back', "BeamSword.Meshes.SM_BeamSword_Sheath", false);
	Template.Tier = Tier;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.RANGERSWORD_BEAM_AIM;
	Template.CritChance = default.RANGERSWORD_BEAM_CRITCHANCE;
	Template.iSoundRange = default.RANGERSWORD_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.RANGERSWORD_BEAM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));
	
	Template.CreatorTemplateName = 'Sword_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Sword_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';
	
	return Template;
}


static function X2DataTemplate CreateTLE1Sword(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sword";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Sword.WP_TLE1Sword";
	Template.AddDefaultAttachment('R_Back', "", false);
	Template.Tier = Tier;

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_CRITCHANCE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}

static function X2DataTemplate CreateTLE2Sword(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sword_Laser";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Sword.WP_TLE2Sword";
	Template.AddDefaultAttachment('R_Back', "MagSword.Meshes.SM_MagSword_Sheath", false);
	Template.Tier = Tier;

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_CRITCHANCE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_STUNCHANCE, false));

	Template.CreatorTemplateName = 'Sword_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Sword_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Melee';

	Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , class'X2Item_DefaultWeapons'.default.RANGERSWORD_MAGNETIC_STUNCHANCE, , , "%");

	return Template;
}

static function X2DataTemplate CreateTLE3Sword(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sword_Plasma";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Sword.WP_TLE3Sword";
	Template.AddDefaultAttachment('R_Back', "BeamSword.Meshes.SM_BeamSword_Sheath", false);
	Template.Tier = Tier;

	Template.iRadius = 1;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_CRITCHANCE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.RANGERSWORD_BEAM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType='Melee';

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));

	Template.CreatorTemplateName = 'Sword_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Sword_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Melee';

	return Template;
}

static function X2DataTemplate CreateTemplate_PsiAmp_Frayer(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponCat = 'psiamp';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.PsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = Tier;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_CV.WP_PsiAmp_CV";

	Template.Abilities.AddItem('PsiAmpCV_BonusStats');
	Template.Abilities.AddItem('SoulFire');
	Template.Abilities.AddItem('MindMerge');
	Template.Abilities.AddItem('SoulSteal');
	
	Template.ExtraDamage = GetPsiAmpWeaponDamage(Tier);

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	// Show In Armory Requirements
	Template.ArmoryDisplayRequirements.RequiredTechs.AddItem('Psionics');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_ItemGrantedAbilitySet'.default.PSIAMP_CV_STATBONUS, true);

	return Template;
}


static function X2DataTemplate CreateTemplate_PsiAmp_Meteoric(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagPsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = Tier;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_MG.WP_PsiAmp_MG";

	Template.Abilities.AddItem('PsiAmpMG_BonusStats');
	Template.Abilities.AddItem('LW_Phasewalk');
	Template.Abilities.AddItem('LW_SoulStorm');

	Template.ExtraDamage = GetPsiAmpWeaponDamage(Tier);

	Template.CreatorTemplateName = 'PsiAmp_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PsiAmp_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;
	
	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_ItemGrantedAbilitySet'.default.PSIAMP_MG_STATBONUS);

	return Template;
}


static function X2DataTemplate CreateTemplate_PsiAmp_Madman(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = Tier;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_BM.WP_PsiAmp_BM";

	Template.Abilities.AddItem('PsiAmpBM_BonusStats');
	Template.Abilities.AddItem('Insanity');
	Template.Abilities.AddItem('VoidRift');

	Template.ExtraDamage = GetPsiAmpWeaponDamage(Tier);

	Template.CreatorTemplateName = 'PsiAmp_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PsiAmp_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_ItemGrantedAbilitySet'.default.PSIAMP_BM_STATBONUS);

	return Template;
}

static function X2DataTemplate CreateTemplate_PsiAmp_Puppeteer(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.DamageTypeTemplateName = 'Psi';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamPsiAmp";
	Template.EquipSound = "Psi_Amp_Equip";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	Template.Tier = Tier;
	// This all the resources; sounds, animations, models, physics, the works.
	
	Template.GameArchetype = "WP_PsiAmp_BM.WP_PsiAmp_BM";

	Template.Abilities.AddItem('PsiAmpBM_BonusStats');

	Template.Abilities.AddItem('PsiMindControl');

	Template.ExtraDamage = GetPsiAmpWeaponDamage(Tier);

	Template.CreatorTemplateName = 'PsiAmp_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'PsiAmp_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.SetUIStatMarkup(class'XLocalizedData'.default.PsiOffenseBonusLabel, eStat_PsiOffense, class'X2Ability_ItemGrantedAbilitySet'.default.PSIAMP_BM_STATBONUS);

	return Template;
}

static function X2GrenadeLauncherTemplate Create_IRI_RocketLauncher_Standard(name TemplateName, int Tier)
{
	local X2GrenadeLauncherTemplate Template;	//	there's no real upside for using this

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, TemplateName);

	Template.WeaponCat = 'iri_rocket_launcher';
	Template.strImage = "img:///IRI_RocketLaunchers.Inv_Rocket_Launcher_CV";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";

	Template.TradingPostValue = class'X2Item_DefaultGrenades'.default.GRENADELAUNCHER_TRADINGPOSTVALUE;
	Template.Tier = Tier;

	//Template.RangeAccuracy = default.CV_RL_RANGE_ACCURACY;
	//Template.OneActionRangeAccuracy = default.CV_RL_RANGE_ACCURACY_ONE_ACTION;

	Template.WeaponTech = GetWeaponTech(Tier);

	Template.IncreaseGrenadeRange = 0;

	Template.GameArchetype = "IRI_RocketLaunchers.Archetypes.WP_RocketLauncher_CV";

	Template.CanBeBuilt = false;
	Template.StartingItem = true;
	Template.bInfiniteItem = false;

	Template.bSoundOriginatesFromOwnerLocation = false;
	Template.bMergeAmmo = true;
	Template.iPhysicsImpulse = 5;

	//	Gauntlet Compability
	//Template.Aim = 0;
	//Template.CritChance = 0;

	Template.iRange = class'X2Item_IRI_RocketLaunchers'.default.RL_CV_RANGE;
	Template.iRadius = class'X2Item_IRI_RocketLaunchers'.default.RL_CV_RADIUS;
	Template.iClipSize = class'X2Item_IRI_RocketLaunchers'.default.RL_CV_CLIPSIZE;
	Template.iSoundRange = class'X2Item_IRI_RocketLaunchers'.default.RL_CV_SOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_IRI_RocketLaunchers'.default.RL_CV_ENVIRONMENTAL_DAMAGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.75f);
	Template.DamageTypeTemplateName = class'X2Item_IRI_RocketLaunchers'.default.RL_CV_BASEDAMAGE.DamageType;	

	Template.Abilities.AddItem('IRI_FireRocketLauncher');
	Template.Abilities.AddItem('RocketFuse');
	//Template.Abilities.AddItem('LWRocketLauncher');
	//Template.Abilities.AddItem('HeavyArmaments');

	return Template;
}


static function X2GrenadeLauncherTemplate Create_IRI_RocketLauncher_Shredder(name TemplateName, int Tier)
{
	local X2GrenadeLauncherTemplate Template;	//	there's no real upside for using this

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, TemplateName);

	Template.WeaponCat = 'iri_rocket_launcher';
	Template.strImage = "img:///IRI_RocketLaunchers.Inv_Rocket_Launcher_MG";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";

	Template.TradingPostValue = class'X2Item_DefaultGrenades'.default.GRENADELAUNCHER_TRADINGPOSTVALUE;
	Template.Tier = Tier;

	//Template.RangeAccuracy = default.MG_RL_RANGE_ACCURACY;
	//Template.OneActionRangeAccuracy = default.MG_RL_RANGE_ACCURACY_ONE_ACTION;

	//Template.Abilities.AddItem('IRI_RocketLauncher_MG_Passive');

	Template.WeaponTech = GetWeaponTech(Tier);

	Template.IncreaseGrenadeRange = class'X2Item_IRI_RocketLaunchers'.default.MG_RL_BONUS_ROCKET_RANGE_TILES;

	Template.GameArchetype = "IRI_RocketLaunchers.Archetypes.WP_RocketLauncher_MG";

	Template.CreatorTemplateName = 'IRI_RocketLauncher_MG_Schematic';
	Template.BaseItem = 'IRI_RocketLauncher_CV';

	Template.CanBeBuilt = false;
	Template.StartingItem = false;
	Template.bInfiniteItem = false;

	Template.iRange = class'X2Item_IRI_RocketLaunchers'.default.RL_MG_RANGE;
	Template.iRadius = class'X2Item_IRI_RocketLaunchers'.default.RL_MG_RADIUS;
	Template.iClipSize = class'X2Item_IRI_RocketLaunchers'.default.RL_MG_CLIPSIZE;
	Template.iSoundRange = class'X2Item_IRI_RocketLaunchers'.default.RL_MG_SOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_IRI_RocketLaunchers'.default.RL_MG_ENVIRONMENTAL_DAMAGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.75f,,3,2);
	Template.DamageTypeTemplateName = class'X2Item_IRI_RocketLaunchers'.default.RL_MG_BASEDAMAGE.DamageType;	

	Template.Abilities.AddItem('IRI_FireRocketLauncher');
	Template.Abilities.AddItem('RocketFuse');

	return Template;
}

static function X2GrenadeLauncherTemplate Create_IRI_RocketLauncher_Ejector(name TemplateName, int Tier)
{
	local X2GrenadeLauncherTemplate Template;	//	there's no real upside for using this

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, TemplateName);

	Template.WeaponCat = 'iri_rocket_launcher';
	Template.strImage = "img:///IRI_RocketLaunchers.Inv_Rocket_Launcher_BM";
	Template.EquipSound = "Secondary_Weapon_Equip_Conventional";

	//Template.iSoundRange = class'X2Item_DefaultGrenades'.default.GRENADELAUNCHER_ISOUNDRANGE;
	//Template.iEnvironmentDamage = class'X2Item_DefaultGrenades'.default.GRENADELAUNCHER_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = class'X2Item_DefaultGrenades'.default.GRENADELAUNCHER_TRADINGPOSTVALUE;
	//Template.iClipSize = class'X2Item_DefaultGrenades'.default.GRENADELAUNCHER_ICLIPSIZE;
	Template.Tier = Tier;

	//Template.RangeAccuracy = default.BM_RL_RANGE_ACCURACY;
	//Template.OneActionRangeAccuracy = default.BM_RL_RANGE_ACCURACY_ONE_ACTION;

	//Template.Abilities.AddItem('IRI_RocketLauncher_BM_Passive');

	Template.WeaponTech = GetWeaponTech(Tier);

	Template.IncreaseGrenadeRange = class'X2Item_IRI_RocketLaunchers'.default.BM_RL_BONUS_ROCKET_RANGE_TILES;

	Template.GameArchetype = "IRI_RocketLaunchers.Archetypes.WP_RocketLauncher_BM";

	Template.CreatorTemplateName = 'IRI_RocketLauncher_BM_Schematic';
	Template.BaseItem = 'IRI_RocketLauncher_MG';

	Template.CanBeBuilt = false;
	Template.StartingItem = false;
	Template.bInfiniteItem = false;

	Template.iRange = class'X2Item_IRI_RocketLaunchers'.default.RL_BM_RANGE;
	Template.iRadius = class'X2Item_IRI_RocketLaunchers'.default.RL_BM_RADIUS;
	Template.iClipSize = class'X2Item_IRI_RocketLaunchers'.default.RL_BM_CLIPSIZE;
	Template.iSoundRange = class'X2Item_IRI_RocketLaunchers'.default.RL_BM_SOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_IRI_RocketLaunchers'.default.RL_BM_ENVIRONMENTAL_DAMAGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.DamageTypeTemplateName = class'X2Item_IRI_RocketLaunchers'.default.RL_BM_BASEDAMAGE.DamageType;	

	//Template.Abilities.AddItem('IRI_FireRocketLauncher');
	Template.Abilities.AddItem('IRI_Fire_PlasmaEjector');
	Template.Abilities.AddItem('RocketFuse');

	return Template;
}


static function X2DataTemplate CreateTemplate_WristBlade_Laser(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;
	local WeaponAttachment Attach;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'WristBladeLeft_LS';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'wristblade';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_MagSGauntlet";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SkirmisherGauntlet.WP_SkirmisherGauntlet_MG";
	Template.AltGameArchetype = "WP_SkirmisherGauntlet.WP_SkirmisherGauntlet_F_MG";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Attach.AttachSocket = 'R_Claw';
	Attach.AttachMeshName = "SkirmisherGauntlet.Meshes.SM_SkirmisherGauntletR_Claw_M_MG";
	Attach.RequiredGender = eGender_Male;
	Attach.AttachToPawn = true;
	Template.DefaultAttachments.AddItem(Attach);

	Attach.AttachSocket = 'R_Claw';
	Attach.AttachMeshName = "SkirmisherGauntlet.Meshes.SM_SkirmisherGauntletR_Claw_F_MG";
	Attach.RequiredGender = eGender_Female;
	Attach.AttachToPawn = true;
	Template.DefaultAttachments.AddItem(Attach);

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_FactionWeapons'.default.WRISTBLADE_LASER_AIM;
	Template.CritChance = class'X2Item_FactionWeapons'.default.WRISTBLADE_LASER_CRITCHANCE;
	Template.iSoundRange = class'X2Item_FactionWeapons'.default.WRISTBLADE_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_FactionWeapons'.default.WRISTBLADE_LASER_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.Abilities.AddItem('SkirmisherVengeance');
	Template.Abilities.AddItem('Reckoning_LW');
	Template.Abilities.AddItem('RipAndTear_LW');

	Template.CreatorTemplateName = 'WristBlade_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'WristBlade_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';


	return Template;
}
static function X2DataTemplate CreateTemplate_WristBlade_Magnetic(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;
	local WeaponAttachment Attach;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'WristBladeLeft_MG';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'wristblade';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_MagSGauntlet";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SkirmisherGauntlet.WP_SkirmisherGauntlet_MG";
	Template.AltGameArchetype = "WP_SkirmisherGauntlet.WP_SkirmisherGauntlet_F_MG";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Attach.AttachSocket = 'R_Claw';
	Attach.AttachMeshName = "SkirmisherGauntlet.Meshes.SM_SkirmisherGauntletR_Claw_M_MG";
	Attach.RequiredGender = eGender_Male;
	Attach.AttachToPawn = true;
	Template.DefaultAttachments.AddItem(Attach);

	Attach.AttachSocket = 'R_Claw';
	Attach.AttachMeshName = "SkirmisherGauntlet.Meshes.SM_SkirmisherGauntletR_Claw_F_MG";
	Attach.RequiredGender = eGender_Female;
	Attach.AttachToPawn = true;
	Template.DefaultAttachments.AddItem(Attach);

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_XpackWeapons'.default.WRISTBLADE_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.WRISTBLADE_MAGNETIC_CRITCHANCE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.WRISTBLADE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.WRISTBLADE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.Abilities.AddItem('Justice');
	Template.Abilities.AddItem('SkirmisherVengeance');
	Template.Abilities.AddItem('ManualOverride_LW');

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateStunnedStatusEffect(2, class'X2Item_XpackWeapons'.default.WRISTBLADE_MAGNETIC_STUNCHANCE, false));

	Template.CreatorTemplateName = 'WristBlade_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'WristBlade_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	Template.SetUIStatMarkup(class'XLocalizedData'.default.StunChanceLabel, , class'X2Item_XpackWeapons'.default.WRISTBLADE_MAGNETIC_STUNCHANCE, , , "%");


	return Template;
}

static function X2DataTemplate CreateTemplate_WristBlade_Coil(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;
	local WeaponAttachment Attach;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'WristBladeLeft_CG';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'wristblade';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_MagSGauntlet";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SkirmisherGauntlet.WP_SkirmisherGauntlet_MG";
	Template.AltGameArchetype = "WP_SkirmisherGauntlet.WP_SkirmisherGauntlet_F_MG";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Attach.AttachSocket = 'R_Claw';
	Attach.AttachMeshName = "SkirmisherGauntlet.Meshes.SM_SkirmisherGauntletR_Claw_M_MG";
	Attach.RequiredGender = eGender_Male;
	Attach.AttachToPawn = true;
	Template.DefaultAttachments.AddItem(Attach);

	Attach.AttachSocket = 'R_Claw';
	Attach.AttachMeshName = "SkirmisherGauntlet.Meshes.SM_SkirmisherGauntletR_Claw_F_MG";
	Attach.RequiredGender = eGender_Female;
	Attach.AttachToPawn = true;
	Template.DefaultAttachments.AddItem(Attach);

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_FactionWeapons'.default.WRISTBLADE_COIL_AIM;
	Template.CritChance = class'X2Item_FactionWeapons'.default.WRISTBLADE_COIL_CRITCHANCE;
	Template.iSoundRange = class'X2Item_FactionWeapons'.default.WRISTBLADE_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_FactionWeapons'.default.WRISTBLADE_COIL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';

	Template.CreatorTemplateName = 'WristBlade_CG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'WristBlade_MG'; // Which item this will be upgraded from

	Template.Abilities.AddItem('Justice');
	Template.Abilities.AddItem('Battlelord');
	Template.Abilities.AddItem('CombatPresence');

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';


	return Template;
}

static function X2DataTemplate CreateTemplate_WristBlade_Beam(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;
	local WeaponAttachment Attach;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'WristBladeLeft_BM';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'wristblade';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_BeamSGauntlet";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SkirmisherGauntlet.WP_SkirmisherGauntlet_BM";
	Template.AltGameArchetype = "WP_SkirmisherGauntlet.WP_SkirmisherGauntlet_F_BM";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Attach.AttachSocket = 'R_Claw';
	Attach.AttachMeshName = "SkirmisherGauntlet.Meshes.SM_SkirmisherGauntletR_Claw_M_BM";
	Attach.RequiredGender = eGender_Male;
	Attach.AttachToPawn = true;
	Template.DefaultAttachments.AddItem(Attach);

	Attach.AttachSocket = 'R_Claw';
	Attach.AttachMeshName = "SkirmisherGauntlet.Meshes.SM_SkirmisherGauntletR_Claw_F_BM";
	Attach.RequiredGender = eGender_Female;
	Attach.AttachToPawn = true;
	Template.DefaultAttachments.AddItem(Attach);
	
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_XpackWeapons'.default.WRISTBLADE_BEAM_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.WRISTBLADE_BEAM_CRITCHANCE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.WRISTBLADE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.WRISTBLADE_BEAM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Melee';
	
	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));

	Template.CreatorTemplateName = 'WristBlade_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'WristBlade_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Melee';

	Template.Abilities.AddItem('Reckoning_LW');
	Template.Abilities.AddItem('Whiplash');
	Template.Abilities.AddItem('Ignite_LW');

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;
	local X2Effect_Persistent BleedingEffect;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	class'X2Item_SecondaryThrowingKnives'.static.InitializeThrowingKnifeTemplate(Template);
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///MusashiCombatKnifeMod_LW.UI.UI_Kunai_MG";
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "MusashiCombatKnifeMod_LW.Archetypes.WP_Kunai_MG";
	Template.Tier = Tier;

	Template.StartingItem = false;
	Template.bInfiniteItem = false;
	Template.CanBeBuilt = true;
	Template.BaseItem = 'ThrowingKnife_LS_Secondary'; // Which item this will be upgraded from
	Template.CreatorTemplateName = 'ThrowingKnife_MG_Schematic'; // The schematic which creates this item

	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,0.75f);
	Template.Abilities.AddItem('RendTheMarked');
	Template.Abilities.AddItem('ImpersonalEdge');
	//Template.Abilities.AddItem('ImpersonalEdge_LW');

	// Add chance to inflict bleeding
	BleedingEffect = class'X2StatusEffects'.static.CreateBleedingStatusEffect(
		class'X2Item_SecondaryThrowingKnives'.default.THROWING_KNIFE_MG_BLEED_DURATION,
		Tier/2);
	BleedingEffect.ApplyChance = class'X2Item_SecondaryThrowingKnives'.default.THROWING_KNIFE_MG_BLEED_CHANCE;
	Template.BonusWeaponEffects.AddItem(BleedingEffect);

	return Template;
}

static function X2DataTemplate CreateTemplate_ThrowingKnife_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;
	local X2Effect_Persistent BleedingEffect;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	class'X2Item_SecondaryThrowingKnives'.static.InitializeThrowingKnifeTemplate(Template);
	Template.iClipSize=1;
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///MusashiCombatKnifeMod_LW.UI.UI_Kunai_BM";
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "MusashiCombatKnifeMod_LW.Archetypes.WP_Kunai_BM";
	Template.Tier = Tier;

	Template.StartingItem = false;
	Template.bInfiniteItem = false;
	Template.CanBeBuilt = true;
	Template.BaseItem = 'ThrowingKnife_CG_Secondary'; // Which item this will be upgraded from
	Template.CreatorTemplateName = 'ThrowingKnife_BM_Schematic'; // The schematic which creates this item

	Template.BaseDamage = GetWeaponDamage(Tier);

	Template.Abilities.AddItem('KnifeJuggler_LW');
	Template.Abilities.AddItem('KnifeEncounters');

	// Add chance to inflict bleeding
	BleedingEffect = class'X2StatusEffects'.static.CreateBleedingStatusEffect(
		class'X2Item_SecondaryThrowingKnives'.default.THROWING_KNIFE_BM_BLEED_DURATION,
		Tier/2);
	BleedingEffect.ApplyChance = class'X2Item_SecondaryThrowingKnives'.default.THROWING_KNIFE_BM_BLEED_CHANCE;
	Template.BonusWeaponEffects.AddItem(BleedingEffect);

	return Template;
}


static function X2DataTemplate CreateTemplate_GremlinDrone_Magnetic_RO(name TemplateName, int Tier)
{
	local X2GremlinTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GremlinTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagGremlin";
	Template.EquipSound = "Gremlin_Equip";

	Template.CosmeticUnitTemplate = "GremlinMk2";
	Template.Tier = 2;

	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,,99);
	Template.HackingAttemptBonus = default.GREMLINMK2_HACKBONUS;
	Template.AidProtocolBonus = 5;
	Template.HealingBonus = 1;
	//Template.BaseDamage.Damage = 4;     //  combat protocol
	//Template.BaseDamage.Pierce = 1000;  //  ignore armor
	Template.Abilities.AddItem('RescueProtocol');
	Template.Abilities.AddItem('BlindingProtocol_LW');
	Template.Abilities.AddItem('AdvancedRobotics_LW');
	Template.Abilities.AddItem('CombatProtocol');
	Template.Abilities.AddItem('RevivalProtocol');

	Template.iRange = 2;
	Template.iRadius = 40;              //  only for scanning protocol
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;



	Template.CreatorTemplateName = 'Gremlin_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Gremlin_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Electrical';

	Template.bHideDamageStat = false;
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechBonusLabel, eStat_Hacking, default.GREMLINMK2_HACKBONUS);

	return Template;
}

static function X2DataTemplate CreateTemplate_GremlinDrone_Beam_RO(name TemplateName, int Tier)
{
	local X2GremlinTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GremlinTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Gremlin";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.BeamSecondaryWeapons.BeamGremlin";
	Template.EquipSound = "Gremlin_Equip";

	Template.CosmeticUnitTemplate = "GremlinMk3";
	Template.Tier = Tier;

	//Template.ExtraDamage = default.GREMLINMK3_ABILITYDAMAGE;
	Template.HackingAttemptBonus = default.GREMLINMK3_HACKBONUS;
	Template.AidProtocolBonus = 5;
	Template.HealingBonus = 2;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,,99);

	Template.RevivalChargesBonus = 1;
	Template.ScanningChargesBonus = 1;

	Template.iRange = 2;
	Template.iRadius = 40;              //  only for scanning protocol
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Gremlin_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Gremlin_MG'; // Which item this will be upgraded from
	
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.Abilities.AddItem('RescueProtocol');
	Template.Abilities.AddItem('BlindingProtocol_LW');
	Template.Abilities.AddItem('ChainingJolt_LW');
	Template.Abilities.AddItem('HayWireProtocol');
	Template.Abilities.AddItem('VoltaicArc_LW');

	Template.DamageTypeTemplateName = 'Electrical';
	
	Template.bHideDamageStat = false;
	Template.SetUIStatMarkup(class'XLocalizedData'.default.TechBonusLabel, eStat_Hacking, default.GREMLINMK3_HACKBONUS);

	return Template;
}
