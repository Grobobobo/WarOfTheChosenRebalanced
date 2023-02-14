//--------------------------------------------------------------------------------------- 
//  FILE:    X2Item_LWAlienweapons.uc
//  AUTHOR:	 Amineri / John Lumpkin (Pavonis Interactive)
//  PURPOSE: Defines news weapon for ADVENT/alien forces
//--------------------------------------------------------------------------------------- 
//Extending X2Item_DefaultWeapons to make the config copy pasting easier
class X2Item_LWAlienWeapons extends X2Item_DefaultWeapons config(GameData_WeaponData);

var config WeaponDamageValue MUTONM2_LW_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTONM2_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTONM2_LW_MELEEATTACK_BASEDAMAGE;

var config int MutonM2_LW_IDEALRANGE;
var config int MutonM2_LW_GRENADE_iENVIRONMENTDAMAGE;
var config int MutonM2_LW_GRENADE_iRANGE;
var config int MutonM2_LW_GRENADE_iRADIUS;

var config WeaponDamageValue MUTONM3_LW_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTONM3_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTONM3_LW_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue MUTONM4_LW_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTONM4_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTONM4_LW_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue MUTONM5_LW_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTONM5_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTONM5_LW_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue MUTON_LEADER_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTON_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTON_LEADER_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue MUTONM2_LEADER_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTONM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTONM2_LEADER_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue MUTONM3_LEADER_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTONM3_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTONM3_LEADER_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue MUTONM4_LEADER_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTONM4_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTONM4_LEADER_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue MUTONM5_LEADER_GRENADE_BASEDAMAGE;
var config WeaponDamageValue MUTONM5_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue MUTONM5_LEADER_MELEEATTACK_BASEDAMAGE;

var config int MutonM3_LW_IDEALRANGE;
var config int MutonM3_LW_WPN_ICLIPSIZE;

var config int MutonM3_LW_GRENADE_iENVIRONMENTDAMAGE;
var config int MutonM3_LW_GRENADE_iRANGE;
var config int MutonM3_LW_GRENADE_iRADIUS;

var config WeaponDamageValue VIPERM2_WPN_BASEDAMAGE;
var config WeaponDamageValue VIPERM3_WPN_BASEDAMAGE;
var config WeaponDamageValue VIPERM4_WPN_BASEDAMAGE;
var config WeaponDamageValue VIPERM5_WPN_BASEDAMAGE;

var config WeaponDamageValue VIPER_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue VIPERM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue VIPERM3_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue VIPERM4_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue VIPERM5_LEADER_WPN_BASEDAMAGE;

var config WeaponDamageValue NAJA_WPN_BASEDAMAGE;
var config WeaponDamageValue NAJAM2_WPN_BASEDAMAGE;
var config WeaponDamageValue NAJAM3_WPN_BASEDAMAGE;
var config int NAJA_WPN_ICLIPSIZE;
var config int NAJA_IDEALRANGE;

var config WeaponDamageValue SIDEWINDER_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM2_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM3_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM4_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM5_WPN_BASEDAMAGE;
var config int SIDEWINDER_WPN_ICLIPSIZE;
var config int SIDEWINDER_IDEALRANGE;

var config WeaponDamageValue SIDEWINDER_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM3_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM4_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM5_LEADER_WPN_BASEDAMAGE;

var config WeaponDamageValue SIDEWINDER_LEADER_SWORD_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM2_LEADER_SWORD_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM3_LEADER_SWORD_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM4_LEADER_SWORD_WPN_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM5_LEADER_SWORD_WPN_BASEDAMAGE;

var config WeaponDamageValue SIDEWINDER_LEADER_GLOB_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM2_LEADER_GLOB_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM3_LEADER_GLOB_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM4_LEADER_GLOB_BASEDAMAGE;
var config WeaponDamageValue SIDEWINDERM5_LEADER_GLOB_BASEDAMAGE;

var config int ADVSENTRY_IDEALRANGE;
var config WeaponDamageValue AdvSentryM1_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvSentryM2_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvSentryM3_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvSentryM4_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvSentryM5_WPN_BASEDAMAGE;

var config int ADVGRENADIER_FLASHBANGGRENADE_RANGE;
var config int ADVGRENADIER_FLASHBANGGRENADE_RADIUS;
var config int ADVGRENADIER_FLASHBANGGRENADE_IENVIRONMENTDAMAGE;
var config int ADVGRENADIER_FLASHBANGGRENADE_ICLIPSIZE;

var config WeaponDamageValue ADVGRENADIER_FIREGRENADE_BASEDAMAGE;
var config int ADVGRENADIER_FIREGRENADE_RANGE;
var config int ADVGRENADIER_FIREGRENADE_RADIUS;
var config int ADVGRENADIER_FIREGRENADE_COVERAGE;
var config int ADVGRENADIER_FIREGRENADE_ISOUNDRANGE;
var config int ADVGRENADIER_FIREBOMB_IENVIRONMENTDAMAGE;
var config int ADVGRENADIER_FIREBOMB_ICLIPSIZE;

var config WeaponDamageValue ADVGRENADIER_ACIDGRENADE_BASEDAMAGE;
var config int ADVGRENADIER_ACIDGRENADE_RANGE;
var config int ADVGRENADIER_ACIDGRENADE_RADIUS;
var config int ADVGRENADIER_ACIDGRENADE_COVERAGE;
var config int ADVGRENADIER_ACIDGRENADE_ISOUNDRANGE;
var config int ADVGRENADIER_ACIDGRENADE_IENVIRONMENTDAMAGE;
var config int ADVGRENADIER_ACIDGRENADE_ICLIPSIZE;

var config int ADVGRENADIER_IDEALRANGE;

var config WeaponDamageValue ADVROCKETEERM1_ROCKETEERLAUNCHER_BASEDAMAGE;
var config int ADVROCKETEERM1_ROCKETEERLAUNCHER_ISOUNDRANGE;
var config int ADVROCKETEERM1_ROCKETEERLAUNCHER_IENVIRONMENTDAMAGE;
var config int ADVROCKETEERM1_ROCKETEERLAUNCHER_CLIPSIZE;
var config int ADVROCKETEERM1_ROCKETEERLAUNCHER_RANGE;
var config int ADVROCKETEERM1_ROCKETEERLAUNCHER_RADIUS;
var config int ADVROCKETEERM1_IDEALRANGE;

var config WeaponDamageValue ADVGUNNER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVGUNNERM2_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVGUNNERM3_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVGUNNERM4_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVGUNNERM5_WPN_BASEDAMAGE;
var config int ADVGUNNER_IDEALRANGE;
var config int ADVGUNNER_WPN_CLIPSIZE;

var config int AdvMECArcher_IdealRange;
var config WeaponDamageValue AdvMECArcher_Wpn_BaseDamage;
var config int AdvMECArcher_Wpn_Clipsize;
var config int AdvMECArcher_Wpn_EnvironmentDamage;
var config WeaponDamageValue AdvMECArcher_MicroMissiles_BaseDamage;
var config int AdvMECArcher_MicroMissiles_Clipsize;
var config int AdvMECArcher_MicroMissiles_EnvironmentDamage;
var config int AdvMECArcher_Micromissiles_Range;

var config WeaponDamageValue LWDRONEM1_DRONEWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM2_DRONEWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM3_DRONEWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM4_DRONEWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM5_DRONEWEAPON_BASEDAMAGE;

var config WeaponDamageValue LWDRONE_LEADER_DRONEWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM2_LEADER_DRONEWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM3_LEADER_DRONEWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM4_LEADER_DRONEWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM5_LEADER_DRONEWEAPON_BASEDAMAGE;

var config int LWDRONE_DRONEWEAPON_ISOUNDRANGE;
var config int LWDRONE_DRONEWEAPON_IENVIRONMENTDAMAGE;
var config int LWDRONE_DRONEWEAPON_RANGE;

var config WeaponDamageValue LWDRONEM1_DRONEREPAIRWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM2_DRONEREPAIRWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM3_DRONEREPAIRWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM4_DRONEREPAIRWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM5_DRONEREPAIRWEAPON_BASEDAMAGE;


var config WeaponDamageValue LWDRONE_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM2_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM3_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM4_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE;
var config WeaponDamageValue LWDRONEM5_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE;

var config int LWDRONE_DRONEREPAIRWEAPON_ISOUNDRANGE;
var config int LWDRONE_DRONEREPAIRWEAPON_IENVIRONMENTDAMAGE;
var config int LWDRONE_DRONEREPAIRWEAPON_RANGE;

var config int LWDRONE_IDEALRANGE;

var config int ADVVANGUARD_IDEALRANGE;

var config WeaponDamageValue AdvSergeantM1_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvSergeantM2_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvShockTroop_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvCommando_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvVanguard_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvScout_WPN_BASEDAMAGE;

var config WeaponDamageValue AdvGeneralM1_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvGeneralM2_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvGeneralM3_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvGeneralM4_LW_WPN_BASEDAMAGE;
var config WeaponDamageValue AdvGeneralM5_LW_WPN_BASEDAMAGE;

var config WeaponDamageValue ADVTROOPERM4_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVTROOPERM5_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVSHIELDBEARERM4_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVSHIELDBEARERM5_WPN_BASEDAMAGE;

var config array<WeaponDamageValue> SPECTREM3_PSI_ABILITYDAMAGE;
var config array<WeaponDamageValue> SPECTREM4_PSI_ABILITYDAMAGE;
var config WeaponDamageValue SPECTREM3_WPN_BASEDAMAGE;
var config WeaponDamageValue SPECTREM4_WPN_BASEDAMAGE;

var config WeaponDamageValue GATEKEEPERM2_WPN_BASEDAMAGE;
var config WeaponDamageValue GATEKEEPERM3_WPN_BASEDAMAGE;

var config WeaponDamageValue SECTOPODM2_WPN_BASEDAMAGE;
var config WeaponDamageValue SECTOPODM3_WPN_BASEDAMAGE;

var config WeaponDamageValue ANDROMEDONM2_WPN_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONM3_WPN_BASEDAMAGE;

var config WeaponDamageValue ANDROMEDONROBOT_MELEEATTACKM2_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONROBOT_MELEEATTACKM3_BASEDAMAGE;

