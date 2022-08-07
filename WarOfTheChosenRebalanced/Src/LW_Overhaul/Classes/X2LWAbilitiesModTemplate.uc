//---------------------------------------------------------------------------------------
//  FILE:    X2LWAbilitiesModTemplate.uc
//  AUTHOR:  Peter Ledbrook
//  PURPOSE: Modifies existing ability templates.
//
//           In particular, it sets the final hit chance override delegate
//           on X2AbilityToHitCalc_StandardAim instances.
//---------------------------------------------------------------------------------------
class X2LWAbilitiesModTemplate extends X2LWTemplateModTemplate config(LW_Overhaul);

struct ToHitAdjustments
{
	var int ConditionalCritAdjust;	// reduction in bonus damage chance from it being conditional on hitting
	var int DodgeCritAdjust;		// reduction in bonus damage chance from enemy dodge
	var int DodgeHitAdjust;			// reduction in hit chance from dodge converting graze to miss
	var int FinalCritChance;
	var int FinalSuccessChance;
	var int FinalGrazeChance;
	var int FinalMissChance;
};

var localized string strCritReductionFromConditionalToHit;

var config bool ALLOW_NEGATIVE_DODGE;
var config bool DODGE_CONVERTS_GRAZE_TO_MISS;
var config bool GUARANTEED_HIT_ABILITIES_IGNORE_GRAZE_BAND;
var config bool DISABLE_LOST_HEADSHOT;

var config array<bool> HEADSHOT_ENABLED;

var config int TEAMWORK_LVL1_CHARGES;
var config int TEAMWORK_LVL2_CHARGES;
var config int TEAMWORK_LVL3_CHARGES;

var config int SUMMON_COOLDOWN;

var config float MELEE_DAMAGE_REDUCTION;
var config float EXPLOSIVE_DAMAGE_REDUCTION;

var config int SCANNING_PROTOCOL_INITIAL_CHARGES;

var config int MIND_SCORCH_RADIUS;
var config int MIND_SCORCH_BURNING_BASE_DAMAGE;
var config int MIND_SCORCH_BURNING_DAMAGE_SPREAD;
var config int MIND_SCORCH_BURN_CHANCE;

var config int SUSTAIN_WOUND_HP_REDUCTTION;

var config float CHOSEN_REGENERATION_HEAL_VALUE_PCT;

var config WeaponDamageValue EMPTY_DAMAGE_VALUE;
var config array<name> PISTOL_ABILITY_WEAPON_CATS;

var config int BIND_M2_BONUSDAMAGE;
var config int BIND_M3_BONUSDAMAGE;
var config int BIND_M4_BONUSDAMAGE;
var config int BIND_M5_BONUSDAMAGE;
var config int BIND_M6_BONUSDAMAGE;

var config int REVIVAL_PROTOCOL_COOLDOWN;
// Data structure for multi-shot abilities that need patching
struct MultiShotAbility
{
	var name AbilityName;
	var array<name> FollowUpAbilityNames;
};

var config int MEDICAL_PROTOCOL_COOLDOWN;
var config bool USE_LOS_FOR_MULTI_SHOT_ABILITIES;
var config array<MultiShotAbility> MULTI_SHOT_ABILITIES;

var privatewrite X2Condition_Visibility GameplayVisibilityCondition;

static function UpdateAbilities(X2AbilityTemplate Template, int Difficulty)
{
    // Override the FinalizeHitChance calculation for abilities that use standard aim
    if (ClassIsChildOf(Template.AbilityToHitCalc.Class, class'X2AbilityToHitCalc_StandardAim'))
    {
        Template.AbilityToHitCalc.OverrideFinalHitChanceFns.AddItem(OverrideFinalHitChance);
    }

	switch (Template.DataName)
	{
		case 'BondmateTeamwork':
		case 'BondmateTeamwork_Improved':
			UpdateTeamwork(Template);
			break;
		case 'BondmateSolaceCleanse':
			FixBondmateCleanse(Template);
			break;
		case 'BondmateDualStrikeFollowup':
			// Fix performance issue where it considers every enemy on the map a
			// valid target.
			Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
			break;
		case 'LostHeadshotInit':
			DisableLostHeadshot(Template);
			break;
		case 'Bayonet':
			UpdateBayonet(Template);
			break;
		//I probably could just update it in the Alienpack, but it doesn't recognize the cooldown class there
		case 'BayonetCharge':
			UpdateBayonetCharge(Template);
			break;
		case 'ChosenImmuneMelee':
			ReplaceWithDamageReductionMelee(Template);
			break;
		case 'BlastShield':
			ReplaceWithDamageReductionExplosive(Template);
			break;
		case 'PoisonSpit':
			AddImmuneConditionToPoisonSpit(Template);
			break;
		case 'AdvPurifierFlamethrower':
			UpdatePurifierFlamethrower(Template);
			break;
		case 'Fuse':
			//class'Helpers_LW'.static.MakeFreeAction(Template);
			break;
		case 'PriestStasis':
			MakeAbilityNonTurnEnding(Template);
			MakeAbilitiesUnusableOnLost(Template);
			GiveGLobalCooldownToPriestStasis(Template);
			break;
		case 'HunterGrapple':
		case 'Grapple':
		case 'PoweredGrapple':
			AddGrappledThisTurnEffect(Template);
			break;
		case 'Solace':
			RemoveRoboticsAsValidTargetsOfSolace(Template);
			break;
		case 'SolaceCleanse':
			RemoveRoboticsAsValidTargetsOfSolaceCleanse(Template);
			break;
		case 'HolyWarriorDeath':
			RemoveTheDeathFromHolyWarriorDeath(Template);
			break;
		case 'Sustain':
			UpdateSustainEffect(Template);
			break;
		case 'RevivalProtocol':
			ReworkRevivalProtocol(Template);
			break;
		case 'DeadeyeDamage':
			UseNewDeadeyeEffect(Template);
			break;
		case 'RestorativeMist':
			AllowRestorativeMistToRemoveStunned(Template);
			break;
		case 'Implacable':
			ReplaceImplacableEffect(Template);
			break;
		case 'BladestormAttack':
		case 'TemplarBladestormAttack':
			MakeBladestormNotTriggerOnItsTurn(Template);
			Template.PostActivationEvents.AddItem('BladestormActivated');
//			Template.AdditionalAbilities.AddItem('CoolUnderPressure');
			break;

		case 'Bind':
		case 'BindSustained':
		MakeBindDamageScale(Template);
		//At this point trying to figure out why AI does not do the thing it's supposed to do takes way longer than just doing this
		case 'GetOverHere':
		case 'KingGetOverHere':
			MakeAbilitiesUnusableOnLost(Template);
			break;
		case 'ScanningProtocol':
			class'Helpers_LW'.static.MakeFreeAction(Template);
			AddInitialScanningCharges(Template);
			break;
		case 'MindScorch':
			ReworkMindScorch(Template);
			break;
		case 'PartingSilk':
			ReworkPartingSilk(Template);
			break;
		case 'ChosenEngaged':
			MakeChosenInstantlyEngagedAndRemoveTimerPause(Template);
			break;
		case 'TeleportAlly':
			BuffTeleportAlly(Template);
			MakeAbilityWorkWhenBurning(Template);
			break;
		case 'ChosenSummonFollowers':
			UpdateSummon(Template);
			break;
		case 'VanishingWind_Scamper':
			UpdateVanishingWind(Template);
			break;
		case 'ChosenActivation':
			Template.AdditionalAbilities.RemoveItem('ChosenSummonFollowers');
			break;
		case 'BendingReed':
			//Template.bShowActivation = false;
			break;
		case 'VanishingWindReveal':
			Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_NeverShow;
			break;
		case 'ChosenAllSeeing':
			Template.ChosenExcludeTraits.Length = 0;
			break;
		case 'Slash_LW':
		case 'SwordSlice_LW':
		case 'CombativesCounterattack':
		case 'SilentTakedown_LW':
			Template.PostActivationEvents.AddItem('SlashActivated');
			break;
		case 'DisruptorRifleCrit':
			Template.bDisplayInUITooltip = true;
			Template.bDisplayInUITacticalText = true;
			break;
		case 'ChosenRegenerate':
			UpdateChosenRegenerate(Template);
			break;
		case 'TrackingShot':
			class'Helpers_LW'.static.MakeFreeAction(Template);
			break;
		case 'HarborWave':
			ReworkHarborWave(Template);
			break;
		case 'HunterRifleShot':
			MakeAbilityWorkWhenBurning(Template);

		// case 'FanFire':
		// case 'LightningHands':
		// case 'FaceOff':
		case 'SniperStandardFire':
		case 'StandardShot':
		case 'PistolStandardShot':
		case 'GunslingerShot':
		case 'OverwatchShot':
		case 'PistolOverwatchShot':
		case 'LongWatchShot':
		case 'PrimaryReturnFireShot':
			AddDisablingShotEffect(Template);
			Template.AddTargetEffect(class'X2Ability_Chosen'.static.HoloTargetEffect());
			Template.AssociatedPassives.AddItem('Disabler');
			break;
		case 'MindShield':
			DisplayMindShieldPassive(Template);
			break;
		case 'SteadyHands':
			FixSteadyHands(Template);
			break;
		case 'ChryssalidSlash':
			RemoveAbilityWeaponDamage(Template);
			RemoveTargetingRandomCivilians(Template);
			break;
		case 'DevastatingPunch':
			class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_ImmediateAbilityActivation');
		case 'BigDamnPunch':
		case 'ScythingClaws':
			RemoveAbilityWeaponDamage(Template);
			break;
		case 'MindSpin':
			ReworkMindSpin(Template);
		case 'MarkTarget':
		class'Helpers_LW'.static.MakeFreeAction(Template);
			break;

		case 'PsiReanimation':
		case 'MassReanimation_LW':
			MakeAbilityNonTurnEnding(Template);
			break;			

		case 'StunLance':
			MakeStunLanceWorkWhenBurning(Template);
			Template.PostActivationEvents.AddItem('PartingSilkActivated');

		case 'ShadowBind':
		case 'Bayonet':
		case 'BigDamnPunch':
		//case 'StandardMelee':
			MakeMeleeBlueMove(Template);
			break;

		case 'HolyWarriorM1':
		case 'HolyWarriorM2':
		case 'HolyWarriorM3':
		case 'HolyWarriorM4':
		case 'HolyWarriorM5':
			AddSuperiorholyWarrior(Template);
			break;

		case 'Reload':
			UpdateReload(Template);
			break;
		case 'Suppression':
		case 'AreaSuppression':
		case 'BulletWizard':
			AddSharedSuppressionCooldown(Template);
			break;

		case 'MedikitHeal':
		case 'NanoMedikitHeal':
			UpdateMedikits(Template);
			break;

		case 'GremlinHeal':
		case 'GremlinStabilize':
			UpdateMedicalProtocol(Template);
			break;
		case 'EverVigilant':
			Template.AdditionalAbilities.Removeitem('EverVigilantTrigger');
			Template.AdditionalAbilities.AddItem('NewEverVigilantTrigger');
			Template.AdditionalAbilities.AddItem('CoolUnderPressure');
			break;
		case 'SectopodLightningField':
			class'Helpers_LW'.static.MakeFreeAction(Template);
			break;
		case 'AidProtocol':
			UpdateAidProtocol(Template);
			break;
		case 'CombatProtocol':
			UpdateCombatProtocol(Template);
			break;
		// case 'LongWatch':
		// 	Template.AdditionalAbilities.AddItem('CoolUnderPressure');
		case 'Overwatch':
		case 'PistolOverwatch':
		case 'SniperRifleOverwatch':
		case 'LongWatch':
		case 'WatchThemRun_LW':
			UpdateOverwatch(Template);
			break;
		case 'LaunchGrenade':
			UpdateLaunchGrenade(Template);
			break;
		case 'BulletShred':
			UpdateRupture(Template);
			break;
		case 'EUBerserkerDevastatingPunch':
			UpdateLeaderPunch(Template);
			break;
		case 'SkirmisherAmbush':
			UpdateWaylay(Template);
			break;
		case 'Micromissiles':
		case 'MicroMissileFuse':
			MakeMicroMissilesDestroyLoot(Template);
			break;
		case 'RetributionAttack':
			MakeBladestormNotTriggerOnItsTurn(Template);
			Template.PostActivationEvents.AddItem('BladestormActivated');
		case 'SkirmisherFleche':
		case 'SkirmisherPostAbilityMelee':
			AddRipjackRuptureEffects(Template);
			break;
		// case 'SpawnChryssalid':
		// 	ReworkChryssalidSpawning(Template);
		// 	break
		default:
			break;

	}

	// Update pistol abilities so that they don't appear unless a pistol
	// or other suitable weapon is equipped.
	switch (Template.DataName)
	{
		case 'ClutchShot':
		case 'FanFire':
		case 'FaceOff':
		case 'Gunslinger':
		case 'LightningHands':
			Template.AbilityShooterConditions.AddItem(CreatePistolWeaponCatCondition());
			break;
	}

	// Handle multi-shot abilities
	UpdateMultiShotAbility(Template);
}

