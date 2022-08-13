class LW_GotchaAgain_IntegratedSettings extends UIScreenListener config(LW_GotchaAgain_IntegratedSettings);

var config int iVersion;

var config bool bShowSquadsightHackingIndicator;
var config bool bShowFriendlyLOSIndicators;
var config bool bShowVIPSpottedByEnemyIndicators;
var config bool bShowLoneWolfIndicator;

var config string sIconPack;
var config bool bShowTowerHackingArrows;
var config bool bHideTowerArrowsAfterHacking;

var config bool bShowRemoteDoorHackingIndicators;

var config bool bShowLOSIndicatorsForGrappleDestinations;
var config bool bDisableHideObjectiveArrowsWhenUsingGrapple;
var config bool bDisableDimHostileUnitFlagsWhenUsingGrapple;

var config bool bUseCustomPathIndicatorSystem;
var config bool bShowOverwatchTriggers;
var config bool bShowOverwatchTriggerForSuppression;
var config bool bShowActivationTriggers;
var config bool bShowNoiseIndicators;
var config bool bShowSmokeIndicator;
var config bool bShowPsiBombIndicator;
var config bool bShowHuntersMarkIndicator;

var config bool bAlwaysShowPodActivation;

var int CurrentGameMode;

var private array<string> AvailableIconPacks;

event OnInit(UIScreen Screen) {
    if(iVersion < class'LW_GotchaAgain_IntegratedDefaultSettings'.default.iVersion) {
        LoadDefaultSettings();
    }

    if(MCM_API(Screen) != none) {
        MCM_API(Screen).RegisterClientMod(1, 0, ClientModCallback);
	}
}