var config WeaponDamageValue ANDROMEDONM2_ACIDBLOB_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONM3_ACIDBLOB_BASEDAMAGE;

var config WeaponDamageValue ANDROMEDON_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONM3_LEADER_WPN_BASEDAMAGE;

var config WeaponDamageValue ANDROMEDONROBOT_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONROBOT_LEADER_MELEEATTACKM2_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONROBOT_LEADER_MELEEATTACKM3_BASEDAMAGE;

var config WeaponDamageValue ANDROMEDON_LEADER_ACIDBLOB_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONM2_LEADER_ACIDBLOB_BASEDAMAGE;
var config WeaponDamageValue ANDROMEDONM3_LEADER_ACIDBLOB_BASEDAMAGE;

var config WeaponDamageValue AdvMEC_M3_MicroMissiles_BaseDamage;
var config WeaponDamageValue AdvMEC_M4_MicroMissiles_BaseDamage;
var config WeaponDamageValue AdvMEC_M5_MicroMissiles_BaseDamage;

var config WeaponDamageValue ADVMEC_M3_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVMEC_M4_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVMEC_M5_WPN_BASEDAMAGE;

var config WeaponDamageValue AdvMEC_Leader_MicroMissiles_BaseDamage;
var config WeaponDamageValue AdvMECM2_Leader_MicroMissiles_BaseDamage;
var config WeaponDamageValue AdvMECM3_Leader_MicroMissiles_BaseDamage;
var config WeaponDamageValue AdvMECM4_Leader_MicroMissiles_BaseDamage;
var config WeaponDamageValue AdvMECM5_Leader_MicroMissiles_BaseDamage;


var config WeaponDamageValue ADVMEC_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVMECM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVMECM3_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVMECM4_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVMECM5_LEADER_WPN_BASEDAMAGE;


var config WeaponDamageValue ARCHON_BLAZINGPINIONSM2_BASEDAMAGE;
var config WeaponDamageValue ARCHON_BLAZINGPINIONSM3_BASEDAMAGE;

var config WeaponDamageValue ARCHONM2_WPN_BASEDAMAGE;
var config WeaponDamageValue ARCHONM3_WPN_BASEDAMAGE;

var config WeaponDamageValue ARCHON_MELEEATTACKM2_BASEDAMAGE;
var config WeaponDamageValue ARCHON_MELEEATTACKM3_BASEDAMAGE;

var config WeaponDamageValue ARCHON_LEADER_BLAZINGPINIONS_BASEDAMAGE;
var config WeaponDamageValue ARCHON_LEADER_BLAZINGPINIONSM2_BASEDAMAGE;
var config WeaponDamageValue ARCHON_LEADER_BLAZINGPINIONSM3_BASEDAMAGE;

var config WeaponDamageValue ARCHON_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ARCHONM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ARCHONM3_LEADER_WPN_BASEDAMAGE;

var config WeaponDamageValue ARCHON_LEADERMELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue ARCHON_LEADERMELEEATTACKM2_BASEDAMAGE;
var config WeaponDamageValue ARCHON_LEADERMELEEATTACKM3_BASEDAMAGE;


var config WeaponDamageValue ADVSTUNLANCERM4_STUNLANCE_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM5_STUNLANCE_BASEDAMAGE;

var config WeaponDamageValue ADVSTUNLANCER_LEADER_STUNLANCE_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM2_LEADER_STUNLANCE_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM3_LEADER_STUNLANCE_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM4_LEADER_STUNLANCE_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM5_LEADER_STUNLANCE_BASEDAMAGE;

var config WeaponDamageValue ADVSTUNLANCERM4_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM5_WPN_BASEDAMAGE;

var config WeaponDamageValue ADVSTUNLANCER_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM3_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM4_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVSTUNLANCERM5_LEADER_WPN_BASEDAMAGE;



var config WeaponDamageValue ADVCAPTAINM4_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVCAPTAINM5_WPN_BASEDAMAGE;

var config WeaponDamageValue ADVCAPTAINM3_GRENADE_BASEDAMAGE;
var config WeaponDamageValue ADVCAPTAINM4_GRENADE_BASEDAMAGE;
var config WeaponDamageValue ADVCAPTAINM5_GRENADE_BASEDAMAGE;

var config WeaponDamageValue ADVTROOPERM3_GRENADE_BASEDAMAGE;
var config WeaponDamageValue ADVTROOPERM4_GRENADE_BASEDAMAGE;
var config WeaponDamageValue ADVTROOPERM5_GRENADE_BASEDAMAGE;

var config WeaponDamageValue SECTOIDM2_WPN_BASEDAMAGE;
var config WeaponDamageValue SECTOIDM3_WPN_BASEDAMAGE;
var config WeaponDamageValue SECTOIDM4_WPN_BASEDAMAGE;
var config WeaponDamageValue SECTOIDM5_WPN_BASEDAMAGE;

var config WeaponDamageValue SECTOID_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue SECTOIDM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue SECTOIDM3_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue SECTOIDM4_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue SECTOIDM5_LEADER_WPN_BASEDAMAGE;

var config WeaponDamageValue PSIZOMBIE_MELEEATTACKM2_BASEDAMAGE;
var config WeaponDamageValue PSIZOMBIE_MELEEATTACKM3_BASEDAMAGE;
var config WeaponDamageValue PSIZOMBIE_MELEEATTACKM4_BASEDAMAGE;
var config WeaponDamageValue PSIZOMBIE_MELEEATTACKM5_BASEDAMAGE;

var config WeaponDamageValue ADVPRIESTM4_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVPRIESTM5_WPN_BASEDAMAGE;

var config WeaponDamageValue ADVPRIEST_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVPRIESTM2_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVPRIESTM3_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVPRIESTM4_LEADER_WPN_BASEDAMAGE;
var config WeaponDamageValue ADVPRIESTM5_LEADER_WPN_BASEDAMAGE;

var config WeaponDamageValue BERSERKERM2_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue BERSERKERM3_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue BERSERKERM4_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue BERSERKER_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue BERSERKERM2_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue BERSERKERM3_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue BERSERKERM4_LEADER_MELEEATTACK_BASEDAMAGE;


var config WeaponDamageValue FACELESS_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue FACELESSM2_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue FACELESSM3_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue FACELESSM4_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue FACELESSM5_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue FACELESS_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue FACELESSM2_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue FACELESSM3_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue FACELESSM4_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue FACELESSM5_LEADER_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue CHRYSSALIDM2_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue CHRYSSALIDM3_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue CHRYSSALIDM4_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue CHRYSSALIDM5_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue NEONATECHRYSSALID_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue NEONATECHRYSSALIDM2_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue NEONATECHRYSSALIDM3_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue NEONATECHRYSSALIDM4_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue NEONATECHRYSSALIDM5_MELEEATTACK_BASEDAMAGE;