static function bool OverrideFinalHitChance(X2AbilityToHitCalc AbilityToHitCalc, out ShotBreakdown ShotBreakdown)
{
	local X2AbilityToHitCalc_StandardAim	StandardAim;
	local ToHitAdjustments					Adjustments;
	local ShotModifierInfo					ModInfo;

	StandardAim = X2AbilityToHitCalc_StandardAim(AbilityToHitCalc);
	if (StandardAim == none)
	{
		return false;
	}

	GetUpdatedHitChances(StandardAim, ShotBreakdown, Adjustments);

	// LWOTC Replacing the old FinalHitChance calculation with one that treats all graze
	// as a hit.
	// ShotBreakdown.FinalHitChance = ShotBreakdown.ResultTable[eHit_Success] + Adjustments.DodgeHitAdjust;
	ShotBreakdown.FinalHitChance = Adjustments.FinalSuccessChance + Adjustments.FinalGrazeChance + Adjustments.FinalCritChance;
	ShotBreakdown.ResultTable[eHit_Crit] = Adjustments.FinalCritChance;
	ShotBreakdown.ResultTable[eHit_Success] = Adjustments.FinalSuccessChance;
	ShotBreakdown.ResultTable[eHit_Graze] = Adjustments.FinalGrazeChance;
	ShotBreakdown.ResultTable[eHit_Miss] = Adjustments.FinalMissChance;

	if(Adjustments.DodgeHitAdjust != 0)
	{
		ModInfo.ModType = eHit_Success;
		ModInfo.Value   = Adjustments.DodgeHitAdjust;
		ModInfo.Reason  = class'XLocalizedData'.default.DodgeStat;
		ShotBreakdown.Modifiers.AddItem(ModInfo);
	}
	if(Adjustments.ConditionalCritAdjust != 0)
	{
		ModInfo.ModType = eHit_Crit;
		ModInfo.Value   = Adjustments.ConditionalCritAdjust;
		ModInfo.Reason  = default.strCritReductionFromConditionalToHit;
		ShotBreakdown.Modifiers.AddItem(ModInfo);
	}
	if(Adjustments.DodgeCritAdjust != 0)
	{
		ModInfo.ModType = eHit_Crit;
		ModInfo.Value   = Adjustments.DodgeCritAdjust;
		ModInfo.Reason  = class'XLocalizedData'.default.DodgeStat;
		ShotBreakdown.Modifiers.AddItem(ModInfo);
	}

	return true;
}

