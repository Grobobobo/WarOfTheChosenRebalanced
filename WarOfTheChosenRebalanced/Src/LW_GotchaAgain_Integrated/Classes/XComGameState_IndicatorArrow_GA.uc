class XComGameState_IndicatorArrow_GA extends XComGameState_IndicatorArrow;

var UISpecialMissionHUD_Arrows_GA ArrowManager;
var EIndicatorValue CurrentIndicatorValue;
var EIconSetIdentifier IconSetIdentifier;

// Creates an arrow pointing to the specified unit
static function XComGameState_IndicatorArrow CreateArrowPointingAtUnit(XComGameState_Unit InUnit, 
                                                                       optional float InOffset = 128, 
                                                                       optional EUIState InColor = eUIState_Normal,
                                                                       optional int InCounterValue = -1,
                                                                       optional string InIcon = "") {
    local XComGameState_IndicatorArrow_GA CreatedArrow;
    
    // Replace wrong HostileVIP icon with one from the iconpack loaded
    if (InUnit.GetMyTemplateName() == 'HostileVIPCivilian' && InUnit.GetMyTemplate().bIsHostileCivilian) {
        InIcon = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetIconPack().GetIconSet(eKillVIP).DefaultIcon;
    }

    CreatedArrow = XComGameState_IndicatorArrow_GA(super.CreateArrowPointingAtUnit(InUnit, InOffset, InColor, InCounterValue, InIcon));
    CreatedArrow.IconSetIdentifier = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetIconPack().IdentifyIconSet(CreatedArrow);
    return CreatedArrow;
}


// Creates an arrow pointing to the specified location
static function XComGameState_IndicatorArrow CreateArrowPointingAtLocation(vector InLocation, 
                                                                           optional float InOffset = 128, 
                                                                           optional EUIState InColor = eUIState_Normal,
                                                                           optional int InCounterValue = -1,
                                                                           optional string InIcon = "") {
    local XComGameState_IndicatorArrow_GA CreatedArrow;
    
    // Replace some more icons with icons from the iconpack used
    // This might replace with the exact same icon if the iconset doesn't replace this icon... doesn't matter
    switch (InIcon) {
        case "img:///UILibrary_Common.Objective_DestroyAlienFacility":            
            InIcon = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetIconPack().GetIconSet(eDestroyAlienFacility).DefaultIcon;
            break;
        case "img:///UILibrary_Common.Objective_HackWorkstation":
            InIcon = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetIconPack().GetIconSet(eHackWorkstation).DefaultIcon;
            
            // Fix for incorrect placement of objective arrow pointing at the elevator computer in Shen's Last Gift
            if(XComTacticalMissionManager(class'Engine'.static.GetEngine().GetTacticalMissionManager()).ActiveMission.MissionName == 'LastGift') {
                InLocation.Z -= 2 * class'XComWorldData'.const.WORLD_FloorHeight;
                InOffSet += 2 * class'XComWorldData'.const.WORLD_FloorHeight;
            }
            break;
        case "img:///UILibrary_Common.Objective_UFO":
            InIcon = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetIconPack().GetIconSet(eHackUFO).DefaultIcon;
            break;
        case "img:///UILibrary_Common.Objective_Broadcast":
            InIcon = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetIconPack().GetIconSet(eHackBroadcast).DefaultIcon;
            break;
        case "img:///UILibrary_Common.Objective_RecoverItem":
            InIcon = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetIconPack().GetIconSet(eRecoverItem).DefaultIcon;
            break;
    }

	CreatedArrow = XComGameState_IndicatorArrow_GA(super.CreateArrowPointingAtLocation(InLocation, InOffset, InColor, InCounterValue, InIcon));
    CreatedArrow.IconSetIdentifier = UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetIconPack().IdentifyIconSet(CreatedArrow);
    return CreatedArrow;
}


public function SetIcon(IconPack_GA IconPack, EIndicatorValue IndicatorValue, optional bool ForceSet = False) {
    local vector ArrowOffset;

    if(IndicatorValue != CurrentIndicatorValue || ForceSet) {
        if(IconSetIdentifier == eNoIconSet) {
            if(!ForceSet) `log("Gotcha Again: Error! Attempted to change icon of unknown IndicatorArrow! Current: " $ Icon $ ", Parameters: " $ IconPack $ ", " $ IndicatorValue);
            return;
        }

        CurrentIndicatorValue = IndicatorValue;
        ArrowOffset.Z = Offset;
        if (PointsToUnit()) {
            GetArrowManager().AddArrowPointingAtActor(class'XComGameStateHistory'.static.GetGameStateHistory().GetVisualizer(Unit.ObjectID), ArrowOffset, ArrowColor, CounterValue, IconPack.GetIconFromIconSet(IconSetIdentifier, IndicatorValue));
        } else if(IconSetIdentifier == eHackAdventTower && IndicatorValue == eAlreadyHacked) {
            // We want the already-hacked icon to be permanent, so we save the icon-path to the object so it will persist across savegames
            Icon = IconPack.GetIconFromIconSet(IconSetIdentifier, IndicatorValue);
            GetArrowManager().AddArrowPointingAtLocation(Location, ArrowOffset, ArrowColor, CounterValue, Icon);
        } else {
            GetArrowManager().AddArrowPointingAtLocation(Location, ArrowOffset, ArrowColor, CounterValue, IconPack.GetIconFromIconSet(IconSetIdentifier, IndicatorValue));
        }
    }
}


public function bool IsTowerIndicatorArrow() {
    return IconSetIdentifier == eHackAdventTower;
}


// If a tactical save is loaded, the ArrowManager refered to by the class property is not valid anymore and will be none
private function UISpecialMissionHUD_Arrows_GA GetArrowManager() {
    if(ArrowManager == none) {
        ArrowManager = UISpecialMissionHUD_Arrows_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).GetSpecialMissionHUD().GetChildByName('arrowContainer'));
    }
    return ArrowManager;
}