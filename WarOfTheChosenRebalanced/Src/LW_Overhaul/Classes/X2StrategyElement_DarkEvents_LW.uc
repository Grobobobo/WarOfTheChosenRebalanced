class X2StrategyElement_DarkEvents_LW extends X2StrategyElement_DefaultDarkEvents config (GameData);

var config float RURAL_PROPAGANDA_BLITZ_RECRUITING_MULTIPLIER;
var config float COUNTERINTELLIGENCE_SWEEP_INTEL_MULTIPLIER;
var config float RURAL_CHECKPOINTS_SUPPLY_MULTIPLIER;

var config int T1_UPGRADES_WEIGHT;
var config int T2_UPGRADES_WEIGHT;
var config int T3_UPGRADES_WEIGHT;
var config int T4_UPGRADES_WEIGHT;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> DarkEvents;

	//`LWTrace("  >> X2StrategyElement_DarkEvents_LW.CreateTemplates()");
	
	//DarkEvents.AddItem(CreateCounterintelligenceSweepTemplate());
	//DarkEvents.AddItem(CreateRuralPropagandaBlitzTemplate());
	// DarkEvents.AddItem(CreateHavenInfiltrationTemplate());
	//DarkEvents.AddItem(CreateAirPatrolsTemplate());
	//DarkEvents.AddItem(CreateRuralCheckpointsLWTemplate());


	//DarkEvents.AddItem(CreateFirewallsTemplate());
		//DarkEvents.AddItem(CreateAdventScopesTemplate());
	//DarkEvents.AddItem(CreateAdventLaserSightsTemplate());
	//DarkEvents.AddItem(CreateAlienConditioning1Template());
	//DarkEvents.AddItem(CreateAlienConditioning2Template());
	//DarkEvents.AddItem(CreateAlienConditioning3Template());
	//DarkEvents.AddItem(CreateVeteranUnitsTemplate());
	//DarkEvents.AddItem(CreateAdvancedServosTemplate());
	//DarkEvents.AddItem(CreateTacticalUpgradesDefenseTemplate());
	//DarkEvents.AddItem(CreateTacticalUpgradesWilltoSurviveTemplate());
	//DarkEvents.AddItem(CreateTacticalUpgradesCenterMassTemplate());


	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Impulse_LW','Trooper',TrooperAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Formidable','Trooper',TrooperAppeared,default.T1_UPGRADES_WEIGHT));

	//DarkEvents.AddItem(CreateTacticalUpgradesTemplate('LockedOn','Trooper',MECAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('HyperReactivePupils','Trooper',MECAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('OpenFire_LW','Trooper',MECAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Suppression','Trooper',MECAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Evasive','Trooper',LidAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ChosenVenomRounds','Trooper',LidAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('CombatAwareness','Sentry',TrooperAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('GrazingFire','Sentry',TrooperAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('CoolUnderPressure','Sentry',MECAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Concentration_LW','Sentry',MECAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('RapidReaction','Sentry',LidAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('HuntersInstinct','Sentry',LidAppeared,default.T3_UPGRADES_WEIGHT));


	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('GrazingFire','Gunner',TrooperAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('OpenFire_LW','Gunner',TrooperAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('CombatAwareness','Gunner',MECAppeared,default.T2_UPGRADES_WEIGHT));
	//DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Mayhem','Gunner',MECAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('SteadFast','Gunner',LidAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Holotargeting','Gunner',LidAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Shredder','Gunner',LidAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('InstantReactionTime','Sectoid',TrooperAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Predator_LW','Sectoid',TrooperAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ShootingSharp_LW','Sectoid',MECAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Aggression','Sectoid',MECAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Dominant_LW','Sectoid',LidAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('MindShield','Sectoid',LidAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ApexPredator_LW','Sectoid',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Solace','Sectoid',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));

	// DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ShootingSharp_LW','Captain',TrooperAppeared,default.T1_UPGRADES_WEIGHT));

	// DarkEvents.AddItem(CreateTacticalUpgradesTemplate('AimAssist_LW','Captain',MECAppeared,default.T2_UPGRADES_WEIGHT));
	// DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Suppression','Captain',MECAppeared,default.T2_UPGRADES_WEIGHT));
	// DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Executioner_LW','Captain',MECAppeared,default.T2_UPGRADES_WEIGHT));

	// DarkEvents.AddItem(CreateTacticalUpgradesTemplate('CloseCombatSpecialist','Captain',LidAppeared,default.T3_UPGRADES_WEIGHT));
	// DarkEvents.AddItem(CreateTacticalUpgradesTemplate('OverBearingSuperiority_LW','Captain',LidAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Predator_LW','Drone',TrooperAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Brawler','Drone',TrooperAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('HuntersInstinct','Drone',MECAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ApexPredator_LW','Drone',MECAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('CloseCombatSpecialist','Drone',LidAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ParalyzingBlows','Drone',LidAppeared,default.T3_UPGRADES_WEIGHT));


	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Infighter','StunLancer',LancerAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ZoneOfControl_LW','StunLancer',LancerAppeared,default.T1_UPGRADES_WEIGHT));

	//DarkEvents.AddItem(CreateTacticalUpgradesTemplate('FreeGrenades','StunLancer',LancerAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('CoupDeGrace2','StunLancer',SpectreAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Bladestorm','StunLancer',AndromedonAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ParalyzingBlows','StunLancer',AndromedonAppeared,default.T3_UPGRADES_WEIGHT));


	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Infighter','Viper',ViperAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('OpenFire_LW','Viper',ViperAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('SurvivalInstinct_LW','Viper',SpectreAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('SteadyHands','Viper',SpectreAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Serpentine','Viper',LidAppeared,default.T3_UPGRADES_WEIGHT));
	//DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Entwine_LW','Viper',LidAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('HazmatVestBonus_LW','Viper',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Impulse_LW','Priest',ViperAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Infighter','Priest',ViperAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('SuperiorHolyWarrior','Priest',SpectreAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Grit_LW','Priest',SpectreAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('MindShield','Priest',SpectreAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Dominant_LW','Priest',LidAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ChosenDragonRounds','Priest',LidAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Solace','Priest',LidAppeared,default.T3_UPGRADES_WEIGHT));


	//DarkEvents.AddItem(CreateTacticalUpgradesTemplate('OverBearingSuperiority_LW','Priest',ViperM4,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('InstantReactionTime','Sidewinder',PurifierAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Formidable','Sidewinder',PurifierAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Predator_LW','Sidewinder',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('QuickRetreat','Sidewinder',ArchonAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Serpentine','Sidewinder',ArchonAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Magnum_LW','Purifier',PurifierAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('LowProfile','Purifier',PurifierAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('OverKill_LW','Purifier',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Sprinter','Purifier',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));

	//DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ReturnFire','Purifier',ArchonAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('InstantReactionTime','Purifier',ArchonAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Sprinter','Muton',MutonAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Shredder','Muton',MutonAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Bladestorm','Muton',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Predator_LW','Muton',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ZoneOfControl_LW','Muton',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('TotalCombat','Muton',MutonEliteAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Grit_LW','Muton',MutonEliteAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Resilience','Mec',MutonAppeared,default.T1_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Shredder','Mec',MutonAppeared,default.T1_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('VolatileMix','Mec',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Sprinter','Mec',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ReturnFire','Mec',MutonEliteAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('AbsorptionFields_LW','Mec',MutonEliteAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Resilience','Cyberus',Cyberus,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Predator','Cyberus',Cyberus,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('LowProfile','Cyberus',Cyberus,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ApexPredator_LW','Cyberus',Cyberus,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Infighter','Spectre',SpectreAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Predator_LW','Spectre',SpectreAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('LowProfile','Spectre',AndromedonAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Sprinter','Spectre',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('HuntersInstinct','Spectre',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Brawler','Shieldbearer',SpectreAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Formidable','Shieldbearer',LidAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ChosenDragonRounds','Shieldbearer',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ReadyForAnything','Shieldbearer',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Resilience','Berserker',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ParalyzingBlows','Berserker',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ZoneOfControl_LW','Berserker',ArchonAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Sprinter','Berserker',ArchonAppeared,default.T3_UPGRADES_WEIGHT));