// doesn't actually assign anything to the ToHitCalc, just computes relative to-hit adjustments
static function GetUpdatedHitChances(X2AbilityToHitCalc_StandardAim ToHitCalc, out ShotBreakdown ShotBreakdown, out ToHitAdjustments Adjustments)
{
	local ShotModifierInfo ModInfo;
	local int GrazeBand;
	local int CriticalChance, DodgeChance;
	local int MissChance, HitChance, CritChance;
	local int GrazeChance, GrazeChance_Hit, GrazeChance_Miss;
	local int CritPromoteChance_HitToCrit;
	local int CritPromoteChance_GrazeToHit;
	local int DodgeDemoteChance_CritToHit;
	local int DodgeDemoteChance_HitToGraze;
	local int DodgeDemoteChance_GrazeToMiss;
	local int i;
	local EAbilityHitResult HitResult;
	local bool bLogHitChance;

	bLogHitChance = false;

	if(bLogHitChance)
	{
		`LWTRACE("==" $ GetFuncName() $ "==\n");
		`LWTRACE("Starting values...", bLogHitChance);
		for (i = 0; i < eHit_MAX; ++i)
		{
			HitResult = EAbilityHitResult(i);
			`LWTRACE(HitResult $ ":" @ ShotBreakdown.ResultTable[i]);
		}
	}

	// STEP 1 "Band of hit values around nominal to-hit that results in a graze
	GrazeBand = `LWOVERHAULOPTIONS.GetGrazeBand();

	// options to zero out the band for certain abilities -- either GuaranteedHit or an ability-by-ability
	if (default.GUARANTEED_HIT_ABILITIES_IGNORE_GRAZE_BAND && ToHitCalc.bGuaranteedHit)
	{
		GrazeBand = 0;
	}

	HitChance = ShotBreakdown.ResultTable[eHit_Success];
	// LWOTC: If hit chance is within grazeband of either 0 or 100%, then adjust
	// the band so that 100% is a hit and 0% is a miss.
	if (HitChance < GrazeBand)
	{
		GrazeBand = Max(0, HitChance);
	}
	else if (HitChance > (100 - GrazeBand))
	{
		GrazeBand = Max(0, 100 - HitChance);
	}
	// End LWOTC change

	GrazeChance_Hit = Clamp(HitChance, 0, GrazeBand); // captures the "low" side where you just barely hit
	GrazeChance_Miss = Clamp(100 - HitChance, 0, GrazeBand);  // captures the "high" side where  you just barely miss
	GrazeChance = GrazeChance_Hit + GrazeChance_Miss;

	if (GrazeChance_Hit > 0)
	{
		ModInfo.ModType = eHit_Success;
		ModInfo.Value   = GrazeChance_Hit;
		ModInfo.Reason  = class'X2TacticalGameRulesetDataStructures'.default.m_aAbilityHitResultStrings[eHit_Graze];
		Shotbreakdown.Modifiers.AddItem(ModInfo);
	}

	if (bLogHitChance)
	{
		`LWTRACE("Graze Chance from band = " $ GrazeChance, bLogHitChance);
	}

	//STEP 2 Update Hit Chance to remove GrazeChance -- for low to-hits this can be zero
	HitChance = Clamp(Min(100, HitChance)-GrazeChance_Hit, 0, 100-GrazeChance);
	if(bLogHitChance)
		`LWTRACE("HitChance after graze graze band removal = " $ HitChance, bLogHitChance);

	//STEP 3 "Crits promote from graze to hit, hit to crit
	CriticalChance = ShotBreakdown.ResultTable[eHit_Crit];
	if (default.ALLOW_NEGATIVE_DODGE && ShotBreakdown.ResultTable[eHit_Graze] < 0)
	{
		// negative dodge acts like crit, if option is enabled
		CriticalChance -= ShotBreakdown.ResultTable[eHit_Graze];
	}
	CriticalChance = Clamp(CriticalChance, 0, 100);
	CritPromoteChance_HitToCrit = Round(float(HitChance) * float(CriticalChance) / 100.0);

	CritPromoteChance_GrazeToHit = Round(float(GrazeChance) * float(CriticalChance) / 100.0);
	if(bLogHitChance)
	{
		`LWTRACE("CritPromoteChance_HitToCrit = " $ CritPromoteChance_HitToCrit, bLogHitChance);
		`LWTRACE("CritPromoteChance_GrazeToHit = " $ CritPromoteChance_GrazeToHit, bLogHitChance);
	}

	CritChance = CritPromoteChance_HitToCrit; // crit chance is the chance you promoted to crit
	HitChance = HitChance + CritPromoteChance_GrazeToHit - CritPromoteChance_HitToCrit;  // add chance for promote from dodge, remove for promote to crit
	GrazeChance = GrazeChance - CritPromoteChance_GrazeToHit; // remove chance for promote to hit
	if(bLogHitChance)
	{
		`LWTRACE("PostCrit:", bLogHitChance);
		`LWTRACE("CritChance  = " $ CritChance, bLogHitChance);
		`LWTRACE("HitChance   = " $ HitChance, bLogHitChance);
		`LWTRACE("GrazeChance = " $ GrazeChance, bLogHitChance);
	}

	//save off loss of crit due to conditional on to-hit
	Adjustments.ConditionalCritAdjust = -(CriticalChance - CritPromoteChance_HitToCrit);

	//STEP 4 "Dodges demotes from crit to hit, hit to graze, (optional) graze to miss"
	if (ShotBreakdown.ResultTable[eHit_Graze] > 0)
	{
		DodgeChance = Clamp(ShotBreakdown.ResultTable[eHit_Graze], 0, 100);
		DodgeDemoteChance_CritToHit = Round(float(CritChance) * float(DodgeChance) / 100.0);
		DodgeDemoteChance_HitToGraze = Round(float(HitChance) * float(DodgeChance) / 100.0);
		if(default.DODGE_CONVERTS_GRAZE_TO_MISS)
		{
			DodgeDemoteChance_GrazeToMiss = Round(float(GrazeChance) * float(DodgeChance) / 100.0);
		}
		CritChance = CritChance - DodgeDemoteChance_CritToHit;
		HitChance = HitChance + DodgeDemoteChance_CritToHit - DodgeDemoteChance_HitToGraze;
		GrazeChance = GrazeChance + DodgeDemoteChance_HitToGraze - DodgeDemoteChance_GrazeToMiss;

		if(bLogHitChance)
		{
			`LWTRACE("DodgeDemoteChance_CritToHit   = " $ DodgeDemoteChance_CritToHit);
			`LWTRACE("DodgeDemoteChance_HitToGraze  = " $ DodgeDemoteChance_HitToGraze);
			`LWTRACE("DodgeDemoteChance_GrazeToMiss = " $DodgeDemoteChance_GrazeToMiss);
			`LWTRACE("PostDodge:");
			`LWTRACE("CritChance  = " $ CritChance);
			`LWTRACE("HitChance   = " $ HitChance);
			`LWTRACE("GrazeChance = " $ GrazeChance);
		}

		//save off loss of crit due to dodge demotion
		Adjustments.DodgeCritAdjust = -DodgeDemoteChance_CritToHit;

		//save off loss of to-hit due to dodge demotion of graze to miss
		Adjustments.DodgeHitAdjust = -DodgeDemoteChance_GrazeToMiss;
	}

	//STEP 5 Store
	Adjustments.FinalCritChance = CritChance;
	Adjustments.FinalSuccessChance = HitChance;
	Adjustments.FinalGrazeChance = GrazeChance;

	//STEP 6 Miss chance is what is left over
	MissChance = 100 - (CritChance + HitChance + GrazeChance);
	Adjustments.FinalMissChance = MissChance;
	if(MissChance < 0)
	{
		//This is an error so flag it
		`REDSCREEN("OverrideToHit : Negative miss chance!");
	}
}

static function DisableLostHeadshot(X2AbilityTemplate Template)
{
	local X2Effect_TheLostHeadshot				HeadshotEffect;
	local X2Condition_HeadshotEnabled           HeadshotCondition;
	local int									i;

	`LWTrace("Disabling Headshot mechanic");

	for (i = Template.AbilityTargetEffects.Length-1; i >= 0; i--)
	{
		HeadshotEffect = X2Effect_TheLostHeadshot(Template.AbilityTargetEffects[i]);
		if (HeadshotEffect != none)
		{
			HeadshotCondition = new class'X2Condition_HeadshotEnabled';
			HeadshotCondition.EnabledForDifficulty = default.HEADSHOT_ENABLED;
			HeadshotEffect.TargetConditions.AddItem(HeadshotCondition);
			break;
		}
	}
}

static function UpdateTeamwork(X2AbilityTemplate Template)
{
	// local X2Effect Effect;
	// local X2Condition Condition;
	// local X2Effect_GrantActionPoints ActionPointEffect;
	// local X2Condition_Bondmate BondmateCondition;
	local X2Condition_Visibility TargetVisibilityCondition;
	// local X2AbilityCharges_Teamwork AbilityCharges;

	// // Change the charges for each level of Teamwork
	// AbilityCharges = new class'X2AbilityCharges_Teamwork';
	// AbilityCharges.Charges.AddItem(default.TEAMWORK_LVL1_CHARGES);
	// AbilityCharges.Charges.AddItem(default.TEAMWORK_LVL2_CHARGES);
	// AbilityCharges.Charges.AddItem(default.TEAMWORK_LVL3_CHARGES);

	// if (Template.DataName == 'BondmateTeamwork')
	// {
	// 	// // Change the lvl 1 Teamwork to granting a move action rather than a standard one
	// 	// foreach Template.AbilityTargetEffects(Effect)
	// 	// {
	// 	// 	ActionPointEffect = X2Effect_GrantActionPoints(Effect);
	// 	// 	if (ActionPointEffect != none)
	// 	// 	{
	// 	// 		ActionPointEffect.PointType = class'X2CharacterTemplateManager'.default.MoveActionPoint;
	// 	// 		break;
	// 	// 	}
	// 	// }

	// 	// Only apply lvl 1 Teamwork to lvl 1 bonds (not lvl 2)
	// 	foreach Template.AbilityShooterConditions(Condition)
	// 	{
	// 		BondmateCondition = X2Condition_Bondmate(Condition);
	// 		if (BondmateCondition != none)
	// 		{
	// 			BondmateCondition.MaxBondLevel = 1;
	// 			break;
	// 		}
	// 	}

	// 	Template.AbilityCharges = AbilityCharges;
	// }
	// else if (Template.DataName == 'BondmateTeamwork_Improved')
	// {
	// 	// Only apply lvl 1 Teamwork to lvl 1 bonds (not lvl 2)
	// 	foreach Template.AbilityShooterConditions(Condition)
	// 	{
	// 		BondmateCondition = X2Condition_Bondmate(Condition);
	// 		if (BondmateCondition != none)
	// 		{
	// 			BondmateCondition.MaxBondLevel = 1;
	// 		}
	// 	}

	// 	// Apply Advanced Teamwork to lvl 2 and 3 bonds
	// 	foreach Template.AbilityShooterConditions(Condition)
	// 	{
	// 		BondmateCondition = X2Condition_Bondmate(Condition);
	// 		if (BondmateCondition != none)
	// 		{
	// 			BondmateCondition.MinBondLevel = 2;
	// 			BondmateCondition.MaxBondLevel = 3;
	// 		}
	// 	}

	// 	Template.AbilityCharges = AbilityCharges;
	// }

	// Limit Teamwork to line of sight
	TargetVisibilityCondition = new class'X2Condition_Visibility';
	TargetVisibilityCondition.bRequireGameplayVisible = true;
	TargetVisibilityCondition.bRequireBasicVisibility=true;
	Template.AbilityTargetConditions.AddItem(TargetVisibilityCondition);
}

// Make sure that the bondmate "Solace" effect clears the stunned
// status properly, as the vanilla ability does not.
static function  FixBondmateCleanse(X2AbilityTemplate Template)
{
	local X2Effect_StunRecover StunRecoverEffect;

	// Note that this effect restores action points to the stunned unit
	StunRecoverEffect = class'X2StatusEffects'.static.CreateStunRecoverEffect();
	StunRecoverEffect.TargetConditions.AddItem(new class'X2Condition_IsStunned_LW');
	Template.AddTargetEffect(StunRecoverEffect);
}

static function UpdateBayonet(X2AbilityTemplate Template)
{
	local X2AbilityCooldown_Shared	Cooldown;

	Cooldown = new class'X2AbilityCooldown_Shared';
	Cooldown.iNumTurns = class'X2Ability_LWAlienAbilities'.default.BAYONET_COOLDOWN;
	Cooldown.SharingCooldownsWith.AddItem('BayonetCharge'); //Now shares the cooldown with Bayonet charge
	Template.AbilityCooldown = Cooldown;

}

static function UpdateBayonetCharge(X2AbilityTemplate Template)
{
	local X2AbilityCooldown_Shared	Cooldown;

	Cooldown = new class'X2AbilityCooldown_Shared';
	Cooldown.iNumTurns = class'X2Ability_LWAlienAbilities'.default.BAYONET_COOLDOWN;
	Cooldown.SharingCooldownsWith.AddItem('Bayonet'); //Now shares the cooldown with Bayonet
	Template.AbilityCooldown = Cooldown;
}

static function ReplaceWithDamageReductionExplosive(X2AbilityTemplate Template)
{
	local X2Effect_Formidable	PaddingEffect;

	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_BlastShield');

	PaddingEffect = new class'X2Effect_Formidable';
	PaddingEffect.ExplosiveDamageReduction = default.EXPLOSIVE_DAMAGE_REDUCTION;
	PaddingEffect.Armor_Mitigation = 0;
	Template.AddTargetEffect(PaddingEffect);
}

static function ReplaceWithDamageReductionMelee(X2AbilityTemplate Template)
{
	local X2Effect_DefendingMeleeDamageModifier DamageMod;

	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_DamageImmunity');

	DamageMod = new class'X2Effect_DefendingMeleeDamageModifier';
	DamageMod.DamageMod = default.MELEE_DAMAGE_REDUCTION;
	DamageMod.OnlyForDashingAttacks = true;
	DamageMod.BuildPersistentEffect(1, true, false, true);
	DamageMod.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage,,, Template.AbilitySourceName);
	Template.AddTargetEffect(DamageMod);
}

static function AddImmuneConditionToPoisonSpit(X2AbilityTemplate Template)
{
	local X2Condition_UnitImmunities UnitImmunityCondition;
	
	UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	UnitImmunityCondition.AddExcludeDamageType('Poison');
	Template.AbilityMultiTargetConditions.AddItem(UnitImmunityCondition);
}

static function AddImmuneConditionToFlamethrower(X2AbilityTemplate Template)
{
	local X2Condition_UnitImmunities UnitImmunityCondition;
	
	UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	UnitImmunityCondition.AddExcludeDamageType('Fire');
	Template.AbilityMultiTargetConditions.AddItem(UnitImmunityCondition);
}

static function UpdatePurifierFlamethrower(X2AbilityTemplate Template)
{
	local X2AbilityMultiTarget_Cone_LWFlamethrower	ConeMultiTarget;
	local X2AbilityToHitCalc_StandardAim			StandardAim;
	local X2Condition 								Condition;
	local X2Condition_Phosphorus PhosphorusCondition;
	local X2Effect Effect;
	local X2AbilityCost_Ammo AmmoCost;

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	Template.AbilityCosts.AddItem(AmmoCost);

	StandardAim = new class'X2AbilityToHitCalc_StandardAim';
	StandardAim.bAllowCrit = false;
	StandardAim.bGuaranteedHit = true;
	Template.AbilityToHitCalc = StandardAim;

	foreach Template.AbilityShooterConditions(Condition)
	{
		if(Condition.isA(class'X2Condition_UnitEffects'.name))
		{
			X2Condition_UnitEffects(Condition).RemoveExcludeEffect(class'X2AbilityTemplateManager'.default.DisorientedName);
		}
	}
		PhosphorusCondition = new class'X2Condition_Phosphorus';

	foreach Template.AbilityMultiTargetEffects(Effect)
	{
		if(Effect.isA('X2Effect_ApplyWeaponDamage'))
		{
			X2Effect_ApplyWeaponDamage(Effect).TargetConditions.AddItem(PhosphorusCondition);
		}
	}	

	Template.TargetingMethod = class'X2TargetingMethod_Cone';

	ConeMultiTarget = new class'X2AbilityMultiTarget_Cone_LWFlamethrower';
	ConeMultiTarget.bUseWeaponRadius = true;

	ConeMultiTarget.ConeEndDiameter = class'X2Ability_AdvPurifier'.default.ADVPURIFIER_FLAMETHROWER_TILE_WIDTH * class'XComWorldData'.const.WORLD_StepSize;
	ConeMultiTarget.ConeLength = class'X2Ability_AdvPurifier'.default.ADVPURIFIER_FLAMETHROWER_TILE_LENGTH * class'XComWorldData'.const.WORLD_StepSize;
	ConeMultiTarget.AddConeSizeMultiplier('Incinerator', class'X2Ability_LW_TechnicalAbilitySet'.default.INCINERATOR_RANGE_MULTIPLIER, class'X2Ability_LW_TechnicalAbilitySet'.default.INCINERATOR_RADIUS_MULTIPLIER);
	// Next line used for vanilla targeting
	// ConeMultiTarget.AddConeSizeMultiplier('Incinerator', default.INCINERATOR_CONEEND_DIAMETER_MODIFIER, default.INCINERATOR_CONELENGTH_MODIFIER);
	ConeMultiTarget.bIgnoreBlockingCover = true;
	Template.AbilityMultiTargetStyle = ConeMultiTarget;

	Template.AdditionalAbilities.AddItem('Phosphorus');

	Template.bCheckCollision = true;
	Template.bAffectNeighboringTiles = true;
	Template.bFragileDamageOnly = true;

	// For vanilla targeting
	Template.PostActivationEvents.AddItem('FlamethrowerActivated');
	Template.ActionFireClass = class'X2Action_Fire_Flamethrower_Purifier';

	//Template.BuildVisualizationFn = class'X2Ability_LW_TechnicalAbilitySet'.static.LWFlamethrower_BuildVisualization;

}

static function MakeAbilityNonTurnEnding(X2AbilityTemplate Template)
{
	local X2AbilityCost Cost;

	foreach Template.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_ActionPoints'))
		{
			X2AbilityCost_ActionPoints(Cost).bConsumeAllPoints = false;
		}
	}
}

static function MakeAbilityTurnEnding(X2AbilityTemplate Template)
{
	local X2AbilityCost Cost;

	foreach Template.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_ActionPoints'))
		{
			X2AbilityCost_ActionPoints(Cost).bConsumeAllPoints = true;
		}
	}
}
// Adds an extra unit condition to both Solace and Solace Cleanse that
// prevents them from affecting robotic units. This also removes Holy
// Warrior from the list of effects that Solace Cleanse removes.
static function RemoveRoboticsAsValidTargetsOfSolace(X2AbilityTemplate Template)
{
	local X2Effect_Solace ExistingEffect;
	local X2Condition_UnitProperty UnitCondition;
	local int i;

	// Replace the existing Solace effect with our own
	for (i = 0; i < Template.AbilityMultiTargetEffects.Length; i++)
	{
		// Sanity check to make sure that another mod hasn't modified
		// the effect itself.
		ExistingEffect = X2Effect_Solace(Template.AbilityMultiTargetEffects[i]);
		if (ExistingEffect != none && ClassIsChildOf(class'X2Effect_SolaceAura_LW', ExistingEffect.Class))
		{
			Template.AbilityMultiTargetEffects[i] = new class'X2Effect_SolaceAura_LW'(ExistingEffect);
		}
	}

	// Add a target condition that excludes robotic units
	UnitCondition = new class'X2Condition_UnitProperty';
	UnitCondition.ExcludeHostileToSource = true;
	UnitCondition.ExcludeFriendlyToSource = false;
	UnitCondition.ExcludeRobotic = true;

	Template.AbilityMultiTargetConditions.AddItem(UnitCondition);
}

// Adds an extra unit condition to both Solace and Solace Cleanse that
// prevents them from affecting robotic units. This also removes Holy
// Warrior from the list of effects that Solace Cleanse removes.
static function RemoveRoboticsAsValidTargetsOfSolaceCleanse(X2AbilityTemplate Template)
{
	local X2Effect_RemoveEffects RemoveEffects;
	local X2Condition_UnitProperty UnitCondition;
	local int i, j;

	for (i = 0; i < Template.AbilityTargetEffects.Length; i++)
	{
		RemoveEffects = X2Effect_RemoveEffects(Template.AbilityTargetEffects[i]);
		if (RemoveEffects != none)
		{
			// Make sure the various Solace effects ignore robotic units.
			for (j = 0; j < RemoveEffects.TargetConditions.Length; j++)
			{
				UnitCondition = X2Condition_UnitProperty(RemoveEffects.TargetConditions[j]);
				if (UnitCondition != none)
					UnitCondition.ExcludeRobotic = true;
			}

			// Solace Cleanse should not clear Holy Warrior. If it's clearing the mind
			// control from a unit that has Holy Warrior, then MindControlCleanse will
			// ensure Holy Warrior is correctly removed.
			RemoveEffects.EffectNamesToRemove.RemoveItem(class'X2Ability_AdvPriest'.default.HolyWarriorEffectName);
		}
	}
}

static function RemoveTheDeathFromHolyWarriorDeath(X2AbilityTemplate Template)
{
	class'Helpers_LW'.static.RemoveAbilityMultiTargetEffects(Template, 'X2Effect_HolyWarriorDeath');
}

static function UpdateSustainEffect(X2AbilityTemplate Template)
{
	local X2Effect_Sustain_LW SustainEffect;
	local X2Effect_GreaterPadding	GreaterPaddingEffect;
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_Sustain');

	SustainEffect = new class'X2Effect_Sustain_LW';
	SustainEffect.BuildPersistentEffect(1, true, true);
	SustainEffect.EffectName='Sustain';
	SustainEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(SustainEffect);

	GreaterPaddingEffect = new class 'X2Effect_GreaterPadding';
	GreaterPaddingEffect.BuildPersistentEffect (1, true, false);
	GreaterPaddingEffect.Padding_HealHP = default.SUSTAIN_WOUND_HP_REDUCTTION;	

}

static function UseNewDeadeyeEffect(X2AbilityTemplate Template)
{
	local X2Effect_DeadeyeDamage_LW DeadeyeEffect;

	// Remove old effect before adding the new one.
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template, 'X2Effect_DeadeyeDamage');

	DeadeyeEffect = new class'X2Effect_DeadeyeDamage_LW';
	DeadeyeEffect.BuildPersistentEffect(1, true, false, false);
	DeadeyeEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false,,Template.AbilitySourceName);
	DeadeyeEffect.DamageMultiplier = class'X2Effect_DeadeyeDamage'.default.DamageMultiplier;
	Template.AddTargetEffect(DeadeyeEffect);
}

static function ReworkRevivalProtocol(X2AbilityTemplate Template)
{
	local X2Effect_RestoreActionPoints RestoreAPEffect;
	local X2Effect_RemoveEffects RemoveEffects;
	local X2Effect_StunRecover StunRecoverEffect;
	local int i;
	local X2AbilityCooldown Cooldown;
	// Replace the standard Revival Protocol targeting condition with one that also
	// targets stunned units.
	for (i = 0; i < Template.AbilityTargetConditions.Length; i++)
	{
		if (X2Condition_RevivalProtocol(Template.AbilityTargetConditions[i]) != none)
		{
			Template.AbilityTargetConditions[i] = new class'X2Condition_RevivalProtocol_LW';
		}
	}

	for (i = 0; i < Template.AbilityTargetEffects.Length; i++)
	{
		// Make sure X2Effect_RestoreActionPoints only applies if the target unit is
		// *not* stunned (since X2Effect_StunRecover also restores action points). It
		// should also not apply if the unit is only disoriented.
		RestoreAPEffect = X2Effect_RestoreActionPoints(Template.AbilityTargetEffects[i]);
		if (RestoreAPEffect != none)
		{
			RestoreApEffect.TargetConditions.AddItem(new class'X2Condition_RevivalProtocolRestoreActionPoints_LW');
		}

		// Also make sure that the stunned effect is cleared.
		RemoveEffects = X2Effect_RemoveEffects(Template.AbilityTargetEffects[i]);
		if (RemoveEffects != none)
		{
			RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
		}
	}

	// Add X2Effect_StunRecover so that units recover properly from stunned, but
	// only apply this effect if the unit actually *is* stunned. This effect is
	// mutually exclusive with X2Effect_RestoreActionPoints.
	StunRecoverEffect = class'X2StatusEffects'.static.CreateStunRecoverEffect();
	StunRecoverEffect.TargetConditions.AddItem(new class'X2Condition_IsStunned_LW');
	Template.AddTargetEffect(StunRecoverEffect);

	Template.AbilityCharges = none;

	class'Helpers_LW'.static.RemoveabilityCosts(Template,'X2AbilityCost_Charges');

	Cooldown = new class'X2AbilityCooldown';
	Cooldown.iNumTurns = default.REVIVAL_PROTOCOL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;

}

static function AllowRestorativeMistToRemoveStunned(X2AbilityTemplate Template)
{
	local X2Effect_RestoreActionPoints RestoreAPEffect;
	local X2Effect_RemoveEffects RemoveEffects;
	local X2Effect_StunRecover StunRecoverEffect;
	local int i, j;

	for (i = 0; i < Template.AbilityMultiTargetEffects.Length; i++)
	{
		// Make sure X2Effect_RestoreActionPoints doesn't apply if the unit is only disoriented.
		RestoreAPEffect = X2Effect_RestoreActionPoints(Template.AbilityMultiTargetEffects[i]);
		if (RestoreAPEffect != none)
		{
			for (j = 0; j < RestoreAPEffect.TargetConditions.Length; j++)
			{
				// Replace the RevivalProtocol condition, which returns true if the target
				// is disoriented, with out custom condition that excludes disoriented units,
				// since we don't want those to get action points back.
				if (X2Condition_RevivalProtocol(RestoreAPEffect.TargetConditions[j]) != none)
				{
					RestoreAPEffect.TargetConditions[j] = new class'X2Condition_RevivalProtocolRestoreActionPoints_LW';
				}
			}
		}

		// Also make sure that the stunned effect is cleared.
		RemoveEffects = X2Effect_RemoveEffects(Template.AbilityMultiTargetEffects[i]);
		if (RemoveEffects != none)
		{
			RemoveEffects.EffectNamesToRemove.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);
		}
	}

	// Add X2Effect_StunRecover so that units recover properly from stunned, but
	// only apply this effect if the unit actually *is* stunned. This effect is
	// mutually exclusive with X2Effect_RestoreActionPoints.
	//
	// Note that we still need to include the standard Revival Protocol condition
	// to handle units that can't be revived.
	StunRecoverEffect = class'X2StatusEffects'.static.CreateStunRecoverEffect();
	StunRecoverEffect.TargetConditions.AddItem(new class'X2Condition_RevivalProtocol_LW');
	StunRecoverEffect.TargetConditions.AddItem(new class'X2Condition_IsStunned_LW');
	Template.AddMultiTargetEffect(StunRecoverEffect);
}

// Use an Implacable effect that can't proc during Battlelord turns
static function ReplaceImplacableEffect(X2AbilityTemplate Template)
{
	local X2Effect_Implacable ImplacableEffect;
	local int i;

	// Change the lvl 1 Teamwork to granting a move action rather than a standard one
	for (i = 0; i < Template.AbilityTargetEffects.Length; i++)
	{
		ImplacableEffect = X2Effect_Implacable(Template.AbilityTargetEffects[i]);
		if (ImplacableEffect != none)
		{
			Template.AbilityTargetEffects[i] = new class'X2Effect_Implacable_LW'(ImplacableEffect);
			break;
		}
	}
}

static function UpdateFuseDetonation(X2AbilityTemplate Template)
{
	local X2AbilityCost Cost;

	foreach Template.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_Ammo'))
		{
			X2AbilityCost_Ammo(Cost).bConsumeAllAmmo = true;
		}
	}
}


static function UpdateRupture(X2AbilityTemplate Template)
{
	local X2AbilityCost Cost;

	foreach Template.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_Ammo'))
		{
			X2AbilityCost_Ammo(Cost).iAmmo = 1;
		}
	}
}

static function MakeBladestormNotTriggerOnItsTurn(X2AbilityTemplate Template)
{
	local X2Condition_NotItsOwnTurn Condition;

	Condition = new class'X2Condition_NotItsOwnTurn';
	Template.AbilityShooterConditions.AddItem(Condition);
}

static function MakeAbilitiesUnusableOnLost(X2AbilityTemplate Template)
{
	local X2Condition_NotLost Condition;

	Condition = new class'X2Condition_NotLost';
	Template.AbilityTargetConditions.AddItem(Condition);
}

static function AddInitialScanningCharges(X2AbilityTemplate Template)
{
	Template.AbilityCharges.InitialCharges = default.SCANNING_PROTOCOL_INITIAL_CHARGES;
}

static function ReworkMindScorch(X2AbilityTemplate Template)
{
	local X2Condition_UnitProperty ShooterCondition, TargetCondition;
	local X2AbilityMultiTarget_Radius RadiusMultiTarget;
	local AbilityGrantedBonusRadius DangerZoneBonus;
	local X2Effect_Burning BurningEffect;
	local X2Effect_ApplyWeaponDamage DamageEffect;
	local array<name> SkipExclusions;
	local X2AbilityCooldown_MindScorch Cooldown;


	Cooldown = new class'X2AbilityCooldown_MindScorch';
	Cooldown.iNumTurns = class'X2Ability_ChosenWarlock'.default.MINDSCORCH_COOLDOWN_LOCAL;
	Cooldown.NumGlobalTurns = class'X2Ability_ChosenWarlock'.default.MINDSCORCH_COOLDOWN_GLOBAL;
	Template.AbilityCooldown = Cooldown;

	ShooterCondition = new class'X2Condition_UnitProperty';
	ShooterCondition.ExcludeConcealed = true;
	Template.AbilityShooterConditions.AddItem(ShooterCondition);

	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	TargetCondition = new class'X2Condition_UnitProperty';
	TargetCondition.ExcludeAlive = false;
	TargetCondition.ExcludeDead = true;
	TargetCondition.ExcludeFriendlyToSource = true;
	TargetCondition.ExcludeHostileToSource = false;
	TargetCondition.TreatMindControlledSquadmateAsHostile = false;
	TargetCondition.FailOnNonUnits = true;
	TargetCondition.ExcludeCivilian = true;
	TargetCondition.ExcludeCosmetic = true;
	TargetCondition.ExcludeRobotic = true;


	RadiusMultiTarget = new class'X2AbilityMultiTarget_Radius';
	RadiusMultiTarget.bIgnoreBlockingCover = true;
	RadiusMultiTarget.bAllowDeadMultiTargetUnits = false;
	RadiusMultiTarget.bExcludeSelfAsTargetIfWithinRadius = true;
	RadiusMultiTarget.bUseWeaponRadius = false;
	RadiusMultiTarget.fTargetRadius = `TILESTOMETERS(default.MIND_SCORCH_RADIUS) + 0.01;

	Template.AbilityMultiTargetStyle = RadiusMultiTarget;

	Template.TargetingMethod = class'X2TargetingMethod_AreaSuppression';
	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_DeadEye';

	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template, 'X2Effect_Dazed');
	class'Helpers_LW'.static.RemoveAbilityMultiTargetEffects(Template, 'X2Effect_Dazed');

	BurningEffect = class'X2StatusEffects'.static.CreateBurningStatusEffect(default.MIND_SCORCH_BURNING_BASE_DAMAGE, default.MIND_SCORCH_BURNING_DAMAGE_SPREAD);
	BurningEffect.ApplyChance = default.MIND_SCORCH_BURN_CHANCE;
	Template.AddTargetEffect(BurningEffect);
	Template.AddMultiTargetEffect(BurningEffect);

	Template.AddTargetEffect(CreateMindSchorchPanicEffect());
	Template.AddMultiTargetEffect(CreateMindSchorchPanicEffect());

	DamageEffect = new class'X2Effect_ApplyWeaponDamage';
	DamageEffect.bIgnoreArmor = true;
	DamageEffect.TargetConditions.AddItem(TargetCondition);
	Template.AddTargetEffect(DamageEffect);
	Template.AddMultiTargetEffect(DamageEffect);

	DangerZoneBonus.RequiredAbility = 'MindScorchDangerZone';
	DangerZoneBonus.fBonusRadius = `TILESTOMETERS(class'X2LWModTemplate_TemplarAbilities'.default.VOLT_DANGER_ZONE_BONUS_RADIUS) + 0.01;
	RadiusMultiTarget.AbilityBonusRadii.AddItem(DangerZoneBonus);


}

static function X2Effect_ImmediateMultiTargetAbilityActivation CreateMindSchorchPanicEffect()
{
	local X2Effect_ImmediateMultiTargetAbilityActivation	PanicEffect;
	local X2Condition_AbilityProperty						TerrorCondition;
	local X2Condition_UnitProperty							UnitCondition;

	PanicEffect = new class 'X2Effect_ImmediateMultiTargetAbilityActivation';

	PanicEffect.BuildPersistentEffect(1, false, false, , eGameRule_PlayerTurnBegin);
	PanicEffect.EffectName = 'ImmediateDisorientOrPanic';
	PanicEffect.AbilityName = class'X2Ability_TemplarAbilitySet_LW'.default.PanicImpairingAbilityName;
	PanicEffect.bRemoveWhenTargetDies = true;

	UnitCondition = new class'X2Condition_UnitProperty';
	UnitCondition.ExcludeOrganic = false;
	UnitCondition.ExcludeRobotic = true;
	UnitCondition.ExcludeAlive = false;
	UnitCondition.ExcludeDead = true;
	UnitCondition.FailOnNonUnits = true;
	UnitCondition.ExcludeFriendlyToSource = true;

	TerrorCondition = new class'X2Condition_AbilityProperty';
	TerrorCondition.OwnerHasSoldierAbilities.AddItem('MindScorchTerror');

	PanicEffect.TargetConditions.AddItem(UnitCondition);
	PanicEffect.TargetConditions.AddItem(TerrorCondition);

	return PanicEffect;
}

	
static function MakeChosenInstantlyEngagedAndRemoveTimerPause(X2AbilityTemplate Template)
{
	local X2AbilityTrigger_UnitPostBeginPlay PostBeginPlayTrigger;
	local X2Effect Effect;

	PostBeginPlayTrigger = new class'X2AbilityTrigger_UnitPostBeginPlay';
	PostBeginPlayTrigger.Priority = 60;
	Template.AbilityTriggers.AddItem(PostBeginPlayTrigger);

	foreach Template.AbilityShooterEffects (Effect)
	{
		if(Effect.isA('X2Effect_SuspendMissionTimer'))
		{
			X2Effect_SuspendMissionTimer(Effect).bResumeMissionTimer = true;
		}
	}
}

static function ReworkPartingSilk(X2AbilityTemplate Template)
{
	local X2AbilityCost Cost;
	local X2Condition Condition;
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template, 'X2Effect_Dazed');

	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_DeadEye';

	foreach Template.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_ActionPoints'))
		{
			X2AbilityCost_ActionPoints(Cost).bConsumeAllPoints = true;
		}
	}
	
	foreach Template.AbilityTargetConditions(Condition)
	{
		if (Condition.IsA('X2Condition_UnitProperty'))
		{
			X2Condition_UnitProperty(Condition).RequireUnitSelectedFromHQ = false;
		}
	}

}


static function BuffTeleportAlly(X2AbilityTemplate Template)
{
	local X2Condition_UnitEffects ExcludeEffects;
	//local X2Effect_GrantActionPoints AddAPEffect;
	//local X2Effect_RunBehaviorTree ReactionEffect;


	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;

	ExcludeEffects = new class'X2Condition_UnitEffects';

	ExcludeEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.DisorientedName, 'AA_UnitIsDisoriented');
	ExcludeEffects.AddExcludeEffect(class'X2StatusEffects'.default.BurningName, 'AA_UnitIsBurning');
	ExcludeEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.StunnedName, 'AA_UnitIsStunned');
	ExcludeEffects.AddExcludeEffect(class'X2AbilityTemplateManager'.default.PanickedName, 'AA_UnitIsPanicked');

	Template.AbilityTargetConditions.AddItem(ExcludeEffects);

	/*
	AddAPEffect = new class'X2Effect_GrantActionPoints';
	AddAPEffect.NumActionPoints = 1;
	AddAPEffect.PointType = class'X2CharacterTemplateManager'.default.StandardActionPoint;
	Template.AddTargetEffect(AddAPEffect);

	ReactionEffect = new class'X2Effect_RunBehaviorTree';
	ReactionEffect.BehaviorTreeName = 'TeleportAllyShooterTree';
	Template.AddTargetEffect(ReactionEffect);
	*/
}
//For whatever reason effects and unit value don't seem to be working
static function AddGrappledThisTurnEffect(X2AbilityTemplate Template)
{
	local AdditionalCooldownInfo CooldownInfo;
	CooldownInfo.AbilityName = 'TrackingShotMark';
	CooldownInfo.NumTurns = 1;

	Template.AbilityCooldown.AditionalAbilityCooldowns.AddItem(CooldownInfo);

}

	
static function UpdateSummon(X2AbilityTemplate Template)
{
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;

	//class'Helpers_LW'.static.RemoveAbilityShooterEffects(Template,'X2Effect_SetUnitValue');
	//class'Helpers_LW'.static.RemoveAbilityShooterConditions(Template, 'X2Condition_UnitValue');

	class'Helpers_LW'.static.RemoveAbilityShooterConditions(Template, 'X2Condition_BattleState');

	Template.BuildNewGameStateFn = class'X2Ability_LW_ChosenAbilities'.static.ChosenSummonFollowers_BuildGameState;
	Template.BuildVisualizationFn = class'X2Ability_LW_ChosenAbilities'.static.ChosenSummonFollowers_BuildVisualization;
}
//make assassin run to cover when she conceals herself
static function UpdateVanishingWind(X2AbilityTemplate Template)
{
	local X2Effect_GrantActionPoints AddAPEffect;
	local X2Effect_RunBehaviorTree ReactionEffect;

	AddAPEffect = new class'X2Effect_GrantActionPoints';
	AddAPEffect.NumActionPoints = 1;
	AddAPEffect.PointType = class'X2CharacterTemplateManager'.default.StandardActionPoint;
	Template.AddTargetEffect(AddAPEffect);

	ReactionEffect = new class'X2Effect_RunBehaviorTree';
	ReactionEffect.BehaviorTreeName = 'GenericScamperRoot';
	Template.AddTargetEffect(ReactionEffect);

}

static function MakeAbilityVisible(X2AbilityTemplate Template)
{
	local X2Effect_Persistent PersistentEffect;
	//  This is a dummy effect so that an icon shows up in the UI.
	PersistentEffect = new class'X2Effect_Persistent';
	PersistentEffect.BuildPersistentEffect(1, true, false);
	PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
	Template.AddTargetEffect(PersistentEffect);
}

static function UpdateChosenRegenerate(X2AbilityTemplate Template)
{
	local X2Effect_RegenerationPCT RegenerationEffect;

	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template, 'X2Effect_Regeneration');

	RegenerationEffect = new class'X2Effect_RegenerationPCT';
	RegenerationEffect.BuildPersistentEffect(1, true, true, false, eGameRule_PlayerTurnBegin);
	RegenerationEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage,,,Template.AbilitySourceName);
	RegenerationEffect.HealAmountPCT = default.CHOSEN_REGENERATION_HEAL_VALUE_PCT;
	Template.AddTargetEffect(RegenerationEffect);
}

static function ReworkHarborWave(X2AbilityTemplate Template)
{
	local X2Effect_ApplyHarborWaveDamage DamageEffect;


	Template.AbilityToHitCalc = new class'X2AbilityToHitCalc_DeadEye';

	class'Helpers_LW'.static.RemoveAbilityMultiTargetEffects(Template, 'X2Effect_Dazed');
	class'Helpers_LW'.static.RemoveAbilityMultiTargetEffects(Template, 'X2Effect_ApplyWeaponDamage');
	class'Helpers_LW'.static.RemoveAbilityMultiTargetEffects(Template, 'X2Effect_Knockback');

	DamageEffect = new class'X2Effect_ApplyHarborWaveDamage';
	DamageEffect.bIgnoreArmor = true;
	Template.AddMultiTargetEffect(DamageEffect);

	Template.DefaultSourceItemSlot = eInvSlot_SecondaryWeapon;
}

static function	MakeAbilityWorkWhenBurning(X2AbilityTemplate Template)
{
	local array<name>                       SkipExclusions;

	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);
}


static function AddDisablingShotEffect(X2AbilityTemplate Template)
{
	local X2Effect_DisableWeapon	DisableWeaponEffect;
	local X2Condition_AbilityProperty AbilityCondition;

	DisableWeaponEffect = new class'X2Effect_DisableWeapon';

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('Disabler');
	DisableWeaponEffect.TargetConditions.AddItem(AbilityCondition);

	Template.AddTargetEffect(DisableWeaponEffect);
	if(Template.DataName == 'FaceOff')
	{
		Template.AddMultiTargetEffect(DisableWeaponEffect);
	}
}

static function DisplayMindShieldPassive(X2AbilityTemplate Template)
{
	local X2Effect_DamageImmunity  DamageImmunity;
	local X2Effect TempEffect;

	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_mindshield";
	foreach Template.AbilityTargetEffects( TempEffect )
	{
		if ( X2Effect_DamageImmunity(TempEffect) != none )
		{
			DamageImmunity = X2Effect_DamageImmunity(TempEffect);
			DamageImmunity.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.LocLongDescription, Template.IconImage, true,, Template.AbilitySourceName);
		}
	}
}

static function X2Condition_WeaponCategory CreatePistolWeaponCatCondition()
{
	local X2Condition_WeaponCategory WeaponCatCondition;

	WeaponCatCondition = new class'X2Condition_WeaponCategory';
	WeaponCatCondition.WeaponCats = default.PISTOL_ABILITY_WEAPON_CATS;

	return WeaponCatCondition;
}

// Fixes Steady Hands so that it applies correctly at all times. The vanilla
// implementation has it occasionally applying when it shouldn't and not
// applying when it should.
static function FixSteadyHands(X2AbilityTemplate Template)
{
	local XMBEffect_ConditionalBonus StatChangeEffect;
	local X2Condition_UnitValue ValueCondition;
	local X2Condition_PlayerTurns TurnsCondition;
	local X2Effect_Persistent CurrEffect;
	local int i;

	StatChangeEffect = new class'XMBEffect_ConditionalBonus';
	StatChangeEffect.EffectName = 'SteadyHandsStatBoost';
	StatChangeEffect.AddToHitModifier(class'X2Ability_SharpshooterAbilitySet'.default.STEADYHANDS_AIM_BONUS, eHit_Success);
	StatChangeEffect.AddToHitModifier(class'X2Ability_SharpshooterAbilitySet'.default.STEADYHANDS_AIM_BONUS, eHit_Crit);

	//  this condition check guarantees the unit did not move last turn before allowing the bonus to be applied
	ValueCondition = new class'X2Condition_UnitValue';
	ValueCondition.AddCheckValue('MovesLastTurn', 0, eCheck_Exact);
	StatChangeEffect.AbilityShooterConditions.AddItem(ValueCondition);

	//  this condition guarantees the player has started more than 1 turn. the first turn of the game does not count for steady hands, as there was no "previous" turn.
	TurnsCondition = new class'X2Condition_PlayerTurns';
	TurnsCondition.NumTurnsCheck.CheckType = eCheck_GreaterThan;
	TurnsCondition.NumTurnsCheck.Value = 1;
	StatChangeEffect.AbilityShooterConditions.AddItem(TurnsCondition);

	StatChangeEffect.BuildPersistentEffect(1, true, false, false);
	StatChangeEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.LocHelpText, Template.IconImage, true,,Template.AbilitySourceName);
	StatChangeEffect.bHideWhenNotRelevant = true;

	// class'Helpers_LW'.static.RemoveAbilityShooterEffects(Template, 'X2Effect_Persistent', 'SteadyHands');
	Template.AddShooterEffect(StatChangeEffect);

	for (i = 0; i < Template.AbilityShooterEffects.Length; i++)
	{
		CurrEffect = X2Effect_Persistent(Template.AbilityShooterEffects[i]);
		if (CurrEffect.EffectName == 'SteadyHands')
		{
			// Clear the stat change bonus as it doesn't seem to work.
			CurrEffect.ApplyOnTick.Length = 0;
			break;
		}
	}
}

// Patches any multi-shot abilities that are configured in the
// MULTI_SHOT_ABILITIES config.
static function UpdateMultiShotAbility(X2AbilityTemplate Template)
{
	local MultiShotAbility AbilityData;
	local name AbilityName;
	local int i;

	foreach default.MULTI_SHOT_ABILITIES(AbilityData)
	{
		if (AbilityData.AbilityName == Template.DataName)
		{
			`LWTrace("Patching multi-shot primary ability '" $ AbilityData.AbilityName $ "'");
			PatchMultiShotFirstShot(Template);
			return;
		}
		else
		{
			foreach AbilityData.FollowUpAbilityNames(AbilityName, i)
			{
				if (AbilityName == Template.DataName)
				{
					if (i == AbilityData.FollowUpAbilityNames.Length - 1)
					{
						`LWTrace("Patching multi-shot final-shot ability '" $ AbilityData.AbilityName $ "'");
						PatchMultiShotFinalShot(Template, AbilityData.AbilityName);
						return;
					}
					else
					{
						`LWTrace("Patching multi-shot intermediate ability '" $ AbilityData.AbilityName $ "'");
						PatchMultiShotIntermediateShot(Template, AbilityData.AbilityName);
						return;
					}
				}
			}
		}
	}
}

static function PatchMultiShotFirstShot(X2AbilityTemplate Template)
{
	local X2Effect_SetUnitValue NewEffect;

	if (!default.USE_LOS_FOR_MULTI_SHOT_ABILITIES)
	{
		NewEffect = new class'X2Effect_SetUnitValue';
		NewEffect.UnitName = GetMultiShotContinueUnitValueName(Template.DataName);
		NewEffect.NewValueToSet = 1.0f;
		NewEffect.CleanupType = eCleanup_BeginTurn;
		NewEffect.bApplyOnMiss = true;
		Template.AddShooterEffect(NewEffect);
	}
}

static function PatchMultiShotIntermediateShot(X2AbilityTemplate Template, name FirstShotName)
{
	local X2Condition_UnitValue UnitValueCondition;
	local name UnitValueName;
	
	if (default.USE_LOS_FOR_MULTI_SHOT_ABILITIES)
	{
		Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	}
	else
	{
		UnitValueName = GetMultiShotContinueUnitValueName(FirstShotName);

		// Apply a condition that the first shot must have already been fired.
		UnitValueCondition = new class'X2Condition_UnitValue';
		UnitValueCondition.AddCheckValue(UnitValueName, 1.0f);
		Template.AbilityShooterConditions.AddItem(UnitValueCondition);
	}
}

static function PatchMultiShotFinalShot(X2AbilityTemplate Template, name FirstShotName)
{
	local X2Condition_UnitValue UnitValueCondition;
	local X2Effect_ClearUnitValue NewEffect;
	local name UnitValueName;
	
	if (default.USE_LOS_FOR_MULTI_SHOT_ABILITIES)
	{
		Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);
	}
	else
	{
		UnitValueName = GetMultiShotContinueUnitValueName(FirstShotName);

		// Apply a condition that the first shot must have already been fired.
		UnitValueCondition = new class'X2Condition_UnitValue';
		UnitValueCondition.AddCheckValue(UnitValueName, 1.0f);
		Template.AbilityShooterConditions.AddItem(UnitValueCondition);

		// Make sure the unit value is cleared so the follow up shots are no
		// longer available.
		NewEffect = new class'X2Effect_ClearUnitValue';
		NewEffect.UnitValueName = UnitValueName;
		NewEffect.bApplyOnMiss = true;
		Template.AddShooterEffect(NewEffect);
	}
}