simulated function ClientModCallback(MCM_API_Instance ConfigAPI, int GameMode) {
    local MCM_API_SettingsPage Page;
    local MCM_API_SettingsGroup Group;

    CurrentGameMode = GameMode;
    
    Page = ConfigAPI.NewSettingsPage("Gotcha Again");
    Page.SetPageTitle("Gotcha Again");
    Page.SetSaveHandler(SaveButtonClicked);

    Group = Page.AddGroup('UnitIndicatorSettings', "Unit Indicators");
    Group.AddCheckbox('bShowSquadsightHackingIndicator', "Show hacking indicators in squadsight", "Show hacking indicators for units with Gremlin abilities for units with clear LOS outside regular sightrange.", bShowSquadsightHackingIndicator, CheckboxSaveHandler);
    Group.AddCheckbox('bShowFriendlyLOSIndicators', "Show friendly LOS indicators", "Show LOS indicators towards friendly units.", bShowFriendlyLOSIndicators, CheckboxSaveHandler);
    Group.AddCheckbox('bShowVIPSpottedByEnemyIndicators', "Show VIP spotted by enemy indicators", "Show indicators for enemies that will spot a VIP being moved.", bShowVIPSpottedByEnemyIndicators, CheckboxSaveHandler);
    Group.AddCheckbox('bShowLoneWolfIndicator', "Show Lone Wolf indicator", "Show indicator on the moving units unitflag if Lone Wolf will be active at destination. Requires Long War 2.", bShowLoneWolfIndicator, CheckboxSaveHandler);

    Group = Page.AddGroup('ObjectiveIndicatorSettings', "Objective Indicators");
    Group.AddDropdown('sIconPack', "IconPack", "Select the icon pack to use for objective indicators.", AvailableIconPacks, sIconPack, DropDownSaveHandler);
    Group.AddCheckbox('bShowTowerHackingArrows', "Create ADVENT Tower indicators", "Create objective indicators when an ADVENT tower is discovered, for indicating when hacking it is possible. Changing this will not fully take effect until the next tactical game.", bShowTowerHackingArrows, CheckboxSaveHandler, CheckboxChangeHandler);
    Group.AddCheckbox('bHideTowerArrowsAfterHacking', "Hide Tower indicators after hacking", "Remove the ADVENT tower indicators completely after they have been hacked instead of indicating hacking is no longer possible. Changing this will not fully take effect until the next tactical game.", bHideTowerArrowsAfterHacking, CheckboxSaveHandler);
    if(!bShowTowerHackingArrows) {
        Group.GetSettingByName('bHideTowerArrowsAfterHacking').SetEditable(false);
    }

    Group = Page.AddGroup('DoorHackingIndicatorSettings', "Door Hacking Indicators");
    Group.AddCheckbox('bShowRemoteDoorHackingIndicators', "Show indicator for remote hacking of doors", "Shows the door hacking indicator for positions where hacking is possible using the Gremlin", bShowRemoteDoorHackingIndicators, CheckboxSaveHandler);

    Group = Page.AddGroup('GrappleSettings', "Indicators when selecting Grapple Destination");
    Group.AddCheckbox('bShowLOSIndicatorsForGrappleDestinations', "Show indicators when using Grapple", "Show the LOS indicators when selecting a destination for the Grapple ability.", bShowLOSIndicatorsForGrappleDestinations, CheckboxSaveHandler, CheckboxChangeHandler);
    Group.AddCheckbox('bDisableHideObjectiveArrowsWhenUsingGrapple', "Disable hiding objective indicators", "Disable hiding of objective indicators when using Grapple.", bDisableHideObjectiveArrowsWhenUsingGrapple, CheckboxSaveHandler);
    Group.AddCheckbox('bDisableDimHostileUnitFlagsWhenUsingGrapple', "Disable dimming of unitflags", "Disable the dimming of hostile unitflags when using Grapple.", bDisableDimHostileUnitFlagsWhenUsingGrapple, CheckboxSaveHandler);
    if(!bShowLOSIndicatorsForGrappleDestinations) {
        Group.GetSettingByName('bDisableHideObjectiveArrowsWhenUsingGrapple').SetEditable(false);
        Group.GetSettingByName('bDisableDimHostileUnitFlagsWhenUsingGrapple').SetEditable(false);
    }
    
    Group = Page.AddGroup('PathingIndicators', "Indicators along movement path");
    Group.AddCheckbox('bUseCustomPathIndicatorSystem', "Use custom path indicator system", "Use the custom Gotcha Again path indicator system instead of the native one. This is required to show the various new indicators along the movement path.", bUseCustomPathIndicatorSystem, CheckboxSaveHandler, CheckboxChangeHandler);
    Group.AddCheckbox('bShowOverwatchTriggers', "Show Overwatch-trigger indicators", "Show indicators when an overwatch will be triggered.", bShowOverwatchTriggers, CheckboxSaveHandler, CheckboxChangeHandler);
    Group.AddCheckbox('bShowOverwatchTriggerForSuppression', "Show Overwatch indicators for suppression", "Show overwatch indicator for running a suppression.", bShowOverwatchTriggerForSuppression, CheckboxSaveHandler);
    Group.AddCheckbox('bShowActivationTriggers', "Show Pod Activation-trigger indicators", "Show indicators when an unactivated pod will be activated.", bShowActivationTriggers, CheckboxSaveHandler);
    Group.AddCheckbox('bShowNoiseIndicators', "Show Noise indicators", "Show indicators along the movement path where noise will be generated by breaking windows or kicking in doors.", bShowNoiseIndicators, CheckboxSaveHandler);
    Group.AddCheckbox('bShowSmokeIndicator', "Show Smoke indicators", "Show an indicator at the final tile if it is covered by smoke that offers defensive bonusses.", bShowSmokeIndicator, CheckboxSaveHandler);
    Group.AddCheckbox('bShowPsiBombIndicator', "Show PsiBomb indicators", "Show an indicator at the final tile if it is within the AOE of an active PsiBomb.", bShowPsiBombIndicator, CheckboxSaveHandler);
	Group.AddCheckbox('bShowHuntersMarkIndicator', "Show Hunter's Mark indicators", "Show an indicator at the final tile if it is targeted by Hunter's Mark.", bShowHuntersMarkIndicator, CheckboxSaveHandler);
    if(!bUseCustomPathIndicatorSystem) {
        Group.GetSettingByName('bShowOverwatchTriggers').SetEditable(false);
        Group.GetSettingByName('bShowOverwatchTriggerForSuppression').SetEditable(false);
        Group.GetSettingByName('bShowActivationTriggers').SetEditable(false);
        Group.GetSettingByName('bShowNoiseIndicators').SetEditable(false);
        Group.GetSettingByName('bShowSmokeIndicator').SetEditable(false);
        Group.GetSettingByName('bShowPsiBombIndicator').SetEditable(false);
		Group.GetSettingByName('bShowHuntersMarkIndicator').SetEditable(false);
    } else if(!bShowOverwatchTriggers) {
        Group.GetSettingByName('bShowOverwatchTriggerForSuppression').SetEditable(false);
    }

	Group = Page.AddGroup('Cheats', "CHEATS");
    Group.AddCheckbox('bAlwaysShowPodActivation', "Unrevealed Pod Activation indicator", "Always show pod activation indicator even for unrevealed enemies.", bAlwaysShowPodActivation, CheckboxSaveHandler, CheckboxChangeHandler);

    Page.ShowSettings();
}