//	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Bladestorm','Berserker',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('DamageControl','Berserker',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Infighter','Chryssalid',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('MovingTarget_LW','Chryssalid',BerserkerAppeared,default.T2_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('InstantReactionTime','Chryssalid',MutonEliteAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Sprinter','Chryssalid',MutonEliteAppeared,default.T3_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Grit_LW','Chryssalid',MutonEliteAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ParalyzingBlows','Chryssalid',MutonEliteAppeared,default.T3_UPGRADES_WEIGHT));

	//DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ReadyForAnything','Shieldbearer',ViperM4,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Sprinter','Andromedon',AndromedonAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('VolatileMix','Andromedon',AndromedonAppeared,default.T3_UPGRADES_WEIGHT));


	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('CloseCombatSpecialist','Andromedon',LancerM4,default.T4_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('SuperDuperRobot','AndromedonRobot',LancerM4,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('CoolUnderPressure','Archon',ArchonAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('HardTarget','Archon',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Shredder','Sectopod',SectopodAppeared,default.T3_UPGRADES_WEIGHT));
	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('ReturnFire','Sectopod',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));

	DarkEvents.AddItem(CreateTacticalUpgradesTemplate('Defilade','Gatekeeper',GateKeeperAppeared,default.T4_UPGRADES_WEIGHT));
/*
	DarkEvents.AddItem(CreateTacticalUpgradesFormidableTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesLethalTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesShredderTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesHuntersInstinctTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesLightningReflexesTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesGrazingFireTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesCutthroatTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesCombatAwarenessTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesIronSkinTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesTacticalSenseTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesAggressionTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesResilienceTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesShadowstepTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesDamageControlTemplate());
	DarkEvents.AddItem(CreateTacticalUpgradesHardTargetTemplate());
	DarkEvents.AddItem(CreateGreaterFacelessDarkEventTemplate());
	*/
	//DarkEvents.AddItem(CreateTacticalUpgradesMutonEngineersTemplate()); Disabled for now


    return DarkEvents;
}


static function X2DataTemplate CreateTacticalUpgradesTemplate(name BaseAbilityName,
name EnemyTag,
Delegate <X2DarkEventTemplate.CanActivateDelegate> Activation,
int StartingWeight = 5,
 String IconImage ="img:///UILibrary_StrategyImages.X2StrategyMap.DarkEvent_ShowOfForce",
int MinActivationDays = 12,
int MaxActivationDays = 18)
{
local X2DarkEventTemplate Template;

`CREATE_X2TEMPLATE(class'X2DarkEventTemplate', Template, name('DarkEvent_' $ EnemyTag $  BaseAbilityName));
Template.ImagePath = IconImage; 
GenericSettings(Template);
Template.StartingWeight = StartingWeight;
Template.MinActivationDays = MinActivationDays;
Template.MaxActivationDays = MaxActivationDays;
Template.CanActivateFn = Activation;

return Template;
}

static function X2DataTemplate CreateAirPatrolsTemplate()
{
	local X2DarkEventTemplate Template;

	`CREATE_X2TEMPLATE(class'X2DarkEventTemplate', Template, 'DarkEvent_AirPatrols');
	Template.ImagePath = "img:///UILibrary_StrategyImages.X2StrategyMap.DarkEvent_UFO";
	Template.Category = "DarkEvent";
	Template.bRepeatable = true;
    Template.bTactical = false;
    Template.bLastsUntilNextSupplyDrop = false;
    Template.MaxSuccesses = 0;
    Template.MinActivationDays = 8;
    Template.MaxActivationDays = 15;
    Template.MinDurationDays = 14;
    Template.MaxDurationDays = 16;
    Template.bInfiniteDuration = false;
    Template.StartingWeight = 5;
    Template.MinWeight = 1;
    Template.MaxWeight = 5;
    Template.WeightDeltaPerPlay = -1;
    Template.WeightDeltaPerActivate = 0;
	return Template;
}

static function X2DataTemplate CreateRuralCheckpointsLWTemplate()
{
	local X2DarkEventTemplate Template;

	`CREATE_X2TEMPLATE(class'X2DarkEventTemplate', Template, 'DarkEvent_RuralCheckpoints_LW');
    Template.ImagePath = "img:///UILibrary_StrategyImages.X2StrategyMap.DarkEvent_SuppliesSeized";
	Template.Category = "DarkEvent";
	Template.bRepeatable = true;
    Template.bTactical = false;
    Template.bLastsUntilNextSupplyDrop = false;
    Template.MaxSuccesses = 0;
    Template.MinActivationDays = 10;
    Template.MaxActivationDays = 15;
    Template.MinDurationDays = 14;
    Template.MaxDurationDays = 16;
    Template.bInfiniteDuration = false;
    Template.StartingWeight = 5;
    Template.MinWeight = 1;
    Template.MaxWeight = 5;
    Template.WeightDeltaPerPlay = -1;
    Template.WeightDeltaPerActivate = 0;
	return Template;
}


static function X2DataTemplate CreateCounterintelligenceSweepTemplate() 
{
	local X2DarkEventTemplate Template;

	`CREATE_X2TEMPLATE(class'X2DarkEventTemplate', Template, 'DarkEvent_CounterintelligenceSweep');
	Template.ImagePath = "img:///UILibrary_StrategyImages.X2StrategyMap.DarkEvent_Crackdown"; 
	Template.Category = "DarkEvent";
	Template.bRepeatable = true;
    Template.bTactical = false;
    Template.bLastsUntilNextSupplyDrop = false;
    Template.MaxSuccesses = 0;
    Template.MinActivationDays = 12;
    Template.MaxActivationDays = 16;
    Template.MinDurationDays = 14;
    Template.MaxDurationDays = 16;
    Template.bInfiniteDuration = false;
    Template.StartingWeight = 5;
    Template.MinWeight = 1;
    Template.MaxWeight = 5;
    Template.WeightDeltaPerPlay = -1;
    Template.WeightDeltaPerActivate = 0;
	return Template;
}

static function X2DataTemplate CreateRuralPropagandaBlitzTemplate()
{
	local X2DarkEventTemplate Template;

	`CREATE_X2TEMPLATE(class'X2DarkEventTemplate', Template, 'DarkEvent_RuralPropagandaBlitz');
	Template.ImagePath = "img:///UILibrary_StrategyImages.X2StrategyMap.DarkEvent_SuppliesSeized"; 
	Template.Category = "DarkEvent";
	Template.bRepeatable = true;
    Template.bTactical = false;
    Template.bLastsUntilNextSupplyDrop = false;
    Template.MaxSuccesses = 0;
    Template.MinActivationDays = 14;
    Template.MaxActivationDays = 20;
    Template.MinDurationDays = 14;
    Template.MaxDurationDays = 16;
    Template.bInfiniteDuration = false;
    Template.StartingWeight = 5;
    Template.MinWeight = 1;
    Template.MaxWeight = 5;
    Template.WeightDeltaPerPlay = -1;
    Template.WeightDeltaPerActivate = 0;

	return Template;
}

// static function X2DataTemplate CreateHavenInfiltrationTemplate()
// {
// 	local X2DarkEventTemplate Template;

// 	`CREATE_X2TEMPLATE(class'X2DarkEventTemplate', Template, 'DarkEvent_HavenInfiltration');
// 	Template.ImagePath = "img:///UILibrary_StrategyImages.X2StrategyMap.DarkEvent_Faceless"; 
// 	Template.Category = "DarkEvent";
// 	Template.bRepeatable = true;
//     Template.bTactical = false;
//     Template.bLastsUntilNextSupplyDrop = false;
//     Template.MaxSuccesses = 0;
//     Template.MinActivationDays = 10;
//     Template.MaxActivationDays = 15;
//     Template.MinDurationDays = 45;
//     Template.MaxDurationDays = 60;
//     Template.bInfiniteDuration = false;
//     Template.StartingWeight = 5;
//     Template.MinWeight = 1;
//     Template.MaxWeight = 5;
//     Template.WeightDeltaPerPlay = -1;
//     Template.WeightDeltaPerActivate = 0;
// 	Template.CanActivateFn = CanActivateFacelessUpgrade;
// 	return Template;
// }


// static function X2DataTemplate CreateGreaterFacelessDarkEventTemplate()
// {
// 	local X2DarkEventTemplate Template;

// 	`CREATE_X2TEMPLATE(class'X2DarkEventTemplate', Template, 'DarkEvent_GreaterFaceless');
// 	Template.ImagePath = "img:///UILibrary_StrategyImages.X2StrategyMap.DarkEvent_Faceless"; 
// 	GenericSettings(Template);
// 	Template.StartingWeight = 5;
//     Template.MinActivationDays = 10;
//     Template.MaxActivationDays = 14;
// 	Template.CanActivateFn = CanActivateFacelessUpgrade;
// 	return Template;
// }

function bool CanActivateHunterClass_LW (XComGameState_DarkEvent DarkEventState)
{
	//local XComGameStateHistory History;
	//local XComGameState_HeadquartersAlien AlienHQ;
	local XComGameState_HeadquartersResistance ResistanceHQ;

	//History = `XCOMHISTORY;
	//AlienHQ = XComGameState_HeadquartersAlien(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	ResistanceHQ = XComGameState_HeadquartersResistance(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	return  (ResistanceHQ.NumMonths >= (7 - `STRATEGYDIFFICULTYSETTING));
}

function bool CanActivateJune1 (XComGameState_DarkEvent DarkEventState)
{
	local XComGameState_HeadquartersResistance ResistanceHQ;

    ResistanceHQ = XComGameState_HeadquartersResistance(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	if (ResistanceHQ.NumMonths >= 3)
		return true;
	return false;
}

function bool CanActivateSept1 (XComGameState_DarkEvent DarkEventState)
{
	local XComGameState_HeadquartersResistance ResistanceHQ;

    ResistanceHQ = XComGameState_HeadquartersResistance(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	if (ResistanceHQ.NumMonths >= 6)
		return true;
	return false;
}

function bool CanActivateDec1 (XComGameState_DarkEvent DarkEventState)
{
	local XComGameState_HeadquartersResistance ResistanceHQ;

    ResistanceHQ = XComGameState_HeadquartersResistance(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));
	if (ResistanceHQ.NumMonths >= 9)
		return true;
	return false;
}

function bool SeenAnyofThem(array<name> Charlist)
{
	local bool Result;
	local int k;
	
	Result = false;
	for (k = 0; k < CharList.Length; ++k)
	{
		if (HasSeenCharacterTemplate(class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager().FindCharacterTemplate(CharList[k])))
		{
			Result = true;
		}
	}
	return Result;
}

function bool HasSeenCharacterTemplate(X2CharacterTemplate CharacterTemplate)
{
	return (`XCOMHQ.SeenCharacterTemplates.Find(CharacterTemplate.DataName) != INDEX_NONE);
}


function bool TrooperAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('AdvTrooperM1');
	CharList.AddItem('AdvCaptainM1');
	CharList.AddItem('AdvSentryM1');
	CharList.AddItem('AdvGunnerM1');
	CharList.AddItem('LWDroneM1');
	return SeenAnyofThem(Charlist);
}

function bool MECAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('AdvMec_M1');
	CharList.AddItem('AdvMec_Leader');
	return SeenAnyofThem(Charlist);
}

function bool LidAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('Chryssalid');
	CharList.AddItem('Chryssalid_Leader');
	return SeenAnyofThem(Charlist);
}

function bool LancerAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('AdvStunLancerM1');
	CharList.AddItem('AdvStunLancer_Leader');
	return SeenAnyofThem(Charlist);
}

function bool SpectreAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('SpectreM2');
	return SeenAnyofThem(Charlist);
}

function bool AndromedonAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;
	CharList.AddItem('Andromedon');
	CharList.AddItem('Andromedon_Leader');
	return SeenAnyofThem(Charlist);
}

function bool LancerM4(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('AdvStunSpectreAppeared');
	CharList.AddItem('SpecreM4');

	return SeenAnyofThem(Charlist);
}

function bool ViperAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('Viper');
	CharList.AddItem('AdvPriestM1');

	return SeenAnyofThem(Charlist);
}

function bool PurifierAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('AdvPurifierM1');
	CharList.AddItem('AdvPurifier_Leader');
	CharList.AddItem('SideWinderM1');
	CharList.AddItem('SideWinder_Leader');

	return SeenAnyofThem(Charlist);
}

function bool BerserkerAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('Berserker');
	CharList.AddItem('Berserker_Leader');

	return SeenAnyofThem(Charlist);
}

function bool MutonAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('Muton');
	CharList.AddItem('Muton_Leader');

	return SeenAnyofThem(Charlist);
}

function bool MutonEliteAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('BerserkerAppeared_LW');
	CharList.AddItem('BerserkerAppeared_Leader');

	return SeenAnyofThem(Charlist);
}

function bool Cyberus(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('Cyberus');
	return SeenAnyofThem(Charlist);
}

function bool ArchonAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('Archon');
	CharList.AddItem('Archon_Leader');
	return SeenAnyofThem(Charlist);
}

function bool SectopodAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('Sectopod');
	return SeenAnyofThem(Charlist);
}

function bool GateKeeperAppeared(XComGameState_DarkEvent DarkEventState)
{
	local array<name> CharList;

	CharList.AddItem('Gatekeeper');
	return SeenAnyofThem(Charlist);
}


function bool AlwaysFalse(XComGameState_DarkEvent DarkEventState)
{
	return false;
}


static function GenericSettings (out X2DarkEventTemplate Template)
{
	Template.Category = "DarkEvent";
	Template.bRepeatable = false;
    Template.bTactical = true;
    Template.bLastsUntilNextSupplyDrop = false;
	Template.StartingWeight = 5;
	Template.MaxWeight = Template.StartingWeight;
    Template.MaxSuccesses = 0;
    Template.MinDurationDays = 9999;
    Template.MaxDurationDays = 99999;
    Template.bInfiniteDuration = true;
    Template.WeightDeltaPerActivate = 0;
	Template.WeightDeltaPerPlay = 0;
    Template.MinActivationDays = 21;
    Template.MaxActivationDays = 28;
	Template.MinWeight = 1;
	Template.OnActivatedFn = ActivateTacticalDarkEvent;
    Template.OnDeactivatedFn = DeactivateTacticalDarkEvent;
}

function string GetMajorBreakthroughSummary2(string strSummaryText)
{
	local XGParamTag ParamTag;

	ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	ParamTag.StrValue0 = GetBlocksString(GetMajorBreakthroughDoom());
	return `XEXPAND.ExpandString(strSummaryText);
}

function string GetMajorBreakthroughPreMissionText2(string strPreMissionText)
{
	local XGParamTag ParamTag;

	ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	ParamTag.StrValue0 = GetBlocksString(GetMajorBreakthroughDoom());
	return `XEXPAND.ExpandString(strPreMissionText);
}

function bool CanActivateMajorBreakthroughAlt(XComGameState_DarkEvent DarkEventState)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersResistance ResistanceHQ;
	local bool bCanActivate;

	History = `XCOMHISTORY;
	ResistanceHQ = XComGameState_HeadquartersResistance(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersResistance'));

	`LWTRACE ("Checking activation criteria for Major Breakthrough Dark Event");
	bCanActivate = true;
	if (ResistanceHQ.NumMonths < 2)
	{
		`LWTRACE ("--- Major Breakthrough : Invalid because in first two months");
		bCanActivate = false;
	}
	if (AtMaxDoom())
	{
		`LWTRACE ("--- Major Breakthrough : Invalid because at max doom");
		bCanActivate = false;
	}
	if (!class'XComGameState_HeadquartersXCom'.static.IsObjectiveCompleted('S0_RevealAvatarProject'))
	{
		`LWTRACE ("--- Major Breakthrough : Invalid because at S0_RevealAvatarProject not complete");
		bCanActivate = false;
	}
	if (bCanActivate)
	{
		`LWTRACE ("--- Major Breakthrough : All conditions passed");
	}
	return bCanActivate;
}

function bool CanActivateMinorBreakthroughAlt(XComGameState_DarkEvent DarkEventState)
{
	local bool bCanActivate;

	`LWTRACE ("Checking activation criteria for Minor Breakthrough Dark Event");
	bCanActivate = true;
	if (AtFirstMonth())
	{
		`LWTRACE ("--- Minor Breakthrough : Invalid because in first month");
		bCanActivate = false;
	}
	if (AtMaxDoom())
	{
		`LWTRACE ("--- Minor Breakthrough : Invalid because at max doom");
		bCanActivate = false;
	}
	// Add condition that avatar project IS revealed
	if (!class'XComGameState_HeadquartersXCom'.static.IsObjectiveCompleted('S0_RevealAvatarProject'))
	{
		`LWTRACE ("--- Minor Breakthrough : Invalid because at S0_RevealAvatarProject not complete");
		bCanActivate = false;
	}
	if (bCanActivate)
	{
		`LWTRACE ("--- Minor Breakthrough : All conditions passed");
	}
	return bCanActivate;
}

// Removes BlackMarket impact
function ActivateAlienCypher_LW(XComGameState NewGameState, StateObjectReference InRef, optional bool bReactivate)
{
    local StrategyCostScalar IntelScalar;
	IntelScalar.ItemTemplateName = 'Intel';
	IntelScalar.Scalar = GetAlienCypherScalar();
	IntelScalar.Difficulty = `STRATEGYDIFFICULTYSETTING; // Set to the current difficulty

	GetAlienHQ().CostScalars.AddItem(IntelScalar);
}

function DeactivateAlienCypher_LW(XComGameState NewGameState, StateObjectReference InRef)
{
	local XComGameState_HeadquartersAlien AlienHQ;
	local int idx;

	AlienHQ = GetAlienHQ();

	for(idx = 0; idx < AlienHQ.CostScalars.Length; idx++)
	{
		if(AlienHQ.CostScalars[idx].ItemTemplateName == 'Intel' && AlienHQ.CostScalars[idx].Scalar == GetAlienCypherScalar())
		{
			AlienHQ.CostScalars.Remove(idx, 1);
			break;
		}
	}
}

function XComGameState_HeadquartersAlien GetAlienHQ()
{
	return XComGameState_HeadquartersAlien(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
}