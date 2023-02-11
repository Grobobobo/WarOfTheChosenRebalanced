// This is an Unreal Script
class X2Item_ResOpUtilityItems extends X2Item_DefaultGrenades config(GameData_WeaponData);


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Weapons;


	Weapons.AddItem(CreateFragGrenade_RO('FragGrenade_1',1));
	Weapons.AddItem(CreateFragGrenade_RO('FragGrenade_2',2));
	Weapons.AddItem(CreateFragGrenade_RO('FragGrenade_3',3));
	Weapons.AddItem(CreateFragGrenade_RO('FragGrenade_4',4));
	Weapons.AddItem(CreateFragGrenade_RO('FragGrenade_5',5));

	//Weapons.AddItem(CreateMagGrenade('MagGrenade_1',1));
	Weapons.AddItem(CreateMagGrenade('MagGrenade_2',2));
	Weapons.AddItem(CreateMagGrenade('MagGrenade_3',3));
	Weapons.AddItem(CreateMagGrenade('MagGrenade_4',4));
	Weapons.AddItem(CreateMagGrenade('MagGrenade_5',4));
    
	//Weapons.AddItem(CreateAlienGrenade_RO('AlienGrenade_1',1));
	//Weapons.AddItem(CreateAlienGrenade_RO('AlienGrenade_2',2));
	Weapons.AddItem(CreateAlienGrenade_RO('AlienGrenade_3',3));
	Weapons.AddItem(CreateAlienGrenade_RO('AlienGrenade_4',4));
	Weapons.AddItem(CreateAlienGrenade_RO('AlienGrenade_5',4));

	Weapons.AddItem(ProximityMine_RO('ProximityMine_3',3));
	Weapons.AddItem(ProximityMine_RO('ProximityMine_4',4));
	Weapons.AddItem(ProximityMine_RO('ProximityMine_5',5));


    return Weapons;
    }

static function WeaponDamageValue GetWeaponDamage(int WeaponTier, optional float DamagePCT = 1.0f, float CritDamagePCT = 0.5f , optional int BonusSpread = 0, optional int BonusPierce = 0, optional int BonusShred = 0, optional int BonusRupture = 0){
    local WeaponDamageValue WeaponDamage;
    local float FloatBaseDamage;
    local int IntBaseDamage;

    FloatBaseDamage = (3 + WeaponTier) * DamagePCT;
    IntBaseDamage = int(FloatBaseDamage);
    

    WeaponDamage.Damage = IntBaseDamage;
    WeaponDamage.Spread = Max(1 + int(FloatBaseDamage / 10) + BonusSpread,0);
    WeaponDamage.PlusOne = int((FloatBaseDamage - IntBaseDamage) * 100);
    WeaponDamage.Crit = int(FloatBaseDamage * CritDamagePCT);
    WeaponDamage.Pierce = BonusPierce;
    WeaponDamage.Shred = BonusShred;
    WeaponDamage.Rupture = BonusRupture;
	WeaponDamage.DamageType = 'Explosion';

    return WeaponDamage;
}
static function X2DataTemplate CreateFragGrenade_RO(name TemplateName, int Tier)
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local X2Effect_Knockback KnockbackEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, TemplateName);

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Frag_Grenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.iRange = default.FRAGGRENADE_RANGE;
	Template.iRadius = default.FRAGGRENADE_RADIUS;

	Template.BaseDamage = GetWeaponDamage(Tier,1.5f);
	Template.iSoundRange = default.FRAGGRENADE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.FRAGGRENADE_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.FRAGGRENADE_TRADINGPOSTVALUE;
	Template.iClipSize = default.FRAGGRENADE_ICLIPSIZE;
	Template.DamageTypeTemplateName = 'Explosion';
	Template.Tier = 0;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');
	
	Template.GameArchetype = "WP_Grenade_Frag.WP_Grenade_Frag";

	Template.iPhysicsImpulse = 10;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);

	Template.HideIfResearched = 'PlasmaGrenade';

	Template.OnThrowBarkSoundCue = 'ThrowGrenade';

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.ThrownGrenadeEffects.AddItem(KnockbackEffect);
	Template.LaunchedGrenadeEffects.AddItem(KnockbackEffect);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.FRAGGRENADE_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.FRAGGRENADE_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.FRAGGRENADE_BASEDAMAGE.Shred);

	return Template;
}