var config WeaponDamageValue CHRYSSALID_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue CHRYSSALIDM2_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue CHRYSSALIDM3_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue CHRYSSALIDM4_LEADER_MELEEATTACK_BASEDAMAGE;
var config WeaponDamageValue CHRYSSALIDM5_LEADER_MELEEATTACK_BASEDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	
	`LWTrace("  >> X2Item_LWAlienWeapons.CreateTemplates()");
	
	Templates.AddItem(CreateMuton_LWGrenade('MutonM2_LWGrenade', default.MUTONM2_LW_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateMuton_LWGrenade('MutonM3_LWGrenade', default.MUTONM3_LW_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateMuton_LWGrenade('MutonM4_LWGrenade', default.MUTONM4_LW_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateMuton_LWGrenade('MutonM5_LWGrenade', default.MUTONM5_LW_GRENADE_BASEDAMAGE));

	Templates.AddItem(CreateMuton_LWGrenade('Muton_Leader_Grenade', default.MUTON_LEADER_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateMuton_LWGrenade('MutonM2_Leader_Grenade', default.MUTONM2_LEADER_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateMuton_LWGrenade('MutonM3_Leader_Grenade', default.MUTONM3_LEADER_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateMuton_LWGrenade('MutonM4_Leader_Grenade', default.MUTONM4_LEADER_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateMuton_LWGrenade('MutonM5_Leader_Grenade', default.MUTONM5_LEADER_GRENADE_BASEDAMAGE));


	Templates.AddItem(CreateTemplate_MutonCenturion_LW_WPN('MutonM2_LW_WPN', default.MUTONM2_LW_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_MutonCenturion_LW_WPN('MutonM3_LW_WPN', default.MUTONM3_LW_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_MutonCenturion_LW_WPN('MutonM4_LW_WPN', default.MUTONM4_LW_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_MutonCenturion_LW_WPN('MutonM5_LW_WPN', default.MUTONM5_LW_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_MutonCenturion_LW_WPN('Muton_Leader_WPN', default.MUTON_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_MutonCenturion_LW_WPN('MutonM2_Leader_WPN', default.MUTONM2_LEADER_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_MutonElite_LW_WPN('MutonM3_Leader_WPN',default.MUTONM3_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_MutonElite_LW_WPN('MutonM4_Leader_WPN',default.MUTONM4_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_MutonElite_LW_WPN('MutonM5_Leader_WPN',default.MUTONM5_LEADER_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('MutonM2_LW_MeleeAttack', default.MUTONM2_LW_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('MutonM3_LW_MeleeAttack', default.MUTONM3_LW_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('MutonM4_LW_MeleeAttack', default.MUTONM4_LW_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('MutonM5_LW_MeleeAttack', default.MUTONM5_LW_MELEEATTACK_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('Muton_Leader_MeleeAttack', default.MUTON_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('MutonM2_Leader_MeleeAttack', default.MUTONM2_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('MutonM3_Leader_MeleeAttack', default.MUTONM3_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('MutonM4_Leader_MeleeAttack', default.MUTONM4_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Muton_LW_MeleeAttack('MutonM5_Leader_MeleeAttack', default.MUTONM5_LEADER_MELEEATTACK_BASEDAMAGE));



	Templates.AddItem(CreateTemplate_Sidewinder_WPN('SidewinderM1_WPN'));
	Templates.AddItem(CreateTemplate_Sidewinder_WPN('SidewinderM2_WPN'));
	Templates.AddItem(CreateTemplate_Sidewinder_WPN('SidewinderM3_WPN'));
	Templates.AddItem(CreateTemplate_Sidewinder_WPN('SidewinderM4_WPN'));
	Templates.AddItem(CreateTemplate_Sidewinder_WPN('SidewinderM5_WPN'));

	Templates.AddItem(CreateTemplate_Sidewinder_Leader_WPN('Sidewinder_Leader_WPN', default.SIDEWINDER_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sidewinder_Leader_WPN('SidewinderM2_Leader_WPN', default.SIDEWINDERM2_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sidewinder_Leader_WPN('SidewinderM3_Leader_WPN', default.SIDEWINDERM3_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sidewinder_Leader_WPN('SidewinderM4_Leader_WPN', default.SIDEWINDERM4_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sidewinder_Leader_WPN('SidewinderM5_Leader_WPN', default.SIDEWINDERM5_LEADER_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_PsiSpitGlob('Sidewinder_Leader_Glob', default.SIDEWINDER_LEADER_GLOB_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_PsiSpitGlob('SidewinderM2_Leader_Glob', default.SIDEWINDERM2_LEADER_GLOB_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_PsiSpitGlob('SidewinderM3_Leader_Glob', default.SIDEWINDERM3_LEADER_GLOB_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_PsiSpitGlob('SidewinderM4_Leader_Glob', default.SIDEWINDERM4_LEADER_GLOB_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_PsiSpitGlob('SidewinderM5_Leader_Glob', default.SIDEWINDERM5_LEADER_GLOB_BASEDAMAGE));


	Templates.AddItem(CreateTemplate_VorpalBlade('Sidewinder_Leader_Sword_WPN', default.SIDEWINDER_LEADER_SWORD_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_VorpalBlade('SidewinderM2_Leader_Sword_WPN', default.SIDEWINDERM2_LEADER_SWORD_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_VorpalBlade('SidewinderM3_Leader_Sword_WPN', default.SIDEWINDERM3_LEADER_SWORD_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_VorpalBlade('SidewinderM4_Leader_Sword_WPN', default.SIDEWINDERM4_LEADER_SWORD_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_VorpalBlade('SidewinderM5_Leader_Sword_WPN', default.SIDEWINDERM5_LEADER_SWORD_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_ViperMX_WPN('ViperM2_LW_WPN'));
	Templates.AddItem(CreateTemplate_ViperMX_WPN('ViperM3_LW_WPN'));
	Templates.AddItem(CreateTemplate_ViperMX_WPN('ViperM4_LW_WPN'));
	Templates.AddItem(CreateTemplate_ViperMX_WPN('ViperM5_LW_WPN'));

	Templates.AddItem(CreateTemplate_Viper_Leader_WPN('Viper_Leader_WPN', default.VIPER_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Viper_Leader_WPN('ViperM2_Leader_WPN', default.VIPERM2_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Viper_Leader_WPN('ViperM3_Leader_WPN', default.VIPERM3_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Viper_Leader_WPN('ViperM4_Leader_WPN', default.VIPERM4_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Viper_Leader_WPN('ViperM5_Leader_WPN', default.VIPERM5_LEADER_WPN_BASEDAMAGE));



	Templates.AddItem(CreateTemplate_AdvGunner_WPN('AdvGunnerM1_WPN', default.ADVGUNNER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvGunner_WPN('AdvGunnerM2_WPN', default.ADVGUNNERM2_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvGunner_WPN('AdvGunnerM3_WPN', default.ADVGUNNERM3_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvGunner_WPN('AdvGunnerM4_WPN', default.ADVGUNNERM4_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvGunner_WPN('AdvGunnerM5_WPN', default.ADVGUNNERM5_WPN_BASEDAMAGE));
	
	Templates.AddItem(CreateTemplate_AdvGunner_Leader_WPN('AdvGunner_Leader_WPN', default.ADVGUNNER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvGunner_Leader_WPN('AdvGunnerM2_Leader_WPN', default.ADVGUNNERM2_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvGunner_Leader_WPN('AdvGunnerM3_Leader_WPN', default.ADVGUNNERM3_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvGunner_Leader_WPN('AdvGunnerM4_Leader_WPN', default.ADVGUNNERM4_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvGunner_Leader_WPN('AdvGunnerM5_Leader_WPN', default.ADVGUNNERM5_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_AdvSentry_WPN('AdvSentryM1_WPN'));
	Templates.AddItem(CreateTemplate_AdvSentry_WPN('AdvSentryM2_WPN'));
	Templates.AddItem(CreateTemplate_AdvSentry_WPN('AdvSentryM3_WPN'));
	Templates.AddItem(CreateTemplate_AdvSentry_WPN('AdvSentryM4_WPN'));
	Templates.AddItem(CreateTemplate_AdvSentry_WPN('AdvSentryM5_WPN'));

	Templates.AddItem(CreateTemplate_AdvGrenadier_GrenadeLauncher('AdvGrenadierM1_GrenadeLauncher'));
	Templates.AddItem(CreateTemplate_AdvGrenadier_GrenadeLauncher('AdvGrenadierM2_GrenadeLauncher'));
	Templates.AddItem(CreateTemplate_AdvGrenadier_GrenadeLauncher('AdvGrenadierM3_GrenadeLauncher'));

	Templates.AddItem(CreateTemplate_AdvGrenadier_Flashbang());

	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM1_WPN', default.LWDRONEM1_DRONEWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM2_WPN', default.LWDRONEM2_DRONEWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM3_WPN', default.LWDRONEM3_DRONEWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM4_WPN', default.LWDRONEM4_DRONEWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM5_WPN', default.LWDRONEM5_DRONEWEAPON_BASEDAMAGE));
	
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDrone_Leader_WPN', default.LWDRONE_LEADER_DRONEWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM2_Leader_WPN', default.LWDRONEM2_LEADER_DRONEWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM3_Leader_WPN', default.LWDRONEM3_LEADER_DRONEWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM4_Leader_WPN', default.LWDRONEM4_LEADER_DRONEWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDrone_WPN('LWDroneM5_Leader_WPN', default.LWDRONEM5_LEADER_DRONEWEAPON_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDroneRepairM1_WPN', default.LWDRONEM1_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDroneRepairM2_WPN', default.LWDRONEM2_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDroneRepairM3_WPN', default.LWDRONEM3_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDroneRepairM4_WPN', default.LWDRONEM4_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDroneRepairM5_WPN', default.LWDRONEM5_DRONEREPAIRWEAPON_BASEDAMAGE));


	Templates.AddItem(CreateTemplate_LWDroneRepair_Leader_WPN('LWDroneRepair_Leader_WPN', default.LWDRONE_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_Leader_WPN('LWDroneRepairM2_Leader_WPN', default.LWDRONEM2_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_Leader_WPN('LWDroneRepairM3_Leader_WPN', default.LWDRONEM3_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_Leader_WPN('LWDroneRepairM4_Leader_WPN', default.LWDRONEM4_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_Leader_WPN('LWDroneRepairM5_Leader_WPN', default.LWDRONEM5_LEADER_DRONEREPAIRWEAPON_BASEDAMAGE));



	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDrone_LeaderRepairM1_WPN', default.LWDRONEM1_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDrone_LeaderRepairM2_WPN', default.LWDRONEM2_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDrone_LeaderRepairM3_WPN', default.LWDRONEM3_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDrone_LeaderRepairM4_WPN', default.LWDRONEM4_DRONEREPAIRWEAPON_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_LWDroneRepair_WPN('LWDrone_LeaderRepairM5_WPN', default.LWDRONEM5_DRONEREPAIRWEAPON_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvVanguard_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvShockTroop_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvSergeantM1_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvSergeantM2_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvScout_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvCommando_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvGeneralM1_LW_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvGeneralM2_LW_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvGeneralM3_LW_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvGeneralM4_LW_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvGeneralM5_LW_WPN'));

	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvTrooperM4_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvTrooperM5_WPN'));

	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvStunlancerM4_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvStunlancerM5_WPN'));

	Templates.AddItem(CreateTemplate_AdvStunlancer_Leader_WPN('AdvStunlancer_Leader_WPN',default.ADVSTUNLANCER_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunlancer_Leader_WPN('AdvStunlancerM2_Leader_WPN',default.ADVSTUNLANCERM2_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunlancer_Leader_WPN('AdvStunlancerM3_Leader_WPN',default.ADVSTUNLANCERM3_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunlancer_Leader_WPN('AdvStunlancerM4_Leader_WPN',default.ADVSTUNLANCERM4_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunlancer_Leader_WPN('AdvStunlancerM5_Leader_WPN',default.ADVSTUNLANCERM5_LEADER_WPN_BASEDAMAGE));


	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvShieldbearerM4_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvShieldbearerM5_WPN'));

	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvCaptainM4_WPN'));
	Templates.AddItem(CreateTemplate_AdvElite_WPN('AdvCaptainM5_WPN'));

	Templates.AddItem(CreateTemplate_Hunter_Flashbang());	

	Templates.AddItem(CreateTemplate_AdvStunLancer_StunLance_LW('AdvStunLancerM4_StunLance', default.ADVSTUNLANCERM4_STUNLANCE_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunLancer_StunLance_LW('AdvStunLancerM5_StunLance', default.ADVSTUNLANCERM5_STUNLANCE_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_AdvStunLancer_StunLance_LW('AdvStunLancer_Leader_StunLance', default.ADVSTUNLANCER_LEADER_STUNLANCE_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunLancer_StunLance_LW('AdvStunLancerM2_Leader_StunLance', default.ADVSTUNLANCERM2_LEADER_STUNLANCE_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunLancer_StunLance_LW('AdvStunLancerM3_Leader_StunLance', default.ADVSTUNLANCERM3_LEADER_STUNLANCE_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunLancer_StunLance_LW('AdvStunLancerM4_Leader_StunLance', default.ADVSTUNLANCERM4_LEADER_STUNLANCE_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvStunLancer_StunLance_LW('AdvStunLancerM5_Leader_StunLance', default.ADVSTUNLANCERM5_LEADER_STUNLANCE_BASEDAMAGE));


	Templates.AddItem(CreateTemplate_PsiZombie_MeleeAttack_LW('PsiZombie_MeleeAttackM2'));
	Templates.AddItem(CreateTemplate_PsiZombie_MeleeAttack_LW('PsiZombie_MeleeAttackM3'));
	Templates.AddItem(CreateTemplate_PsiZombie_MeleeAttack_LW('PsiZombie_MeleeAttackM4'));
	Templates.AddItem(CreateTemplate_PsiZombie_MeleeAttack_LW('PsiZombie_MeleeAttackM5'));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('Berserker_MeleeAttack', default.BERSERKER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('BerserkerM2_MeleeAttack', default.BERSERKERM2_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('BerserkerM3_MeleeAttack', default.BERSERKERM3_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('BerserkerM4_MeleeAttack', default.BERSERKERM4_MELEEATTACK_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('Berserker_Leader_MeleeAttack', default.BERSERKER_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('BerserkerM2_Leader_MeleeAttack', default.BERSERKERM2_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('BerserkerM3_Leader_MeleeAttack', default.BERSERKERM3_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('BerserkerM4_Leader_MeleeAttack', default.BERSERKERM4_LEADER_MELEEATTACK_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('Chryssalid_WPN', class'X2Item_DefaultWeapons'.default.CHRYSSALID_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('ChryssalidM2_WPN', default.CHRYSSALIDM2_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('ChryssalidM3_WPN', default.CHRYSSALIDM3_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('ChryssalidM4_WPN', default.CHRYSSALIDM4_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('ChryssalidM5_WPN', default.CHRYSSALIDM5_MELEEATTACK_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('NeonateChryssalid_WPN', default.NEONATECHRYSSALID_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('NeonateChryssalidM2_WPN', default.NEONATECHRYSSALIDM2_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('NeonateChryssalidM3_WPN', default.NEONATECHRYSSALIDM3_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('NeonateChryssalidM4_WPN', default.NEONATECHRYSSALIDM4_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('NeonateChryssalidM5_WPN', default.NEONATECHRYSSALIDM5_MELEEATTACK_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('Chryssalid_Leader_WPN', default.CHRYSSALID_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('ChryssalidM2_Leader_WPN', default.CHRYSSALIDM2_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('ChryssalidM3_Leader_WPN', default.CHRYSSALIDM3_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('ChryssalidM4_Leader_WPN', default.CHRYSSALIDM4_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('ChryssalidM4_Leader_WPN', default.CHRYSSALIDM5_LEADER_MELEEATTACK_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('Faceless_WPN', default.FACELESS_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('FacelessM2_WPN', default.FACELESSM2_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('FacelessM3_WPN', default.FACELESSM3_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('FacelessM4_WPN', default.FACELESSM4_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('FacelessM5_WPN', default.FACELESSM5_MELEEATTACK_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('Faceless_Leader_WPN', default.FACELESS_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('FacelessM2_Leader_WPN', default.FACELESSM2_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('FacelessM3_Leader_WPN', default.FACELESSM3_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('FacelessM4_Leader_WPN', default.FACELESSM4_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('FacelessM5_Leader_WPN', default.FACELESSM5_LEADER_MELEEATTACK_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Archon_MeleeAttack_LW('ArchonStaffM2', default.ARCHON_MELEEATTACKM2_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_MeleeAttack_LW('ArchonStaffM3', default.ARCHON_MELEEATTACKM2_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Archon_LW_WPN('ArchonM2_WPN', default.ARCHONM2_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_LW_WPN('ArchonM3_WPN', default.ARCHONM3_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Archon_Blazing_Pinions_LW_WPN('Archon_Blazing_PinionsM2_WPN', default.ARCHON_BLAZINGPINIONSM2_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_Blazing_Pinions_LW_WPN('Archon_Blazing_PinionsM3_WPN', default.ARCHON_BLAZINGPINIONSM3_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Archon_MeleeAttack_LW('Archon_LeaderStaff', default.ARCHON_LEADERMELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_MeleeAttack_LW('ArchonM2_LeaderStaff', default.ARCHON_LEADERMELEEATTACKM2_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_MeleeAttack_LW('ArchonM3_LeaderStaff', default.ARCHON_LEADERMELEEATTACKM2_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Archon_LW_WPN('Archon_Leader_WPN', default.ARCHON_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_LW_WPN('ArchonM2_Leader_WPN', default.ARCHONM2_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_LW_WPN('ArchonM3_Leader_WPN', default.ARCHONM3_LEADER_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Archon_Blazing_Pinions_LW_WPN('Archon_Leader_Blazing_Pinions_WPN', default.ARCHON_LEADER_BLAZINGPINIONS_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_Blazing_Pinions_LW_WPN('ArchonM2_Leader_Blazing_Pinions_WPN', default.ARCHON_LEADER_BLAZINGPINIONSM2_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Archon_Blazing_Pinions_LW_WPN('ArchonM3_Leader_Blazing_Pinions_WPN', default.ARCHON_LEADER_BLAZINGPINIONSM3_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_AdvMEC_LW_WPN('AdvMec_M3_WPN', default.ADVMEC_M3_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvMEC_LW_WPN('AdvMec_M4_WPN',default.ADVMEC_M4_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvMEC_LW_WPN('AdvMec_M5_WPN', default.ADVMEC_M5_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_AdvMEC_LW_WPN('AdvMec_Leader_WPN', default.ADVMEC_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvMEC_LW_WPN('AdvMecM2_Leader_WPN', default.ADVMECM2_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvMEC_LW_WPN('AdvMecM3_Leader_WPN', default.ADVMECM3_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvMEC_LW_WPN('AdvMecM4_Leader_WPN', default.ADVMECM4_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvMEC_LW_WPN('AdvMecM5_Leader_WPN', default.ADVMECM5_LEADER_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_AdvMEC_Shoulder_LW_WPN('AdvMEC_M3_Shoulder_WPN', default.AdvMEC_M3_MicroMissiles_BaseDamage));
	Templates.AddItem(CreateTemplate_AdvMEC_Shoulder_LW_WPN('AdvMEC_M4_Shoulder_WPN', default.AdvMEC_M4_MicroMissiles_BaseDamage));
	Templates.AddItem(CreateTemplate_AdvMEC_Shoulder_LW_WPN('AdvMEC_M5_Shoulder_WPN', default.AdvMEC_M5_MicroMissiles_BaseDamage));

	Templates.AddItem(CreateTemplate_AdvMEC_Shoulder_LW_WPN('AdvMEC_Leader_Shoulder_WPN', default.AdvMEC_Leader_MicroMissiles_BaseDamage));
	Templates.AddItem(CreateTemplate_AdvMEC_Shoulder_LW_WPN('AdvMEC_M2_Leader_Shoulder_WPN', default.AdvMECM2_Leader_MicroMissiles_BaseDamage));
	Templates.AddItem(CreateTemplate_AdvMEC_Shoulder_LW_WPN('AdvMEC_M3_Leader_Shoulder_WPN', default.AdvMECM3_Leader_MicroMissiles_BaseDamage));
	Templates.AddItem(CreateTemplate_AdvMEC_Shoulder_LW_WPN('AdvMEC_M4_Leader_Shoulder_WPN', default.AdvMECM4_Leader_MicroMissiles_BaseDamage));
	Templates.AddItem(CreateTemplate_AdvMEC_Shoulder_LW_WPN('AdvMEC_M5_Leader_Shoulder_WPN', default.AdvMECM5_Leader_MicroMissiles_BaseDamage));

	Templates.AddItem(CreateTemplate_Andromedon_LW_WPN('AndromedonM2_WPN', default.ANDROMEDONM2_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Andromedon_LW_WPN('AndromedonM3_WPN', default.ANDROMEDONM3_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Andromedon_LW_WPN('Andromedon_Leader_WPN', default.ANDROMEDON_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Andromedon_LW_WPN('AndromedonM2_Leader_WPN', default.ANDROMEDONM2_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Andromedon_LW_WPN('AndromedonM3_Leader_WPN', default.ANDROMEDONM3_LEADER_WPN_BASEDAMAGE));


	Templates.AddItem(CreateAcidBlob_LW('AcidBlobM2', default.ANDROMEDONM2_ACIDBLOB_BASEDAMAGE));
	Templates.AddItem(CreateAcidBlob_LW('AcidBlobM3', default.ANDROMEDONM3_ACIDBLOB_BASEDAMAGE));

	Templates.AddItem(CreateAcidBlob_LW('AcidBlob_Leader', default.ANDROMEDON_LEADER_ACIDBLOB_BASEDAMAGE));
	Templates.AddItem(CreateAcidBlob_LW('AcidBlobM2_Leader', default.ANDROMEDONM2_LEADER_ACIDBLOB_BASEDAMAGE));
	Templates.AddItem(CreateAcidBlob_LW('AcidBlobM3', default.ANDROMEDONM3_LEADER_ACIDBLOB_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('AndromedonRobot_WPN', class'X2Item_DefaultWeapons'.default.ANDROMEDONROBOT_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('AndromedonRobotM2_WPN', default.ANDROMEDONROBOT_MELEEATTACKM2_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('AndromedonRobotM3_WPN', default.ANDROMEDONROBOT_MELEEATTACKM3_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('AndromedonRobot_Leader_WPN', default.ANDROMEDONROBOT_LEADER_MELEEATTACK_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('AndromedonRobotM2_Leader_WPN', default.ANDROMEDONROBOT_LEADER_MELEEATTACKM2_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_GenericMeleeWeapon_LW('AndromedonRobotM3_Leader_WPN', default.ANDROMEDONROBOT_LEADER_MELEEATTACKM3_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Spectre_LW_WPN('SpectreM3_WPN', default.SPECTREM3_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Spectre_LW_WPN('SpectreM4_WPN', default.SPECTREM4_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Spectre_PsiAttack_LW('SpectreM3_PsiAttack', default.SPECTREM3_PSI_ABILITYDAMAGE));
	Templates.AddItem(CreateTemplate_Spectre_PsiAttack_LW('SpectreM4_PsiAttack', default.SPECTREM3_PSI_ABILITYDAMAGE));

	Templates.AddItem(CreateTemplate_Gatekeeper_LW_WPN('GatekeeperM2_WPN', default.GATEKEEPERM2_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Gatekeeper_LW_WPN('GatekeeperM3_WPN', default.GATEKEEPERM3_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Sectopod_LW_WPN('SectopodM2_WPN', default.SECTOPODM2_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sectopod_LW_WPN('SectopodM3_WPN', default.SECTOPODM3_WPN_BASEDAMAGE));


	Templates.AddItem(CreateAdventGrenade('AdventTrooperMk3Grenade', default.ADVTROOPERM3_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateAdventGrenade('AdventTrooperMk4Grenade', default.ADVTROOPERM4_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateAdventGrenade('AdventTrooperMk5Grenade', default.ADVTROOPERM5_GRENADE_BASEDAMAGE));
	
	Templates.AddItem(CreateAdventGrenade('AdventCaptainMk3Grenade', default.ADVCAPTAINM3_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateAdventGrenade('AdventCaptainMk4Grenade', default.ADVCAPTAINM4_GRENADE_BASEDAMAGE));
	Templates.AddItem(CreateAdventGrenade('AdventCaptainMk5Grenade', default.ADVCAPTAINM5_GRENADE_BASEDAMAGE));

	
	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('SectoidM2_WPN', default.SECTOIDM2_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('SectoidM3_WPN', default.SECTOIDM3_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('SectoidM4_WPN', default.SECTOIDM4_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('SectoidM5_WPN', default.SECTOIDM5_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('Sectoid_Leader_WPN', default.SECTOID_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('SectoidM2_Leader_WPN', default.SECTOIDM2_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('SectoidM3_Leader_WPN', default.SECTOIDM3_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('SectoidM4_Leader_WPN', default.SECTOIDM4_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_Sectoid_LW_WPN('SectoidM5_Leader_WPN', default.SECTOIDM5_LEADER_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_AdvPriest_WPN('AdvPriestM4_WPN', default.ADVPRIESTM4_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_AdvPriest_WPN('AdvPriestM5_WPN', default.ADVPRIESTM5_WPN_BASEDAMAGE));

	Templates.AddItem(CreateTemplate_PurgeGun('AdvPriest_Leader_WPN', default.ADVPRIEST_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_PurgeGun('AdvPriestM2_Leader_WPN', default.ADVPRIESTM2_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_PurgeGun('AdvPriestM3_Leader_WPN', default.ADVPRIESTM3_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_PurgeGun('AdvPriestM4_Leader_WPN', default.ADVPRIESTM4_LEADER_WPN_BASEDAMAGE));
	Templates.AddItem(CreateTemplate_PurgeGun('AdvPriestM5_Leader_WPN', default.ADVPRIESTM5_LEADER_WPN_BASEDAMAGE));



	Templates.AddItem(CreateTemplate_AdvPriest_PsiAmp('AdvPriestM4_PsiAmp', 'HolyWarriorM4'));
	Templates.AddItem(CreateTemplate_AdvPriest_PsiAmp('AdvPriestM5_PsiAmp', 'HolyWarriorM4'));

	Templates.AddItem(CreateTemplate_AdvPriest_PsiAmp('AdvPriest_Leader_PsiAmp', 'HolyWarriorM1'));
	Templates.AddItem(CreateTemplate_AdvPriest_PsiAmp('AdvPriestM2_Leader_PsiAmp', 'HolyWarriorM2'));
	Templates.AddItem(CreateTemplate_AdvPriest_PsiAmp('AdvPriestM3_Leader_PsiAmp', 'HolyWarriorM3'));
	Templates.AddItem(CreateTemplate_AdvPriest_PsiAmp('AdvPriestM4_Leader_PsiAmp', 'HolyWarriorM4'));
	Templates.AddItem(CreateTemplate_AdvPriest_PsiAmp('AdvPriestM5_Leader_PsiAmp', 'HolyWarriorM5'));

	//Templates.AddItem(CreateTemplate_AdvPriest_PsiAmp_Leader('AdvPriestM5_PsiAmp'));

	return Templates;
}


static function X2DataTemplate CreateTemplate_MutonCenturion_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.MutonRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;
	Template.BaseDamage = Damage;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.MutonM2_LW_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Execute');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Muton_Rifle.WP_MutonRifle";  // re-use base-game Muton Rifle art assets

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_Muton_LW_MeleeAttack(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'baton';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.Sword";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Muton_Bayonet.WP_MutonBayonet"; // re-use base game art assets for melee weapon
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.Aim = class'X2Item_DefaultWeapons'.default.GENERIC_MELEE_ACCURACY;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;
	Template.iIdealRange = 1;

	Template.BaseDamage = Damage;
	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 10;

	//Build Data
	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	Template.Abilities.AddItem('Bayonet');
	//Template.Abilities.AddItem('BayonetCharge');
	Template.Abilities.AddItem('CounterattackBayonet');

	return Template;
}


static function X2DataTemplate CreateMuton_LWGrenade(name TemplateName, WeaponDamageValue Damage)
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, TemplateName);

	Template.strImage = "img:///UILibrary_StrategyImages.InventoryIcons.Inv_AlienGrenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.BaseDamage = Damage;
	Template.iEnvironmentDamage = default.MutonM2_LW_GRENADE_iENVIRONMENTDAMAGE;
	Template.iRange = default.MutonM2_LW_GRENADE_iRANGE;
	Template.iRadius = default.MutonM2_LW_GRENADE_iRADIUS;
	Template.iClipSize = 1;
	Template.iSoundRange = class'X2Item_DefaultGrenades'.default.GRENADE_SOUND_RANGE;
	Template.DamageTypeTemplateName = 'Explosion';
	
	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);
	
	Template.GameArchetype = "WP_Grenade_Alien.WP_Grenade_Alien";

	Template.iPhysicsImpulse = 10;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 50;

	return Template;
}

// Muton Elite Gear

static function X2DataTemplate CreateTemplate_MutonElite_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_BeamCannon";
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_Base";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;
	Template.BaseDamage = Damage;
	Template.iClipSize = default.MutonM3_LW_WPN_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_BEAM_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_BEAM_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.MutonM3_LW_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Projectile_BeamXCom';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Execute');

	//Template.Abilities.AddItem('LightEmUp');

 	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWMutonM3Rifle.Archetypes.WP_MutonM3Rifle_Base";  // upscaled, recolored beam cannon

	Template.AddDefaultAttachment('Mag', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_Mag",, "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_MagA");
    Template.AddDefaultAttachment('Core', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_Core",, "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_CoreA");
    Template.AddDefaultAttachment('Core_Center', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_Core_Center");
    Template.AddDefaultAttachment('HeatSink', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_HeatSink",, "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_HeatsinkA");
    Template.AddDefaultAttachment('Suppressor', "LWMutonM3Rifle.Meshes.SK_MutonM3Rifle_Suppressor",, "img:///UILibrary_Common.UI_BeamCannon.BeamCannon_SupressorA");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_Sidewinder_WPN(name TemplateName)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'smg';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///LWSidewinderSMG.Textures.LWBeamSMG_Common"; 
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_SMGWeapon'.default.MIDSHORT_CONVENTIONAL_RANGE;
	
	if (TemplateName == 'SidewinderM1_WPN')
		Template.BaseDamage = default.SIDEWINDER_WPN_BASEDAMAGE;
	if (TemplateName == 'SidewinderM2_WPN')
		Template.BaseDamage = default.SIDEWINDERM2_WPN_BASEDAMAGE;
	if (TemplateName == 'SidewinderM3_WPN')
		Template.BaseDamage = default.SIDEWINDERM3_WPN_BASEDAMAGE;
	if (TemplateName == 'SidewinderM4_WPN')
		Template.BaseDamage = default.SIDEWINDERM4_WPN_BASEDAMAGE;
	if (TemplateName == 'SidewinderM5_WPN')
		Template.BaseDamage = default.SIDEWINDERM5_WPN_BASEDAMAGE;

	Template.iClipSize = default.SIDEWINDER_WPN_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.SIDEWINDER_IDEALRANGE;

	Template.CritChance = class'X2Item_SMGWeapon'.default.SMG_CONVENTIONAL_CRITCHANCE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	if (TemplateName == 'SidewinderM1_WPN' || TemplateName == 'SidewinderM2_WPN' || TemplateName == 'SidewinderM3_WPN')
	{
		//future use
	}
	if (TemplateName == 'SidewinderM2_WPN' || TemplateName == 'SidewinderM3_WPN')
	{	
		//future use
	}
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWSidewinderSMG.Archetypes.WP_Sidewinder_SMG";  

	//Template.AddDefaultAttachment('Optic', "BeamSniper.Meshes.SM_BeamSniper_OpticA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_OpticA");
	Template.AddDefaultAttachment('Mag', "LWSidewinderSMG.Meshes.SM_BeamAssaultRifle_MagB");
	//Template.AddDefaultAttachment('Suppressor', "BeamSniper.Meshes.SM_BeamSniper_SuppressorA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_SupressorA");
	Template.AddDefaultAttachment('Core', "LWSidewinderSMG.Meshes.SK_LWBeamSMG_CoreA");
	//Template.AddDefaultAttachment('HeatSink', "NajaRifle.Meshes.SM_BeamSniper_HeatSinkA", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_HeatsinkA");
	//Template.AddDefaultAttachment('Autoloader', "NajaRifle.Meshes.SM_BeamSniper_MagC", , "img:///UILibrary_Common.UI_BeamSniper.BeamSniper_AutoLoader");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}


static function X2DataTemplate CreateTemplate_Sidewinder_Leader_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.ViperRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.BaseDamage = Damage;
    Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
    Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
    Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
    Template.iIdealRange = class'X2Item_DefaultWeapons'.default.VIPER_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "ViperGatling.Archetype.WP_ViperGatlingPsi";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_PsiSpitGlob(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'grenade';
	Template.strImage = "img:///UILibrary_StrategyImages.InventoryIcons.Inv_SmokeGrenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	//Template.GameArchetype = "WP_Grenade_Frag.WP_Grenade_Frag";
	Template.GameArchetype = "WP_Viper_PoisonSpit.WP_Viper_PoisonSpit";
	Template.CanBeBuilt = false;	

	Template.iRange = 14;
	Template.iRadius = 4;
	Template.iClipSize = 1;
	Template.InfiniteAmmo = true;

	Template.iSoundRange = 6;
	Template.bSoundOriginatesFromOwnerLocation = true;
	Template.BaseDamage = Damage;
	Template.BaseDamage.DamageType = 'Psi';

	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_None;
	Template.Abilities.AddItem('PsiSpit_LW');
	
	// This controls how much arc this projectile may have and how many times it may bounce
	Template.WeaponPrecomputedPathData.InitialPathTime = 0.5;
	Template.WeaponPrecomputedPathData.MaxPathTime = 1.0;
	Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;

	return Template;
}

static function X2DataTemplate CreateTemplate_VorpalBlade(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_Sword";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'sword';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILib_ArmoredVipers.INV_ViperBlade";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "ViperBlade.Archetype.WP_ViperBlade";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.Aim = default.GENERIC_MELEE_ACCURACY;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;

	Template.BaseDamage = Damage;
	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 0;
	Template.iIdealRange = 0;

	//Build Data
	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	Template.Abilities.AddItem('VorpalCharge');
	Template.Abilities.AddItem('Vampirism_LW');

	return Template;
}


static function X2DataTemplate CreateTemplate_AdvGunner_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.UI_MagCannon.MagCannon_Base";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;

	Template.BaseDamage = Damage;
	Template.iClipSize = default.ADVGUNNER_WPN_CLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ADVGUNNER_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('AreaSuppression');
/*
	if (TemplateName == 'AdvGunnerM2_WPN' || TemplateName == 'AdvGunnerM3_WPN')
	{
		Template.Abilities.AddItem('LockedOn');
	}
	if (TemplateName == 'AdvGunnerM3_WPN')
	{
		Template.Abilities.AddItem('TraverseFire');
		Template.Abilities.AddItem('CoveringFire');
	}
	*/
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWAdvGunner.Archetypes.WP_Cannon_MG";  

	Template.AddDefaultAttachment('Mag', "LWAdvGunner.Meshes.SK_MagCannon_Mag", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_MagA");
	Template.AddDefaultAttachment('Reargrip',   "LWAdvGunner.Meshes.SM_MagCannon_Reargrip");
	Template.AddDefaultAttachment('Foregrip', "LWAdvGunner.Meshes.SM_MagCannon_Stock", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_StockA");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}


static function X2DataTemplate CreateTemplate_AdvGunner_Leader_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'cannon';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.UI_MagCannon.MagCannon_Base";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;

	Template.BaseDamage = Damage;
	Template.iClipSize = default.ADVGUNNER_WPN_CLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.LMG_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ADVGUNNER_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('BulletWizard');
	Template.Abilities.AddItem('SteadFast');
/*
	if (TemplateName == 'AdvGunnerM2_WPN' || TemplateName == 'AdvGunnerM3_WPN')
	{
		Template.Abilities.AddItem('LockedOn');
	}
	if (TemplateName == 'AdvGunnerM3_WPN')
	{
		Template.Abilities.AddItem('TraverseFire');
		Template.Abilities.AddItem('CoveringFire');
	}
	*/
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWAdvGunner.Archetypes.WP_Cannon_MG";  

	Template.AddDefaultAttachment('Mag', "LWAdvGunner.Meshes.SK_MagCannon_Mag", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_MagA");
	Template.AddDefaultAttachment('Reargrip',   "LWAdvGunner.Meshes.SM_MagCannon_Reargrip");
	Template.AddDefaultAttachment('Foregrip', "LWAdvGunner.Meshes.SM_MagCannon_Stock", , "img:///UILibrary_Common.UI_MagCannon.MagCannon_StockA");

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}



static function X2DataTemplate CreateTemplate_AdvSentry_WPN(name TemplateName)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventAssaultRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;
    Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE; 

    Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	if (TemplateName == 'AdvSentryM1_WPN')
		Template.BaseDamage = default.AdvSentryM1_WPN_BASEDAMAGE;
	if (TemplateName == 'AdvSentryM2_WPN')
		Template.BaseDamage = default.AdvSentryM2_WPN_BASEDAMAGE;
	if (TemplateName == 'AdvSentryM3_WPN')
		Template.BaseDamage = default.AdvSentryM3_WPN_BASEDAMAGE;
	if (TemplateName == 'AdvSentryM4_WPN')
		Template.BaseDamage = default.AdvSentryM4_WPN_BASEDAMAGE;
	if (TemplateName == 'AdvSentryM5_WPN')
		Template.BaseDamage = default.AdvSentryM4_WPN_BASEDAMAGE;

    Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
    Template.iIdealRange = default.ADVSENTRY_IDEALRANGE; //check this

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
		
	/*
	if (TemplateName == 'AdvSentryM2_WPN')
	{
		Template.Abilities.AddItem('CoolUnderPressure');
		Template.Abilities.AddItem('Sentinel');
		Template.Abilities.AddItem('CoveringFire');
	}

	if (TemplateName == 'AdvSentryM3_WPN')
	{
		Template.Abilities.AddItem('CoolUnderPressure');
		Template.Abilities.AddItem('Sentinel_LW');
		Template.Abilities.AddItem('CoveringFire');
	}
*/
	Template.GameArchetype = "WP_AssaultRifle_MG.WP_AssaultRifle_MG_Advent";
	Template.iPhysicsImpulse = 5;
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.DamageTypeTemplateName = 'Projectile_MagAdvent';

	return Template;
}


static function X2DataTemplate CreateTemplate_AdvGrenadier_GrenadeLauncher(name TemplateName)
{
	local X2GrenadeLauncherTemplate Template;

	`CREATE_X2TEMPLATE(class'X2GrenadeLauncherTemplate', Template, TemplateName);

	Template.strImage = "img:///UILibrary_Common.MagSecondaryWeapons.MagLauncher";
	Template.EquipSound = "Secondary_Weapon_Equip_Magnetic";

	Template.InventorySlot = eInvSlot_SecondaryWeapon;

	Template.iSoundRange = class'X2Item_DefaultGrenades'.default.ADVGRENADELAUNCHER_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultGrenades'.default.ADVGRENADELAUNCHER_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = 18;
	Template.iClipSize = class'X2Item_DefaultGrenades'.default.ADVGRENADELAUNCHER_ICLIPSIZE;
	Template.Tier = 1;
	Template.iIdealRange = default.ADVGRENADIER_IDEALRANGE;

	// REMOVED because this seems to rely on HasSoldierAbility, which doesn't work for advent/aliens
	//if (TemplateName == 'AdvGrenadeLauncherM1')
	//{
		//Template.IncreaseGrenadeRadius = default.ADVGRENADIERM1_GRENADELAUNCHER_RADIUSBONUS;
		//Template.IncreaseGrenadeRange = default.ADVGRENADIERM1_GRENADELAUNCHER_RANGEBONUS;
	//}
	//if (TemplateName == 'AdvGrenadeLauncherM2')
	//{
		//Template.IncreaseGrenadeRadius = default.ADVGRENADIERM2_GRENADELAUNCHER_RADIUSBONUS;
		//Template.IncreaseGrenadeRange = default.ADVGRENADIERM2_GRENADELAUNCHER_RANGEBONUS;
	//}
	//if (TemplateName == 'AdvGrenadeLauncherM3')
	//{
		//Template.IncreaseGrenadeRadius = default.ADVGRENADIERM3_GRENADELAUNCHER_RADIUSBONUS;
		//Template.IncreaseGrenadeRange = default.ADVGRENADIERM3_GRENADELAUNCHER_RANGEBONUS;
	//}

	//Template.Abilities.AddItem('LaunchGrenade');  // remove this to prevent a "null" LaunchGrenade ability which confuses the AI
	Template.Abilities.AddItem('AdventGrenadeLauncher');

	Template.GameArchetype = "WP_GrenadeLauncher_MG.WP_GrenadeLauncher_MG";

	Template.CanBeBuilt = false;

	return Template;
}