simulated function CheckboxChangeHandler(MCM_API_Setting _Setting, bool _SettingValue) {
    switch(_Setting.GetName()) {
        case 'bShowTowerHackingArrows':
            _Setting.GetParentGroup().GetSettingByName('bHideTowerArrowsAfterHacking').SetEditable(_SettingValue);
            break;
        case 'bShowLOSIndicatorsForGrappleDestinations':
            _Setting.GetParentGroup().GetSettingByName('bDisableHideObjectiveArrowsWhenUsingGrapple').SetEditable(_SettingValue);
            _Setting.GetParentGroup().GetSettingByName('bDisableDimHostileUnitFlagsWhenUsingGrapple').SetEditable(_SettingValue);
            break;
        case 'bUseCustomPathIndicatorSystem':
            _Setting.GetParentGroup().GetSettingByName('bShowOverwatchTriggers').SetEditable(_SettingValue);
            _Setting.GetParentGroup().GetSettingByName('bShowOverwatchTriggerForSuppression').SetEditable(bShowOverwatchTriggers);
            _Setting.GetParentGroup().GetSettingByName('bShowActivationTriggers').SetEditable(_SettingValue);
            _Setting.GetParentGroup().GetSettingByName('bShowNoiseIndicators').SetEditable(_SettingValue);
            _Setting.GetParentGroup().GetSettingByName('bShowSmokeIndicator').SetEditable(_SettingValue);
            _Setting.GetParentGroup().GetSettingByName('bShowPsiBombIndicator').SetEditable(_SettingValue);
			_Setting.GetParentGroup().GetSettingByName('bShowHuntersMarkIndicator').SetEditable(_SettingValue);
            break;
        case 'bShowOverwatchTriggers':
            _Setting.GetParentGroup().GetSettingByName('bShowOverwatchTriggerForSuppression').SetEditable(_SettingValue);
            break;
    }
}

simulated function CheckboxSaveHandler(MCM_API_Setting _Setting, bool _SettingValue) {
    switch(_Setting.GetName()) {
        case 'bShowSquadsightHackingIndicator':             bShowSquadsightHackingIndicator = _SettingValue; break;
        case 'bShowFriendlyLOSIndicators':                  bShowFriendlyLOSIndicators = _SettingValue; break;
        case 'bShowVIPSpottedByEnemyIndicators':            bShowVIPSpottedByEnemyIndicators = _SettingValue; break;
        case 'bShowLoneWolfIndicator':                      bShowLoneWolfIndicator = _SettingValue; break;
        
        case 'bShowTowerHackingArrows':                     bShowTowerHackingArrows = _SettingValue; break;
        case 'bHideTowerArrowsAfterHacking':                bHideTowerArrowsAfterHacking = _SettingValue; break;
        
        case 'bShowRemoteDoorHackingIndicators':            bShowRemoteDoorHackingIndicators = _SettingValue; break;

        case 'bShowLOSIndicatorsForGrappleDestinations':    bShowLOSIndicatorsForGrappleDestinations = _SettingValue; break;
        case 'bDisableHideObjectiveArrowsWhenUsingGrapple': bDisableHideObjectiveArrowsWhenUsingGrapple = _SettingValue; break;
        case 'bDisableDimHostileUnitFlagsWhenUsingGrapple': bDisableDimHostileUnitFlagsWhenUsingGrapple = _SettingValue; break;
        
        case 'bUseCustomPathIndicatorSystem':               bUseCustomPathIndicatorSystem = _SettingValue; break;
        case 'bShowOverwatchTriggers':                      bShowOverwatchTriggers = _SettingValue; break;
        case 'bShowOverwatchTriggerForSuppression':         bShowOverwatchTriggerForSuppression = _SettingValue; break;
        case 'bShowActivationTriggers':                     bShowActivationTriggers = _SettingValue; break;
        case 'bShowNoiseIndicators':                        bShowNoiseIndicators = _SettingValue; break;
        case 'bShowSmokeIndicator':                         bShowSmokeIndicator = _SettingValue; break;
        case 'bShowPsiBombIndicator':                       bShowPsiBombIndicator = _SettingValue; break;
        case 'bShowHuntersMarkIndicator':                   bShowHuntersMarkIndicator = _SettingValue; break;

		case 'bAlwaysShowPodActivation':					bAlwaysShowPodActivation = _SettingValue; break;
    }
}

