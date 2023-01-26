//---------------------------------------------------------------------------------------
//  FILE:    X2Ability_LW_GearAbilities.uc
//  AUTHOR:  John Lumpkin (Pavonis Interactive)
//  PURPOSE: Defines gear-based ability templates for LW Overhaul
//--------------------------------------------------------------------------------------- 

class X2Ability_LW_GearAbilities extends X2Ability config(LW_Overhaul);

var config int SCOPE_BSC_AIM_BONUS;
var config int SCOPE_ADV_AIM_BONUS;
var config int SCOPE_SUP_AIM_BONUS;
var config int SCOPE_EMPOWER_BONUS;

var config int TRIGGER_BSC_AIM_BONUS;
var config int TRIGGER_ADV_AIM_BONUS;
var config int TRIGGER_SUP_AIM_BONUS;
var config int TRIGGER_EMPOWER_BONUS;

var config int STOCK_BSC_SW_AIM_BONUS;
var config int STOCK_ADV_SW_AIM_BONUS;
var config int STOCK_SUP_SW_AIM_BONUS;
var config int STOCK_EMPOWER_BONUS;

var config int STOCK_BSC_SUCCESS_CHANCE;
var config int STOCK_ADV_SUCCESS_CHANCE;
var config int STOCK_SUP_SUCCESS_CHANCE;

var config int MINI_PLATING_HP;
var config int CERAMIC_PLATING_HP;
var config int ALLOY_PLATING_HP;
var config int CARAPACE_PLATING_HP;
var config int CHITIN_PLATING_HP;

var config int LIGHT_KEVLAR_PLATING_HP;
var config int SPIDER_PLATING_HP;
var config int WRAITH_PLATING_HP;
var config int KEVLAR_PLATING_HP;
var config int PREDATOR_PLATING_HP;
var config int WARDEN_PLATING_HP;

var config int CARPACE_MEDIUM_PLATING_HP;
var config int CARPACE_MEDIUM_HP;
var config int CARPACE_MEDIUM_ARMOR;

var config int TITAN_MEDIUM_PLATING_HP;
var config int TITAN_MEDIUM_HP;
var config int TITAN_MEDIUM_ARMOR;

var config int NANOFIBER_CRITDEF_BONUS;
var config int NANOFIBER_ABLATIVE_BONUS;

var config int HAZMAT_ABLATIVE_BONUS;


var config int BONUS_COILGUN_SHRED;

var config int BLUESCREEN_DISORIENT_CHANCE;

var localized string strWeight;
var localized string AblativeHPLabel;

var config int LIGHT_KEVLAR_MOBILITY_BONUS;
var config int HEAVY_ARMOR_MOB_PENALTY;
var config int HEAVY_WEAPONS_MOB_PENALTY;
var config int LIGHT_WEAPONS_MOB_BONUS;


var config int EXPANDED_MAG_MOB_PENALTY;


var config int AP_ROUNDS_CRIT_PENALTY;

var config int COMMANDER_VEST_CV_BASEDAMAGE;
var config int COMMANDER_VEST_LS_BASEDAMAGE;
var config int COMMANDER_VEST_MG_BASEDAMAGE;
var config int COMMANDER_VEST_CG_BASEDAMAGE;
var config int COMMANDER_VEST_BM_BASEDAMAGE;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	`Log("LW_GearAbilitySet.CreateTemplates --------------------------------");

	Templates.AddItem(CreateScopeBonus('Scope_LW_Bsc_Ability', default.SCOPE_BSC_AIM_BONUS));
	Templates.AddItem(CreateScopeBonus('Scope_LW_Adv_Ability', default.SCOPE_ADV_AIM_BONUS));
	Templates.AddItem(CreateScopeBonus('Scope_LW_Sup_Ability', default.SCOPE_SUP_AIM_BONUS));

	Templates.AddItem(CreateHairTriggerBonus('Hair_Trigger_LW_Bsc_Ability', default.TRIGGER_BSC_AIM_BONUS));
	Templates.AddItem(CreateHairTriggerBonus('Hair_Trigger_LW_Adv_Ability', default.TRIGGER_ADV_AIM_BONUS));
	Templates.AddItem(CreateHairTriggerBonus('Hair_Trigger_LW_Sup_Ability', default.TRIGGER_SUP_AIM_BONUS));
	
	Templates.AddItem(CreateStockSteadyWeaponAbility('Stock_LW_Bsc_Ability', default.STOCK_BSC_SW_AIM_BONUS));
	Templates.AddItem(CreateStockSteadyWeaponAbility('Stock_LW_Adv_Ability', default.STOCK_ADV_SW_AIM_BONUS));
	Templates.AddItem(CreateStockSteadyWeaponAbility('Stock_LW_Sup_Ability', default.STOCK_SUP_SW_AIM_BONUS));

	Templates.AddItem(CreateStockGrazingFireAbility('Stock_GF_Bsc_Ability', default.STOCK_BSC_SUCCESS_CHANCE));
	Templates.AddItem(CreateStockGrazingFireAbility('Stock_GF_Adv_Ability', default.STOCK_ADV_SUCCESS_CHANCE));
	Templates.AddItem(CreateStockGrazingFireAbility('Stock_GF_Sup_Ability', default.STOCK_SUP_SUCCESS_CHANCE));

	Templates.AddItem(CreateAblativeHPAbility('Mini_Plating_Ability', default.MINI_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Ceramic_Plating_Ability', default.CERAMIC_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Alloy_Plating_Ability', default.ALLOY_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Chitin_Plating_Ability', default.CHITIN_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Carapace_Plating_Ability', default.CARAPACE_PLATING_HP));

	Templates.AddItem(CreateAblativeHPAbility('Light_Kevlar_Plating_Ability', default.LIGHT_KEVLAR_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Spider_Plating_Ability', default.SPIDER_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Wraith_Plating_Ability', default.WRAITH_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Kevlar_Plating_Ability', default.KEVLAR_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Predator_Plating_Ability', default.PREDATOR_PLATING_HP));
	Templates.AddItem(CreateAblativeHPAbility('Warden_Plating_Ability', default.WARDEN_PLATING_HP));

	Templates.AddItem(CreateHazmatVestBonusAbility_LW());
	Templates.AddItem(CreateDeadMansVestBonusAbility_LW());

	
	Templates.AddItem(CreateNanofiberBonusAbility_LW());
	Templates.AddItem(CreateNeurowhipAbility());
	Templates.AddItem(CreateStilettoRoundsAbility());
	Templates.AddItem(CreateFlechetteRoundsAbility());

	Templates.AddItem(PurePassive('Needle_Rounds_Ability', "img:///UILibrary_PerkIcons.UIPerk_ammo_needle", false, 'eAbilitySource_Item'));
	Templates.AddItem(PurePassive('Redscreen_Rounds_Ability', "img:///UILibrary_LW_Overhaul.LW_AbilityRedscreen", false, 'eAbilitySource_Item'));
	Templates.AddItem(PurePassive('Shredder_Rounds_Ability', "img:///UILibrary_PerkIcons.UIPerk_maximumordanance", false, 'eAbilitySource_Item'));
	
	Templates.AddItem(PurePassive('Dragon_Rounds_Ability_PP', "img:///UILibrary_PerkIcons.UIPerk_ammo_incendiary", false, 'eAbilitySource_Item'));
	Templates.AddItem(PurePassive('Bluescreen_Rounds_Ability_PP', "img:///UILibrary_PerkIcons.UIPerk_ammo_bluescreen", false, 'eAbilitySource_Item'));
	Templates.AddItem(PurePassive('Talon_Rounds_Ability_PP', "img:///UILibrary_PerkIcons.UIPerk_ammo_talon", false, 'eAbilitySource_Item'));
	Templates.AddItem(PurePassive('AP_Rounds_Ability_PP', "img:///UILibrary_PerkIcons.UIPerk_ammo_ap", false, 'eAbilitySource_Item'));
	Templates.AddItem(PurePassive('Venom_Rounds_Ability_PP', "img:///UILibrary_LW_Overhaul.LW_AbilityVenomRounds", false, 'eAbilitySource_Item'));
	Templates.AddItem(PurePassive('Tracer_Rounds_Ability_PP', "img:///UILibrary_PerkIcons.UIPerk_ammo_tracer", false, 'eAbilitySource_Item'));

	Templates.AddItem(PurePassive('FireControl25', "img:///UILibrary_LW_Overhaul.LW_AbilityFireControl", false));
	Templates.AddItem(PurePassive('FireControl50', "img:///UILibrary_LW_Overhaul.LW_AbilityFireControl", false));
	Templates.AddItem(PurePassive('FireControl75', "img:///UILibrary_LW_Overhaul.LW_AbilityFireControl", false));

	Templates.AddItem(CreateSmallItemWeightAbility());
	Templates.AddItem(RemoveGrenadeWeightAbility()); // does not work

	Templates.AddItem(CreateSedateAbility());
	Templates.AddItem(CreateBonusShredAbility('CoilgunBonusShredAbility', default.BONUS_COILGUN_SHRED));

	Templates.AddItem(CreateBluescreenRoundsDisorient());
	//Templates.AddItem(CreateConsumeWhenActivatedAbility ('ConsumeShapedCharge', 'ShapedChargeUsed'));

	Templates.AddItem(CreateLightKevlarAbility());
	Templates.AddItem(HeavyArmorMobPenalty());
	Templates.AddItem(HeavyWeaponsMobPenalty());
	Templates.AddItem(HeavySecondaryWeaponsMobPenalty());
	Templates.AddItem(LightSecondaryWeaponsMobBonus());
	Templates.AddItem(ExpandedMagMobPenalty());
	Templates.AddItem(AddAPRoundsCritPenalty());
	Templates.AddItem(Gremlin_T2_Indicator());
	Templates.AddItem(Gremlin_T3_Indicator());
	Templates.AddItem(ScorchCircuitsDamage());
	Templates.AddItem(HisVengeance());
	Templates.AddItem(HisWill());

	Templates.AddItem(MediumCarapaceArmorStats());
	Templates.AddItem(MediumTitanArmorStats());

	
	return Templates;
}

static function X2AbilityTemplate CreateScopeBonus(name TemplateName, int Bonus)
{
	local X2AbilityTemplate                 Template;	
	local X2Effect_ModifyNonReactionFire	ScopeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	
	Template.AbilitySourceName = 'eAbilitySource_Item';

	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;
	ScopeEffect=new class'X2Effect_ModifyNonReactionFire';
	ScopeEffect.BuildPersistentEffect(1,true,false,false);
	//ScopeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	ScopeEffect.To_Hit_Modifier = Bonus;
	ScopeEffect.Upgrade_Empower_Bonus = default.SCOPE_EMPOWER_BONUS;
	ScopeEffect.FriendlyName = Template.LocFriendlyName;
	Template.AddTargetEffect(ScopeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate CreateHairTriggerBonus(name TemplateName, int Bonus)
{
	local X2AbilityTemplate				Template;
	local X2Effect_HairTrigger			TriggerEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);	
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;
	TriggerEffect=new class'X2Effect_HairTrigger';
	TriggerEffect.BuildPersistentEffect(1,true,false,false);
	//TriggerEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	TriggerEffect.To_Hit_Modifier = Bonus;
	TriggerEffect.Upgrade_Empower_Bonus = default.TRIGGER_EMPOWER_BONUS;
	TriggerEffect.FriendlyName = Template.LocFriendlyName;
	Template.AddTargetEffect(TriggerEffect);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

static function X2AbilityTemplate CreateStockSteadyWeaponAbility(name TemplateName, int Bonus)
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCooldown					Cooldown;
	local X2AbilityCost_ActionPoints		ActionPointCost;
	local X2Effect_SteadyWeapon				ToHitModifier;
	local X2Condition_UnitEffects			SuppressedCondition;
	local X2Condition_AnyEnemyVisible		VisibleCondition;
	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);
	Template.IconImage = "img:///UILibrary_LW_PerkPack.LW_AbilitySteadyWeapon";
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.bSkipFireAction=true;
	Template.bShowActivation=true;
	Template.AbilityConfirmSound = "Unreal2DSounds_OverWatch";
	Template.bCrossClassEligible = false;
	//Template.DefaultKeyBinding = 539;
	//Template.bNoConfirmationWithHotKey = true;
	Template.AddShooterEffectExclusions();

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = 1;
	Template.AbilityCooldown = Cooldown;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;    
	Template.AbilityCosts.AddItem(ActionPointCost);

    Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	SuppressedCondition = new class'X2Condition_UnitEffects';
	SuppressedCondition.AddExcludeEffect(class'X2Effect_Suppression'.default.EffectName, 'AA_UnitIsSuppressed');
	SuppressedCondition.AddExcludeEffect(class'X2Effect_AreaSuppression'.default.EffectName, 'AA_UnitIsSuppressed');
	Template.AbilityShooterConditions.AddItem(SuppressedCondition);

	VisibleCondition = new class'X2Condition_AnyEnemyVisible';
	Template.AbilityShooterConditions.AddItem(VisibleCondition);

	Template.CinescriptCameraType = "Overwatch";
	ToHitModifier = new class'X2Effect_SteadyWeapon';
	ToHitModifier.BuildPersistentEffect(2, false, true, false, eGameRule_PlayerTurnBegin);
	ToHitModifier.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,,Template.AbilitySourceName);
	ToHitModifier.DuplicateResponse = eDupe_Refresh;
	ToHitModifier.Aim_Bonus = Bonus;
	ToHitModifier.Crit_Bonus = Bonus;
	ToHitModifier.Upgrade_Empower_Bonus = default.STOCK_EMPOWER_BONUS;
	//ToHitModifier.ITZ_Triggers = default.VALID_ITZ_ABILITIES;
	Template.AddTargetEffect(ToHitModifier);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	return Template;
}

static function X2AbilityTemplate CreateStockGrazingFireAbility(name TemplateName, int Chance)
{
	local X2AbilityTemplate					Template;
	local X2Effect_GrazingFire				GrazingEffect;

	`CREATE_X2ABILITY_TEMPLATE (Template, TemplateName);

	Template.IconImage = "img:///UILibrary_LW_PerkPack.LW_AbilityGrazingFire";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.AbilityToHitCalc = default.DeadEye;
    Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.bShowActivation = false;
	Template.bSkipFireAction = true;
	Template.bCrossClassEligible = true;
	GrazingEffect = new class'X2Effect_GrazingFire';
	GrazingEffect.SuccessChance = Chance;
	GrazingEffect.BuildPersistentEffect (1, true, false);
	//GrazingEffect.SetDisplayInfo (ePerkBuff_Passive,Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	Template.AddTargetEffect(GrazingEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	//Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	return Template;
}