static function X2DataTemplate CreateTemplate_AdvGrenadier_Flashbang()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'AdvGrenadierFlashbangGrenade');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons..Inv_Flashbang_Grenade";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_flash");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_flash");
	Template.iRange = default.ADVGRENADIER_FLASHBANGGRENADE_RANGE;
	Template.iRadius = default.ADVGRENADIER_FLASHBANGGRENADE_RADIUS;
	
	Template.bFriendlyFire = false;
	Template.bFriendlyFireWarning = false;
	Template.Abilities.AddItem('ThrowGrenade');

	Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreateDisorientedStatusEffect());

	//We need to have an ApplyWeaponDamage for visualization, even if the grenade does 0 damage (makes the unit flinch, shows overwatch removal)
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);

	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;
	
	Template.GameArchetype = "WP_Grenade_Flashbang.WP_Grenade_Flashbang";

	Template.iEnvironmentDamage = default.ADVGRENADIER_FLASHBANGGRENADE_IENVIRONMENTDAMAGE;
	Template.iClipSize = default.ADVGRENADIER_FLASHBANGGRENADE_ICLIPSIZE;

	return Template;
}


static function X2DataTemplate CreateTemplate_LWDrone_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_LWAlienPack.LWAdventDrone_ArcWeapon";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.BaseDamage = Damage;
	Template.iRange = default.LWDRONE_DRONEWEAPON_RANGE;
	Template.iSoundRange = default.LWDRONE_DRONEWEAPON_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LWDRONE_DRONEWEAPON_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.LWDRONE_IDEALRANGE;
	Template.RangeAccuracy = class'X2Item_SMGWeapon'.default.MIDSHORT_CONVENTIONAL_RANGE;

	Template.iClipSize = 3;
	Template.InfiniteAmmo = false;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('LWDroneShock');
	Template.Abilities.AddItem('ReloadNoAnim');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWDroneWeapon.Archetypes.WP_DroneBeam";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_LWDroneRepair_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.GatekeeperEyeball"; 
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.BaseDamage = Damage;

	Template.iRange = default.LWDRONE_DRONEREPAIRWEAPON_RANGE;
	Template.iSoundRange = default.LWDRONE_DRONEREPAIRWEAPON_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LWDRONE_DRONEREPAIRWEAPON_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.LWDRONE_IDEALRANGE;

	Template.iClipSize = 99;
	Template.InfiniteAmmo = true;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('LWDroneRepair');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWDroneWeapon.Archetypes.WP_DroneRepair";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_LWDroneRepair_Leader_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.GatekeeperEyeball"; 
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.BaseDamage = Damage;

	Template.iRange = default.LWDRONE_DRONEREPAIRWEAPON_RANGE;
	Template.iSoundRange = default.LWDRONE_DRONEREPAIRWEAPON_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.LWDRONE_DRONEREPAIRWEAPON_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.LWDRONE_IDEALRANGE;

	Template.iClipSize = 99;
	Template.InfiniteAmmo = true;
	
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('LWDroneRepair');
	Template.Abilities.AddItem('LWDroneHeal');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWDroneWeapon.Archetypes.WP_DroneRepair";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}