static function name GetMultiShotContinueUnitValueName(name AbilityName)
{
	return name(AbilityName $ "Continue");
}
	

static function RemoveAbilityWeaponDamage(X2AbilityTemplate Template)
{
	local X2Effect_ApplyWeaponDamage  WeaponDamage;
	local X2Effect TempEffect;

	foreach Template.AbilityTargetEffects( TempEffect )
	{
		if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
		{
			WeaponDamage = X2Effect_ApplyWeaponDamage(TempEffect);
			WeaponDamage.EffectDamageValue = default.EMPTY_DAMAGE_VALUE;
		}
	}
	foreach Template.AbilityMultiTargetEffects( TempEffect )
	{
		if ( X2Effect_ApplyWeaponDamage(TempEffect) != none )
		{
			WeaponDamage = X2Effect_ApplyWeaponDamage(TempEffect);
			WeaponDamage.EffectDamageValue = default.EMPTY_DAMAGE_VALUE;
		}
	}
}

//Make Chryssalids not insta-ruin some missions when they appear
static function RemoveTargetingRandomCivilians(X2AbilityTemplate Template)
{
	local X2Effect TempEffect;
	local X2Condition_UnitProperty	UnitPropertyCondition;

	class 'Helpers_LW'.static.RemoveAbilityTargetConditions(Template,'X2Condition_UnitProperty');

	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	//UnitPropertyCondition.ExcludeFriendlyToSource = false; // Disable this to allow civilians to be attacked.
	UnitPropertyCondition.ExcludeSquadmates = true;		   // Don't attack other AI units.
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

}