static function X2AbilityTemplate CreateAblativeHPAbility(name TemplateName, int AblativeHPAmt)
{
	local X2AbilityTemplate                 Template;
	local X2Effect_PersistentStatChange		AblativeHP;

	`CREATE_X2ABILITY_TEMPLATE(Template, TemplateName);

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.Hostility = eHostility_Neutral;
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	Template.bShowActivation=false;
	Template.bDisplayInUITacticalText = false;
	Template.bIsPassive = true;
	Template.bCrossClassEligible = false;
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	AblativeHP = new class'X2Effect_PersistentStatChange';
	AblativeHP.BuildPersistentEffect(1, true, false, false);
	AblativeHP.AddPersistentStatChange(eStat_ShieldHP, AblativeHPAmt);
	Template.AddTargetEffect(AblativeHP);
	Template.SetUIStatMarkup(default.AblativeHPLabel, eStat_ShieldHP, AblativeHPAmt);
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}


static function X2AbilityTemplate CreateHazmatVestBonusAbility_LW()
{
	local X2AbilityTemplate                 Template;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;
	local X2Effect_DamageImmunity           DamageImmunity;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HazmatVestBonus_LW');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_item_flamesealant";

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	// Bonus to health stat Effect, also gives protection from fire and poison
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ShieldHP, default.HAZMAT_ABLATIVE_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);
	
	DamageImmunity = new class'X2Effect_DamageImmunity';
	DamageImmunity.ImmuneTypes.AddItem('Fire');
	DamageImmunity.ImmuneTypes.AddItem('Poison');
	DamageImmunity.ImmuneTypes.AddItem('Acid'); /// ADDING THIS
	DamageImmunity.ImmuneTypes.AddItem(class'X2Item_DefaultDamageTypes'.default.ParthenogenicPoisonType);
	DamageImmunity.BuildPersistentEffect(1, true, false, false);
	DamageImmunity.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false, , Template.AbilitySourceName);
	Template.AddTargetEffect(DamageImmunity);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function X2AbilityTemplate CreateDeadMansVestBonusAbility_LW()
{
	local X2AbilityTemplate                 Template;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'DeadMansVestBonus_LW');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_item_flamesealant";

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	// Bonus to health stat Effect, also gives protection from fire and poison
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ShieldHP, default.HAZMAT_ABLATIVE_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);
	
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}


static function X2AbilityTemplate CreateNanoFiberBonusAbility_LW()
{
	local X2AbilityTemplate                 Template;	
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;
	local X2Effect_Resilience				CritDefEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'NanofiberVestBonus_LW');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_item_nanofibervest";

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	

	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false, , Template.AbilitySourceName);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ShieldHP, default.NANOFIBER_ABLATIVE_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	CritDefEffect = new class'X2Effect_Resilience';
	CritDefEffect.CritDef_Bonus = default.NANOFIBER_CRITDEF_BONUS;
	CritDefEffect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(CritDefEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}


static function X2AbilityTemplate CreateStilettoRoundsAbility()
{
	local X2AbilityTemplate                 Template;	
	local X2Effect_StilettoRounds			Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'Stiletto_Rounds_Ability');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_ammo_stiletto";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'X2Effect_StilettoRounds';
	Effect.BonusDmg = class'X2Item_LWUtilityItems'.default.STILETTO_DMGMOD;
	Effect.BuildPersistentEffect (1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
	Template.AddTargetEffect (Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate CreateFlechetteRoundsAbility()
{
	local X2AbilityTemplate                 Template;	
	local X2Effect_FlechetteRounds			Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'Flechette_Rounds_Ability');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_ammo_fletchette";

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'X2Effect_FlechetteRounds';
	Effect.BonusDmg = class'X2Item_LWUtilityItems'.default.FLECHETTE_BONUS_DMG;
	Effect.BuildPersistentEffect (1, true, false, false);
	Effect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true, , Template.AbilitySourceName);
	Template.AddTargetEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate CreateNeurowhipAbility()
{
	local X2AbilityTemplate                 Template;	
	local X2Effect_PersistentStatChange		Effect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'Neurowhip_Ability');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = new class'X2Effect_PersistentStatChange';
	Effect.AddPersistentStatChange(eStat_PsiOffense, float(class'X2Item_LWUtilityItems'.default.NEUROWHIP_PSI_BONUS));
	Effect.AddPersistentStatChange(eStat_Will, -float(class'X2Item_LWUtilityItems'.default.NEUROWHIP_WILL_MALUS));
	Effect.BuildPersistentEffect (1, true, false, false);
	Template.AddTargetEffect(Effect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	return Template;
}

// function SetUIStatMarkup(string InLabel, optional X2TacticalGameRulesetDataStructures.ECharStatType InStatType, optional int Amount, optional bool ForceShow, optional delegate<SpecialRequirementsDelegate> ShowUIStatFn)

static function X2AbilityTemplate CreateSmallItemWeightAbility()
{
	local X2AbilityTemplate								Template;	
	local X2Effect_ItemWeight							WeightEffect;
	
	`CREATE_X2ABILITY_TEMPLATE(Template, 'SmallItemWeight');
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);
	//Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_ammo_stiletto";

	WeightEffect = new class'X2Effect_ItemWeight';
	WeightEffect.EffectName = 'SmallItemWeight';
	WeightEffect.BuildPersistentEffect (1, true, false, false);
	//WeightEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false, , Template.AbilitySourceName);
	WeightEffect.bUniqueTarget = true;
	WeightEffect.DuplicateResponse = eDupe_Allow;
	Template.AddTargetEffect(WeightEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

// This doesn't work
static function X2AbilityTemplate RemoveGrenadeWeightAbility()
{
	local X2AbilityTemplate						Template;	
	local X2Effect_RemoveEffects				RemoveEffects;
	local X2AbilityTrigger_OnAbilityActivated	GrenadeTossTrigger, GrenadeLaunchTrigger;
	local X2AbilityCharges					Charges;
	local X2AbilityCost_Charges				ChargeCost;
	local X2Condition_UnitEffects			UntriggeredCondition;
	local X2Effect_Persistent				TriggeredEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'RemoveGrenadeWeight');
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	
	GrenadeTossTrigger=new class 'X2AbilityTrigger_OnAbilityActivated';
	GrenadeTossTrigger.SetListenerData('ThrowGrenade');
	Template.AbilityTriggers.AddItem(GrenadeTossTrigger);

	GrenadeLaunchTrigger=new class 'X2AbilityTrigger_OnAbilityActivated';
	GrenadeLaunchTrigger.SetListenerData('LaunchGrenade');
	Template.AbilityTriggers.AddItem(GrenadeLaunchTrigger);

	Charges = new class'X2AbilityCharges';
    Charges.InitialCharges = 1;
    Template.AbilityCharges = Charges;

    ChargeCost = new class'X2AbilityCost_Charges';
    ChargeCost.NumCharges = 1;
    Template.AbilityCosts.AddItem(ChargeCost);

	UntriggeredCondition = new class 'X2Condition_UnitEffects';
	UntriggeredCondition.AddExcludeEffect('GrenadeWeightLoss', 'AA_UnitAlreadyAffected');
	Template.AbilityTargetConditions.AddItem(UntriggeredCondition);

	TriggeredEffect = new class 'X2Effect_Persistent';
	TriggeredEffect.EffectName = 'GrenadeWeightLoss';
	TriggeredEffect.bCanTickEveryAction = true;
	TriggeredEffect.BuildPersistentEffect(1,false,false,false,eGameRule_UseActionPoint);
	Template.AddTargetEffect(TriggeredEffect);

	//Maybe a once-per condition 

	RemoveEffects = new class'X2Effect_RemoveEffects';
	RemoveEffects.EffectNamesToRemove.AddItem('SmallItemWeight');
	Template.AddTargetEffect(RemoveEffects);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

static function SedatedVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
    if(EffectApplyResult != 'AA_Success')
    {
        return;
    }
    if(XComGameState_Unit(ActionMetadata.StateObject_NewState) == none)
    {
        return;
    }
    class'X2StatusEffects'.static.AddEffectMessageToTrack(
		ActionMetadata,
		class'X2StatusEffects'.default.UnconsciousEffectAcquiredString,
		VisualizeGameState.GetContext(),
		class'UIEventNoticesTactical'.default.UnconsciousTitle,
		"img:///UILibrary_Common.status_unconscious",
		eUIState_Good);
	class'X2StatusEffects'.static.UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

static function X2Effect_Persistent CreateSedatedStatusEffect()
{
    local X2Effect_Persistent PersistentEffect;

    PersistentEffect = new class'X2Effect_Persistent';
    PersistentEffect.EffectName = class'X2StatusEffects'.default.UnconsciousName;
    PersistentEffect.DuplicateResponse = eDupe_Ignore;
    PersistentEffect.BuildPersistentEffect(1, true, false);
    PersistentEffect.bRemoveWhenTargetDies = true;
    PersistentEffect.bIsImpairing = true;
    PersistentEffect.SetDisplayInfo(ePerkBuff_Penalty, class'X2StatusEffects'.default.UnconsciousFriendlyName, class'X2StatusEffects'.default.UnconsciousFriendlyDesc, "img:///UILibrary_PerkIcons.UIPerk_stun", true, "img:///UILibrary_Common.status_unconscious");
    PersistentEffect.EffectAddedFn = class'X2StatusEffects'.static.UnconsciousEffectAdded;
    PersistentEffect.EffectRemovedFn = class'X2StatusEffects'.static.UnconsciousEffectRemoved;
    PersistentEffect.VisualizationFn = SedatedVisualization;
    PersistentEffect.EffectTickedVisualizationFn = class'X2StatusEffects'.static.UnconsciousVisualizationTicked;
    PersistentEffect.EffectRemovedVisualizationFn = class'X2StatusEffects'.static.UnconsciousVisualizationRemoved;
    PersistentEffect.CleansedVisualizationFn =class'X2StatusEffects'.static.UnconsciousCleansedVisualization;
    PersistentEffect.EffectHierarchyValue = class'X2StatusEffects'.default.UNCONCIOUS_HIERARCHY_VALUE;
    PersistentEffect.DamageTypes.AddItem('Unconscious');
    return PersistentEffect;
}


static function X2AbilityTemplate CreateSedateAbility()
{
	local X2AbilityTemplate						Template;	
	local X2AbilityCost_ActionPoints			ActionPointCost;
	local X2Condition_UnitProperty				UnitPropertyCondition;
	local X2Condition_Sedate					SedateCondition;
	local X2AbilityCharges						Charges;
	local X2AbilityCost_Charges					ChargeCost;
	local X2AbilityTarget_Single				SingleTarget;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'Sedate');
		
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	//Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_HideSpecificErrors;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_sedation";
	Template.Hostility = eHostility_Neutral;
	Template.bLimitTargetIcons = true;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	Template.bShowActivation = true;
    Template.ShotHUDPriority = 1101;

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	Charges = new class'X2AbilityCharges';
	Charges.InitialCharges = 2;
	Template.AbilityCharges = Charges;

	ChargeCost = new class'X2AbilityCost_Charges';
	ChargeCost.NumCharges = 1;
	ChargeCost.bOnlyOnHit = true;
	Template.AbilityCosts.AddItem(ChargeCost);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	Template.AbilityCosts.AddItem(ActionPointCost);

	SingleTarget = new class'X2AbilityTarget_Single';
	SingleTarget.bIncludeSelf = false;
	Template.AbilityTargetStyle = SingleTarget;

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeHostileToSource = true;
    UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	UnitPropertyCondition.ExcludeStunned = false;
	UnitPropertyCondition.ExcludeAlien = true;
	UnitPropertyCondition.IsAdvent = false;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.FailOnNonUnits = true;
	UnitPropertyCondition.RequireWithinRange = true;
	UnitPropertyCondition.IsPlayerControlled = true;
	UnitPropertyCondition.RequireSquadmates = true;
	UnitPropertyCondition.WithinRange = 144;	// 1 adjacent tile
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	SedateCondition = new class 'X2Condition_Sedate';
	Template.AbilityTargetConditions.AddItem(SedateCondition);

	Template.AddTargetEffect(CreateSedatedStatusEffect());

	Template.ActivationSpeech = 'StabilizingAlly';
	Template.bShowActivation = true;
	
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

//Doesn't work
static function X2AbilityTemplate CreateConsumeWhenActivatedAbility(name AbilityName, name EventName)
{
    local X2AbilityTemplate Template;
	local X2AbilityTrigger_EventListener EventListener;

	`CREATE_X2ABILITY_TEMPLATE(Template, AbilityName);
	Template.AbilityToHitCalc = default.DeadEye;
	Template.bDontDisplayInAbilitySummary = true;

	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
    Template.Hostility = eHostility_Neutral;

    Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.AbilityCosts.AddItem(new class'X2AbilityCost_ConsumeItem');

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = EventName;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	EventListener.ListenerData.Filter = eFilter_Unit;
    Template.AbilityTriggers.AddItem(EventListener);

	Template.AbilityTargetStyle = default.SelfTarget;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}

// Passive ability that grants soldiers bonus shred based on the primary weapon
// they're using.
static function X2AbilityTemplate CreateBonusShredAbility(name AbilityName, int BonusShred)
{
	local X2AbilityTemplate Template;
	local X2Effect_BonusShred BonusShredEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, AbilityName);
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_shredder";
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.bShowActivation = false;
	Template.bSkipFireAction = true;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	BonusShredEffect = new class'X2Effect_BonusShred';
	BonusShredEffect.BonusShredvalue = BonusShred;
	Template.AddTargetEffect(BonusShredEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;

	return Template;
}

static function X2AbilityTemplate CreateBluescreenRoundsDisorient()
{
	local X2AbilityTemplate Template;
	local X2Effect_Persistent Effect;
	local X2Condition_UnitProperty Condition_UnitProperty;
	`CREATE_X2ABILITY_TEMPLATE(Template, 'BluescreenRoundsDisorient');
	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.Hostility = eHostility_Neutral;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
	Template.bShowActivation = false;
	Template.bSkipFireAction = true;
	Template.bDontDisplayInAbilitySummary = true;
	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Effect = class'X2StatusEffects'.static.CreateDisorientedStatusEffect();
	Effect.ApplyChance=default.BLUESCREEN_DISORIENT_CHANCE;
	Template.AddTargetEffect(Effect);

	Condition_UnitProperty = new class'X2Condition_UnitProperty';
	Condition_UnitProperty.ExcludeOrganic = true;
	Condition_UnitProperty.IncludeWeakAgainstTechLikeRobot = true;
	Condition_UnitProperty.TreatMindControlledSquadmateAsHostile = true;
	Condition_UnitProperty.FailOnNonUnits = true;
	Template.AbilityTargetConditions.AddItem(Condition_UnitProperty);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;

	return Template;
}
	
static function X2AbilityTemplate CreateLightKevlarAbility()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LightKevlarArmorStats');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// light armor has dodge and mobility as well as health
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.LIGHT_KEVLAR_MOBILITY_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}