static function X2DataTemplate CreateTemplate_ViperMX_WPN(name TemplateName)
{
    local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
    Template.WeaponPanelImage = "_ConventionalRifle";
    Template.ItemCat = 'Weapon';
    Template.WeaponCat = 'rifle';
    Template.WeaponTech = 'beam';
    Template.strImage = "img:///UILibrary_Common.AlienWeapons.ViperRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability
	


	switch(TemplateName)
	{
		case 'ViperM2_LW_WPN':
			Template.BaseDamage = default.VIPERM2_WPN_BASEDAMAGE;
			Template.Abilities.AddItem('BindM2Damage');
			break;
		case 'ViperM3_LW_WPN':
			Template.BaseDamage = default.VIPERM3_WPN_BASEDAMAGE;
			Template.Abilities.AddItem('BindM3Damage');
			break;
		case 'ViperM4_LW_WPN':
			Template.BaseDamage = default.VIPERM4_WPN_BASEDAMAGE;
			Template.Abilities.AddItem('BindM4Damage');
		break;
		case 'ViperM5_LW_WPN':
			Template.BaseDamage = default.VIPERM5_WPN_BASEDAMAGE;
			Template.Abilities.AddItem('BindM5Damage');
			break;
	}


    Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
    Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
    Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
    Template.iIdealRange = class'X2Item_DefaultWeapons'.default.VIPER_IDEALRANGE;
    Template.DamageTypeTemplateName = 'Heavy';
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
    Template.Abilities.AddItem('StandardShot');
    Template.Abilities.AddItem('overwatch');
    Template.Abilities.AddItem('OverwatchShot');
    Template.Abilities.AddItem('Reload');
    Template.Abilities.AddItem('HotLoadAmmo');
    Template.GameArchetype = "WP_Viper_Rifle.WP_ViperRifle";
    Template.iPhysicsImpulse = 5;
    Template.CanBeBuilt = false;
    Template.TradingPostValue = 30;
    return Template;
}