simulated function DropDownSaveHandler(MCM_API_Setting _Setting, string _SettingValue) {
    local IconPack_GA newIconPack;

    switch(_Setting.GetName()) {
        case 'sIconPack':
            sIconPack = _SettingValue;
            if(CurrentGameMode == eGameMode_Tactical) {
                newIconPack = class'IconPack_GA'.static.LoadIconPack();
                UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).SwitchIconPack(newIconPack);
            }
            break;
    }
}


simulated function SaveButtonClicked(MCM_API_SettingsPage Page) {
    local UIUnitFlagManager_GA UIUnitFlagManager;

    if(CurrentGameMode == eGameMode_Tactical) {
        UIUnitFlagManager = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager);
        // Clear all indicators before saving to prevent stuff sticking around and not being updated because the setting was turned off
        UIUnitFlagManager.ClearLOSIndicators(true);
        ClearDefaultWaypointMarkers();
        
        // Destroy existing doorhacking indicators if they were turned off since they prevent the regular ones from showing up!
        if(!bShowRemoteDoorHackingIndicators) {
            UIUnitFlagManager.ObjectiveIndicatorUtility.CacheUtility.DestroyAllDoorHackingIndicators();
        }
    }

    self.SaveConfig();
}


private static function LoadDefaultSettings() {
    // Append added settings in later versions as additional cases (using the latest version they were NOT included in) and use fallthrough to collect all the needed updates
    // Remember to include all versions here from 135, where MCM was introduced, and on (excluding the latest) even though no new options were added
    switch(default.iVersion) {
        case 0:
            default.bShowSquadsightHackingIndicator             = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowSquadsightHackingIndicator;
            default.bShowFriendlyLOSIndicators                  = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowFriendlyLOSIndicators;
            default.bShowVIPSpottedByEnemyIndicators            = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowVIPSpottedByEnemyIndicators;
            default.bShowLoneWolfIndicator                      = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowLoneWolfIndicator;

            default.sIconPack                                   = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.sIconPack;
            default.bShowTowerHackingArrows                     = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowTowerHackingArrows;
            default.bHideTowerArrowsAfterHacking                = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bHideTowerArrowsAfterHacking;

            default.bShowLOSIndicatorsForGrappleDestinations    = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowLOSIndicatorsForGrappleDestinations;
            default.bDisableHideObjectiveArrowsWhenUsingGrapple = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bDisableHideObjectiveArrowsWhenUsingGrapple;
            default.bDisableDimHostileUnitFlagsWhenUsingGrapple = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bDisableDimHostileUnitFlagsWhenUsingGrapple;

            default.bUseCustomPathIndicatorSystem               = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bUseCustomPathIndicatorSystem;
            default.bShowOverwatchTriggers                      = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowOverwatchTriggers;
            default.bShowActivationTriggers                     = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowActivationTriggers;
            default.bShowNoiseIndicators                        = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowNoiseIndicators;
            default.bShowSmokeIndicator                         = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowSmokeIndicator;
            default.bShowPsiBombIndicator                       = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowPsiBombIndicator;
        case 135:
        case 136:
            default.bShowRemoteDoorHackingIndicators            = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowRemoteDoorHackingIndicators;
        case 137:
            default.bShowOverwatchTriggerForSuppression         = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowOverwatchTriggerForSuppression;
        case 138:
		case 139:
		case 140:
			default.bShowHuntersMarkIndicator                   = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bShowHuntersMarkIndicator;
		case 141:
			default.bAlwaysShowPodActivation					= class'LW_GotchaAgain_IntegratedDefaultSettings'.default.bAlwaysShowPodActivation;
    }
    default.iVersion = class'LW_GotchaAgain_IntegratedDefaultSettings'.default.iVersion;
    StaticSaveConfig();
}


// In case default waypoint markers have been created and the settings are switched to use the custom system we need to clear these to avoid persisting markers.
private static function ClearDefaultWaypointMarkers() {
    local XComPathingPawn PathingPawn;
    local int i;

    PathingPawn = XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).m_kPathingPawn;
    for(i = 0; i < PathingPawn.WaypointMeshPool.Length; i++) {
        PathingPawn.WaypointMeshPool[i].FadeOut();
    }
}


defaultproperties
{
    ScreenClass = none;
    AvailableIconPacks = ("lewe1","lewe2","lewe3","lewe4","lewe5","vhs0","vhs1","vhs2")
}