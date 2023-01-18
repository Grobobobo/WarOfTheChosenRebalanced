// This is an Unreal Script
class X2Item_ResOpPrimaryWeapons extends X2Item_DefaultWeapons config(GameData_WeaponData);

var config int ASSAULTRIFLE_TLE_CONVENTIONAL_AIM;
var config int ASSAULTRIFLE_TLE_CONVENTIONAL_CRITCHANCE;
var config int ASSAULTRIFLE_TLE_CONVENTIONAL_ICLIPSIZE;

var config int ASSAULTRIFLE_TLE_MAGNETIC_AIM;
var config int ASSAULTRIFLE_TLE_MAGNETIC_CRITCHANCE;
var config int ASSAULTRIFLE_TLE_MAGNETIC_ICLIPSIZE;

var config int ASSAULTRIFLE_TLE_BEAM_AIM;
var config int ASSAULTRIFLE_TLE_BEAM_CRITCHANCE;
var config int ASSAULTRIFLE_TLE_BEAM_ICLIPSIZE;

var config int LMG_TLE_CONVENTIONAL_AIM;
var config int LMG_TLE_CONVENTIONAL_CRITCHANCE;
var config int LMG_TLE_CONVENTIONAL_ICLIPSIZE;

var config int LMG_TLE_MAGNETIC_AIM;
var config int LMG_TLE_MAGNETIC_CRITCHANCE;
var config int LMG_TLE_MAGNETIC_ICLIPSIZE;

var config int LMG_TLE_BEAM_AIM;
var config int LMG_TLE_BEAM_CRITCHANCE;
var config int LMG_TLE_BEAM_ICLIPSIZE;

var config int SHOTGUN_TLE_CONVENTIONAL_AIM;
var config int SHOTGUN_TLE_CONVENTIONAL_CRITCHANCE;
var config int SHOTGUN_TLE_CONVENTIONAL_ICLIPSIZE;

var config int SHOTGUN_TLE_MAGNETIC_AIM;
var config int SHOTGUN_TLE_MAGNETIC_CRITCHANCE;
var config int SHOTGUN_TLE_MAGNETIC_ICLIPSIZE;

var config int SHOTGUN_TLE_BEAM_AIM;
var config int SHOTGUN_TLE_BEAM_CRITCHANCE;
var config int SHOTGUN_TLE_BEAM_ICLIPSIZE;

var config int SNIPERRIFLE_TLE_CONVENTIONAL_AIM;
var config int SNIPERRIFLE_TLE_CONVENTIONAL_CRITCHANCE;
var config int SNIPERRIFLE_TLE_CONVENTIONAL_ICLIPSIZE;

var config int SNIPERRIFLE_TLE_MAGNETIC_AIM;
var config int SNIPERRIFLE_TLE_MAGNETIC_CRITCHANCE;
var config int SNIPERRIFLE_TLE_MAGNETIC_ICLIPSIZE;

var config int SNIPERRIFLE_TLE_BEAM_AIM;
var config int SNIPERRIFLE_TLE_BEAM_CRITCHANCE;
var config int SNIPERRIFLE_TLE_BEAM_ICLIPSIZE;

struct GauntletExtraDamage{
	var name Tag;
	var float DamageMod;
	var float CritDamageMod;
	var float BonusSpread;
	var bool FlatDamage;

	structdefaultproperties{
		CritDamageMod=0.5f
	}
};
var config array<GauntletExtraDamage> SHARDGAUNTLET_EXTRADAMAGE_TAGS;