static function X2DataTemplate CreateTemplate_Viper_Leader_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.ViperRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

    Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;
	Template.BaseDamage = Damage;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
    Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
    Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
    Template.iIdealRange = class'X2Item_DefaultWeapons'.default.VIPER_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.GameArchetype = "ViperGatling.Archetype.WP_ViperGatling";

	switch(TemplateName)
	{
		case 'ViperM2_Leader_WPN':
			Template.Abilities.AddItem('BindM3Damage');
			break;
		case 'ViperM3_Leader_WPN':
			Template.Abilities.AddItem('BindM4Damage');
			break;
		case 'ViperM4_Leader_WPN':
			Template.Abilities.AddItem('BindM5Damage');
		break;
		case 'ViperM5_Leader_WPN':
			Template.Abilities.AddItem('BindM6Damage');
			break;
		default:
			Template.Abilities.AddItem('BindM2Damage');
			break;
	}
	// This all the resources; sounds, animations, models, physics, the works.

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}


static function X2DataTemplate CreateTemplate_AdvElite_WPN(name TemplateName)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventAssaultRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_CONVENTIONAL_RANGE;
    Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE; 

    Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	
	switch (TemplateName)
	{
		case 'AdvSergeantM1_WPN': Template.BaseDamage = default.AdvSergeantM1_WPN_BASEDAMAGE; break;
		case 'AdvSergeantM2_WPN': Template.BaseDamage = default.AdvSergeantM2_WPN_BASEDAMAGE;  break;
		case 'AdvShockTroop_WPN': Template.BaseDamage = default.AdvShockTroop_WPN_BASEDAMAGE;  break;
		case 'AdvCommando_WPN': Template.BaseDamage = default.AdvCommando_WPN_BASEDAMAGE; break;
		case 'AdvVanguard_WPN': Template.BaseDamage = default.AdvVanguard_WPN_BASEDAMAGE; break;
		case 'AdvScout_WPN': Template.BaseDamage = default.AdvScout_WPN_BASEDAMAGE; break;
		case 'AdvGeneralM1_LW_WPN': Template.BaseDamage = default.AdvGeneralM1_LW_WPN_BASEDAMAGE; break;
		case 'AdvGeneralM2_LW_WPN': Template.BaseDamage = default.AdvGeneralM2_LW_WPN_BASEDAMAGE; break;
		case 'AdvGeneralM3_LW_WPN': Template.BaseDamage = default.AdvGeneralM3_LW_WPN_BASEDAMAGE; break;
		case 'AdvGeneralM4_LW_WPN': Template.BaseDamage = default.AdvGeneralM4_LW_WPN_BASEDAMAGE; break;
		case 'AdvGeneralM5_LW_WPN': Template.BaseDamage = default.AdvGeneralM5_LW_WPN_BASEDAMAGE; break;

		case 'AdvTrooperM4_WPN': Template.BaseDamage = default.AdvTrooperM4_WPN_BASEDAMAGE; break;
		case 'AdvTrooperM5_WPN': Template.BaseDamage = default.AdvTrooperM5_WPN_BASEDAMAGE; break;

		case 'AdvShieldbearerM4_WPN': Template.BaseDamage = default.AdvSHIELDBEARERM4_WPN_BASEDAMAGE; break;
		case 'AdvShieldbearerM5_WPN': Template.BaseDamage = default.AdvSHIELDBEARERM5_WPN_BASEDAMAGE; break;

		case 'AdvStunLancerM4_WPN': Template.BaseDamage = default.ADVSTUNLANCERM4_WPN_BASEDAMAGE; break;
		case 'AdvStunLancerM5_WPN': Template.BaseDamage = default.ADVSTUNLANCERM5_WPN_BASEDAMAGE; break;

		case 'AdvCaptainM4_WPN': Template.BaseDamage = default.ADVCAPTAINM4_WPN_BASEDAMAGE; break;
		case 'AdvCaptainM5_WPN': Template.BaseDamage = default.ADVCAPTAINM5_WPN_BASEDAMAGE; break;


		default: break;
	}

    Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
    Template.iIdealRange = default.ADVVANGUARD_IDEALRANGE; 

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	Template.GameArchetype = "WP_AssaultRifle_MG.WP_AssaultRifle_MG_Advent";
	Template.iPhysicsImpulse = 5;
	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.DamageTypeTemplateName = 'Projectile_MagAdvent';

	return Template;
}


	static function X2DataTemplate CreateTemplate_Hunter_Flashbang()
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, 'HunterFlashbang');

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons..Inv_Flashbang_Grenade";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_flash");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_flash");
	Template.iRange = default.ADVGRENADIER_FLASHBANGGRENADE_RANGE;
	Template.iRadius = default.ADVGRENADIER_FLASHBANGGRENADE_RADIUS;
	
	Template.bFriendlyFire = false;
	Template.bFriendlyFireWarning = false;
	Template.Abilities.AddItem('ThrowGrenade');

	Template.ThrownGrenadeEffects.AddItem(class'X2StatusEffects'.static.CreateDisorientedStatusEffect());

	//We need to have an ApplyWeaponDamage for visualization, even if the grenade does 0 damage (makes the unit flinch, shows overwatch removal)
	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);

	Template.LaunchedGrenadeEffects = Template.ThrownGrenadeEffects;
	
	Template.GameArchetype = "WP_Grenade_Flashbang.WP_Grenade_Flashbang";

	Template.iEnvironmentDamage = default.ADVGRENADIER_FLASHBANGGRENADE_IENVIRONMENTDAMAGE;
	Template.iClipSize = 50;

	return Template;
}