static function MakeBindDamageScale(X2AbilityTemplate Template)
{
	local X2Condition_AbilityProperty	BindM2Condition, BindM3Condition,BindM4Condition,BindM5Condition, BindM6Condition;
	local X2Effect_ApplyWeaponDamage    PhysicalDamageEffect;


	BindM2Condition = new class 'X2Condition_AbilityProperty';
	BindM2Condition.OwnerHasSoldierAbilities.addItem('BindM2Damage');

	BindM3Condition = new class 'X2Condition_AbilityProperty';
	BindM3Condition.OwnerHasSoldierAbilities.addItem('BindM3Damage');

	BindM4Condition = new class 'X2Condition_AbilityProperty';
	BindM4Condition.OwnerHasSoldierAbilities.addItem('BindM4Damage');

	BindM5Condition = new class 'X2Condition_AbilityProperty';
	BindM5Condition.OwnerHasSoldierAbilities.addItem('BindM5Damage');

	BindM6Condition = new class 'X2Condition_AbilityProperty';
	BindM6Condition.OwnerHasSoldierAbilities.addItem('BindM6Damage');

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue.Damage = default.BIND_M2_BONUSDAMAGE;
	PhysicalDamageEffect.DamageTypes.AddItem('ViperCrush');
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	PhysicalDamageEffect.bIgnoreArmor = true;
	PhysicalDamageEffect.TargetConditions.AddItem(BindM2Condition);
	Template.AddTargetEffect(PhysicalDamageEffect);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue.Damage = default.BIND_M3_BONUSDAMAGE;
	PhysicalDamageEffect.DamageTypes.AddItem('ViperCrush');
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	PhysicalDamageEffect.bIgnoreArmor = true;
	PhysicalDamageEffect.TargetConditions.AddItem(BindM3Condition);
	Template.AddTargetEffect(PhysicalDamageEffect);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue.Damage = default.BIND_M4_BONUSDAMAGE;
	PhysicalDamageEffect.DamageTypes.AddItem('ViperCrush');
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	PhysicalDamageEffect.bIgnoreArmor = true;
	PhysicalDamageEffect.TargetConditions.AddItem(BindM4Condition);
	Template.AddTargetEffect(PhysicalDamageEffect);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue.Damage = default.BIND_M5_BONUSDAMAGE;
	PhysicalDamageEffect.DamageTypes.AddItem('ViperCrush');
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	PhysicalDamageEffect.bIgnoreArmor = true;
	PhysicalDamageEffect.TargetConditions.AddItem(BindM5Condition);
	Template.AddTargetEffect(PhysicalDamageEffect);

	PhysicalDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	PhysicalDamageEffect.EffectDamageValue.Damage = default.BIND_M6_BONUSDAMAGE;
	PhysicalDamageEffect.DamageTypes.AddItem('ViperCrush');
	PhysicalDamageEffect.EffectDamageValue.DamageType = 'Melee';
	PhysicalDamageEffect.bIgnoreArmor = true;
	PhysicalDamageEffect.TargetConditions.AddItem(BindM5Condition);
	Template.AddTargetEffect(PhysicalDamageEffect);

}