static function X2AbilityTemplate HeavyArmorMobPenalty()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HeavyArmorMobPenalty');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// light armor has dodge and mobility as well as health
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.HEAVY_ARMOR_MOB_PENALTY);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate HeavyWeaponsMobPenalty()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HeavyWeaponsMobPenalty');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// light armor has dodge and mobility as well as health
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.HEAVY_WEAPONS_MOB_PENALTY);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate HeavySecondaryWeaponsMobPenalty()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HeavySecondaryWeaponsMobPenalty');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// light armor has dodge and mobility as well as health
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.HEAVY_WEAPONS_MOB_PENALTY);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate LightSecondaryWeaponsMobBonus()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LightSecondaryWeaponsMobBonus');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// light armor has dodge and mobility as well as health
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.LIGHT_WEAPONS_MOB_BONUS);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}

static function X2AbilityTemplate HeavyWeaponsMobPenalty()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HeavySecondaryWeaponsMobPenalty');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// light armor has dodge and mobility as well as health
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.HEAVY_WEAPONS_MOB_PENALTY);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}


static function X2AbilityTemplate ExpandedMagMobPenalty()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'ExpandedMagMobilityPenalty');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// light armor has dodge and mobility as well as health
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_Mobility, default.EXPANDED_MAG_MOB_PENALTY);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}


	static function X2AbilityTemplate Gremlin_T2_Indicator()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LW_T2GremlinIndicator');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}
	