static function array<X2DataTemplate> CreateTemplates(name TemplateName, int Tier)
{
	local array<X2DataTemplate> Weapons;

	Weapons.AddItem(CreateTLE1AssaultRifle('TLE_AssaultRifle_CV_1',1));    

	Weapons.AddItem(CreateTemplate_AssaultRifle_Conventional('AssaultRifle_CV_1',1));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Conventional('AssaultRifle_CV_2',2));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Conventional('AssaultRifle_CV_3',3));
	
	Weapons.AddItem(CreateTemplate_AssaultRifle_Laser('AssaultRifle_LS_2',2));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Laser('AssaultRifle_LS_3',3));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Laser('AssaultRifle_LS_4',4));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Laser('AssaultRifle_LS_5',5));

	Weapons.AddItem(CreateTemplate_AssaultRifle_Magnetic('AssaultRifle_MG_2',2));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Magnetic('AssaultRifle_MG_3',3));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Magnetic('AssaultRifle_MG_4',4));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Magnetic('AssaultRifle_MG_5',5));

	//Weapons.AddItem(CreateTemplate_AssaultRifle_Coil('AssaultRifle_CG_2',2));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Coil('AssaultRifle_CG_3',3));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Coil('AssaultRifle_CG_4',4));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Coil('AssaultRifle_CG_5',5));

	//Weapons.AddItem(CreateTemplate_AssaultRifle_Coil('AssaultRifle_CG_2',2));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Beam('AssaultRifle_BM_3',3));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Beam('AssaultRifle_BM_4',4));
	Weapons.AddItem(CreateTemplate_AssaultRifle_Beam('AssaultRifle_BM_5',5));


	Weapons.AddItem(CreateTLE2AssaultRifle('TLE_AssaultRifle_MG_2',2));
	Weapons.AddItem(CreateTLE2AssaultRifle('TLE_AssaultRifle_MG_3',3));
	Weapons.AddItem(CreateTLE2AssaultRifle('TLE_AssaultRifle_MG_4',4));
	Weapons.AddItem(CreateTLE2AssaultRifle('TLE_AssaultRifle_MG_5',5));


	Weapons.AddItem(CreateTLE3AssaultRifle('TLE_AssaultRifle_BM_3',3));
	Weapons.AddItem(CreateTLE3AssaultRifle('TLE_AssaultRifle_BM_4',4));
	Weapons.AddItem(CreateTLE3AssaultRifle('TLE_AssaultRifle_BM_5',5));



	Weapons.AddItem(CreateTemplate_Immolator_T0('LWImmolator_T0_1',1));
	Weapons.AddItem(CreateTemplate_Immolator_T0('LWImmolator_T0_2',2));
	Weapons.AddItem(CreateTemplate_Immolator_T0('LWImmolator_T0_3',3));

	Weapons.AddItem(CreateTemplate_Immolator_CV('LWImmolator_CV_2',2));
	Weapons.AddItem(CreateTemplate_Immolator_CV('LWImmolator_CV_3',3));
	Weapons.AddItem(CreateTemplate_Immolator_CV('LWImmolator_CV_4',4));
	Weapons.AddItem(CreateTemplate_Immolator_CV('LWImmolator_CV_5',5));

	Weapons.AddItem(CreateTemplate_Immolator_MG('LWImmolator_MG_2',2));
	Weapons.AddItem(CreateTemplate_Immolator_MG('LWImmolator_MG_3',3));
	Weapons.AddItem(CreateTemplate_Immolator_MG('LWImmolator_MG_4',4));
	Weapons.AddItem(CreateTemplate_Immolator_MG('LWImmolator_MG_5',5));

	Weapons.AddItem(CreateTemplate_Immolator_BM('LWImmolator_BM_2',2));
	Weapons.AddItem(CreateTemplate_Immolator_BM('LWImmolator_BM_3',3));
	Weapons.AddItem(CreateTemplate_Immolator_BM('LWImmolator_BM_4',4));
	Weapons.AddItem(CreateTemplate_Immolator_BM('LWImmolator_BM_5',5));

	Weapons.AddItem(CreateTLE1Cannon('TLE_Cannon_CV_1',1));
	Weapons.AddItem(CreateTLE1Cannon('TLE_Cannon_CV_2',2));
	Weapons.AddItem(CreateTLE1Cannon('TLE_Cannon_CV_3',3));

	Weapons.AddItem(CreateTLE2Cannon('TLE_Cannon_MG_2',2));
	Weapons.AddItem(CreateTLE2Cannon('TLE_Cannon_MG_3',3));
	Weapons.AddItem(CreateTLE2Cannon('TLE_Cannon_MG_4',4));
	Weapons.AddItem(CreateTLE2Cannon('TLE_Cannon_MG_5',5));

	Weapons.AddItem(CreateTLE3Cannon('TLE_Cannon_BM_2',3));
	Weapons.AddItem(CreateTLE3Cannon('TLE_Cannon_BM_3',4));
	Weapons.AddItem(CreateTLE3Cannon('TLE_Cannon_BM_4',5));

	Weapons.AddItem(CreateTemplate_VektorRifle_Conventional('VektorRifle_CV_1',1));
	Weapons.AddItem(CreateTemplate_VektorRifle_Conventional('VektorRifle_CV_2',2));
	Weapons.AddItem(CreateTemplate_VektorRifle_Conventional('VektorRifle_CV_3',3));

	Weapons.AddItem(CreateVektor_Laser('VektorRifle_LS_2',2));
	Weapons.AddItem(CreateVektor_Laser('VektorRifle_LS_3',3));
	Weapons.AddItem(CreateVektor_Laser('VektorRifle_LS_4',4));
	Weapons.AddItem(CreateVektor_Laser('VektorRifle_LS_5',5));

	Weapons.AddItem(CreateTemplate_VektorRifle_Magnetic('VektorRifle_MG_2',2));
	Weapons.AddItem(CreateTemplate_VektorRifle_Magnetic('VektorRifle_MG_3',3));
	Weapons.AddItem(CreateTemplate_VektorRifle_Magnetic('VektorRifle_MG_4',4));
	Weapons.AddItem(CreateTemplate_VektorRifle_Magnetic('VektorRifle_MG_5',5));

	Weapons.AddItem(CreateVektor_Coil('VektorRifle_CG_3',3));
	Weapons.AddItem(CreateVektor_Coil('VektorRifle_CG_4',4));
	Weapons.AddItem(CreateVektor_Coil('VektorRifle_CG_5',5));

	Weapons.AddItem(CreateTemplate_VektorRifle_Beam('VektorRifle_BM_3',3));
	Weapons.AddItem(CreateTemplate_VektorRifle_Beam('VektorRifle_BM_4',4));
	Weapons.AddItem(CreateTemplate_VektorRifle_Beam('VektorRifle_BM_5',5));

	Weapons.AddItem(CreateTemplate_Bullpup_Conventional('Bullpup_CV_1',1));
	Weapons.AddItem(CreateTemplate_Bullpup_Conventional('Bullpup_CV_2',2));
	Weapons.AddItem(CreateTemplate_Bullpup_Conventional('Bullpup_CV_3',3));

	Weapons.AddItem(CreateTemplate_Bullpup_Laser('Bullpup_LS_2',2));
	Weapons.AddItem(CreateTemplate_Bullpup_Laser('Bullpup_LS_3',3));
	Weapons.AddItem(CreateTemplate_Bullpup_Laser('Bullpup_LS_4',4));
	Weapons.AddItem(CreateTemplate_Bullpup_Laser('Bullpup_LS_5',5));

	Weapons.AddItem(CreateTemplate_Bullpup_Magnetic('Bullpup_MG_2',2));
	Weapons.AddItem(CreateTemplate_Bullpup_Magnetic('Bullpup_MG_3',3));
	Weapons.AddItem(CreateTemplate_Bullpup_Magnetic('Bullpup_MG_4',4));
	Weapons.AddItem(CreateTemplate_Bullpup_Magnetic('Bullpup_MG_5',5));

	Weapons.AddItem(CreateBullpup_Coil_Template('Bullpup_CG_3',3));
	Weapons.AddItem(CreateBullpup_Coil_Template('Bullpup_CG_4',4));
	Weapons.AddItem(CreateBullpup_Coil_Template('Bullpup_CG_5',5));

	Weapons.AddItem(CreateTemplate_Bullpup_Beam('Bullpup_BM_3',3));
	Weapons.AddItem(CreateTemplate_Bullpup_Beam('Bullpup_BM_4',4));
	Weapons.AddItem(CreateTemplate_Bullpup_Beam('Bullpup_BM_5',5));


	Weapons.AddItem(CreateTemplate_Cannon_Conventional('Cannon_CV_1',1));
	Weapons.AddItem(CreateTemplate_Cannon_Conventional('Cannon_CV_2',2));
	Weapons.AddItem(CreateTemplate_Cannon_Conventional('Cannon_CV_3',3));

	Weapons.AddItem(CreateTemplate_Cannon_Laser('Cannon_LS_2',2));
	Weapons.AddItem(CreateTemplate_Cannon_Laser('Cannon_LS_3',3));
	Weapons.AddItem(CreateTemplate_Cannon_Laser('Cannon_LS_4',4));
	Weapons.AddItem(CreateTemplate_Cannon_Laser('Cannon_LS_5',5));

	Weapons.AddItem(CreateTemplate_Cannon_Magnetic('Cannon_MG_2',2));
	Weapons.AddItem(CreateTemplate_Cannon_Magnetic('Cannon_MG_3',3));
	Weapons.AddItem(CreateTemplate_Cannon_Magnetic('Cannon_MG_4',4));
	Weapons.AddItem(CreateTemplate_Cannon_Magnetic('Cannon_MG_5',5));

	Weapons.AddItem(CreateCannon_Coil_Template('Cannon_CG_3',3));
	Weapons.AddItem(CreateCannon_Coil_Template('Cannon_CG_4',4));
	Weapons.AddItem(CreateCannon_Coil_Template('Cannon_CG_5',5));

	Weapons.AddItem(CreateTemplate_Cannon_Beam('Cannon_BM_3',3));
	Weapons.AddItem(CreateTemplate_Cannon_Beam('Cannon_BM_4',4));
	Weapons.AddItem(CreateTemplate_Cannon_Beam('Cannon_BM_5',5));

	Weapons.AddItem(CreateTemplate_SMG_Conventional('SMG_CV_1',1));
	Weapons.AddItem(CreateTemplate_SMG_Conventional('SMG_CV_2',2));
	Weapons.AddItem(CreateTemplate_SMG_Conventional('SMG_CV_3',3));

	Weapons.AddItem(CreateTemplate_SMG_Laser('SMG_LS_2',2));
	Weapons.AddItem(CreateTemplate_SMG_Laser('SMG_LS_3',3));
	Weapons.AddItem(CreateTemplate_SMG_Laser('SMG_LS_4',4));
	Weapons.AddItem(CreateTemplate_SMG_Laser('SMG_LS_5',5));

	Weapons.AddItem(CreateTemplate_SMG_Magnetic('SMG_MG_2',2));
	Weapons.AddItem(CreateTemplate_SMG_Magnetic('SMG_MG_3',3));
	Weapons.AddItem(CreateTemplate_SMG_Magnetic('SMG_MG_4',4));
	Weapons.AddItem(CreateTemplate_SMG_Magnetic('SMG_MG_5',5));

	Weapons.AddItem(CreateSMG_Coil_Template('SMG_CG_3',3));
	Weapons.AddItem(CreateSMG_Coil_Template('SMG_CG_4',4));
	Weapons.AddItem(CreateSMG_Coil_Template('SMG_CG_5',5));

	Weapons.AddItem(CreateTemplate_SMG_Beam('SMG_BM_3',3));
	Weapons.AddItem(CreateTemplate_SMG_Beam('SMG_BM_4',4));
	Weapons.AddItem(CreateTemplate_SMG_Beam('SMG_BM_5',5));

	Weapons.AddItem(CreateTemplate_SniperRifle_Conventional('SniperRifle_CV_1',1));
	Weapons.AddItem(CreateTemplate_SniperRifle_Conventional('SniperRifle_CV_2',2));
	Weapons.AddItem(CreateTemplate_SniperRifle_Conventional('SniperRifle_CV_3',3));

	Weapons.AddItem(CreateTemplate_SniperRifle_Laser('SniperRifle_LS_2',2));
	Weapons.AddItem(CreateTemplate_SniperRifle_Laser('SniperRifle_LS_3',3));
	Weapons.AddItem(CreateTemplate_SniperRifle_Laser('SniperRifle_LS_4',4));
	Weapons.AddItem(CreateTemplate_SniperRifle_Laser('SniperRifle_LS_5',5));

	Weapons.AddItem(CreateTemplate_SniperRifle_Magnetic('SniperRifle_MG_2',2));
	Weapons.AddItem(CreateTemplate_SniperRifle_Magnetic('SniperRifle_MG_3',3));
	Weapons.AddItem(CreateTemplate_SniperRifle_Magnetic('SniperRifle_MG_4',4));
	Weapons.AddItem(CreateTemplate_SniperRifle_Magnetic('SniperRifle_MG_5',5));

	Weapons.AddItem(CreateSniperRifle_Coil_Template('SniperRifle_CG_3',3));
	Weapons.AddItem(CreateSniperRifle_Coil_Template('SniperRifle_CG_4',4));
	Weapons.AddItem(CreateSniperRifle_Coil_Template('SniperRifle_CG_5',5));

	Weapons.AddItem(CreateTemplate_SniperRifle_Beam('SniperRifle_BM_3',3));
	Weapons.AddItem(CreateTemplate_SniperRifle_Beam('SniperRifle_BM_4',4));
	Weapons.AddItem(CreateTemplate_SniperRifle_Beam('SniperRifle_BM_5',5));

	Weapons.AddItem(CreateTLE1SniperRifle('TLE_SniperRifle_CV_1',1));
	Weapons.AddItem(CreateTLE1SniperRifle('TLE_SniperRifle_CV_2',2));
	Weapons.AddItem(CreateTLE1SniperRifle('TLE_SniperRifle_CV_3',3));

	Weapons.AddItem(CreateTLE2SniperRifle('TLE_SniperRifle_MG_2',2));
	Weapons.AddItem(CreateTLE2SniperRifle('TLE_SniperRifle_MG_3',3));
	Weapons.AddItem(CreateTLE2SniperRifle('TLE_SniperRifle_MG_4',4));
	Weapons.AddItem(CreateTLE2SniperRifle('TLE_SniperRifle_MG_5',5));

	Weapons.AddItem(CreateTLE3SniperRifle('TLE_SniperRifle_BM_2',3));
	Weapons.AddItem(CreateTLE3SniperRifle('TLE_SniperRifle_BM_3',4));
	Weapons.AddItem(CreateTLE3SniperRifle('TLE_SniperRifle_BM_4',5));

	Weapons.AddItem(CreateTemplate_ShardGauntlet('ShardGauntlet_CV_1',1));
	Weapons.AddItem(CreateTemplate_ShardGauntlet('ShardGauntlet_CV_2',2));
	Weapons.AddItem(CreateTemplate_ShardGauntlet('ShardGauntlet_CV_3',3));
	Weapons.AddItem(CreateTemplate_ShardGauntlet('ShardGauntlet_CV_4',4));
	Weapons.AddItem(CreateTemplate_ShardGauntlet('ShardGauntlet_CV_5',5));

	//Weapons.AddItem(CreateTemplate_CasterGauntlet('CasterGauntlet_CV_1',1));
	Weapons.AddItem(CreateTemplate_CasterGauntlet('CasterGauntlet_CV_2',2));
	Weapons.AddItem(CreateTemplate_CasterGauntlet('CasterGauntlet_CV_3',3));
	Weapons.AddItem(CreateTemplate_CasterGauntlet('CasterGauntlet_CV_4',4));
	Weapons.AddItem(CreateTemplate_CasterGauntlet('CasterGauntlet_CV_5',5));

	Weapons.AddItem(CreateTemplate_BladeMasterGauntlet('BladeMasterGauntlet_CV_2',2));
	Weapons.AddItem(CreateTemplate_BladeMasterGauntlet('BladeMasterGauntlet_CV_3',3));
	Weapons.AddItem(CreateTemplate_BladeMasterGauntlet('BladeMasterGauntlet_CV_4',4));
	Weapons.AddItem(CreateTemplate_BladeMasterGauntlet('BladeMasterGauntlet_CV_5',5));

	Weapons.AddItem(CreateTemplate_TacticianGauntlet('TacticianGauntlet_CV_2',2));
	Weapons.AddItem(CreateTemplate_TacticianGauntlet('TacticianGauntlet_CV_3',3));
	Weapons.AddItem(CreateTemplate_TacticianGauntlet('TacticianGauntlet_CV_4',4));
	Weapons.AddItem(CreateTemplate_TacticianGauntlet('TacticianGauntlet_CV_5',5));

	//Weapons.AddItem(CreateTemplate_PowerGauntlet('PowerGauntlet_CV_5',5));
	Weapons.AddItem(CreateTemplate_PowerGauntlet('PowerGauntlet_CV_2',2));
	Weapons.AddItem(CreateTemplate_PowerGauntlet('PowerGauntlet_CV_3',3));
	Weapons.AddItem(CreateTemplate_PowerGauntlet('PowerGauntlet_CV_4',4));
	Weapons.AddItem(CreateTemplate_PowerGauntlet('PowerGauntlet_CV_5',5));

	Weapons.AddItem(CreateTemplate_ReplicatorGauntlet('ReplicatorGauntlet_CV_2',2));
	Weapons.AddItem(CreateTemplate_ReplicatorGauntlet('ReplicatorGauntlet_CV_3',3));
	Weapons.AddItem(CreateTemplate_ReplicatorGauntlet('ReplicatorGauntlet_CV_4',4));
	Weapons.AddItem(CreateTemplate_ReplicatorGauntlet('ReplicatorGauntlet_CV_5',5));

	
	//Grenades.AddItem(CreateTemplate_AssaultRifle_Conventional('AssaultRifle_CV_1',1));

	return Weapons;
}


static function WeaponDamageValue GetWeaponDamage(int WeaponTier, optional float DamagePCT = 1.0f, float CritDamagePCT = 0.5f , optional int BonusSpread = 0, optional int BonusPierce = 0, optional int BonusShred = 0, optional int BonusRupture = 0){
    local WeaponDamageValue WeaponDamage;
    local float FloatBaseDamage;
    local int IntBaseDamage;

    FloatBaseDamage = WeaponTier * DamagePCT;
    IntBaseDamage = int(WeaponTier);
    

    WeaponDamage.Damage = IntBaseDamage;
    WeaponDamage.Spread = Max(1 + int(FloatBaseDamage / 5) + BonusSpread,0);
    WeaponDamage.PlusOne = int((FloatBaseDamage - IntBaseDamage) * 100);
    WeaponDamage.Crit = int(FloatBaseDamage * CritDamagePCT);
    WeaponDamage.Pierce = BonusPierce;
    WeaponDamage.Pierce = BonusPierce;
    WeaponDamage.Rupture = BonusRupture;
	WeaponDamage.DamageType = 'Projectile_MagXCom';

    return WeaponDamage;
}