static function MakeMeleeBlueMove(X2AbilityTemplate Template)
{
	local X2AbilityTarget_MovingMelee			MeleeTarget;

	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	MeleeTarget.MovementRangeAdjustment = 1;
	Template.AbilityTargetStyle = MeleeTarget;
	Template.TargetingMethod = class'X2TargetingMethod_MeleePath';
}


static function AddSuperiorHolyWarrior(X2AbilityTemplate Template)
{
	local X2Condition_AbilityProperty	HolyWarriorCondition;
	local X2Effect_PersistentStatChange    HolyWarriorEffect;


	HolyWarriorCondition = new class 'X2Condition_AbilityProperty';
	HolyWarriorCondition.OwnerHasSoldierAbilities.addItem('SuperiorHolyWarrior');

	HolyWarriorEffect = new class'X2Effect_PersistentStatChange';
	HolyWarriorEffect.EffectName = 'SuperiorHolyWarrior';
	HolyWarriorEffect.DuplicateResponse = eDupe_Ignore;
	HolyWarriorEffect.BuildPersistentEffect(1, true, false, true);
	HolyWarriorEffect.bRemoveWhenTargetDies = true;
	HolyWarriorEffect.SetDisplayInfo(ePerkBuff_Bonus, Template.LocFriendlyName, Template.GetMyHelpText(), Template.IconImage);
	HolyWarriorEffect.AddPersistentStatChange(eStat_CritChance, 30);
	HolyWarriorEffect.TargetConditions.AddItem(HolyWarriorCondition);
	Template.AddTargetEffect(HolyWarriorEffect);


}