static function X2AbilityTemplate Gremlin_T3_Indicator()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'LW_T3GremlinIndicator');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}
static function X2AbilityTemplate AddAPRoundsCritPenalty()
{
	local X2AbilityTemplate						Template;
	local X2AbilityTargetStyle                  TargetStyle;
	local X2AbilityTrigger						Trigger;
	local X2Effect_ToHitModifier                ToHitModifier;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'APRoundsCritPenalty');
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hithurts";

	Template.AbilitySourceName = 'eAbilitySource_Perk';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;

	Template.AbilityToHitCalc = default.DeadEye;

	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);

	ToHitModifier = new class'X2Effect_ToHitModifier';
	ToHitModifier.BuildPersistentEffect(1, true, true, true);
	ToHitModifier.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,false,,Template.AbilitySourceName);
	ToHitModifier.AddEffectHitModifier(eHit_Crit, default.AP_ROUNDS_CRIT_PENALTY, Template.LocFriendlyName, /*StandardAim*/, false, true, true, true);
	Template.AddTargetEffect(ToHitModifier);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	Template.bDisplayInUITooltip = false;
	Template.bDisplayInUITacticalText = false;
	Template.bDontDisplayInAbilitySummary = true;

	//  NOTE: No visualization on purpose!

	return Template;
}

//override normal hellweave ability
static function X2AbilityTemplate ScorchCircuitsDamage()
{
	local X2AbilityTemplate						Template;
	local X2Effect_ApplyWeaponDamage            DamageEffect;
	local X2AbilityTrigger_EventListener        Trigger;
	local X2Effect_Persistent	ScorchCircuitsTargetEffect;
	local X2Condition_UnitEffectsWithAbilitySource ScorchCircuitsTargetCondition;
	local X2AbilityTarget_Single_CCS	SingleTarget;
	`CREATE_X2ABILITY_TEMPLATE(Template, 'ScorchCircuitsDamage');

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Defensive;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_hunter";

	Template.AbilityToHitCalc = default.DeadEye;

	SingleTarget = new class'X2AbilityTarget_Single_CCS';
	Template.AbilityTargetStyle = SingleTarget;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityTargetConditions.AddItem(default.LivingHostileTargetProperty);

	DamageEffect = new class'X2Effect_ApplyWeaponDamage';
	DamageEffect.EffectDamageValue.Damage = 4;
	DamageEffect.EffectDamageValue.Spread = 1;
	DamageEffect.bIgnoreArmor = true;
	DamageEffect.DamageTypes.AddItem('Electrical');
	Template.AddTargetEffect(DamageEffect);

	ScorchCircuitsTargetEffect = new class'X2Effect_Persistent';
	ScorchCircuitsTargetEffect.BuildPersistentEffect(1, false, true, true, eGameRule_PlayerTurnEnd);
	ScorchCircuitsTargetEffect.EffectName = 'ScorchCircuitsTarget';
	ScorchCircuitsTargetEffect.bApplyOnMiss = true; //Only one chance, even if you miss (prevents crazy flailing counter-attack chains with a Muton, for example)
	Template.AddTargetEffect(ScorchCircuitsTargetEffect);
	
	ScorchCircuitsTargetCondition = new class'X2Condition_UnitEffectsWithAbilitySource';
	ScorchCircuitsTargetCondition.AddExcludeEffect('ScorchCircuitsTarget', 'AA_DuplicateEffectIgnored');
	Template.AbilityTargetConditions.AddItem(ScorchCircuitsTargetCondition);



	//  trigger on movement
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'ObjectMoved';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalOverwatchListener;
	Template.AbilityTriggers.AddItem(Trigger);
	//  trigger on an attack
	Trigger = new class'X2AbilityTrigger_EventListener';
	Trigger.ListenerData.EventID = 'AbilityActivated';
	Trigger.ListenerData.Deferral = ELD_OnStateSubmitted;
	Trigger.ListenerData.Filter = eFilter_None;
	Trigger.ListenerData.EventFn = class'XComGameState_Ability'.static.TypicalAttackListener;
	Template.AbilityTriggers.AddItem(Trigger);

	Template.bSkipFireAction = true;
	Template.bShowActivation = true;
	Template.FrameAbilityCameraType = eCameraFraming_Never;
	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;
	//Template.MergeVisualizationFn = ScorchCircuits_VisualizationMerge;

	return Template;
}


static function X2AbilityTemplate HisWill()
{
	local X2AbilityTemplate						Template;
	local X2AbilityCost_ActionPoints			ActionPointCost;
	local X2AbilityCost_Ammo					AmmoCost;
	local X2AbilityMultiTarget_Radius           MultiTargetRadius;
	local X2Condition_UnitProperty				UnitCondition;
	local X2Effect_SuicideVestDamage            DamageEffect;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;
	`CREATE_X2ABILITY_TEMPLATE(Template, 'HisWill_LW');

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_AlwaysShow;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_fuse";
	Template.AbilityConfirmSound = "TacticalUI_SwordConfirm";
	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);
	
	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = new class'X2AbilityTarget_Cursor';
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);
	Template.TargetingMethod = class'X2TargetingMethod_PathTarget';

	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AddShooterEffectExclusions();

	// Target everything in this blast radius
	MultiTargetRadius = new class'X2AbilityMultiTarget_Radius';
	MultiTargetRadius.bUseWeaponRadius = true;
	MultiTargetRadius.bExcludeSelfAsTargetIfWithinRadius = true;
	Template.AbilityMultiTargetStyle = MultiTargetRadius;
	
	UnitCondition = new class'X2Condition_UnitProperty';
	UnitCondition.ExcludeDead = false;
	UnitCondition.ExcludeHostileToSource = false;
	UnitCondition.ExcludeFriendlyToSource = false;
	UnitCondition.FailOnNonUnits = false;
	Template.AbilityMultiTargetConditions.AddItem(UnitCondition);

	// Everything in the blast radius receives explosive damage
	DamageEffect = new class'X2Effect_SuicideVestDamage';
	DamageEffect.T1Damage = default.COMMANDER_VEST_CV_BASEDAMAGE;
	DamageEffect.T2Damage = default.COMMANDER_VEST_LS_BASEDAMAGE;
	DamageEffect.T3Damage = default.COMMANDER_VEST_MG_BASEDAMAGE;
	DamageEffect.T4Damage = default.COMMANDER_VEST_CG_BASEDAMAGE;
	DamageEffect.T5Damage = default.COMMANDER_VEST_BM_BASEDAMAGE;
	DamageEffect.bExplosiveDamage = true;
	DamageEffect.bIgnoreBaseDamage = true;
		
	Template.AddMultiTargetEffect(DamageEffect);

	WeaponDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	WeaponDamageEffect.bExplosiveDamage = true;
	WeaponDamageEffect.bIgnoreBaseDamage = true;
	WeaponDamageEffect.EffectDamageValue.Damage = 99;
	Template.AddShooterEffect(WeaponDamageEffect);  // You're not going to survive this
	
	Template.BuildNewGameStateFn = TypicalMoveEndAbility_BuildGameState;
	Template.BuildVisualizationFn = Detonation_BuildVisualization;
	Template.BuildInterruptGameStateFn = TypicalMoveEndAbility_BuildInterruptGameState;
	
	Template.CustomFireAnim = 'FF_Melee';
	Template.ActivationSpeech = 'BlasterLauncher';
	Template.bShowPostActivation = true;

	Template.SuperConcealmentLoss = class'X2AbilityTemplateManager'.default.SuperConcealmentStandardShotLoss;
	Template.ChosenActivationIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotChosenActivationIncreasePerUse;
	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.GrenadeLostSpawnIncreasePerUse;
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.Hostility = eHostility_Offensive;

	return Template;
}