static function X2DataTemplate CreateTemplate_Archon_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.ArchonStaff";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability


	Template.BaseDamage = Damage;
	
	Template.RangeAccuracy = default.FLAT_CONVENTIONAL_RANGE;


	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ARCHON_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Archon_Rifle.WP_ArchonRifle";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_Archon_Blazing_Pinions_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.ArchonStaff";

	Template.RangeAccuracy = default.FLAT_CONVENTIONAL_RANGE;
	Template.iClipSize = 0;
	Template.iSoundRange = 0;
	Template.iEnvironmentDamage = default.ARCHON_BLAZINGPINIONS_ENVDAMAGE;
	Template.iIdealRange = 0;
	Template.iPhysicsImpulse = 5;
	Template.DamageTypeTemplateName = 'BlazingPinions';

	Template.BaseDamage = Damage;

	Template.InventorySlot = eInvSlot_Utility;
	Template.Abilities.AddItem('BlazingPinionsStage2');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Archon_Blazing_Pinions.WP_Blazing_Pinions_CV";

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 0;

	return Template;
}

	static function X2DataTemplate CreateTemplate_Archon_MeleeAttack_LW(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'baton';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.ArchonStaff";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Archon_Staff.WP_ArchonStaff";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.Aim = default.GENERIC_MELEE_ACCURACY;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;
	Template.iIdealRange = 1;

	Template.BaseDamage = Damage;

	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 10;

	//Build Data
	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	Template.Abilities.AddItem('StandardMelee');
	Template.AddAbilityIconOverride('StandardMelee', "img:///UILibrary_PerkIcons.UIPerk_archon_beatdown");

	return Template;
}

static function X2DataTemplate CreateTemplate_GenericMeleeWeapon_LW(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'baton';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_PerkIcons.UIPerk_muton_punch";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.Aim = class'X2Item_DefaultWeapons'.default.GENERIC_MELEE_ACCURACY;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;
	Template.iIdealRange = 1;

	Template.BaseDamage = Damage;

	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 10;

	//Build Data
	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	return Template;
}