static function AddSharedSuppressionCooldown(X2AbilityTemplate Template)
{
	local X2AbilityCooldown_Suppression	Cooldown;

	Cooldown = new class'X2AbilityCooldown_Suppression';
	Cooldown.iNumTurns = 2;
	Cooldown.SharingCooldownsWith.AddItem('Suppression'); //Now shares the cooldown with Bayonet
	Cooldown.SharingCooldownsWith.AddItem('AreaSuppression'); //Now shares the cooldown with Bayonet
	Cooldown.SharingCooldownsWith.AddItem('BulletWizard'); //Now shares the cooldown with Bayonet
	Template.AbilityCooldown = Cooldown;
}

static function UpdateMedikits(X2AbilityTemplate Template)
{
	local X2AbilityCooldown_Shared	Cooldown;

	Cooldown = new class'X2AbilityCooldown_Shared';
	Cooldown.SharingCooldownsWith.AddItem('MedikitHeal');
	Cooldown.SharingCooldownsWith.AddItem('NanoMedikitHeal');
	Cooldown.SharingCooldownsWith.AddItem('MedikitStabilize');
	Cooldown.SharingCooldownsWith.AddItem('ParaMedikitStabilize');
	Cooldown.SharingCooldownsWith.AddItem('ParaMedikitHeal');

	if(X2AbilityTarget_Single(Template.AbilityTargetStyle) != none)
	{
		X2AbilityTarget_Single(Template.AbilityTargetStyle).bIncludeSelf = false;
	}
	

	Cooldown.iNumTurns = 1;
	Template.AbilityCooldown = Cooldown;
}


static function UpdateMedicalProtocol(X2AbilityTemplate Template)
{
	local X2AbilityCooldown_Shared	Cooldown;

	Cooldown = new class'X2AbilityCooldown_Shared';
	Cooldown.SharingCooldownsWith.AddItem('GremlinHeal');
	Cooldown.SharingCooldownsWith.AddItem('GremlinStabilize');

	// if(X2AbilityTarget_Single(Template.AbilityTargetStyle) != none)
	// {
	// 	X2AbilityTarget_Single(Template.AbilityTargetStyle).bIncludeSelf = false;
	// }
	Template.OverrideAbilities.Length = 0;

	Cooldown.iNumTurns = default.MEDICAL_PROTOCOL_COOLDOWN;
	Template.AbilityCooldown = Cooldown;
}


static function UpdateAidProtocol(X2AbilityTemplate Template)
{
	local X2AbilityCooldown_ABCProtocol 	Cooldown;
	local X2Condition_AbilityProperty AbilityCondition;
	local X2Effect_RemoveEffectsByDamageType RemoveEffects;
	local name HealType;
	local X2Effect_TriggerEvent	ThreatAssessmentEvent;
	Cooldown = new class'X2AbilityCooldown_ABCProtocol';
	Template.AbilityCooldown = Cooldown;

	RemoveEffects = new class'X2Effect_RemoveEffectsByDamageType';
	foreach class'X2Ability_XMBPerkAbilitySet'.default.AgentsHealEffectTypes(HealType)
	{
		RemoveEffects.DamageTypesToRemove.AddItem(HealType);
	}
	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('NeutralizingAgents_LW');
	RemoveEffects.TargetConditions.AddItem(AbilityCondition);

	Template.AssociatedPassives.AddItem('NeutralizingAgents_LW');
	Template.AddTargetEffect(RemoveEffects);

	//Add Threat assessment overwatch mark so it works


	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('ThreatAssessment');

	//Trigger the threat assessment ability which will properly mark the targets
	ThreatAssessmentEvent = new class'X2Effect_TriggerEvent';
	ThreatAssessmentEvent.TriggerEventName = 'ThreatAssessmentActivated';
	ThreatAssessmentEvent.TargetConditions.AddItem(AbilityCondition);
	Template.AddTargetEffect(ThreatAssessmentEvent);

}


static function UpdateCombatProtocol(X2AbilityTemplate Template)
{
	local X2AbilityCooldown_ABCProtocol 	Cooldown;
	local X2AbilityCost_ActionPoints ActionPointCost;


	Cooldown = new class'X2AbilityCooldown_ABCProtocol';
	Template.AbilityCooldown = Cooldown;

	Template.AbilityCharges = none;
	Template.AbilityCosts.Length = 0;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bConsumeAllPoints = false;
	Template.AbilityCosts.AddItem(ActionPointCost);
}