static function X2AbilityTemplate HisVengeance()
{
	local X2AbilityTemplate						Template;
	local X2AbilityTrigger_EventListener		EventListener;
	local X2AbilityMultiTarget_Radius			MultiTargetRadius;
	local X2Condition_UnitProperty				UnitPropertyCondition;
	local X2Effect_SuicideVestDamage			DamageEffect;
	local X2Effect_KillUnit						KillUnitEffect;
	local X2AbilityCost_Ammo					AmmoCost;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'HisVengeance_LW');
	Template.IconImage = "img:///UILibrary_DLC3Images.UIPerk_spark_nova";

	Template.AbilitySourceName = 'eAbilitySource_Standard';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Offensive;

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	// if (default.CONSUME_ON_ACTIVATION)
	// 	Template.AbilityCosts.AddItem(new class'X2AbilityCost_ConsumeItem');

	// This ability is only valid if there has not been another death explosion on the unit
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = false;
	UnitPropertyCondition.ExcludeDeadFromSpecialDeath = true;
	Template.AbilityShooterConditions.AddItem(UnitPropertyCondition);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitDied';
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);

	EventListener = new class'X2AbilityTrigger_EventListener';
	EventListener.ListenerData.Deferral = ELD_OnStateSubmitted;
	EventListener.ListenerData.EventID = 'UnitBleedingOut';
	EventListener.ListenerData.Filter = eFilter_Unit;
	EventListener.ListenerData.EventFn = class'XComGameState_Ability'.static.AbilityTriggerEventListener_Self;
	Template.AbilityTriggers.AddItem(EventListener);
	// Targets the unit so the blast center is its dead body
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityToHitCalc = default.DeadEye;

	// Target everything in this blast radius
	MultiTargetRadius = new class'X2AbilityMultiTarget_Radius';
	MultiTargetRadius.bUseWeaponRadius = true;
	Template.AbilityMultiTargetStyle = MultiTargetRadius;
	
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = false;
	UnitPropertyCondition.ExcludeHostileToSource = false;
	UnitPropertyCondition.ExcludeFriendlyToSource = false;
	UnitPropertyCondition.FailOnNonUnits = false;
	Template.AbilityMultiTargetConditions.AddItem(UnitPropertyCondition);

	// Everything in the blast radius receives explosive damage
	DamageEffect = new class'X2Effect_SuicideVestDamage';
	DamageEffect.T1Damage = default.COMMANDER_VEST_CV_BASEDAMAGE;
	DamageEffect.T2Damage = default.COMMANDER_VEST_LS_BASEDAMAGE;
	DamageEffect.T3Damage = default.COMMANDER_VEST_MG_BASEDAMAGE;
	DamageEffect.T4Damage = default.COMMANDER_VEST_CG_BASEDAMAGE;
	DamageEffect.T5Damage = default.COMMANDER_VEST_BM_BASEDAMAGE;
	DamageEffect.bExplosiveDamage = true;
	DamageEffect.bIgnoreBaseDamage = true;
	
	Template.AddMultiTargetEffect(DamageEffect);

	// If the unit is alive, kill it
	KillUnitEffect = new class'X2Effect_KillUnit';
	KillUnitEffect.BuildPersistentEffect(1, false, false, false, eGameRule_PlayerTurnEnd);
	KillUnitEffect.EffectName = 'KillUnit';
	Template.AddTargetEffect(KillUnitEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildVisualizationFn = Detonation_BuildVisualization;
	Template.bShowPostActivation = true;
	//Template.VisualizationTrackInsertedFn = class'X2Ability_Death'.static.DeathExplosion_VisualizationTrackInsert;

	Template.FrameAbilityCameraType = eCameraFraming_Never;

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.GrenadeLostSpawnIncreasePerUse;
	Template.bFrameEvenWhenUnitIsHidden = true;
	//Template.AssociatedPlayTiming = SPT_AfterParallel;

	return Template;
}