static function X2DataTemplate CreateTemplate_PsiZombie_MeleeAttack_LW(name TemplateName)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'melee';
	Template.WeaponTech = 'alien';
	Template.strImage = "img:///UILibrary_PerkIcons.UIPerk_muton_punch";
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.StowedLocation = eSlot_RightHand;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Zombiefist.WP_Zombiefist";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;
	Template.iIdealRange = 1;
	if(Templatename == 'PsiZombie_MeleeAttackM2')
	{
		Template.BaseDamage = default.PSIZOMBIE_MELEEATTACKM2_BASEDAMAGE;
	}
	if(Templatename == 'PsiZombie_MeleeAttackM3')
	{
		Template.BaseDamage = default.PSIZOMBIE_MELEEATTACKM3_BASEDAMAGE;
	}
	if(Templatename == 'PsiZombie_MeleeAttackM4')
	{
		Template.BaseDamage = default.PSIZOMBIE_MELEEATTACKM4_BASEDAMAGE;
	}
	if(Templatename == 'PsiZombie_MeleeAttackM5')
	{
		Template.BaseDamage = default.PSIZOMBIE_MELEEATTACKM5_BASEDAMAGE;
	}
	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 10;

	//Build Data
	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	Template.bDisplayWeaponAndAmmo = false;

	Template.Abilities.AddItem('StandardMelee');

	return Template;
}

// ********************************* Stun Lance
static function X2DataTemplate CreateTemplate_AdvStunLancer_StunLance_LW(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'baton';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_PerkIcons.UIPerk_muton_punch";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Adv_StunLancer.WP_StunLance";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.Aim = default.GENERIC_MELEE_ACCURACY;
	//Template.Aim = 10;

	Template.iRange = 0;
	Template.iRadius = 1;
	Template.NumUpgradeSlots = 2;
	Template.InfiniteAmmo = true;
	Template.iPhysicsImpulse = 5;
	Template.iIdealRange = 1;

	Template.BaseDamage = Damage;

	Template.BaseDamage.DamageType='Melee';
	Template.iSoundRange = 2;
	Template.iEnvironmentDamage = 0;

	//Build Data
	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	Template.Abilities.AddItem('StunLance');

	return Template;
}

static function X2DataTemplate CreateTemplate_AdvMEC_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventMecGun";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.FLAT_CONVENTIONAL_RANGE;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ADVMEC_M2_IDEALRANGE;
	

	Template.BaseDamage = Damage;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.Abilities.AddItem('Suppression');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_AdvMec_Gun.WP_AdvMecGun";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	Template.DamageTypeTemplateName = 'Projectile_MagAdvent';

	return Template;
}

static function X2DataTemplate CreateTemplate_AdvMEC_Shoulder_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'shoulder_launcher';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventMecGun";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.FLAT_CONVENTIONAL_RANGE;
	Template.iClipSize = 2;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ADVMEC_M2_IDEALRANGE;

	Template.BaseDamage = Damage;

	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.Abilities.AddItem('MicroMissiles');
	Template.Abilities.AddItem('MicroMissileFuse');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_AdvMec_Launcher.WP_AdvMecLauncher";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.iRange = 20;


	// This controls how much arc this projectile may have and how many times it may bounce
	Template.WeaponPrecomputedPathData.InitialPathTime = 1.5;
	Template.WeaponPrecomputedPathData.MaxPathTime = 2.5;
	Template.WeaponPrecomputedPathData.MaxNumberOfBounces = 0;

	Template.DamageTypeTemplateName = 'Explosion';

	return Template;
}

static function X2DataTemplate CreateTemplate_Andromedon_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AndromedonRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.FLAT_CONVENTIONAL_RANGE;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.ANDROMEDON_IDEALRANGE;

	Template.BaseDamage = Damage;
	
	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Andromedon_Cannon.WP_AndromedonCannon";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

	static function X2DataTemplate CreateTemplate_Spectre_PsiAttack_LW(name TemplateName, array<WeaponDamageValue> Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.WeaponTech = 'alien';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Psi_Amp";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	// This all the resources; sounds, animations, models, physics, the works.

	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.ExtraDamage = Damage;

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Psi';

	Template.Abilities.AddItem('Horror');

	return Template;
}

static function X2DataTemplate CreateTemplate_Spectre_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.ViperRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_MAGNETIC_RANGE;
	Template.BaseDamage = Damage;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = class'X2Item_XpackWeapons'.default.SPECTREM1_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';

	Template.InfiniteAmmo = false;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_SpectreRifle.WP_SpectreRifle";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_Gatekeeper_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.GatekeeperEyeball";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.BaseDamage = Damage;
	Template.iClipSize = 1;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Gatekeeper_Anima_Gate.WP_Gatekeeper_Anima_Gate";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_Sectopod_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_BeamSniperRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventTurret";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.FLAT_BEAM_RANGE;
	Template.BaseDamage = default.SECTOPOD_WPN_BASEDAMAGE;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.SECTOPOD_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('Blaster');
	Template.Abilities.AddItem('BlasterDuringCannon');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sectopod_Turret.WP_Sectopod_Turret";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}


static function X2DataTemplate CreateAcidBlob_LW(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	Template = new class'X2WeaponTemplate';
	
	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'grenade';
	Template.strImage = "img:///UILibrary_StrategyImages.InventoryIcons.Inv_SmokeGrenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.GameArchetype = "WP_Andromedon_AcidAttack.WP_Andromedon_AcidAttack";
	Template.CanBeBuilt = false;

	Template.iRange = 14;
	Template.iRadius = 2;
	Template.iClipSize = 1;
	Template.InfiniteAmmo = true;

	Template.iSoundRange = class'X2Item_DefaultGrenades'.default.GRENADE_SOUND_RANGE;
	Template.bSoundOriginatesFromOwnerLocation = false;

	Template.BaseDamage.DamageType = 'Acid';
	Template.BaseDamage = Damage;
	
	Template.InventorySlot = eInvSlot_Utility;
	Template.StowedLocation = eSlot_None;
	Template.Abilities.AddItem('AcidBlob');

	return Template;
}

static function X2DataTemplate CreateAdventGrenade(name TemplateName, WeaponDamageValue Damage)
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, TemplateName);

	Template.strImage = "img:///UILibrary_StrategyImages.InventoryIcons.Inv_FragGrenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";

	Template.BaseDamage = Damage;
	Template.iEnvironmentDamage = class'X2Item_DefaultGrenades'.default.FRAGGRENADE_IENVIRONMENTDAMAGE;
	Template.iRange = 10;
	Template.iRadius = 4;
	Template.iClipSize = 1;
	Template.iSoundRange = class'X2Item_DefaultGrenades'.default.GRENADE_SOUND_RANGE;
	Template.DamageTypeTemplateName = 'Explosion';

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');
	
	Template.GameArchetype = "WP_Grenade_Frag.WP_Grenade_Frag";

	Template.iPhysicsImpulse = 10;

	Template.StartingItem = false;
	Template.CanBeBuilt = false;

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);

	return Template;
}

static function X2DataTemplate CreateTemplate_Sectoid_LW_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.SectoidPistol";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = default.FLAT_CONVENTIONAL_RANGE;
	Template.BaseDamage = Damage;
	Template.iClipSize = default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = default.SECTOID_IDEALRANGE;

	Template.DamageTypeTemplateName = 'Heavy';
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "WP_Sectoid_ArmPistol.WP_SectoidPistol";

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	return Template;
}

static function X2DataTemplate CreateTemplate_AdvPriest_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.AdventAssaultRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.BaseDamage = Damage;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_MAGNETIC_RANGE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = class'X2Item_XpackWeapons'.default.ADVPRIESTM1_IDEALRANGE;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
//BEGIN AUTOGENERATED CODE: Template Overrides 'AdvPriestM1_WPN'
	Template.GameArchetype = "WP_AdvPriestRifle.WP_AdvPriestRifle";
//END AUTOGENERATED CODE: Template Overrides 'AdvPriestM1_WPN'

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	Template.DamageTypeTemplateName = 'Projectile_BeamAvatar';

	return Template;
}

static function X2DataTemplate CreateTemplate_AdvPriest_PsiAmp(name TemplateName, name HolyWarriorname)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	Template.WeaponPanelImage = "_PsiAmp";                       // used by the UI. Probably determines iconview of the weapon.
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'psiamp';
	Template.WeaponTech = 'conventional';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Psi_Amp";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.

//BEGIN AUTOGENERATED CODE: Template Overrides 'AdvPriestM2_PsiAmp'
	Template.GameArchetype = "WP_AdvPriestPsiAmp.WP_AdvPriestPsiAmp";
//END AUTOGENERATED CODE: Template Overrides 'AdvPriestM2_PsiAmp'

	//Template.Abilities.AddItem('PriestPsiMindControl');
	Template.Abilities.AddItem('PriestStasis');
	Template.Abilities.AddItem(HolyWarriorname);
	
	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Psi';

	return Template;
}

static function X2DataTemplate CreateTemplate_AdvStunLancer_Leader_WPN(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);
	
	Template.WeaponPanelImage = "_ConventionalRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'vektor_rifle';
	Template.WeaponTech = 'magnetic';
	Template.strImage = "img:///LWAdventPathfinderCaptain_UI.Icon_PathfinderHunterRifle";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability
	
	Template.BaseDamage = Damage;

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_MAGNETIC_RANGE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = 15;
	
	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	Template.BonusWeaponEffects.AddItem(class'X2Ability_LWAlienAbilities'.static.HunterMarkAdventEffect());
	//Animation Test
	//Template.Abilities.AddItem('Suppression');
	
	// This all the resources; sounds, animations, models, physics, the works.
	Template.GameArchetype = "LWAdventPathfinderHunterWeapons.Archetype.WP_HunterRifle_MG_Advent";


	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;

	Template.DamageTypeTemplateName = 'Projectile_MagAdvent';

	return Template;
}

static function X2DataTemplate CreateTemplate_PurgeGun(name TemplateName, WeaponDamageValue Damage)
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, TemplateName);

	Template.WeaponPanelImage = "_BeamRifle";                       // used by the UI. Probably determines iconview of the weapon.
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'rifle';
	Template.WeaponTech = 'beam';
	Template.strImage = "img:///WoTC_PurgePriest_UI.MagneticPurgeGun"; 
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.FLAT_MAGNETIC_RANGE;
	Template.BaseDamage = Damage;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = 13;

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');

	// This all the resources; sounds, animations, models, physics, the works.
//BEGIN AUTOGENERATED CODE: Template Overrides 'AdvPriestM1_WPN'
	Template.GameArchetype = "WoTC_PurgeGuns.Archetypes.WP_AdvPurgeGun"; 
//END AUTOGENERATED CODE: Template Overrides 'AdvPriestM1_WPN'

	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;

	Template.BonusWeaponEffects.AddItem(class'X2StatusEffects'.static.CreateBurningStatusEffect(2, 0));

	return Template;
}