static function UpdateOverwatch(X2AbilityTemplate Template)
{
	local X2AbilityMultiTarget_AllUnits MultiTargetMark;
	local X2Condition_Visibility	VisibilityCondition;
	local X2Effect_OverwatchMark	OverwatchMark;
	local X2Condition_AnyEnemyVisible VisibleCondition;

	MultiTargetMark = new class'X2AbilityMultiTarget_AllUnits';
	MultiTargetMark.bAcceptEnemyUnits = true;
	Template.AbilityMultiTargetStyle = MultiTargetMark;

	VisibilityCondition = new class'X2Condition_Visibility';
	VisibilityCondition.bRequireGameplayVisible = true;
	if(Template.DataName == 'LongWatch' || Template.DataName == 'SniperRifleOverWatch')
	{
	VisibilityCondition.bAllowSquadsight = true;
	}
	Template.AbilityMultiTargetConditions.AddItem(VisibilityCondition);


	OverwatchMark =	new class'X2Effect_OverwatchMark';
	OverwatchMark.DuplicateResponse = eDupe_Allow;
	OverwatchMark.BuildPersistentEffect(1, false, , , eGameRule_PlayerTurnEnd);
	Template.AddMultiTargetEffect(OverwatchMark);

	Template.TargetingMethod = class'X2TargetingMethod_TopDown';

	VisibleCondition = new class'X2Condition_AnyEnemyVisible';
	Template.AbilityShooterConditions.AddItem(VisibleCondition);
	Template.AbilityConfirmSound = "";

	Template.BuildVisualizationFn = OverwatchAbility_BuildVisualization;
}

	
static simulated function OverwatchAbility_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local StateObjectReference          InteractingUnitRef;

	local VisualizationActionMetadata        EmptyTrack;
	local VisualizationActionMetadata        ActionMetadata;

	local X2Action_CameraFrameAbility FrameAction;
	local X2Action_PlaySoundAndFlyOver SoundAndFlyOver;
	local X2Action_CameraRemove RemoveCameraAction;
	local UnitValue EverVigilantValue;
	local XComGameState_Unit UnitState;
	local X2AbilityTemplate AbilityTemplate;
	local string FlyOverText, FlyOverImage;
	local XGUnit UnitVisualizer;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	UnitState = XComGameState_Unit(ActionMetadata.StateObject_NewState);

	// Only turn the camera on the overwatcher if it is visible to the local player.
	if( !`XENGINE.IsMultiPlayerGame() || class'X2TacticalVisibilityHelpers'.static.IsUnitVisibleToLocalPlayer(UnitState.ObjectID, VisualizeGameState.HistoryIndex) )
	{
		FrameAction = X2Action_CameraFrameAbility(class'X2Action_CameraFrameAbility'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));
		FrameAction.AbilitiesToFrame.AddItem(Context);
		FrameAction.CameraTag = 'OverwatchCamera';
	}
					
	if (UnitState != none && UnitState.GetUnitValue(class'X2Ability_SpecialistAbilitySet'.default.EverVigilantEffectName, EverVigilantValue) && EverVigilantValue.fValue > 0)
	{
		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate('EverVigilant');
		if (UnitState.HasSoldierAbility('CoveringFire'))
			FlyOverText = class'XLocalizedData'.default.EverVigilantWithCoveringFire;
		else
			FlyOverText = AbilityTemplate.LocFlyOverText;
		FlyOverImage = AbilityTemplate.IconImage;
	}
	else if (UnitState != none && UnitState.HasSoldierAbility('ReadyForAnything'))
	{
		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate('ReadyForAnything');
		FlyOverText = AbilityTemplate.LocFlyOverText;
		FlyOverImage = AbilityTemplate.IconImage;
	}
	else if (UnitState != none && UnitState.HasSoldierAbility('CoveringFire'))
	{
		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate('CoveringFire');
		FlyOverText = AbilityTemplate.LocFlyOverText;
		FlyOverImage = AbilityTemplate.IconImage;
	}
	else if (UnitState != none && UnitState.HasSoldierAbility('SkirmisherAmbush'))
	{
		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate('SkirmisherAmbush');
		FlyOverText = AbilityTemplate.LocFlyOverText;
		FlyOverImage = AbilityTemplate.IconImage;
	}
	else
	{
		AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(Context.InputContext.AbilityTemplateName);
		FlyOverText = AbilityTemplate.LocFlyOverText;
		FlyOverImage = AbilityTemplate.IconImage;
	}
	SoundAndFlyOver = X2Action_PlaySoundAndFlyOver(class'X2Action_PlaySoundAndFlyOver'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded));

	if (UnitState != none)
	{
		UnitVisualizer = XGUnit(UnitState.GetVisualizer());
		if( (UnitVisualizer != none) && !UnitVisualizer.IsMine())
		{
			SoundAndFlyOver.SetSoundAndFlyOverParameters(SoundCue'SoundUI.OverwatchCue', FlyOverText, 'Overwatch', eColor_Bad, FlyOverImage);
		}
		else
		{
			SoundAndFlyOver.SetSoundAndFlyOverParameters(SoundCue'SoundUI.OverwatchCue', FlyOverText, 'Overwatch', eColor_Good, FlyOverImage);
		}
	}

	if( FrameAction != none )
	{
		RemoveCameraAction = X2Action_CameraRemove(class'X2Action_CameraRemove'.static.AddToVisualizationTree(ActionMetaData, Context));
		RemoveCameraAction.CameraTagToRemove = 'OverwatchCamera';
	}

	//****************************************************************************************
}

	
static function UpdateLaunchGrenade(X2AbilityTemplate Template)
{
	local X2AbilityCost Cost;

	foreach Template.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_ActionPoints'))
		{
			X2AbilityCost_ActionPoints(Cost).DoNotConsumeAllSoldierAbilities.AddItem('TotalCombat');
		}
	}
}

static function ReworkMindSpin(X2AbilityTemplate Template)
{
	local X2Effect_MindControl MindControlEffect;
	local X2Effect_RemoveEffects MindControlRemoveEffects;
	local X2Condition_TargetHasOneOfTheEffects NeedOneOfTheEffects;
	local X2Condition_UnitEffects EffectsCondition;
	local X2Effect_Stunned StunnedEffect;
	local X2Effect_Panicked PanickedEffect;
	//Remove random mind control
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_MindControl');
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_RemoveEffects');
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_Persistent');
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_Panicked');


	EffectsCondition = new class'X2Condition_UnitEffects';
	EffectsCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.PanickedName, 'AA_AbilityUnavailable');
	EffectsCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.DisorientedName, 'AA_AbilityUnavailable');
	EffectsCondition.AddExcludeEffect(class'X2AbilityTemplateManager'.default.StunnedName, 'AA_AbilityUnavailable');
	EffectsCondition.AddExcludeEffect(class'X2Effect_MindControl'.default.EffectName, 'AA_AbilityUnavailable');



	NeedOneOfTheEffects = new class'X2Condition_TargetHasOneOfTheEffects';
	NeedOneOfTheEffects.EffectNames.AddItem(class'X2AbilityTemplateManager'.default.PanickedName);
	NeedOneOfTheEffects.EffectNames.AddItem(class'X2AbilityTemplateManager'.default.DisorientedName);
	NeedOneOfTheEffects.EffectNames.AddItem(class'X2AbilityTemplateManager'.default.StunnedName);


	MindControlEffect = class'X2StatusEffects'.static.CreateMindControlStatusEffect(class'X2Ability_Sectoid'.default.SECTOID_MINDSPIN_CONTROL_DURATION);
	MindControlEffect.TargetConditions.AddItem(NeedOneOfTheEffects);
	Template.AddTargetEffect(MindControlEffect);

	MindControlRemoveEffects = class'X2StatusEffects'.static.CreateMindControlRemoveEffects();
	MindControlRemoveEffects.DamageTypes.AddItem('Mental');
	MindControlRemoveEffects.TargetConditions.AddItem(NeedOneOfTheEffects);
	Template.AddTargetEffect(MindControlRemoveEffects);


	StunnedEffect = class'X2StatusEffects'.static.CreateStunnedStatusEffect(1,100);
	StunnedEffect.MinStatContestResult = 1;
	StunnedEffect.MaxStatContestResult = 2;
	StunnedEffect.TargetConditions.AddItem(EffectsCondition);
	Template.AddTargetEffect(StunnedEffect);

	PanickedEffect = class'X2StatusEffects'.static.CreatePanickedStatusEffect();
	PanickedEffect.MinStatContestResult = 3;
	PanickedEffect.MaxStatContestResult = 0;
	PanickedEffect.TargetConditions.AddItem(EffectsCondition);
	Template.AddTargetEffect(PanickedEffect);


}

static function GiveGLobalCooldownToPriestStasis(X2AbilityTemplate Template)
{
	local X2AbilityCooldown_LocalAndGlobal	Cooldown;

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = 3;
	Cooldown.NumGlobalTurns = 1;
	Template.AbilityCooldown = Cooldown;
}

static function UpdateReload(X2AbilityTemplate Template)
{
	local X2AbilityCost Cost;

	foreach Template.AbilityCosts(Cost)
	{
		if (Cost.IsA('X2AbilityCost_ActionPoints'))
		{
			X2AbilityCost_ActionPoints(Cost).bConsumeAllPoints = true;
			X2AbilityCost_ActionPoints(Cost).DoNotConsumeAllSoldierAbilities.AddItem('UnstoppableGunFire');
		}
	}
}

static function MakeMicroMissilesDestroyLoot(X2AbilityTemplate Template)
{
	local X2Effect Effect;

	foreach Template.AbilityMultiTargetEffects(Effect)
	{
		if (Effect.IsA('X2Effect_ApplyWeaponDamage'))
		{
			X2Effect_ApplyWeaponDamage(Effect).bExplosiveDamage = true;
		}
	}
}


static function MakeStunLanceWorkWhenBurning(X2AbilityTemplate Template)
{
	local array<name> SkipExclusions;

	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);
}

static function UpdateLeaderPunch(X2AbilityTemplate Template)
{
	local X2Effect_ApplyWeaponDamage DamageEffect;
	local X2AbilityTarget_MovingMelee	MeleeTarget;

	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_ImmediateAbilityActivation');
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_ApplyWeaponDamage');
	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_Persistent');

	DamageEffect = new class'X2Effect_ApplyWeaponDamage';
	Template.AddTargetEffect(DamageEffect);

	MeleeTarget = new class'X2AbilityTarget_MovingMelee';
	MeleeTarget.MovementRangeAdjustment = 1;
	Template.AbilityTargetStyle = MeleeTarget;


}

static function UpdateWaylay(X2AbilityTemplate Template)
{
	local X2Effect_Sentinel_LW PersistentEffect;

	PersistentEffect = new class'X2Effect_Sentinel_LW';
	PersistentEffect.BuildPersistentEffect(1, true, false);
	PersistentEffect.SetDisplayInfo(ePerkBuff_Passive, Template.LocFriendlyName, Template.GetMyLongDescription(), Template.IconImage, false,, Template.AbilitySourceName);
	Template.AddTargetEffect(PersistentEffect);
}

static function AddRipjackRuptureEffects(X2AbilityTemplate Template)
{
//	local X2AbilityTemplateManager							AbilityTemplateMgr;
//	local array<X2AbilityTemplate>							AbilityTemplateArray;
	//local X2AbilityTemplate									AbilityTemplate;
	local X2Effect_ApplyWeaponDamage						RuptureEffect;
	local X2Condition_RipAndTearRupture_LW			HeatValueCondition;
	local X2Condition_UnitProperty							OrganicTargetCondition;
	local X2Condition_AbilityProperty	AbilityCondition;
	// EffectCondition = new class'X2Condition_WOTC_APA_EffectRequirement';
	// EffectCondition.RequiredEffectNames.AddItem('WOTC_APA_RipAndTearShredEffect');
	// EffectCondition.bCheckSourceUnit = true;

	AbilityCondition = new class'X2Condition_AbilityProperty';
	AbilityCondition.OwnerHasSoldierAbilities.AddItem('RipAndTear_LW');
	//Effect.TargetConditions.AddItem(AbilityCondition);

	HeatValueCondition = new class'X2Condition_RipAndTearRupture_LW';

	OrganicTargetCondition = new class'X2Condition_UnitProperty';
	OrganicTargetCondition.ExcludeRobotic = true;
	OrganicTargetCondition.ExcludeOrganic = false;
	OrganicTargetCondition.FailOnNonUnits = true;

	RuptureEffect = new class'X2Effect_ApplyWeaponDamage';
	RuptureEffect.bIgnoreBaseDamage = true;
	RuptureEffect.EffectDamageValue.Rupture = class'X2Ability_SkirmisherAbilitySet_LW'.default.RIP_AND_TEAR_RUPTURE;
	RuptureEffect.TargetConditions.AddItem(AbilityCondition);
	RuptureEffect.TargetConditions.AddItem(HeatValueCondition);
	RuptureEffect.TargetConditions.AddItem(OrganicTargetCondition);


	//Make the justice/wrath attack not a guaranteed hit for the LULZ and better damage preview
	X2AbilityToHitCalc_StandardAim(Template.AbilityToHitCalc).bGuaranteedHit = false;

	Template.AddTargetEffect(RuptureEffect);
}


// static function ReworkChryssalidSpawning(X2AbilityTemplate Template)
// {
// 	local X2Effect_TheLostHeadshot				HeadshotEffect;
// 	local X2Condition_HeadshotEnabled           HeadshotCondition;
// 	local int									i;

// 	class'Helpers_LW'.static.RemoveAbilityTargetEffects(Template,'X2Effect_SpawnChryssalid');
// 	Template.AddTargetEffect(new class'X2Effect_SpawnChryssalid_LW');
// }


defaultproperties
{
	AbilityTemplateModFn=UpdateAbilities

	Begin Object Class=X2Condition_Visibility Name=DefaultGameplayVisibilityCondition
		bRequireGameplayVisible=true
		bRequireBasicVisibility=true
	End Object
	GameplayVisibilityCondition = DefaultGameplayVisibilityCondition;
}