static function Detonation_BuildVisualization(XComGameState VisualizeGameState)
{	
	//general
	local XComGameStateHistory	History;
	local XComGameStateVisualizationMgr VisualizationMgr;

	//visualizers
	local Actor	TargetVisualizer, ShooterVisualizer;

	//actions
	local X2Action							AddedAction;
	local X2Action							FireAction;
	local X2Action_MoveTurn					MoveTurnAction;
	local X2Action_PlaySoundAndFlyOver		SoundAndFlyover;
	local X2Action_ExitCover				ExitCoverAction;
	local X2Action_MoveTeleport				TeleportMoveAction;
	local X2Action_Delay					MoveDelay;
	local X2Action_MoveEnd					MoveEnd;
	local X2Action_MarkerNamed				JoinActions;
	local array<X2Action>					LeafNodes;
	local X2Action_WaitForAnotherAction		WaitForFireAction;

	//state objects
	local XComGameState_Ability				AbilityState;
	local XComGameState_EnvironmentDamage	EnvironmentDamageEvent;
	local XComGameState_WorldEffectTileData WorldDataUpdate;
	local XComGameState_InteractiveObject	InteractiveObject;
	local XComGameState_BaseObject			TargetStateObject;
	local XComGameState_Item				SourceWeapon;
	local StateObjectReference				ShootingUnitRef;

	//interfaces
	local X2VisualizerInterface			TargetVisualizerInterface, ShooterVisualizerInterface;

	//contexts
	local XComGameStateContext_Ability	Context;
	local AbilityInputContext			AbilityContext;

	//templates
	local X2AbilityTemplate	AbilityTemplate;
	local X2AmmoTemplate	AmmoTemplate;
	local X2WeaponTemplate	WeaponTemplate;
	local array<X2Effect>	MultiTargetEffects;

	//Tree metadata
	local VisualizationActionMetadata   InitData;
	local VisualizationActionMetadata   BuildData;
	local VisualizationActionMetadata   SourceData, InterruptTrack;

	local XComGameState_Unit TargetUnitState;	
	local name         ApplyResult;

	//indices
	local int	EffectIndex, TargetIndex;
	local int	TrackIndex;
	local int	WindowBreakTouchIndex;

	//flags
	local bool	bSourceIsAlsoTarget;
	local bool	bMultiSourceIsAlsoTarget;
	local bool  bPlayedAttackResultNarrative;
			
	// good/bad determination
	local bool bGoodAbility;

	local X2Action_PlayEffect					EffectAction;
	local VisualizationActionMetadata			ActionMetadata;
	//local X2Action_Delay						DelayAction;
	local X2Action_StartStopSound				SoundAction;
	local XComGameState_Unit					UnitState;

	History = `XCOMHISTORY;
	VisualizationMgr = `XCOMVISUALIZATIONMGR;
	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	AbilityContext = Context.InputContext;
	/// HL-Docs: ref:Bugfixes; issue:879
	/// Use HistoryIndex to access the AbilityState as it was when the ability was activated rather than getting the most recent version.
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.AbilityRef.ObjectID,, VisualizeGameState.HistoryIndex));
	AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(AbilityContext.AbilityTemplateName);
	ShootingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter, part I. We split this into two parts since
	//in some situations the shooter can also be a target
	//****************************************************************************************
	ShooterVisualizer = History.GetVisualizer(ShootingUnitRef.ObjectID);
	ShooterVisualizerInterface = X2VisualizerInterface(ShooterVisualizer);

	SourceData = InitData;
	SourceData.StateObject_OldState = History.GetGameStateForObjectID(ShootingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	SourceData.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(ShootingUnitRef.ObjectID);
	if (SourceData.StateObject_NewState == none)
		SourceData.StateObject_NewState = SourceData.StateObject_OldState;
	SourceData.VisualizeActor = ShooterVisualizer;	

	/// HL-Docs: ref:Bugfixes; issue:879
	/// Use HistoryIndex to access the WeaponState as it was when the ability was activated rather than getting the most recent version.
	SourceWeapon = XComGameState_Item(History.GetGameStateForObjectID(AbilityContext.ItemObject.ObjectID,, VisualizeGameState.HistoryIndex));
	if (SourceWeapon != None)
	{
		WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
		AmmoTemplate = X2AmmoTemplate(SourceWeapon.GetLoadedAmmoTemplate(AbilityState));
	}

	bGoodAbility = XComGameState_Unit(SourceData.StateObject_NewState).IsFriendlyToLocalPlayer();

	if( Context.IsResultContextMiss() && AbilityTemplate.SourceMissSpeech != '' )
	{
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(BuildData, Context));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, "", AbilityTemplate.SourceMissSpeech, bGoodAbility ? eColor_Bad : eColor_Good);
	}
	else if( Context.IsResultContextHit() && AbilityTemplate.SourceHitSpeech != '' )
	{
		SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(BuildData, Context));
		SoundAndFlyOver.SetSoundAndFlyOverParameters(None, "", AbilityTemplate.SourceHitSpeech, bGoodAbility ? eColor_Good : eColor_Bad);
	}

	if( !AbilityTemplate.bSkipFireAction || Context.InputContext.MovementPaths.Length > 0 )
	{
		ExitCoverAction = X2Action_ExitCover(class'X2Action_ExitCover'.static.AddToVisualizationTree(SourceData, Context));
		ExitCoverAction.bSkipExitCoverVisualization = AbilityTemplate.bSkipExitCoverWhenFiring;

		// if this ability has a built in move, do it right before we do the fire action
		if(Context.InputContext.MovementPaths.Length > 0)
		{			
			// note that we skip the stop animation since we'll be doing our own stop with the end of move attack
			class'X2VisualizerHelpers'.static.ParsePath(Context, SourceData, AbilityTemplate.bSkipMoveStop);

			//  add paths for other units moving with us (e.g. gremlins moving with a move+attack ability)
			if (Context.InputContext.MovementPaths.Length > 1)
			{
				for (TrackIndex = 1; TrackIndex < Context.InputContext.MovementPaths.Length; ++TrackIndex)
				{
					BuildData = InitData;
					BuildData.StateObject_OldState = History.GetGameStateForObjectID(Context.InputContext.MovementPaths[TrackIndex].MovingUnitRef.ObjectID);
					BuildData.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(Context.InputContext.MovementPaths[TrackIndex].MovingUnitRef.ObjectID);
					MoveDelay = X2Action_Delay(class'X2Action_Delay'.static.AddToVisualizationTree(BuildData, Context));
					MoveDelay.Duration = class'X2Ability_DefaultAbilitySet'.default.TypicalMoveDelay;
					class'X2VisualizerHelpers'.static.ParsePath(Context, BuildData, AbilityTemplate.bSkipMoveStop);	
				}
			}

			if( !AbilityTemplate.bSkipFireAction )
			{
				MoveEnd = X2Action_MoveEnd(VisualizationMgr.GetNodeOfType(VisualizationMgr.BuildVisTree, class'X2Action_MoveEnd', SourceData.VisualizeActor));				

				if (MoveEnd != none)
				{
					// add the fire action as a child of the node immediately prior to the move end
					AddedAction = AbilityTemplate.ActionFireClass.static.AddToVisualizationTree(SourceData, Context, false, none, MoveEnd.ParentActions);

					// reconnect the move end action as a child of the fire action, as a special end of move animation will be performed for this move + attack ability
					VisualizationMgr.DisconnectAction(MoveEnd);
					VisualizationMgr.ConnectAction(MoveEnd, VisualizationMgr.BuildVisTree, false, AddedAction);
				}
				else
				{
					//See if this is a teleport. If so, don't perform exit cover visuals
					TeleportMoveAction = X2Action_MoveTeleport(VisualizationMgr.GetNodeOfType(VisualizationMgr.BuildVisTree, class'X2Action_MoveTeleport', SourceData.VisualizeActor));
					if (TeleportMoveAction != none)
					{
						//Skip the FOW Reveal ( at the start of the path ). Let the fire take care of it ( end of the path )
						ExitCoverAction.bSkipFOWReveal = true;
					}

					AddedAction = AbilityTemplate.ActionFireClass.static.AddToVisualizationTree(SourceData, Context, false, SourceData.LastActionAdded);
				}
			}
		}
		else
		{
			//If we were interrupted, insert a marker node for the interrupting visualization code to use. In the move path version above, it is expected for interrupts to be 
			//done during the move.
			if (Context.InterruptionStatus != eInterruptionStatus_None)
			{
				//Insert markers for the subsequent interrupt to insert into
				class'X2Action'.static.AddInterruptMarkerPair(SourceData, Context, ExitCoverAction);
			}

			if (!AbilityTemplate.bSkipFireAction)
			{
				// no move, just add the fire action. Parent is exit cover action if we have one
				AddedAction = AbilityTemplate.ActionFireClass.static.AddToVisualizationTree(SourceData, Context, false, SourceData.LastActionAdded);
			}			
		}

		if( !AbilityTemplate.bSkipFireAction )
		{
			FireAction = AddedAction;

			class'XComGameState_NarrativeManager'.static.BuildVisualizationForDynamicNarrative(VisualizeGameState, false, 'AttackBegin', FireAction.ParentActions[0]);

			if( AbilityTemplate.AbilityToHitCalc != None )
			{
				X2Action_Fire(AddedAction).SetFireParameters(Context.IsResultContextHit());
			}
		}
	}

	//If there are effects added to the shooter, add the visualizer actions for them
	for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityShooterEffects.Length; ++EffectIndex)
	{
		AbilityTemplate.AbilityShooterEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, SourceData, Context.FindShooterEffectApplyResult(AbilityTemplate.AbilityShooterEffects[EffectIndex]));		
	}
	//****************************************************************************************

	//Configure the visualization track for the target(s). This functionality uses the context primarily
	//since the game state may not include state objects for misses.
	//****************************************************************************************	
	bSourceIsAlsoTarget = AbilityContext.PrimaryTarget.ObjectID == AbilityContext.SourceObject.ObjectID; //The shooter is the primary target
	if (AbilityTemplate.AbilityTargetEffects.Length > 0 &&			//There are effects to apply
		AbilityContext.PrimaryTarget.ObjectID > 0)				//There is a primary target
	{
		TargetVisualizer = History.GetVisualizer(AbilityContext.PrimaryTarget.ObjectID);
		TargetVisualizerInterface = X2VisualizerInterface(TargetVisualizer);

		if( bSourceIsAlsoTarget )
		{
			BuildData = SourceData;
		}
		else
		{
			BuildData = InterruptTrack;        //  interrupt track will either be empty or filled out correctly
		}

		BuildData.VisualizeActor = TargetVisualizer;

		TargetStateObject = VisualizeGameState.GetGameStateForObjectID(AbilityContext.PrimaryTarget.ObjectID);
		if( TargetStateObject != none )
		{
			History.GetCurrentAndPreviousGameStatesForObjectID(AbilityContext.PrimaryTarget.ObjectID, 
															   BuildData.StateObject_OldState, BuildData.StateObject_NewState,
															   eReturnType_Reference,
															   VisualizeGameState.HistoryIndex);
			`assert(BuildData.StateObject_NewState == TargetStateObject);
		}
		else
		{
			//If TargetStateObject is none, it means that the visualize game state does not contain an entry for the primary target. Use the history version
			//and show no change.
			BuildData.StateObject_OldState = History.GetGameStateForObjectID(AbilityContext.PrimaryTarget.ObjectID);
			BuildData.StateObject_NewState = BuildData.StateObject_OldState;
		}

		// if this is a melee attack, make sure the target is facing the location he will be melee'd from
		if(!AbilityTemplate.bSkipFireAction 
			&& !bSourceIsAlsoTarget 
			&& AbilityContext.MovementPaths.Length > 0
			&& AbilityContext.MovementPaths[0].MovementData.Length > 0
			&& XGUnit(TargetVisualizer) != none)
		{
			MoveTurnAction = X2Action_MoveTurn(class'X2Action_MoveTurn'.static.AddToVisualizationTree(BuildData, Context, false, ExitCoverAction));
			MoveTurnAction.m_vFacePoint = AbilityContext.MovementPaths[0].MovementData[AbilityContext.MovementPaths[0].MovementData.Length - 1].Position;
			MoveTurnAction.m_vFacePoint.Z = TargetVisualizerInterface.GetTargetingFocusLocation().Z;
			MoveTurnAction.UpdateAimTarget = true;

			// Jwats: Add a wait for ability effect so the idle state machine doesn't process!
			WaitForFireAction = X2Action_WaitForAnotherAction(class'X2Action_WaitForAnotherAction'.static.AddToVisualizationTree(BuildData, Context, false, MoveTurnAction));
			WaitForFireAction.ActionToWaitFor = FireAction;
		}

		//Pass in AddedAction (Fire Action) as the LastActionAdded if we have one. Important! As this is automatically used as the parent in the effect application sub functions below.
		if (AddedAction != none && AddedAction.IsA('X2Action_Fire'))
		{
			BuildData.LastActionAdded = AddedAction;
		}
		
		//Add any X2Actions that are specific to this effect being applied. These actions would typically be instantaneous, showing UI world messages
		//playing any effect specific audio, starting effect specific effects, etc. However, they can also potentially perform animations on the 
		//track actor, so the design of effect actions must consider how they will look/play in sequence with other effects.
		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
		{
			ApplyResult = Context.FindTargetEffectApplyResult(AbilityTemplate.AbilityTargetEffects[EffectIndex]);

			// Target effect visualization
			if( !Context.bSkipAdditionalVisualizationSteps )
			{
				AbilityTemplate.AbilityTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, ApplyResult);
			}

			// Source effect visualization
			AbilityTemplate.AbilityTargetEffects[EffectIndex].AddX2ActionsForVisualizationSource(VisualizeGameState, SourceData, ApplyResult);
		}

		//the following is used to handle Rupture flyover text
		TargetUnitState = XComGameState_Unit(BuildData.StateObject_OldState);
		if (TargetUnitState != none &&
			XComGameState_Unit(BuildData.StateObject_OldState).GetRupturedValue() == 0 &&
			XComGameState_Unit(BuildData.StateObject_NewState).GetRupturedValue() > 0)
		{
			//this is the frame that we realized we've been ruptured!
			class 'X2StatusEffects'.static.RuptureVisualization(VisualizeGameState, BuildData);
		}

		if (AbilityTemplate.bAllowAmmoEffects && AmmoTemplate != None)
		{
			for (EffectIndex = 0; EffectIndex < AmmoTemplate.TargetEffects.Length; ++EffectIndex)
			{
				ApplyResult = Context.FindTargetEffectApplyResult(AmmoTemplate.TargetEffects[EffectIndex]);
				AmmoTemplate.TargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, ApplyResult);
				AmmoTemplate.TargetEffects[EffectIndex].AddX2ActionsForVisualizationSource(VisualizeGameState, SourceData, ApplyResult);
			}
		}
		if (AbilityTemplate.bAllowBonusWeaponEffects && WeaponTemplate != none)
		{
			for (EffectIndex = 0; EffectIndex < WeaponTemplate.BonusWeaponEffects.Length; ++EffectIndex)
			{
				ApplyResult = Context.FindTargetEffectApplyResult(WeaponTemplate.BonusWeaponEffects[EffectIndex]);
				WeaponTemplate.BonusWeaponEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, ApplyResult);
				WeaponTemplate.BonusWeaponEffects[EffectIndex].AddX2ActionsForVisualizationSource(VisualizeGameState, SourceData, ApplyResult);
			}
		}

		if (Context.IsResultContextMiss() && (AbilityTemplate.LocMissMessage != "" || AbilityTemplate.TargetMissSpeech != ''))
		{
			SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(BuildData, Context, false, BuildData.LastActionAdded));
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocMissMessage, AbilityTemplate.TargetMissSpeech, bGoodAbility ? eColor_Bad : eColor_Good);
		}
		else if( Context.IsResultContextHit() && (AbilityTemplate.LocHitMessage != "" || AbilityTemplate.TargetHitSpeech != '') )
		{
			SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyover'.static.AddToVisualizationTree(BuildData, Context, false, BuildData.LastActionAdded));
			SoundAndFlyOver.SetSoundAndFlyOverParameters(None, AbilityTemplate.LocHitMessage, AbilityTemplate.TargetHitSpeech, bGoodAbility ? eColor_Good : eColor_Bad);
		}

		if (!bPlayedAttackResultNarrative)
		{
			class'XComGameState_NarrativeManager'.static.BuildVisualizationForDynamicNarrative(VisualizeGameState, false, 'AttackResult');
			bPlayedAttackResultNarrative = true;
		}

		if( TargetVisualizerInterface != none )
		{
			//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
			TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, BuildData);
		}

		if( bSourceIsAlsoTarget )
		{
			SourceData = BuildData;
		}
	}

	if (AbilityTemplate.bUseLaunchedGrenadeEffects)
	{
		MultiTargetEffects = X2GrenadeTemplate(SourceWeapon.GetLoadedAmmoTemplate(AbilityState)).LaunchedGrenadeEffects;
	}
	else if (AbilityTemplate.bUseThrownGrenadeEffects)
	{
		MultiTargetEffects = X2GrenadeTemplate(SourceWeapon.GetMyTemplate()).ThrownGrenadeEffects;
	}
	else
	{
		MultiTargetEffects = AbilityTemplate.AbilityMultiTargetEffects;
	}

	//  Apply effects to multi targets - don't show multi effects for burst fire as we just want the first time to visualize
	if( MultiTargetEffects.Length > 0 && AbilityContext.MultiTargets.Length > 0 && X2AbilityMultiTarget_BurstFire(AbilityTemplate.AbilityMultiTargetStyle) == none)
	{
		for( TargetIndex = 0; TargetIndex < AbilityContext.MultiTargets.Length; ++TargetIndex )
		{	
			bMultiSourceIsAlsoTarget = false;
			if( AbilityContext.MultiTargets[TargetIndex].ObjectID == AbilityContext.SourceObject.ObjectID )
			{
				bMultiSourceIsAlsoTarget = true;
				bSourceIsAlsoTarget = bMultiSourceIsAlsoTarget;				
			}

			TargetVisualizer = History.GetVisualizer(AbilityContext.MultiTargets[TargetIndex].ObjectID);
			TargetVisualizerInterface = X2VisualizerInterface(TargetVisualizer);

			if( bMultiSourceIsAlsoTarget )
			{
				BuildData = SourceData;
			}
			else
			{
				BuildData = InitData;
			}
			BuildData.VisualizeActor = TargetVisualizer;

			// if the ability involved a fire action and we don't have already have a potential parent,
			// all the target visualizations should probably be parented to the fire action and not rely on the auto placement.
			if( (BuildData.LastActionAdded == none) && (FireAction != none) )
				BuildData.LastActionAdded = FireAction;

			TargetStateObject = VisualizeGameState.GetGameStateForObjectID(AbilityContext.MultiTargets[TargetIndex].ObjectID);
			if( TargetStateObject != none )
			{
				History.GetCurrentAndPreviousGameStatesForObjectID(AbilityContext.MultiTargets[TargetIndex].ObjectID, 
																	BuildData.StateObject_OldState, BuildData.StateObject_NewState,
																	eReturnType_Reference,
																	VisualizeGameState.HistoryIndex);
				`assert(BuildData.StateObject_NewState == TargetStateObject);
			}			
			else
			{
				//If TargetStateObject is none, it means that the visualize game state does not contain an entry for the primary target. Use the history version
				//and show no change.
				BuildData.StateObject_OldState = History.GetGameStateForObjectID(AbilityContext.MultiTargets[TargetIndex].ObjectID);
				BuildData.StateObject_NewState = BuildData.StateObject_OldState;
			}
		
			//Add any X2Actions that are specific to this effect being applied. These actions would typically be instantaneous, showing UI world messages
			//playing any effect specific audio, starting effect specific effects, etc. However, they can also potentially perform animations on the 
			//track actor, so the design of effect actions must consider how they will look/play in sequence with other effects.
			for (EffectIndex = 0; EffectIndex < MultiTargetEffects.Length; ++EffectIndex)
			{
				ApplyResult = Context.FindMultiTargetEffectApplyResult(MultiTargetEffects[EffectIndex], TargetIndex);

				// Target effect visualization
				MultiTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, ApplyResult);

				// Source effect visualization
				MultiTargetEffects[EffectIndex].AddX2ActionsForVisualizationSource(VisualizeGameState, SourceData, ApplyResult);
			}			

			//the following is used to handle Rupture flyover text
			TargetUnitState = XComGameState_Unit(BuildData.StateObject_OldState);
			if (TargetUnitState != none && 
				XComGameState_Unit(BuildData.StateObject_OldState).GetRupturedValue() == 0 &&
				XComGameState_Unit(BuildData.StateObject_NewState).GetRupturedValue() > 0)
			{
				//this is the frame that we realized we've been ruptured!
				class 'X2StatusEffects'.static.RuptureVisualization(VisualizeGameState, BuildData);
			}
			
			if (!bPlayedAttackResultNarrative)
			{
				class'XComGameState_NarrativeManager'.static.BuildVisualizationForDynamicNarrative(VisualizeGameState, false, 'AttackResult');
				bPlayedAttackResultNarrative = true;
			}

			if( TargetVisualizerInterface != none )
			{
				//Allow the visualizer to do any custom processing based on the new game state. For example, units will create a death action when they reach 0 HP.
				TargetVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, BuildData);
			}

			if( bMultiSourceIsAlsoTarget )
			{
				SourceData = BuildData;
			}			
		}
	}
	//****************************************************************************************

	//Finish adding the shooter's track
	//****************************************************************************************
	if( !bSourceIsAlsoTarget && ShooterVisualizerInterface != none)
	{
		ShooterVisualizerInterface.BuildAbilityEffectsVisualization(VisualizeGameState, SourceData);				
	}	

	//  Handle redirect visualization
	TypicalAbility_AddEffectRedirects(VisualizeGameState, SourceData);

	//****************************************************************************************

	//Configure the visualization tracks for the environment
	//****************************************************************************************

	if (ExitCoverAction != none)
	{
		ExitCoverAction.ShouldBreakWindowBeforeFiring( Context, WindowBreakTouchIndex );
	}

	foreach VisualizeGameState.IterateByClassType(class'XComGameState_EnvironmentDamage', EnvironmentDamageEvent)
	{
		BuildData = InitData;
		BuildData.VisualizeActor = none;
		BuildData.StateObject_NewState = EnvironmentDamageEvent;
		BuildData.StateObject_OldState = EnvironmentDamageEvent;

		// if this is the damage associated with the exit cover action, we need to force the parenting within the tree
		// otherwise LastActionAdded with be 'none' and actions will auto-parent.
		if ((ExitCoverAction != none) && (WindowBreakTouchIndex > -1))
		{
			if (EnvironmentDamageEvent.HitLocation == AbilityContext.ProjectileEvents[WindowBreakTouchIndex].HitLocation)
			{
				BuildData.LastActionAdded = ExitCoverAction;
			}
		}

		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityShooterEffects.Length; ++EffectIndex)
		{
			AbilityTemplate.AbilityShooterEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, 'AA_Success');		
		}

		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
		{
			AbilityTemplate.AbilityTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, 'AA_Success');
		}

		for (EffectIndex = 0; EffectIndex < MultiTargetEffects.Length; ++EffectIndex)
		{
			MultiTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, 'AA_Success');	
		}
	}

	foreach VisualizeGameState.IterateByClassType(class'XComGameState_WorldEffectTileData', WorldDataUpdate)
	{
		BuildData = InitData;
		BuildData.VisualizeActor = none;
		BuildData.StateObject_NewState = WorldDataUpdate;
		BuildData.StateObject_OldState = WorldDataUpdate;

		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityShooterEffects.Length; ++EffectIndex)
		{
			AbilityTemplate.AbilityShooterEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, 'AA_Success');		
		}

		for (EffectIndex = 0; EffectIndex < AbilityTemplate.AbilityTargetEffects.Length; ++EffectIndex)
		{
			AbilityTemplate.AbilityTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, 'AA_Success');
		}

		for (EffectIndex = 0; EffectIndex < MultiTargetEffects.Length; ++EffectIndex)
		{
			MultiTargetEffects[EffectIndex].AddX2ActionsForVisualization(VisualizeGameState, BuildData, 'AA_Success');	
		}
	}
	//****************************************************************************************

	//Process any interactions with interactive objects
	foreach VisualizeGameState.IterateByClassType(class'XComGameState_InteractiveObject', InteractiveObject)
	{
		// Add any doors that need to listen for notification. 
		// Move logic is taken from MoveAbility_BuildVisualization, which only has special case handling for AI patrol movement ( which wouldn't happen here )
		if ( Context.InputContext.MovementPaths.Length > 0 || (InteractiveObject.IsDoor() && InteractiveObject.HasDestroyAnim()) ) //Is this a closed door?
		{
			BuildData = InitData;
			//Don't necessarily have a previous state, so just use the one we know about
			BuildData.StateObject_OldState = InteractiveObject;
			BuildData.StateObject_NewState = InteractiveObject;
			BuildData.VisualizeActor = History.GetVisualizer(InteractiveObject.ObjectID);

			class'X2Action_BreakInteractActor'.static.AddToVisualizationTree(BuildData, Context);
		}
	}
	
	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(Context.InputContext.SourceObject.ObjectID));
	ActionMetadata.StateObject_NewState = UnitState;
	ActionMetadata.VisualizeActor = UnitState.GetVisualizer();

	EffectAction = X2Action_PlayEffect(class'X2Action_PlayEffect'.static.AddToVisualizationTree(ActionMetadata, Context));
	EffectAction.EffectName = class'X2Ability_Grenades'.default.ProximityMineExplosion;
	EffectAction.EffectLocation = Context.InputContext.TargetLocations[0];
	EffectAction.EffectRotation = Rotator(vect(0, 0, 1));
	EffectAction.bWaitForCompletion = false;
	EffectAction.bWaitForCameraArrival = false;
	EffectAction.bWaitForCameraCompletion = false;
	EffectAction.CenterCameraOnEffectDuration = 2.0f;
	EffectAction.RevealFOWRadius = class'XComWorldData'.const.WORLD_StepSize * 7.0f;

	SoundAction = X2Action_StartStopSound(class'X2Action_StartStopSound'.static.AddToVisualizationTree(ActionMetadata, Context));
	SoundAction.Sound = new class'SoundCue';
	SoundAction.Sound.AkEventOverride = AkEvent'SoundX2CharacterFX.Proximity_Mine_Explosion';
	SoundAction.bIsPositional = true;
	SoundAction.vWorldPosition = Context.InputContext.TargetLocations[0];

	// //Keep the camera there after things blow up
	// DelayAction = X2Action_Delay(class'X2Action_Delay'.static.AddToVisualizationTree(ActionMetadata, Context));
	// DelayAction.Duration = 0.5;


	//Add a join so that all hit reactions and other actions will complete before the visualization sequence moves on. In the case
	// of fire but no enter cover then we need to make sure to wait for the fire since it isn't a leaf node
	VisualizationMgr.GetAllLeafNodes(VisualizationMgr.BuildVisTree, LeafNodes);

	if (!AbilityTemplate.bSkipFireAction)
	{
		if (!AbilityTemplate.bSkipExitCoverWhenFiring)
		{			
			LeafNodes.AddItem(class'X2Action_EnterCover'.static.AddToVisualizationTree(SourceData, Context, false, FireAction));
		}
		else
		{
			LeafNodes.AddItem(FireAction);
		}
	}
	
	if (VisualizationMgr.BuildVisTree.ChildActions.Length > 0)
	{
		JoinActions = X2Action_MarkerNamed(class'X2Action_MarkerNamed'.static.AddToVisualizationTree(SourceData, Context, false, none, LeafNodes));
		JoinActions.SetName("Join");
	}
}