static function array<WeaponDamageValue> GetGauntletsExtraWeaponDamage(int WeaponTier){
    local WeaponDamageValue WeaponDamage;
    local float FloatBaseDamage;
    local int IntBaseDamage;
	local array<WeaponDamageValue> ExtraDamages;
	local GauntletExtraDamage TagValue;

	foreach SHARDGAUNTLET_EXTRADAMAGE_TAGS(TagValue){
		FloatBaseDamage = WeaponTier  * TagValue.DamageMod;
		IntBaseDamage = int(WeaponTier);
		
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

static function name GetWeaponTech(int Tier){
	switch(Tier){
		case 1:
		return 'conventional';
		case 2:
		return 'laser_lw';
		case 3:
		return 'magnetic';
		case 4: 
		return 'coilgun_lw';
		case 5: 
		return 'beam';
		case 6: 
		return 'chosen';
		default:
		return 'conventional';
	}
}


static function X2DataTemplate CreateTLE1AssaultRifle(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_AR_Base";
	Template.Tier = Tier;
	//Template.OnAcquiredFn = OnTLE1AssaultRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.ASSAULTRIFLE_TLE_CONVENTIONAL_AIM;
	Template.CritChance = default.ASSAULTRIFLE_TLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.ASSAULTRIFLE_TLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange =class'X2Item_DefaultWeapons'. default.ASSAULTRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('LightEmUp');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1AssaultRifle.WP_TLE1AssaultRifle";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.fKnockbackDamageAmount = 5.0f;
	Template.fKnockbackDamageRadius = 0.0f;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}



static function X2DataTemplate CreateTemplate_AssaultRifle_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

    local String WeaponId;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_Base";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 1;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('Lightemup');
	Template.Abilities.AddItem('Executioner_LW');
	Template.Abilities.AddItem('WalkFire');

	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_AssaultRifle_CV.WP_AssaultRifle_CV";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_MagA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_MagA");
	Template.AddDefaultAttachment('Optic', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_OpticA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_OpticA");
	Template.AddDefaultAttachment('Reargrip', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_ReargripA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_ReargripA");
	Template.AddDefaultAttachment('Stock', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_StockA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_StockA");
	Template.AddDefaultAttachment('Trigger', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_TriggerA", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight", , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	
	Template.fKnockbackDamageAmount = 5.0f;
	Template.fKnockbackDamageRadius = 0.0f;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';
	
	return Template;
}


static function X2DataTemplate CreateTemplate_AssaultRifle_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///" $ class'X2Item_LaserWeapons'.default.AssaultRifle_Laser_ImagePath; 
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MEDIUM_ALL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_LaserWeapons'.default.ASSAULTRIFLE_LASER_AIM;
	Template.CritChance =class'X2Item_LaserWeapons'.default.ASSAULTRIFLE_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_LaserWeapons'.default.ASSAULTRIFLE_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LaserWeapons'.default.ASSAULTRIFLE_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LaserWeapons'.default.ASSAULTRIFLE_LASER_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = class'X2Item_LaserWeapons'.default.ASSAULTRIFLE_LASER_UPGRADESLOTS; 
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

    Template.Abilities.AddItem('Lightemup');
    Template.Abilities.AddItem('LockedOn');

	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWAssaultRifle_LS.Archetype.WP_AssaultRifle_LS";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "LWAttachments_LS.Meshes.SK_Laser_Mag_A", , "img:///UILibrary_LW_LaserPack.LaserRifle_MagA");
	Template.AddDefaultAttachment('Stock', "LWAttachments_LS.Meshes.SK_Laser_Stock_A", , "img:///UILibrary_LW_LaserPack.LaserRifle_StockA");
	Template.AddDefaultAttachment('Reargrip', "LWAttachments_LS.Meshes.SK_Laser_Trigger_A", , "img:///UILibrary_LW_LaserPack.LaserRifle_TriggerA");
	Template.AddDefaultAttachment('Foregrip', "LWAttachments_LS.Meshes.SK_Laser_Foregrip_A", , "img:///UILibrary_LW_LaserPack.LaserRifle_ForegripA");
	//Template.AddDefaultAttachment('Optic', "LWRifle_LS.Meshes.SK_LaserRifle_Optic_A", , "img:///UILibrary_LW_LaserPack.LaserRifle__OpticA"); // no default optic

	Template.CreatorTemplateName = 'GeneralWeapons_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'AssaultRifle_CV'; // Which item this will be upgraded from

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';  

	return Template;
}



static function X2DataTemplate CreateTemplate_AssaultRifle_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MIDSHORT_ALL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');


	Template.Abilities.AddItem('Lightemup');
	Template.Abilities.AddItem('ReaperMode');

	
	Template.GameArchetype = "WP_AssaultRifle_MG.WP_AssaultRifle_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagA", , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_MagA");
	Template.AddDefaultAttachment('Suppressor', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_SuppressorA", , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_SupressorA");
	Template.AddDefaultAttachment('Reargrip', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_ReargripA", , /* included with TriggerA */);
	Template.AddDefaultAttachment('Stock', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_StockA", , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_StockA");
	Template.AddDefaultAttachment('Trigger', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_TriggerA", , "img:///UILibrary_Common.UI_MagAssaultRifle.MagAssaultRifle_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;
	
	Template.CreatorTemplateName = 'AssaultRifle_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'AssaultRifle_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_AssaultRifle_Coil(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage ="img:///" $ class'X2Item_Coilguns'.default.AssaultRifle_Coil_ImagePath;
	Template.WeaponPanelImage = "";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MEDIUM_ALL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_Coilguns'.default.ASSAULTRIFLE_COIL_AIM;
	Template.CritChance = class'X2Item_Coilguns'.default.ASSAULTRIFLE_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_Coilguns'.default.ASSAULTRIFLE_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_Coilguns'.default.ASSAULTRIFLE_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_Coilguns'.default.ASSAULTRIFLE_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 3;

	Template.GameArchetype = "LWAssaultRifle_CG.Archetypes.WP_AssaultRifle_CG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_MagA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_MagA");
	Template.AddDefaultAttachment('Stock', "LWAccessories_CG.Meshes.LW_Coil_StockA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_StockA");
	Template.AddDefaultAttachment('Reargrip', "LWAccessories_CG.Meshes.LW_Coil_ReargripA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilRifle_ReargripA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight"); //, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");  // re-use common conventional flashlight

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Lightemup');
	Template.Abilities.AddItem('TeslaCoil');
	// Template.Abilities.AddItem('CoilgunBonusShredAbility');

	Template.CreatorTemplateName = 'GeneralWeapons_CG_Schematic'; // The schematic which creates this item

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_AssaultRifle_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MEDIUM_ALL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	//Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('Lightemup');
	Template.Abilities.AddItem('PlasmaReload');
	Template.Abilities.AddItem('LockAndLoad');

	Template.GameArchetype = "WP_AssaultRifle_BM.WP_AssaultRifle_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_MagA");
	Template.AddDefaultAttachment('Suppressor', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_SuppressorA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_SupressorA");
	Template.AddDefaultAttachment('Core', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_CoreA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_CoreA");
	Template.AddDefaultAttachment('HeatSink', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_HeatSinkA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_HeatsinkA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.CreatorTemplateName = 'AssaultRifle_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'AssaultRifle_MG'; // Which item this will be upgraded from

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTLE2AssaultRifle(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_AR_Laser_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;
	//Template.OnAcquiredFn = OnTLE2AssaultRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MEDIUM_ALL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,,0.75f);
	Template.Aim = default.ASSAULTRIFLE_TLE_MAGNETIC_AIM;
	Template.CritChance = default.ASSAULTRIFLE_TLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.ASSAULTRIFLE_TLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;



	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('Lightemup');
	Template.Abilities.AddItem('Predator_LW');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2AssaultRifle.WP_TLE2AssaultRifle";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'AssaultRifle_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_AssaultRifle_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTLE3AssaultRifle(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_AR_Plasma_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;
	//Template.OnAcquiredFn = OnTLE3AssaultRifleAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.MEDIUM_ALL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.ASSAULTRIFLE_TLE_BEAM_AIM;
	Template.CritChance = default.ASSAULTRIFLE_TLE_BEAM_CRITCHANCE;
	Template.iClipSize = default.ASSAULTRIFLE_TLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_BEAM_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('Lightemup');
	//Template.Abilities.AddItem('HighVolumeFire');
	Template.Abilities.AddItem('FondFarewell');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3AssaultRifle.WP_TLE3AssaultRifle";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;

	Template.CreatorTemplateName = 'AssaultRifle_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_AssaultRifle_MG'; // Which item this will be upgraded from

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Immolator_T0(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'lwchemthrower';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///IRIStolenFlamer_LW.UI.Flamethrower_TLE";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Weapon_Immolator'.default.Flamethrower_rangemod;
	Template.BaseDamage = GetWeaponDamage(Tier);

	Template.ExtraDamage = class'X2Weapon_Immolator'.default.Flamethrower_SkillDamage_T0;
	Template.iSoundRange = class'X2Weapon_Immolator'.default.FLAMETHROWER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Weapon_Immolator'.default.FLAMETHROWER_IENVIRONMENTDAMAGE;
	Template.iClipSize = class'X2Weapon_Immolator'.default.FLAMETHROWER_ICLIPSIZE;
	Template.iRange = class'X2Weapon_Immolator'.default.FLAMETHROWER_RANGE;
	Template.iRadius = class'X2Weapon_Immolator'.default.FLAMETHROWER_RADIUS;
	Template.fCoverage = class'X2Weapon_Immolator'.default.FlameTHROWER_TILE_COVERAGE_PERCENT;
	Template.BaseDamage.DamageType = 'Fire';
	
	Template.InfiniteAmmo = false;
	Template.PointsToComplete = 0;
	Template.DamageTypeTemplateName = 'Fire';
	Template.iTypicalActionCost = 2;
	Template.NumUpgradeSlots=class'X2Weapon_Immolator'.default.Upgrades_CV;
	Template.iPhysicsImpulse = 5;
	//Template.bIsLargeWeapon = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	
	Template.GameArchetype ="IRIStolenFlamer_LW.Archetypes.WP_StolenFlamer";
	Template.bMergeAmmo = true;
	Template.bCanBeDodged = false;

	Template.Abilities.AddItem('MZFireThrower');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('MZFireThrowerOverwatchShot');
	Template.Abilities.AddItem('MZSmokeCanister');

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.StartingItem = true;

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , class'X2Weapon_Immolator'.default.FLAMETHROWER_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , class'X2Weapon_Immolator'.default.FLAMETHROWER_RADIUS);

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(class'X2Weapon_Immolator'.default.Burn_Dmg_CV, class'X2Weapon_Immolator'.default.Burn_Spread_CV));

	return Template;
}

static function X2DataTemplate CreateTemplate_Immolator_CV(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'lwchemthrower';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///IRIClausImmolator.UI.Flamethrower_CV";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Weapon_Immolator'.default.Flamethrower_rangemod;
	Template.BaseDamage = GetWeaponDamage(Tier);
	
	Template.ExtraDamage = class'X2Weapon_Immolator'.default.Flamethrower_SkillDamage_CV;
	Template.iSoundRange = class'X2Weapon_Immolator'.default.FLAMETHROWER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Weapon_Immolator'.default.FLAMETHROWER_IENVIRONMENTDAMAGE;
	Template.iClipSize = class'X2Weapon_Immolator'.default.FLAMETHROWER_ICLIPSIZE;
	Template.iRange = class'X2Weapon_Immolator'.default.FLAMETHROWER_RANGE;
	Template.iRadius = class'X2Weapon_Immolator'.default.FLAMETHROWER_RADIUS;
	Template.fCoverage = class'X2Weapon_Immolator'.default.FlameTHROWER_TILE_COVERAGE_PERCENT;
	Template.BaseDamage.DamageType = 'Fire';
	
	Template.InfiniteAmmo = false;
	Template.PointsToComplete = 0;
	Template.DamageTypeTemplateName = 'Fire';
	Template.iTypicalActionCost = 2;
	Template.NumUpgradeSlots=class'X2Weapon_Immolator'.default.Upgrades_CV;
	Template.iPhysicsImpulse = 5;
	//Template.bIsLargeWeapon = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	
	Template.GameArchetype ="IRIClausImmolator.Archetypes.WP_Immolator_CV";
	Template.bMergeAmmo = true;
	Template.bCanBeDodged = false;

	Template.Abilities.AddItem('MZFireThrower');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('MZFireThrowerOverwatchShot');
	Template.Abilities.AddItem('MZBlastCanister');

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	Template.StartingItem = true;

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.CreatorTemplateName = 'Immolator_CV_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'LWImmolator_T0'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , class'X2Weapon_Immolator'.default.FLAMETHROWER_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , class'X2Weapon_Immolator'.default.FLAMETHROWER_RADIUS);

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(class'X2Weapon_Immolator'.default.Burn_Dmg_CV, class'X2Weapon_Immolator'.default.Burn_Spread_CV));

	return Template;
}

static function X2DataTemplate CreateTemplate_Immolator_MG(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'lwchemthrower';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///IRIClausImmolator.UI.Flamethrower_MG";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier=Tier;

	Template.RangeAccuracy = class'X2Weapon_Immolator'.default.Flamethrower_rangemod;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.ExtraDamage = class'X2Weapon_Immolator'.default.Flamethrower_SkillDamage_MG;
	Template.iSoundRange = class'X2Weapon_Immolator'.default.FLAMETHROWER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Weapon_Immolator'.default.FLAMETHROWER_IENVIRONMENTDAMAGE;
	Template.iClipSize = class'X2Weapon_Immolator'.default.MG_FLAMETHROWER_ICLIPSIZE;
	Template.iRange = class'X2Weapon_Immolator'.default.FLAMETHROWER_RANGE;
	Template.iRadius = class'X2Weapon_Immolator'.default.FLAMETHROWER_RADIUS;
	Template.fCoverage = class'X2Weapon_Immolator'.default.FlameTHROWER_TILE_COVERAGE_PERCENT;
	Template.BaseDamage.DamageType = 'Fire';
	
	Template.InfiniteAmmo = false;
	Template.PointsToComplete = 0;
	Template.DamageTypeTemplateName = 'Fire';
	Template.iTypicalActionCost = 2;
	Template.NumUpgradeSlots= class'X2Weapon_Immolator'.default.Upgrades_MG;
	Template.iPhysicsImpulse = 5;
	//Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	
	Template.GameArchetype = "IRIClausImmolator.Archetypes.WP_Immolator_MG";
	Template.bMergeAmmo = true;
	Template.bCanBeDodged = false;

	Template.Abilities.AddItem('MZFireThrower');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('MZFireThrowerOverwatchShot');
	Template.Abilities.AddItem('MZBluescreenCanister');

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.CreatorTemplateName = 'Immolator_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'LWImmolator_CV'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , class'X2Weapon_Immolator'.default.FLAMETHROWER_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , class'X2Weapon_Immolator'.default.FLAMETHROWER_RADIUS);

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(class'X2Weapon_Immolator'.default.Burn_Dmg_MG, class'X2Weapon_Immolator'.default.Burn_Spread_MG));

	return Template;
}

static function X2DataTemplate CreateTemplate_Immolator_BM(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'lwchemthrower';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///IRIClausImmolator.UI.Flamethrower_BM";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Weapon_Immolator'.default.Flamethrower_rangemod;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.ExtraDamage = class'X2Weapon_Immolator'.default.Flamethrower_SkillDamage_BM;
	Template.iSoundRange = class'X2Weapon_Immolator'.default.FLAMETHROWER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Weapon_Immolator'.default.FLAMETHROWER_IENVIRONMENTDAMAGE;
	Template.iClipSize = class'X2Weapon_Immolator'.default.BM_FLAMETHROWER_ICLIPSIZE;
	Template.iRange = class'X2Weapon_Immolator'.default.FLAMETHROWER_RANGE;
	Template.iRadius = class'X2Weapon_Immolator'.default.FLAMETHROWER_RADIUS;
	Template.fCoverage = class'X2Weapon_Immolator'.default.FlameTHROWER_TILE_COVERAGE_PERCENT;
	Template.BaseDamage.DamageType = 'Fire';
	
	Template.InfiniteAmmo = false;
	Template.PointsToComplete = 0;
	Template.DamageTypeTemplateName = 'Fire';
	Template.iTypicalActionCost = 2;
	Template.NumUpgradeSlots= class'X2Weapon_Immolator'.default.Upgrades_BM;
	Template.iPhysicsImpulse = 5;
	//Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	
	Template.GameArchetype = "IRIClausImmolator.Archetypes.WP_Immolator_BM";
	Template.bMergeAmmo = true;
	Template.bCanBeDodged = false;

	Template.Abilities.AddItem('MZFireThrower');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('MZFireThrowerOverwatchShot');
	Template.Abilities.AddItem('MZPoisonCanister');

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.CreatorTemplateName = 'Immolator_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'LWImmolator_MG'; // Which item this will be upgraded from

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , class'X2Weapon_Immolator'.default.FLAMETHROWER_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , class'X2Weapon_Immolator'.default.FLAMETHROWER_RADIUS);

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(class'X2Weapon_Immolator'.default.Burn_Dmg_BM, class'X2Weapon_Immolator'.default.Burn_Spread_BM));

	return Template;
}

static function X2DataTemplate CreateTLE1Cannon(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Cannon_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;
	//Template.OnAcquiredFn = OnTLE1CannonAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f,,,1);
	Template.Aim = default.LMG_TLE_CONVENTIONAL_AIM;
	Template.CritChance = default.LMG_TLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.LMG_TLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('HailOfBullets');
	Template.Abilities.AddItem('Suppression');
	//Template.Abilities.AddItem('HeavyWeaponsMobPenalty');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Cannon.WP_TLE1Cannon";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTLE2Cannon(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Cannon_Laser_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;
	//Template.OnAcquiredFn = OnTLE2CannonAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f,,,1);
	Template.Aim = default.LMG_TLE_MAGNETIC_AIM;
	Template.CritChance = default.LMG_TLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.LMG_TLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('CyclicFire');
	//Template.Abilities.AddItem('HeavyWeaponsMobPenalty');
	Template.Abilities.AddItem('Suppression');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Cannon.WP_TLE2Cannon";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Cannon_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Cannon_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTLE3Cannon(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Cannon_Plasma_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;
	//Template.OnAcquiredFn = OnTLE3CannonAcquired;

	Template.RangeAccuracy = class'X2Item_DefaultWeaponMods_LW'.default.LMG_ALL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f,,,1);
	Template.Aim = default.LMG_TLE_BEAM_AIM;
	Template.CritChance = default.LMG_TLE_BEAM_CRITCHANCE;
	Template.iClipSize = default.LMG_TLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_BEAM_IENVIRONMENTDAMAGE;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('SaturationFire');
	Template.Abilities.AddItem('Suppression');

	//Template.Abilities.AddItem('HeavyWeaponsMobPenalty');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Cannon.WP_TLE3Cannon";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Cannon_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Cannon_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_VektorRifle_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'vektor_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_XPACK_Common.ConvVektor_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_XPackWeapons'.default.VEKTOR_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 1;
	Template.iTypicalActionCost = 1;
		
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('InTheZone_LW');
	Template.Abilities.AddItem('Stock_LW_Bsc_Ability');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_ReaperRifle.WP_ReaperRifle";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Mag', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_MagA", , "img:///UILibrary_XPACK_Common.ConvVektor_MagazineA");
	Template.AddDefaultAttachment('Optic', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_OpticA", , "img:///UILibrary_XPACK_Common.ConvVektor_OpticA");
	Template.AddDefaultAttachment('Reargrip', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_ReargripA");
	Template.AddDefaultAttachment('Stock', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_StockA", , "img:///UILibrary_XPACK_Common.ConvVektor_StockA");
	Template.AddDefaultAttachment('Suppressor', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_SuppressorA", , "img:///UILibrary_XPACK_Common.ConvVektor_SuppressorA");
	Template.AddDefaultAttachment('Trigger', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_TriggerA", , "img:///UILibrary_XPACK_Common.ConvVektor_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;
	
	Template.fKnockbackDamageAmount = 5.0f;
	Template.fKnockbackDamageRadius = 0.0f;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';
	
	return Template;
}

static function X2DataTemplate CreateVektor_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'vektor_rifle';
	Template.WeaponTech = GetWeaponTech(Tier); 
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///" $ class'X2Item_FactionWeapons'.default.Vektor_Laser_ImagePath; 
	Template.WeaponPanelImage = "_BeamSniperRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_FactionWeapons'.default.VEKTOR_LASER_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_FactionWeapons'.default.VEKTOR_LASER_AIM;
	Template.CritChance = class'X2Item_FactionWeapons'.default.VEKTOR_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_FactionWeapons'.default.VEKTOR_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_FactionWeapons'.default.VEKTOR_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_FactionWeapons'.default.VEKTOR_LASER_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('HitAndRun');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LW_StrikeRifle.Archetypes.WP_DMR_LS";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.CreatorTemplateName = 'PrecisionWeapons_LS_Schematic'; // The schematic which creates this item

	Template.iPhysicsImpulse = 5;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';  

	return Template;
}

static function X2DataTemplate CreateTemplate_VektorRifle_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticSniperRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'vektor_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_XPACK_Common.MagVektor_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_XPackWeapons'.default.VEKTOR_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;
	Template.iTypicalActionCost = 2;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	Template.Abilities.AddItem('InTheZone_LW');
	Template.Abilities.AddItem('Stock_LW_Bsc_Ability');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_ReaperRifle_MG.WP_ReaperRifle_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Mag', "MagReaperRifle.Meshes.SM_HOR_Mag_ReaperRifle_MagA", , "img:///UILibrary_XPACK_Common.MagVektor_MagazineA");
	Template.AddDefaultAttachment('Optic', "MagReaperRifle.Meshes.SM_HOR_Mag_ReaperRifle_OpticA", , "img:///UILibrary_XPACK_Common.MagVektor_OpticA");
	Template.AddDefaultAttachment('Reargrip', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_ReargripA");
	Template.AddDefaultAttachment('Stock', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_StockA", , "img:///UILibrary_XPACK_Common.MagVektor_StockA");
	Template.AddDefaultAttachment('Trigger', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_TriggerA", , "img:///UILibrary_XPACK_Common.MagVektor_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");
	

	Template.iPhysicsImpulse = 5;
	
	Template.CreatorTemplateName = 'VektorRifle_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'VektorRifle_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}


static function X2DataTemplate CreateVektor_Coil(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'vektor_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage ="img:///" $ class'X2Item_FactionWeapons'.default.Vektor_Coil_ImagePath;
	Template.WeaponPanelImage = "_MagneticSniperRifle";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_FactionWeapons'.default.VEKTOR_COIL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_FactionWeapons'.default.VEKTOR_COIL_AIM;
	Template.CritChance = class'X2Item_FactionWeapons'.default.VEKTOR_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_FactionWeapons'.default.VEKTOR_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_FactionWeapons'.default.VEKTOR_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_FactionWeapons'.default.VEKTOR_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 3;

	Template.GameArchetype = "LW_StrikeRifle.Archetypes.WP_DMR_CG";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';

	Template.CreatorTemplateName = 'VEKTOR_CG_Schematic'; // The schematic which creates this item



	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('InTheZone_LW');
	Template.Abilities.AddItem('Stock_LW_Bsc_Ability');

	// Template.Abilities.AddItem('CoilgunBonusShredAbility');

	Template.CreatorTemplateName = 'PrecisionWeapons_CG_Schematic'; // The schematic which creates this item

	Template.iPhysicsImpulse = 5;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}



static function X2DataTemplate CreateTemplate_VektorRifle_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamSniperRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.WeaponCat = 'vektor_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_XPACK_Common.BeamVektor_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_XPackWeapons'.default.VEKTOR_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_BEAM_AIM;
	Template.CritChance = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XPackWeapons'.default.VEKTORRIFLE_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 2;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	//Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('HitAndRun');
	Template.Abilities.AddItem('PlasmaReload');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_ReaperRifle_BM.WP_ReaperRifle_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Optic', "BemReaperRifle.Meshes.SM_HOR_Bem_ReaperRifle_OpticA", , "img:///UILibrary_XPACK_Common.BeamVektor_OpticA");
	Template.AddDefaultAttachment('Mag', "BemReaperRifle.Meshes.SM_HOR_Bem_ReaperRifle_MagA", , "img:///UILibrary_XPACK_Common.BeamVektor_MagazineA");
	Template.AddDefaultAttachment('Suppressor', "BemReaperRifle.Meshes.SM_HOR_Bem_ReaperRifle_SuppressorA", , "img:///UILibrary_XPACK_Common.BeamVektor_SuppressorA");
	Template.AddDefaultAttachment('Reargrip', "BemReaperRifle.Meshes.SM_HOR_Bem_ReaperRifle_ReargripA");
	Template.AddDefaultAttachment('Trigger', "CnvReaperRifle.Meshes.SM_HOR_Cnv_ReaperRifle_TriggerA", , "img:///UILibrary_XPACK_Common.BeamVektor_TriggerA");
	Template.AddDefaultAttachment('Stock', "BemReaperRifle.Meshes.SM_HOR_Bem_ReaperRifle_StockA", , "img:///UILibrary_XPACK_Common.BeamVektor_StockA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");	

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.CreatorTemplateName = 'VektorRifle_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'VektorRifle_MG'; // Which item this will be upgraded from

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Bullpup_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'bullpup';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_XPACK_Common.ConvSMG_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_XPackWeapons'.default.BULLPUP_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_XPackWeapons'.default.BULLPUP_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_XPackWeapons'.default.BULLPUP_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XPackWeapons'.default.BULLPUP_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XPackWeapons'.default.BULLPUP_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 1;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('ReadyForAnything');
	Template.Abilities.AddItem('CoolUnderPressure');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SkirmisherSMG.WP_SkirmisherSMG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';
	Template.AddDefaultAttachment('Mag', "CnvSMG.Meshes.SM_HOR_Cnv_SMG_MagA",, "img:///UILibrary_XPACK_Common.ConvSMG_MagazineA");
	Template.AddDefaultAttachment('Reargrip', "CnvSMG.Meshes.SM_HOR_Cnv_SMG_ReargripA");
	Template.AddDefaultAttachment('Stock', "CnvSMG.Meshes.SM_HOR_Cnv_SMG_StockA",, "img:///UILibrary_XPACK_Common.ConvSMG_StockA");
	Template.AddDefaultAttachment('Trigger', "CnvSMG.Meshes.SM_HOR_Cnv_SMG_TriggerA",,"img:///UILibrary_XPACK_Common.ConvSMG_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTemplate_Bullpup_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'bullpup';
	Template.WeaponTech = GetWeaponTech(Tier); 
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///" $ class'X2Item_FactionWeapons'.default.Bullpup_Laser_ImagePath; 
	Template.WeaponPanelImage = "_BeamShotgun";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_FactionWeapons'.default.SKIRMISHER_SMG_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_FactionWeapons'.default.BULLPUP_LASER_AIM;
	Template.CritChance = class'X2Item_FactionWeapons'.default.BULLPUP_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_FactionWeapons'.default.BULLPUP_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_FactionWeapons'.default.BULLPUP_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_FactionWeapons'.default.BULLPUP_LASER_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Bullpup_CV_StatBonus');

	Template.Abilities.AddItem('EverVigilant');
	Template.Abilities.AddItem('Sentinel_LW');
	Template.Abilities.AddItem('CoolUnderPressure');
	Template.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_FactionWeaponAbilities'.default.BULLPUP_CONVENTIONAL_MOBILITY_BONUS);

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWSMG_LS.Archetype.WP_SMG_LS";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';


	Template.CreatorTemplateName = 'LightWeapons_LS_Schematic'; // The schematic which creates this item

	Template.iPhysicsImpulse = 5;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';  

	return Template;
}



static function X2DataTemplate CreateTemplate_Bullpup_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'bullpup';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_XPACK_Common.MagSMG_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_XPackWeapons'.default.BULLPUP_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_XPackWeapons'.default.BULLPUP_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_XPackWeapons'.default.BULLPUP_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XPackWeapons'.default.BULLPUP_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XPackWeapons'.default.BULLPUP_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('WatchThemRun_LW');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SkirmisherSMG_MG.WP_SkirmisherSMG_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';

	Template.AddDefaultAttachment('Mag', "MagSMG.Meshes.SM_HOR_Mag_SMG_MagA", , "img:///UILibrary_XPACK_Common.MagSMG_MagazineA");
	Template.AddDefaultAttachment('Reargrip', "CnvSMG.Meshes.SM_HOR_Cnv_SMG_ReargripA");
	Template.AddDefaultAttachment('Stock', "CnvSMG.Meshes.SM_HOR_Cnv_SMG_StockA", , "img:///UILibrary_XPACK_Common.MagSMG_StockA");
	Template.AddDefaultAttachment('Trigger', "CnvSMG.Meshes.SM_HOR_Cnv_SMG_TriggerA", , "img:///UILibrary_XPACK_Common.MagSMG_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.CreatorTemplateName = 'Bullpup_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Bullpup_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateBullpup_Coil_Template(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;	
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'bullpup';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage ="img:///" $ class'X2Item_FactionWeapons'.default.BullPup_Coil_ImagePath;
	Template.WeaponPanelImage = "";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_FactionWeapons'.default.SKIRMISHER_SMG_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_FactionWeapons'.default.BULLPUP_COIL_AIM;
	Template.CritChance = class'X2Item_FactionWeapons'.default.BULLPUP_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_FactionWeapons'.default.BULLPUP_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_FactionWeapons'.default.BULLPUP_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_FactionWeapons'.default.BULLPUP_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 3;

	Template.GameArchetype = "IRI_Bullpup_CG.Archetypes.WP_Bullpup_CG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';


	Template.CreatorTemplateName = 'LightWeapons_CG_Schematic'; // The schematic which creates this item

	Template.iPhysicsImpulse = 5;
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('PistolReturnFire');
	Template.Abilities.AddItem('Sentinel');
	Template.Abilities.AddItem('PrimaryReturnFire');
	Template.Abilities.AddItem('CoveringFire');
	// Template.Abilities.AddItem('CoilgunBonusShredAbility');
	Template.Requirements.RequiredTechs.AddItem('Coilguns');

	Template.Abilities.AddItem('Bullpup_CV_StatBonus');
	Template.SetUIStatMarkup("Mobility", eStat_Mobility, class'X2Ability_FactionWeaponAbilities'.default.BULLPUP_CONVENTIONAL_MOBILITY_BONUS);

	Template.iPhysicsImpulse = 5;
	Template.StartingItem = false;
	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Bullpup_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'bullpup';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_XPACK_Common.BeamSMG_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_XPackWeapons'.default.BULLPUP_BEAM_AIM;
	Template.CritChance = class'X2Item_XPackWeapons'.default.BULLPUP_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_XPackWeapons'.default.BULLPUP_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_XPackWeapons'.default.BULLPUP_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XPackWeapons'.default.BULLPUP_BEAM_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('PistolReturnFire');
	//Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('WayLay');
	Template.Abilities.AddItem('CoolUnderPressure');
	Template.Abilities.AddItem('PlasmaReload');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SkirmisherSMG_BM.WP_SkirmisherSMG_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';	
	Template.AddDefaultAttachment('Mag', "BemSMG.Meshes.SM_HOR_Bem_SMG_MagA", , "img:///UILibrary_XPACK_Common.BeamSMG_MagazineA");
	Template.AddDefaultAttachment('Suppressor', "BemSMG.Meshes.SM_HOR_Bem_SMG_SuppressorA", , "img:///UILibrary_XPACK_Common.BeamSMG_SuppressorA");
	Template.AddDefaultAttachment('Reargrip', "BemSMG.Meshes.SM_HOR_Bem_SMG_ReargripA");
	Template.AddDefaultAttachment('Trigger', "CnvSMG.Meshes.SM_HOR_Cnv_SMG_TriggerA", , "img:///UILibrary_XPACK_Common.BeamSMG_TriggerA");
	Template.AddDefaultAttachment('Stock', "BemSMG.Meshes.SM_HOR_Bem_SMG_StockA", , "img:///UILibrary_XPACK_Common.BeamSMG_StockA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.CreatorTemplateName = 'Bullpup_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Bullpup_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Cannon_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.ConvCannon.ConvCannon_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.5f,,,1);
	Template.Aim = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 1;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('BulletWizard');
	Template.Abilities.AddItem('WalkFire');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Cannon_CV.WP_Cannon_CV";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';
	Template.AddDefaultAttachment('Mag', 		"ConvCannon.Meshes.SM_ConvCannon_MagA", , "img:///UILibrary_Common.ConvCannon.ConvCannon_MagA");
	Template.AddDefaultAttachment('Reargrip',   "ConvCannon.Meshes.SM_ConvCannon_ReargripA"/*REARGRIP INCLUDED IN TRIGGER IMAGE*/);
	Template.AddDefaultAttachment('Stock', 		"ConvCannon.Meshes.SM_ConvCannon_StockA", , "img:///UILibrary_Common.ConvCannon.ConvCannon_StockA");
	Template.AddDefaultAttachment('StockSupport', "ConvCannon.Meshes.SM_ConvCannon_StockA_Support");
	Template.AddDefaultAttachment('Suppressor', "ConvCannon.Meshes.SM_ConvCannon_SuppressorA");
	Template.AddDefaultAttachment('Trigger', "ConvCannon.Meshes.SM_ConvCannon_TriggerA", , "img:///UILibrary_Common.ConvCannon.ConvCannon_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTemplate_Cannon_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'cannon';
	Template.WeaponTech = GetWeaponTech(Tier); 
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///" $ class'X2Item_LaserWeapons'.default.Cannon_Laser_ImagePath;
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_LaserWeapons'.default.MEDIUM_LASER_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f,1.0f,,1);
	Template.Aim = class'X2Item_LaserWeapons'.default.LMG_LASER_AIM;
	Template.CritChance = class'X2Item_LaserWeapons'.default.LMG_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_LaserWeapons'.default.LMG_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LaserWeapons'.default.LMG_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LaserWeapons'.default.LMG_LASER_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = class'X2Item_LaserWeapons'.default.LMG_LASER_UPGRADESLOTS; 
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('SuppressiveFire_LW');
	Template.Abilities.AddItem('Suppression');
	Template.Abilities.AddItem('SteadFast');
	Template.Abilities.AddItem('CoolUnderPressure');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWCannon_LS.Archetype.WP_Cannon_LS";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';
	Template.AddDefaultAttachment('Mag', "LWCannon_LS.Meshes.SK_LaserCannon_Mag_A", , "img:///UILibrary_LW_LaserPack.LaserCannon_MagA");
	Template.AddDefaultAttachment('Stock', "LWCannon_LS.Meshes.SK_LaserCannon_Stock_A", , "img:///UILibrary_LW_LaserPack.LaserCannon_StockA");
	Template.AddDefaultAttachment('Reargrip', "LWCannon_LS.Meshes.SK_LaserCannon_Trigger_A", , "img:///UILibrary_LW_LaserPack.LaserCannon_TriggerA");
	Template.AddDefaultAttachment('Light', "LWAttachments_LS.Meshes.SK_Laser_Flashlight", , );

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.CreatorTemplateName = 'HeavyWeapons_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Cannon_MG'; // Which item this will be upgraded from

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom'; 

	return Template;
}


static function X2DataTemplate CreateTemplate_Cannon_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.UI_MagCannon.MagCannon_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.75f,,,1);
	Template.Aim = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('BulletWizard');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Cannon_MG.WP_Cannon_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';
	Template.AddDefaultAttachment('Mag', "MagCannon.Meshes.SM_MagCannon_MagA", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_MagA");
	Template.AddDefaultAttachment('Reargrip',   "MagCannon.Meshes.SM_MagCannon_ReargripA");
	Template.AddDefaultAttachment('Foregrip', "MagCannon.Meshes.SM_MagCannon_StockA", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_StockA");
	Template.AddDefaultAttachment('Trigger', "MagCannon.Meshes.SM_MagCannon_TriggerA", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Cannon_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Cannon_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateCannon_Coil_Template(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'cannon';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage ="img:///" $ class'X2Item_Coilguns'.default.Cannon_Coil_ImagePath;
	Template.WeaponPanelImage = "";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_Coilguns'.default.MEDIUM_COIL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.5f,,,1);
	Template.Aim = class'X2Item_Coilguns'.default.CANNON_COIL_AIM;
	Template.CritChance = class'X2Item_Coilguns'.default.CANNON_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_Coilguns'.default.CANNON_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_Coilguns'.default.CANNON_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_Coilguns'.default.CANNON_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 3;

	Template.GameArchetype = "LWCannon_CG.Archetypes.WP_Cannon_CG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';
	Template.AddDefaultAttachment('Mag', "LWCannon_CG.Meshes.LW_CoilCannon_MagA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_MagA");
	Template.AddDefaultAttachment('Stock', "LWCannon_CG.Meshes.LW_CoilCannon_StockA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_StockA");
	Template.AddDefaultAttachment('StockSupport', "LWCannon_CG.Meshes.LW_CoilCannon_StockSupportA");
	Template.AddDefaultAttachment('Reargrip', "LWCannon_CG.Meshes.LW_CoilCannon_ReargripA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilCannon_ReargripA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight"); //, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");  // re-use common conventional flashlight

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('BulletWizard');
	// Template.Abilities.AddItem('CoilgunBonusShredAbility');

	Template.CreatorTemplateName = 'HeavyWeapons_CG_Schematic'; // The schematic which creates this item

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Cannon_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamCannon";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.5f,,,1);
	Template.Aim = class'X2Item_DefaultWeapons'.default.LMG_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.LMG_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.LMG_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_BEAM_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	Template.bIsLargeWeapon = true;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('SuppressiveFire_LW');
	Template.Abilities.AddItem('Suppression');
	Template.Abilities.AddItem('HighVolumeFire_LW');
	//Template.Abilities.AddItem('PlasmaReload');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Cannon_BM.WP_Cannon_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Cannon';
	Template.AddDefaultAttachment('Mag', "BeamCannon.Meshes.SM_BeamCannon_MagA", , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_MagA");
	Template.AddDefaultAttachment('Core', "BeamCannon.Meshes.SM_BeamCannon_CoreA", , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_CoreA");
	Template.AddDefaultAttachment('Core_Center',"BeamCannon.Meshes.SM_BeamCannon_CoreA_Center");
	Template.AddDefaultAttachment('HeatSink', "BeamCannon.Meshes.SM_BeamCannon_HeatSinkA", , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_HeatsinkA");
	Template.AddDefaultAttachment('Suppressor', "BeamCannon.Meshes.SM_BeamCannon_SuppressorA", , "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_SupressorA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'Cannon_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Cannon_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_SMG_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.EquipSound = "Conventional_Weapon_Equip";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'smg';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_SMG.conventional.LWConvSMG_Base";
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.Tier = Tier;

	Template.Abilities.AddItem('SMG_CV_StatBonus');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_SMGAbilities'.default.SMG_CONVENTIONAL_MOBILITY_BONUS);

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,1.0f);
	Template.Aim = class'X2Item_SMGWeapon'.default.SMG_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_SMGWeapon'.default.SMG_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_SMGWeapon'.default.SMG_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_SMGWeapon'.default.SMG_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_SMGWeapon'.default.SMG_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = class'X2Item_SMGWeapon'.default.SMG_CONVENTIONAL_UPGRADESLOTS;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('RapidFire');
	Template.Abilities.AddItem('Implacable');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWSMG_CV.WP_SMG_CV";

	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "LWSMG_CV.Meshes.SK_LWConvSMG_MagA", , "img:///UILibrary_SMG.conventional.LWConvSMG_MagA");
	Template.AddDefaultAttachment('Optic', "LWSMG_CV.Meshes.SK_LWConvSMG_OpticA", , "img:///UILibrary_SMG.conventional.LWConvSMG_OpticA");
	Template.AddDefaultAttachment('Stock', "LWSMG_CV.Meshes.SK_LWConvSMG_Stock");  // renamed to just 'Stock' when fixing seaming issues for TTP 52
	Template.AddDefaultAttachment('StockB', "", , "img:///UILibrary_SMG.conventional.LWConvSMG_StockA");  // attach image to StockB so it gets replaced with ugprade
	Template.AddDefaultAttachment('Trigger', "ConvAssaultRifle.Meshes.SM_ConvAssaultRifle_TriggerA", , "img:///UILibrary_SMG.conventional.LWConvSMG_TriggerA"); // re-use Assault Rifle trigger
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight"); //, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");  // re-use common conventional flashlight

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.bInfiniteItem = true;  // post-AlienHunters, Starting items are no longer assumed to be infinite
	Template.CanBeBuilt = false;

	//Template.UpgradeItem = 'SMG_MG';

	Template.fKnockbackDamageAmount = 4.0f;
	Template.fKnockbackDamageRadius = 0.0f;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTemplate_SMG_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'smg';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///" $ class'X2Item_LaserWeapons'.default.SMG_Laser_ImagePath; 
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.Abilities.AddItem('SMG_LS_StatBonus');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_LaserSMGAbilities'.default.SMG_LASER_MOBILITY_BONUS);

	Template.RangeAccuracy = class'X2Item_LaserWeapons'.default.MIDSHORT_LASER_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,1.0f);
		Template.Aim = class'X2Item_LaserWeapons'.default.SMG_LASER_AIM;
	Template.CritChance = class'X2Item_LaserWeapons'.default.SMG_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_LaserWeapons'.default.SMG_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LaserWeapons'.default.SMG_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LaserWeapons'.default.SMG_LASER_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = class'X2Item_LaserWeapons'.default.SMG_LASER_UPGRADESLOTS; 
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('HipFire_LW');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWSMG_LS.Archetype.WP_SMG_LS";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "LWAttachments_LS.Meshes.SK_Laser_Mag_A", , "img:///UILibrary_LW_LaserPack.LaserSMG_MagA");
	Template.AddDefaultAttachment('Stock', "LWShotgun_LS.Meshes.SK_LaserShotgun_Stock_A", , "img:///UILibrary_LW_LaserPack.LaserSMG_StockA"); // switching to use the shotgun-style stock to differentiate better from rifle
	Template.AddDefaultAttachment('Reargrip', "LWAttachments_LS.Meshes.SK_Laser_Trigger_A", , "img:///UILibrary_LW_LaserPack.LaserSMG_TriggerA");
	Template.AddDefaultAttachment('Foregrip', "LWAttachments_LS.Meshes.SK_Laser_Foregrip_A", , "img:///UILibrary_LW_LaserPack.LaserSMG_ForegripA");
	//Template.AddDefaultAttachment('Optic', "LWSMG_LS.Meshes.SK_LaserSMG_Optic_A", , "img:///UILibrary_LW_LaserPack.LaserSMG__OpticA");  // no default optic
	Template.AddDefaultAttachment('Light', "LWAttachments_LS.Meshes.SK_Laser_Flashlight", , );

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.CreatorTemplateName = 'LightWeapons_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SMG_CV'; // Which item this will be upgraded from

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';  

	return Template;
}

static function X2DataTemplate CreateTemplate_SMG_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'smg';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_SMG.magnetic.LWMagSMG_Base";
	Template.WeaponPanelImage = "_MagneticRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.Abilities.AddItem('SMG_MG_StatBonus');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_SMGAbilities'.default.SMG_MAGNETIC_MOBILITY_BONUS);

	Template.RangeAccuracy = class'X2Item_SMGWeapon'.default.MIDSHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,1.25f);
	Template.Aim = class'X2Item_SMGWeapon'.default.SMG_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_SMGWeapon'.default.SMG_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_SMGWeapon'.default.SMG_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_SMGWeapon'.default.SMG_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_SMGWeapon'.default.SMG_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = class'X2Item_SMGWeapon'.default.SMG_MAGNETIC_UPGRADESLOTS;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('RapidFire');
	Template.Abilities.AddItem('Untouchable');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWSMG_MG.WP_SMG_MG";

	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_MagA", , "img:///UILibrary_SMG.magnetic.LWMagSMG_MagA");
	Template.AddDefaultAttachment('Optic', "LWSMG_MG.Meshes.SK_LWMagSMG_OpticA", , "img:///UILibrary_SMG.magnetic.LWMagSMG_OpticA");
	//turn off SuppressorA, as it is built in to the base mesh now
	//Template.AddDefaultAttachment('Suppressor', "LWSMG_MG.Meshes.SK_LWMagSMG_SuppressorA"); //, , "img:///UILibrary_SMG.magnetic.LWMagSMG_SuppressorA"); // included with base
	Template.AddDefaultAttachment('Reargrip', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_ReargripA", , /* included with TriggerA */);
	Template.AddDefaultAttachment('Stock', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_StockA", , "img:///UILibrary_SMG.magnetic.LWMagSMG_StockA");
	Template.AddDefaultAttachment('Trigger', "MagAssaultRifle.Meshes.SM_MagAssaultRifle_TriggerA", , "img:///UILibrary_SMG.magnetic.LWMagSMG_TriggerA");
	Template.AddDefaultAttachment('Light', "LWSMG_MG.Meshes.SK_MagFlashLight");  // alternative -- use mag flashlight, unused in base-game, converted to skeletal mesh

	Template.iPhysicsImpulse = 5;

	//Template.UpgradeItem = 'SMG_BM';
	Template.CreatorTemplateName = 'LightWeapons_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SMG_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateSMG_Coil_Template(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'smg';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage ="img:///" $ class'X2Item_Coilguns'.default.SMG_Coil_ImagePath;
	Template.WeaponPanelImage = "";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;
	Template.Abilities.Additem('SMG_CG_StatBonus');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_SMGAbilities'.default.SMG_COIL_MOBILITY_BONUS);

	Template.RangeAccuracy = class'X2Item_Coilguns'.default.MIDSHORT_COIL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,1.0f);
	Template.Aim = class'X2Item_Coilguns'.default.SMG_COIL_AIM;
	Template.CritChance = class'X2Item_Coilguns'.default.SMG_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_Coilguns'.default.SMG_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_Coilguns'.default.SMG_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_Coilguns'.default.SMG_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 3;

	Template.GameArchetype = "LWSMG_CG.Archetypes.WP_SMG_CG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "LWAssaultRifle_CG.Meshes.LW_CoilRifle_MagA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_MagA");
	Template.AddDefaultAttachment('Stock', "LWAccessories_CG.Meshes.LW_Coil_StockA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_StockA");
	Template.AddDefaultAttachment('Reargrip', "LWAccessories_CG.Meshes.LW_Coil_ReargripA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSMG_ReargripA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight"); //, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");  // re-use common conventional flashlight

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('RapidFire');
	Template.Abilities.AddItem('RunAndGun');

	// Template.Abilities.AddItem('CoilgunBonusShredAbility');

	Template.iPhysicsImpulse = 5;
	Template.CreatorTemplateName = 'LightWeapons_CG_Schematic'; // The schematic which creates this item

	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}


static function X2DataTemplate CreateTemplate_SMG_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'smg';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///UILibrary_SMG.Beam.LWBeamSMG_Base";
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.Abilities.AddItem('SMG_BM_StatBonus');
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, eStat_Mobility, class'X2Ability_SMGAbilities'.default.SMG_BEAM_MOBILITY_BONUS);

	Template.RangeAccuracy = class'X2Item_SMGWeapon'.default.MIDSHORT_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,0.75f,1.0f);
	Template.Aim = class'X2Item_SMGWeapon'.default.SMG_BEAM_AIM;
	Template.CritChance = class'X2Item_SMGWeapon'.default.SMG_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_SMGWeapon'.default.SMG_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_SMGWeapon'.default.SMG_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_SMGWeapon'.default.SMG_BEAM_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = class'X2Item_SMGWeapon'.default.SMG_BEAM_UPGRADESLOTS;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	//Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('HipFire_LW');
	Template.Abilities.AddItem('PlasmaReload');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWSMG_BM.WP_SMG_BM";

	//Parameters are : 	AttachSocket, UIArmoryCameraPointTag, MeshName, ProjectileName, MatchWeaponTemplate, AttachToPawn, IconName, InventoryIconName, InventoryCategoryIcon, ValidateAttachmentFn
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "BeamAssaultRifle.Meshes.SM_BeamAssaultRifle_MagA", , "img:///UILibrary_SMG.Beam.LWBeamSMG_MagA");
	//Template.AddDefaultAttachment('Suppressor', "LWSMG_BM.Meshes.SM_LWBeamSMG_SuppressorA", , "img:///UILibrary_Common.UI_BeamAssaultRifle.BeamAssaultRifle_SupressorA");
	Template.AddDefaultAttachment('Core', "LWSMG_BM.Meshes.SK_LWBeamSMG_CoreB", , "img:///UILibrary_SMG.Beam.LWBeamSMG_CoreA");
	Template.AddDefaultAttachment('HeatSink', "LWSMG_BM.Meshes.SK_LWBeamSMG_HeatsinkA", , "img:///UILibrary_SMG.Beam.LWBeamSMG_HeatsinkA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'LightWeapons_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SMG_MG'; // Which item this will be upgraded from
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Shotgun_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.ConvShotgun.ConvShotgun_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 1;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('CloseCombatSpecialist');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Shotgun_CV.WP_Shotgun_CV";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';
	Template.AddDefaultAttachment('Foregrip', "ConvShotgun.Meshes.SM_ConvShotgun_ForegripA" /*FORGRIP INCLUDED IN MAG IMAGE*/);
	Template.AddDefaultAttachment('Mag', "ConvShotgun.Meshes.SM_ConvShotgun_MagA", , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_MagA");
	Template.AddDefaultAttachment('Reargrip', "ConvShotgun.Meshes.SM_ConvShotgun_ReargripA" /*REARGRIP IS INCLUDED IN THE TRIGGER IMAGE*/);
	Template.AddDefaultAttachment('Stock', "ConvShotgun.Meshes.SM_ConvShotgun_StockA", , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_StockA");
	Template.AddDefaultAttachment('Trigger', "ConvShotgun.Meshes.SM_ConvShotgun_TriggerA", , "img:///UILibrary_Common.ConvShotgun.ConvShotgun_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTemplate_Shotgun_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = GetWeaponTech(Tier); 
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///" $ class'X2Item_LaserWeapons'.default.Shotgun_Laser_ImagePath;
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_LaserWeapons'.default.SHORT_LASER_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_LaserWeapons'.default.SHOTGUN_LASER_AIM;
	Template.CritChance = class'X2Item_LaserWeapons'.default.SHOTGUN_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_LaserWeapons'.default.SHOTGUN_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LaserWeapons'.default.SHOTGUN_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LaserWeapons'.default.SHOTGUN_LASER_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = class'X2Item_LaserWeapons'.default.SHOTGUN_LASER_UPGRADESLOTS; 
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('CloseCombatSpecialist');
	Template.Abilities.AddItem('CoolUnderPressure');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWShotgun_LS.Archetype.WP_Shotgun_LS";

	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';
	Template.AddDefaultAttachment('Mag', "LWShotgun_LS.Meshes.SK_LaserShotgun_Mag_A", , "img:///UILibrary_LW_LaserPack.LaserShotgun_MagA");
	Template.AddDefaultAttachment('Stock', "LWShotgun_LS.Meshes.SK_LaserShotgun_Stock_A", , "img:///UILibrary_LW_LaserPack.LaserShotgun_StockA");
	Template.AddDefaultAttachment('Reargrip', "LWAttachments_LS.Meshes.SK_Laser_Trigger_A", , "img:///UILibrary_LW_LaserPack.LaserShotgun_TriggerA");
	Template.AddDefaultAttachment('Foregrip', "LWAttachments_LS.Meshes.SK_Laser_Foregrip_A", , "img:///UILibrary_LW_LaserPack.LaserShotgun_ForegripA");
	
	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.CreatorTemplateName = 'HeavyWeapons_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Shotgun_MG'; // Which item this will be upgraded from

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';  

	return Template;
}


static function X2DataTemplate CreateTemplate_Shotgun_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.75f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.default.SHOTGUN_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.default.SHOTGUN_MAGNETIC_CRITCHANCE;
	Template.iClipSize =class'X2Item_DefaultWeapons'.default. default.SHOTGUN_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.default.SHOTGUN_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.default.SHOTGUN_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	//Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('ShardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('CloseEncounters');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Shotgun_MG.WP_Shotgun_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';
	Template.AddDefaultAttachment('Foregrip', "MagShotgun.Meshes.SM_MagShotgun_ForegripA", , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_ForegripA");
	Template.AddDefaultAttachment('Mag', "MagShotgun.Meshes.SM_MagShotgun_MagA", , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_MagA");
	Template.AddDefaultAttachment('Reargrip', "MagShotgun.Meshes.SM_MagShotgun_ReargripA" /* included in trigger image */);
	Template.AddDefaultAttachment('Stock', "MagShotgun.Meshes.SM_MagShotgun_StockA", , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_StockA");
	Template.AddDefaultAttachment('Trigger', "MagShotgun.Meshes.SM_MagShotgun_TriggerA", , "img:///UILibrary_Common.UI_MagShotgun.MagShotgun_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.CreatorTemplateName = 'Shotgun_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Shotgun_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateShotgun_Coil_Template(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage ="img:///" $ class'X2Item_CoilGuns'.default.Shotgun_Coil_ImagePath;
	Template.WeaponPanelImage = "";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_Coilguns'.default.SHORT_COIL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_Coilguns'.default.SHOTGUN_COIL_AIM;
	Template.CritChance = class'X2Item_Coilguns'.default.SHOTGUN_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_Coilguns'.default.SHOTGUN_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_Coilguns'.default.SHOTGUN_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_Coilguns'.default.SHOTGUN_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 3;

	Template.GameArchetype = "LWShotgun_CG.Archetypes.WP_Shotgun_CG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';
	Template.AddDefaultAttachment('Stock', "LWAccessories_CG.Meshes.LW_Coil_StockA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_StockA");
	Template.AddDefaultAttachment('Reargrip', "LWAccessories_CG.Meshes.LW_Coil_ReargripA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilShotgun_ReargripA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight"); //, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");  // re-use common conventional flashlight

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('CloseEncounters');
	Template.Abilities.AddItem('SlugShot');

	// Template.Abilities.AddItem('CoilgunBonusShredAbility');

	Template.iPhysicsImpulse = 5;
	Template.CreatorTemplateName = 'HeavyWeapons_CG_Schematic'; // The schematic which creates this item

	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_Shotgun_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('CloseCombatSpecialist');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Shotgun_BM.WP_Shotgun_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';
	Template.AddDefaultAttachment('Mag', "BeamShotgun.Meshes.SM_BeamShotgun_MagA", , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_MagA");
	Template.AddDefaultAttachment('Suppressor', "BeamShotgun.Meshes.SM_BeamShotgun_SuppressorA", , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_SupressorA");
	Template.AddDefaultAttachment('Core_Left', "BeamShotgun.Meshes.SM_BeamShotgun_CoreA", , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_CoreA");
	Template.AddDefaultAttachment('Core_Right', "BeamShotgun.Meshes.SM_BeamShotgun_CoreA");
	Template.AddDefaultAttachment('HeatSink', "BeamShotgun.Meshes.SM_BeamShotgun_HeatSinkA", , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_HeatsinkA");
	Template.AddDefaultAttachment('Foregrip', "BeamShotgun.Meshes.SM_BeamShotgun_ForegripA", , "img:///UILibrary_Common.UI_BeamShotgun.BeamShotgun_Foregrip");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.CreatorTemplateName = 'Shotgun_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'Shotgun_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTLE1Shotgun(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Shotgun_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_CONVENTIONAL_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('CloseCombatSpecialist');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Shotgun.WP_TLE1Shotgun";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTLE2Shotgun(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Shotgun_Laser_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_MAGNETIC_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('RapidDeployment');
	Template.Abilities.AddItem('CheapShot');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Shotgun.WP_TLE2Shotgun";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.CreatorTemplateName = 'Shotgun_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Shotgun_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTLE3Shotgun(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamShotgun";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shotgun';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Shotgun_Plasma_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.SHORT_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SHOTGUN_BEAM_IENVIRONMENTDAMAGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	//Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.Abilities.AddItem('Brawler2');
	Template.Abilities.AddItem('TrenchGun');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Shotgun.WP_TLE3Shotgun";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Shotgun';

	Template.iPhysicsImpulse = 5;

	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 16.0f;

	Template.CreatorTemplateName = 'Shotgun_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_Shotgun_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_SniperRifle_Conventional(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.ConvSniper.ConvSniper_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 1;
	Template.iTypicalActionCost = 2;

	Template.bIsLargeWeapon = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Disabler');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SniperRifle_CV.WP_SniperRifle_CV";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Mag', "ConvSniper.Meshes.SM_ConvSniper_MagA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_MagA");
	Template.AddDefaultAttachment('Optic', "ConvSniper.Meshes.SM_ConvSniper_OpticA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_OpticA");
	Template.AddDefaultAttachment('Reargrip', "ConvSniper.Meshes.SM_ConvSniper_ReargripA" /*REARGRIP INCLUDED IN TRIGGER IMAGE*/);
	Template.AddDefaultAttachment('Stock', "ConvSniper.Meshes.SM_ConvSniper_StockA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_StockA");
	Template.AddDefaultAttachment('Suppressor', "ConvSniper.Meshes.SM_ConvSniper_SuppressorA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_SuppressorA");
	Template.AddDefaultAttachment('Trigger', "ConvSniper.Meshes.SM_ConvSniper_TriggerA", , "img:///UILibrary_Common.ConvSniper.ConvSniper_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}


static function X2DataTemplate CreateTemplate_SniperRifle_Laser(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = GetWeaponTech(Tier); 
	Template.ItemCat = 'weapon';
	Template.strImage = "img:///" $ class'X2Item_LaserWeapons'.default.SniperRifle_Laser_ImagePath;
	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_LaserWeapons'.default.LONG_LASER_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_LaserWeapons'.default.SNIPERRIFLE_LASER_AIM;
	Template.CritChance = class'X2Item_LaserWeapons'.default.SNIPERRIFLE_LASER_CRITCHANCE;
	Template.iClipSize = class'X2Item_LaserWeapons'.default.SNIPERRIFLE_LASER_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_LaserWeapons'.default.SNIPERRIFLE_LASER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LaserWeapons'.default.SNIPERRIFLE_LASER_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = class'X2Item_LaserWeapons'.default.SNIPERRIFLE_LASER_UPGRADESLOTS; 
	Template.iTypicalActionCost = 2;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('PrecisionShot');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWSniperRifle_LS.Archetype.WP_SniperRifle_LS";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Mag', "LWAttachments_LS.Meshes.SK_Laser_Mag_A", , "img:///UILibrary_LW_LaserPack.LaserSniper_MagA");
	Template.AddDefaultAttachment('Stock', "LWAttachments_LS.Meshes.SK_Laser_Stock_A", , "img:///UILibrary_LW_LaserPack.LaserSniper_StockA");
	Template.AddDefaultAttachment('Reargrip', "LWAttachments_LS.Meshes.SK_Laser_Trigger_A", , "img:///UILibrary_LW_LaserPack.LaserSniper_TriggerA");
	Template.AddDefaultAttachment('Foregrip', "LWAttachments_LS.Meshes.SK_Laser_Foregrip_A", , "img:///UILibrary_LW_LaserPack.LaserSniper_ForegripA");
	Template.AddDefaultAttachment('Optic', "LWSniperRifle_LS.Meshes.SK_LaserSniper_Optic_A", , "img:///UILibrary_LW_LaserPack.LaserSniper_OpticA");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.CreatorTemplateName = 'PrecisionWeapons_LS_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SniperRifle_MG'; // Which item this will be upgraded from

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom'; 

	return Template;
}

static function X2DataTemplate CreateTemplate_SniperRifle_Magnetic(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.UI_MagSniper.MagSniper_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.75f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	Template.iTypicalActionCost = 2;

	Template.bIsLargeWeapon = true;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Deadeye');
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SniperRifle_MG.WP_SniperRifle_MG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Mag', "MagSniper.Meshes.SM_MagSniper_MagA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_MagA");
	Template.AddDefaultAttachment('Optic', "MagSniper.Meshes.SM_MagSniper_OpticA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_OpticA");
	Template.AddDefaultAttachment('Reargrip',   "MagSniper.Meshes.SM_MagSniper_ReargripA" /* image included in TriggerA */);
	Template.AddDefaultAttachment('Stock', "MagSniper.Meshes.SM_MagSniper_StockA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_StockA");
	Template.AddDefaultAttachment('Suppressor', "MagSniper.Meshes.SM_MagSniper_SuppressorA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_SuppressorA");
	Template.AddDefaultAttachment('Trigger', "MagSniper.Meshes.SM_MagSniper_TriggerA", , "img:///UILibrary_Common.UI_MagSniper.MagSniper_TriggerA");
	Template.AddDefaultAttachment('Light', "ConvAttachments.Meshes.SM_ConvFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'SniperRifle_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SniperRifle_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateSniperRifle_Coil_Template(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.ItemCat = 'weapon';
	Template.strImage ="img:///" $ class'X2Item_CoilGuns'.default.SniperRifle_Coil_ImagePath;
	Template.WeaponPanelImage = "";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;
	Template.iTypicalActionCost = 2;

	Template.RangeAccuracy = class'X2Item_CoilGuns'.default.LONG_COIL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.75f);
	Template.Aim = class'X2Item_CoilGuns'.default.SNIPERRIFLE_COIL_AIM;
	Template.CritChance = class'X2Item_CoilGuns'.default.SNIPERRIFLE_COIL_CRITCHANCE;
	Template.iClipSize = class'X2Item_CoilGuns'.default.SNIPERRIFLE_COIL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_CoilGuns'.default.SNIPERRIFLE_COIL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_CoilGuns'.default.SNIPERRIFLE_COIL_IENVIRONMENTDAMAGE;

	Template.NumUpgradeSlots = 3;

	Template.GameArchetype = "LWSniperRifle_CG.Archetypes.WP_SniperRifle_CG";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Mag', "LWSniperRifle_CG.Meshes.LW_CoilSniper_MagA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_MagA");
	Template.AddDefaultAttachment('Optic', "BeamSniper.Meshes.SM_BeamSniper_OpticA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_OpticA");
	Template.AddDefaultAttachment('Stock', "LWAccessories_CG.Meshes.LW_Coil_StockB", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_StockB");
	Template.AddDefaultAttachment('Reargrip', "LWAccessories_CG.Meshes.LW_Coil_ReargripA", , "img:///UILibrary_LW_Overhaul.InventoryArt.CoilSniperRifle_ReargripA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight"); //, , "img:///UILibrary_Common.ConvAssaultRifle.ConvAssault_LightA");  // re-use common conventional flashlight

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	// Template.Abilities.AddItem('CoilgunBonusShredAbility');

	Template.iPhysicsImpulse = 5;
	Template.CreatorTemplateName = 'PrecisionWeapons_CG_Schematic'; // The schematic which creates this item

	Template.CanBeBuilt = true;
	Template.bInfiniteItem = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTemplate_SniperRifle_Beam(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.Aim = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_IENVIRONMENTDAMAGE;
	Template.NumUpgradeSlots = 2;
	Template.iTypicalActionCost = 2;
	Template.InfiniteAmmo = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SniperRifle_BM.WP_SniperRifle_BM";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';
	Template.AddDefaultAttachment('Optic', "BeamSniper.Meshes.SM_BeamSniper_OpticA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_OpticA");
	Template.AddDefaultAttachment('Mag', "BeamSniper.Meshes.SM_BeamSniper_MagA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_MagA");
	Template.AddDefaultAttachment('Suppressor', "BeamSniper.Meshes.SM_BeamSniper_SuppressorA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_SupressorA");
	Template.AddDefaultAttachment('Core', "BeamSniper.Meshes.SM_BeamSniper_CoreA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_CoreA");
	Template.AddDefaultAttachment('HeatSink', "BeamSniper.Meshes.SM_BeamSniper_HeatSinkA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_HeatsinkA");
	Template.AddDefaultAttachment('Light', "BeamAttachments.Meshes.BeamFlashLight");

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'SniperRifle_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'SniperRifle_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}

static function X2DataTemplate CreateTLE1SniperRifle(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sniper_Base";
	Template.EquipSound = "Conventional_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_CONVENTIONAL_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.SNIPERRIFLE_TLE_CONVENTIONAL_AIM;
	Template.CritChance = default.SNIPERRIFLE_TLE_CONVENTIONAL_CRITCHANCE;
	Template.iClipSize = default.SNIPERRIFLE_TLE_CONVENTIONAL_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.iTypicalActionCost = 2;

	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE1Sniper.WP_TLE1Sniper";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';

	Template.iPhysicsImpulse = 5;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTLE2SniperRifle(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_MagneticSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sniper_Laser_Base";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_MAGNETIC_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.SNIPERRIFLE_TLE_MAGNETIC_AIM;
	Template.CritChance = default.SNIPERRIFLE_TLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = default.SNIPERRIFLE_TLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iTypicalActionCost = 2;

	Template.bIsLargeWeapon = true;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE2Sniper.WP_TLE2Sniper";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'SniperRifle_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_SniperRifle_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_MagXCom';

	return Template;
}

static function X2DataTemplate CreateTLE3SniperRifle(name TemplateName, int Tier)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_BeamSniperRifle";

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sniper_rifle';
	Template.WeaponTech = GetWeaponTech(Tier);
	Template.strImage = "img:///UILibrary_TLE_Common.TLE_Sniper_Plasma_Base";
	Template.EquipSound = "Beam_Weapon_Equip";
	Template.Tier = Tier;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.LONG_BEAM_RANGE;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.Aim = default.SNIPERRIFLE_TLE_BEAM_AIM;
	Template.CritChance = default.SNIPERRIFLE_TLE_BEAM_CRITCHANCE;
	Template.iClipSize = default.SNIPERRIFLE_TLE_BEAM_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.SNIPERRIFLE_BEAM_IENVIRONMENTDAMAGE;
	Template.iTypicalActionCost = 2;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('SniperStandardFire');
	Template.Abilities.AddItem('SniperRifleOverwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "TLE3Sniper.WP_TLE3Sniper";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_Sniper';

	Template.iPhysicsImpulse = 5;

	Template.CreatorTemplateName = 'SniperRifle_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'TLE_SniperRifle_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';

	return Template;
}


static function X2DataTemplate CreateTemplate_ShardGauntlet(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'ShardGauntletLeft_CV';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gauntlet';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvTGauntlet";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet";
	Template.AltGameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_F";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.ExtraDamage = GetGauntletsExtraWeaponDamage(Tier);
	Template.Aim = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_CONVENTIONAL_CRITCHANCE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Psi';

	Template.Abilities.AddItem('Rend');
	Template.Abilities.AddItem('IRI_TemplarShield');
	Template.Abilities.AddItem('VoidConduit');
	Template.Abilities.AddItem('DeepFocus');

	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Psi';

	return Template;
}

static function X2DataTemplate CreateTemplate_CasterGauntlet(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'ShardGauntletLeft_MG';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gauntlet';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_MagTGauntlet";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_MG";
	Template.AltGameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_F_MG";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.ExtraDamage = GetGauntletsExtraWeaponDamage(Tier);
	Template.Aim = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_MAGNETIC_CRITCHANCE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Psi';

	Template.Abilities.AddItem('IRI_SoulShot');
	Template.Abilities.AddItem('IonicStorm');
	Template.Abilities.AddItem('Volt');
	Template.Abilities.AddItem('DeepFocus');
	Template.Abilities.AddItem('SupremeFocus');

	Template.CreatorTemplateName = 'ShardGauntlet_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'ShardGauntlet_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Psi';

	return Template;
}

static function X2DataTemplate CreateTemplate_BladeMasterGauntlet(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'ShardGauntletLeft_BM';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gauntlet';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_BeamTGauntlet";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_BM";
	Template.AltGameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_F_BM";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier,1.5f);
	Template.ExtraDamage = GetGauntletsExtraWeaponDamage(Tier);
	Template.Aim = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_BEAM_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_BEAM_CRITCHANCE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_BEAM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Psi';

	Template.Abilities.AddItem('Rend');
	Template.Abilities.AddItem('TemplarBladestorm');
	Template.Abilities.AddItem('Amplify');

	Template.CreatorTemplateName = 'ShardGauntlet_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'ShardGauntlet_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Psi';

	return Template;
}

static function X2DataTemplate CreateTemplate_TacticianGauntlet(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'ShardGauntletLeft_MG';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gauntlet';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_MagTGauntlet";
	Template.EquipSound = "Sword_Equip_Magnetic";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_MG";
	Template.AltGameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_F_MG";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.ExtraDamage = GetGauntletsExtraWeaponDamage(Tier);
	Template.Aim = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_MAGNETIC_CRITCHANCE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Psi';

	Template.Abilities.AddItem('IRI_SoulShot');
	Template.Abilities.AddItem('Invert');
	Template.Abilities.AddItem('StunStrike');
	Template.Abilities.AddItem('DeepFocus');
	Template.Abilities.AddItem('SupremeFocus');

	Template.CreatorTemplateName = 'ShardGauntlet_MG_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'ShardGauntlet_CV'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Psi';

	return Template;
}

static function X2DataTemplate CreateTemplate_PowerGauntlet(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'ShardGauntletLeft_BM';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gauntlet';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_BeamTGauntlet";
	Template.EquipSound = "Sword_Equip_Beam";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_BM";
	Template.AltGameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_F_BM";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier,1.5f);
	Template.ExtraDamage = GetGauntletsExtraWeaponDamage(Tier);
	Template.Aim = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_BEAM_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_BEAM_CRITCHANCE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_BEAM_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Psi';

	Template.Abilities.AddItem('Rend');
	Template.Abilities.AddItem('ArcWave');
	Template.Abilities.AddItem('Apotheosis');
	Template.Abilities.AddItem('DeepFocus');

	Template.CreatorTemplateName = 'ShardGauntlet_BM_Schematic'; // The schematic which creates this item
	Template.BaseItem = 'ShardGauntlet_MG'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Psi';

	return Template;
}

static function X2DataTemplate CreateTemplate_ReplicatorGauntlet(name TemplateName, int Tier)
{
	local X2PairedWeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2PairedWeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.
	Template.PairedSlot = eInvSlot_TertiaryWeapon;
	Template.PairedTemplateName = 'ShardGauntletLeft_CV';

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'gauntlet';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvTGauntlet";
	Template.EquipSound = "Sword_Equip_Conventional";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	//Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet";
	Template.AltGameArchetype = "WP_TemplarGauntlet.WP_TemplarGauntlet_F";
	Template.GenderForAltArchetype = eGender_Female;
	Template.Tier = Tier;
	Template.bUseArmorAppearance = true;

	Template.iRadius = 1;
	Template.NumUpgradeSlots = 0;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.iRange = 0;
	Template.BaseDamage = GetWeaponDamage(Tier,1.25f);
	Template.ExtraDamage = GetGauntletsExtraWeaponDamage(Tier);
	Template.Aim = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_CONVENTIONAL_AIM;
	Template.CritChance = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_CONVENTIONAL_CRITCHANCE;
	Template.iSoundRange = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_CONVENTIONAL_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_XpackWeapons'.default.SHARDGAUNTLET_CONVENTIONAL_IENVIRONMENTDAMAGE;
	Template.BaseDamage.DamageType = 'Psi';

	Template.Abilities.AddItem('Rend');
	Template.Abilities.AddItem('Ghost');
	Template.Abilities.AddItem('Volt');
	Template.Abilities.AddItem('DeepFocus');

	Template.StartingItem = false;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Psi';

	return Template;
}
