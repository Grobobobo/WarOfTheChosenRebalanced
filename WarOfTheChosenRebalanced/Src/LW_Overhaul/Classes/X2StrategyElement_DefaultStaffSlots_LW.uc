//---------------------------------------------------------------------------------------
//  FILE:    X2StrategyElement_DefaultStaffSlots_LW.uc
//  AUTHOR:  tracktwo / Pavonis Interactive
//  PURPOSE: New staff slot templates for LW Overhaul
//---------------------------------------------------------------------------------------

class X2StrategyElement_DefaultStaffSlots_LW extends X2StrategyElement;

var localized string m_strLiaisonLocation;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2DataTemplate> StaffSlots;

	`LWTrace("  >> X2StrategyElement_DefaultStaffSlots_LW.CreateTemplates()");
	
    //StaffSlots.AddItem(CreateOutpostScientistStaffSlot());
    StaffSlots.AddItem(CreateCovertActionIntenseTrainingStaffSlotTemplate());

	// This is bad organization; these are really facility upgrades but I didn't want to make a new class
	StaffSlots.AddItem(CreateLaboratory_AdditionalResearchStation2Template());
	StaffSlots.AddItem(CreateLaboratory_AdditionalResearchStation3Template());

    return StaffSlots;
}


static function X2DataTemplate CreateCovertActionIntenseTrainingStaffSlotTemplate()
{
	local X2StaffSlotTemplate Template;

	Template = class'X2StrategyElement_XpackStaffSlots'.static.CreateCovertActionSoldierStaffSlotTemplate('CovertActionIntenseTrainingStaffSlot');
	Template.IsUnitValidForSlotFn = IsUnitValidForCovertActionIntenseTrainingSlot;

	return Template;
}

static function bool IsUnitValidForCovertActionIntenseTrainingSlot(XComGameState_StaffSlot SlotState, StaffUnitInfo UnitInfo)
{
	local XComGameState_Unit Unit;
	local UnitValue UnitValue;

	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitInfo.UnitRef.ObjectID));
	Unit.GetUnitValue('CAIntenseTrainingCount', UnitValue);

	if (UnitValue.fValue >= 2)
	{
		// Unit has already been on the maximum number of allowed Intense
		// Training covert actions.
		return false;
	}

	return class'X2StrategyElement_XpackStaffSlots'.static.IsUnitValidForCovertActionSoldierSlot(SlotState, UnitInfo);
}

static function X2DataTemplate CreateLaboratory_AdditionalResearchStation2Template()
{
    local X2FacilityUpgradeTemplate Template;
    local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'Laboratory_AdditionalResearchStation2');
    Template.PointsToComplete = 0;
    Template.MaxBuild = 1;
    Template.strImage = "img:///UILibrary_StrategyImages.FacilityIcons.ChooseFacility_Laboratory_AdditionalResearchStation";
    Template.OnUpgradeAddedFn = class'X2StrategyElement_DefaultFacilityUpgrades'.static.OnUpgradeAdded_UnlockStaffSlot;
    Template.iPower = -3;
    Template.UpkeepCost = 40;
    Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = 125;
    Template.Cost.ResourceCosts.AddItem(Resources);
    return Template;
}

static function X2DataTemplate CreateLaboratory_AdditionalResearchStation3Template()
{
    local X2FacilityUpgradeTemplate Template;
    local ArtifactCost Resources;

	`CREATE_X2TEMPLATE(class'X2FacilityUpgradeTemplate', Template, 'Laboratory_AdditionalResearchStation3');
    Template.PointsToComplete = 0;
    Template.MaxBuild = 1;
    Template.strImage = "img:///UILibrary_StrategyImages.FacilityIcons.ChooseFacility_Laboratory_AdditionalResearchStation";
    Template.OnUpgradeAddedFn = class'X2StrategyElement_DefaultFacilityUpgrades'.static.OnUpgradeAdded_UnlockStaffSlot;
    Template.iPower = -3;
    Template.UpkeepCost = 40;
    Resources.ItemTemplateName = 'Supplies';
    Resources.Quantity = 125;
    Template.Cost.ResourceCosts.AddItem(Resources);
    return Template;
}