// function Detonation_BuildVisualization(XComGameState VisualizeGameState)
// {
// 	local XComGameStateContext_Ability			AbilityContext;
// 	local X2Action_PlayEffect					EffectAction;
// 	local VisualizationActionMetadata			ActionMetadata;
// 	local X2Action_Delay						DelayAction;
// 	local X2Action_StartStopSound				SoundAction;
// 	local XComGameState_Unit					UnitState;
// 	local X2Action_EnterCover EnterCover;

// 	AbilityContext = XComGameStateContext_Ability(VisualizeGameState.GetContext());
// 	TypicalAbility_BuildVisualization(VisualizeGameState);

// 	UnitState = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(AbilityContext.InputContext.SourceObject.ObjectID));
// 	ActionMetadata.StateObject_NewState = UnitState;
// 	ActionMetadata.VisualizeActor = UnitState.GetVisualizer();



// 	EffectAction = X2Action_PlayEffect(class'X2Action_PlayEffect'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
// 	EffectAction.EffectName = class'X2Ability_Grenades'.default.ProximityMineExplosion;
// 	EffectAction.EffectLocation = AbilityContext.InputContext.TargetLocations[0];
// 	EffectAction.EffectRotation = Rotator(vect(0, 0, 1));
// 	EffectAction.bWaitForCompletion = false;
// 	EffectAction.bWaitForCameraArrival = false;
// 	EffectAction.bWaitForCameraCompletion = false;
// 	EffectAction.CenterCameraOnEffectDuration = 2.0f;
// 	EffectAction.RevealFOWRadius = class'XComWorldData'.const.WORLD_StepSize * 5.0f;