static function X2DataTemplate CreateMagGrenade(name TemplateName, int Tier)
{
	local X2GrenadeTemplate                  Template;
	local X2Effect_ApplyWeaponDamage         WeaponDamageEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, TemplateName);

	Template.strImage = "img:///WoTC_Advent_Assault_Trooper_UI_LW.Inv_Xcom_MagGrenade"; //Texture2D'WoTC_Advent_Assault_Trooper_UI_LW.Inv_Xcom_MagGrenade'
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///WoTC_Advent_Assault_Trooper_UI_LW.UIPerk_grenade_Mag");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///WoTC_Advent_Assault_Trooper_UI_LW.UIPerk_grenade_Mag"); //Texture2D'WoTC_Advent_Assault_Trooper_UI_LW.UIPerk_grenade_Mag'

	Template.iRange = class'X2Item_LWGrenades'.default.MAG_GRENADE_RANGE;
	Template.iRadius = class'X2Item_LWGrenades'.default.MAG_GRENADE_RADIUS;
	//Template.fCoverage = 50;

	Template.BaseDamage = GetWeaponDamage(Tier);
	Template.iSoundRange = class'X2Item_LWGrenades'.default.MAG_GRENADE_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_LWGrenades'.default.MAG_GRENADE_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = class'X2Item_LWGrenades'.default.MAG_GRENADE_TRADINGPOSTVALUE;
	Template.PointsToComplete = class'X2Item_LWGrenades'.default.MAG_GRENADE_IPOINTS;
	Template.iClipSize = class'X2Item_LWGrenades'.default.MAG_GRENADE_ICLIPSIZE;
	Template.Tier = Tier;


	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');


	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;

	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);
	
	Template.GameArchetype = "WoTC_Advent_Assault_Trooper_Grenades_LW.Archetypes.WP_Grenade_Mag_Xcom"; //XComWeapon'WoTC_Advent_Assault_Trooper_Grenades_LW.Archetypes.WP_Grenade_Mag_Xcom'

	Template.iPhysicsImpulse = 10;
	Template.fKnockbackDamageAmount = 10.0f;
	Template.fKnockbackDamageRadius = 10.0f;

	Template.CanBeBuilt = true;
	
	//Template.RewardDecks.AddItem('ExperimentalGrenadeRewards');

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , class'X2Item_LWGrenades'.default.MAG_GRENADE_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , class'X2Item_LWGrenades'.default.MAG_GRENADE_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , class'X2Item_LWGrenades'.default.MAG_GRENADE_BASEDAMAGE.Shred);

	return Template;
}


static function X2DataTemplate CreateAlienGrenade_RO(name TemplateName, int Tier)
{
	local X2GrenadeTemplate Template;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	local X2Effect_Knockback KnockbackEffect;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, TemplateName);

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Plasma_Grenade";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.iRange = default.ALIENGRENADE_RANGE;
	Template.iRadius = default.ALIENGRENADE_RADIUS;

	Template.BaseDamage = GetWeaponDamage(Tier,1.25f,,,,1);
	Template.iSoundRange = default.ALIENGRENADE_ISOUNDRANGE;
	Template.iEnvironmentDamage = default.ALIENGRENADE_IENVIRONMENTDAMAGE;
	Template.TradingPostValue = default.ALIENGRENADE_TRADINGPOSTVALUE;
	Template.PointsToComplete = default.ALIENGRENADE_IPOINTS;
	Template.iClipSize = default.ALIENGRENADE_ICLIPSIZE;
	Template.DamageTypeTemplateName = 'Explosion';
	Template.Tier = Tier;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem('GrenadeFuse');

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	Template.ThrownGrenadeEffects.AddItem(WeaponDamageEffect);
	Template.LaunchedGrenadeEffects.AddItem(WeaponDamageEffect);
	
	Template.GameArchetype = "WP_Grenade_Alien.WP_Grenade_Alien_Soldier";

	Template.iPhysicsImpulse = 10;

	Template.CreatorTemplateName = 'PlasmaGrenade'; // The schematic which creates this item
	Template.BaseItem = 'FragGrenade'; // Which item this will be upgraded from

	Template.CanBeBuilt = false;
	Template.bInfiniteItem = true;

	KnockbackEffect = new class'X2Effect_Knockback';
	KnockbackEffect.KnockbackDistance = 2;
	Template.ThrownGrenadeEffects.AddItem(KnockbackEffect);
	Template.LaunchedGrenadeEffects.AddItem(KnockbackEffect);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.ALIENGRENADE_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.ALIENGRENADE_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.ALIENGRENADE_BASEDAMAGE.Shred);
	
	return Template;
}

static function X2GrenadeTemplate ProximityMine_RO(name TemplateName, int Tier)
{
	local X2GrenadeTemplate Template;
	local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2GrenadeTemplate', Template, TemplateName);

	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Proximity_Mine";
	Template.EquipSound = "StrategyUI_Grenade_Equip";
	Template.AddAbilityIconOverride('ThrowGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_proximitymine");
	Template.AddAbilityIconOverride('LaunchGrenade', "img:///UILibrary_PerkIcons.UIPerk_grenade_proximitymine");
	Template.iRange = default.PROXIMITYMINE_RANGE;
	Template.iRadius = default.PROXIMITYMINE_RADIUS;
	Template.iClipSize = 1;
	Template.BaseDamage = GetWeaponDamage(Tier,2.5f,,,,1);
	Template.iSoundRange = 10;
	Template.iEnvironmentDamage = 20;
	Template.DamageTypeTemplateName = 'Explosion';
	Template.Tier = Tier;

	Template.Abilities.AddItem('ThrowGrenade');
	Template.Abilities.AddItem(class'X2Ability_Grenades'.default.ProximityMineDetonationAbilityName);
	Template.Abilities.AddItem('GrenadeFuse');

	Template.bOverrideConcealmentRule = true;               //  override the normal behavior for the throw or launch grenade ability
	Template.OverrideConcealmentRule = eConceal_Always;     //  always stay concealed when throwing or launching a proximity mine
	
	Template.GameArchetype = "WP_Proximity_Mine.WP_Proximity_Mine";

	Template.iPhysicsImpulse = 10;

	Template.CanBeBuilt = true;	
	Template.TradingPostValue = 25;
	
	// Requirements
	Template.Requirements.RequiredTechs.AddItem('AutopsyAndromedon');

	// Cost
	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 100;
	Template.Cost.ResourceCosts.AddItem(Resources);

	Template.SetUIStatMarkup(class'XLocalizedData'.default.RangeLabel, , default.PROXIMITYMINE_RANGE);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.RadiusLabel, , default.PROXIMITYMINE_RADIUS);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.ShredLabel, , default.PROXIMITYMINE_BASEDAMAGE.Shred);
	
	return Template;
}