// 	SoundAction = X2Action_StartStopSound(class'X2Action_StartStopSound'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
// 	SoundAction.Sound = new class'SoundCue';
// 	SoundAction.Sound.AkEventOverride = AkEvent'SoundX2CharacterFX.Proximity_Mine_Explosion';
// 	SoundAction.bIsPositional = true;
// 	SoundAction.vWorldPosition = AbilityContext.InputContext.TargetLocations[0];

// 	//Keep the camera there after things blow up
// 	DelayAction = X2Action_Delay(class'X2Action_Delay'.static.AddToVisualizationTree(ActionMetadata, AbilityContext));
// 	DelayAction.Duration = 0.5;
// }


static function X2AbilityTemplate MediumCarapaceArmorStats()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MediumCarapaceArmorStats');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// giving health here; medium plated doesn't have mitigation
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.CARPACE_MEDIUM_HP);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ShieldHP, default.CARPACE_MEDIUM_PLATING_HP);
	//PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.CARPACE_MEDIUM_ARMOR);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}


static function X2AbilityTemplate MediumTitanArmorStats()
{
	local X2AbilityTemplate                 Template;	
	local X2AbilityTrigger					Trigger;
	local X2AbilityTarget_Self				TargetStyle;
	local X2Effect_PersistentStatChange		PersistentStatChangeEffect;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'MediumTitanArmorStats');
	// Template.IconImage  -- no icon needed for armor stats

	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;
	
	Template.AbilityToHitCalc = default.DeadEye;
	
	TargetStyle = new class'X2AbilityTarget_Self';
	Template.AbilityTargetStyle = TargetStyle;

	Trigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	Template.AbilityTriggers.AddItem(Trigger);
	
	// giving health here; medium plated doesn't have mitigation
	//
	PersistentStatChangeEffect = new class'X2Effect_PersistentStatChange';
	PersistentStatChangeEffect.BuildPersistentEffect(1, true, false, false);
	// PersistentStatChangeEffect.SetDisplayInfo(ePerkBuff_Passive, default.MediumPlatedHealthBonusName, default.MediumPlatedHealthBonusDesc, Template.IconImage);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_HP, default.TITAN_MEDIUM_HP);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ShieldHP, default.TITAN_MEDIUM_PLATING_HP);
	PersistentStatChangeEffect.AddPersistentStatChange(eStat_ArmorMitigation, default.TITAN_MEDIUM_ARMOR);
	Template.AddTargetEffect(PersistentStatChangeEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;	
}
