class UIUnitFlagManager_GA extends UIUnitFlagManager;

var privatewrite IconPack_GA LoadedIconPack;
var privatewrite CacheUtility_GA CacheUtilityInstance;
var privatewrite LOSUtility_GA LOSUtilityInstance;
var privatewrite UnitIndicatorUtility_GA UnitIndicatorUtility;
var privatewrite ObjectiveIndicatorUtility_GA ObjectiveIndicatorUtility;
var privatewrite PathIndicatorUtility_GA PathIndicatorUtility;

var protected XComGameState_Unit ControlledUnit;
var protected int ControlledUnitSightRange;
var protected bool bControlledUnitIsVIP;

var protected bool bLongWar2Detected;

var bool GrappleIsActive;

simulated function OnInit() {
    local Object ThisObj;

    super.OnInit();

    LoadedIconPack = class'IconPack_GA'.static.LoadIconPack();

    CacheUtilityInstance = new(self) class'CacheUtility_GA';
    CacheUtilityInstance.Init(LoadedIconPack);

    LOSUtilityInstance = new(self) class'LOSUtility_GA';

    UnitIndicatorUtility = new(self) class'UnitIndicatorUtility_GA';
    UnitIndicatorUtility.Init(CacheUtilityInstance, LOSUtilityInstance, LoadedIconPack);

    ObjectiveIndicatorUtility = new(self) class'ObjectiveIndicatorUtility_GA';
    ObjectiveIndicatorUtility.Init(CacheUtilityInstance, LOSUtilityInstance, UnitIndicatorUtility, LoadedIconPack);

    if(class'LW_GotchaAgain_IntegratedSettings'.default.bUseCustomPathIndicatorSystem) {
        PathIndicatorUtility = new(self) class'PathIndicatorUtility_GA';
        PathIndicatorUtility.Init(CacheUtilityInstance, LOSUtilityInstance);
    }

    class'WorldInfo'.static.GetWorldInfo().MyWatchVariableMgr.RegisterWatchVariable(
        XComTacticalController(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).Owner), 
        'm_kActiveUnit', 
        self,
        OnSelectedUnitChanged);

    // Clear indicators whenever an ability is activated (includes moving)!
    ThisObj = self;
    class'X2EventManager'.static.GetEventManager().RegisterForEvent(ThisObj, 'AbilityActivated', OnAbilityActivated, ELD_Immediate);

    bLongWar2Detected = class'X2DownloadableContentInfo_LW_GotchaAgain_Integrated'.static.IsOtherModLoaded('LW_Overhaul');

    `log("Gotcha Again v" $ class'LW_GotchaAgain_IntegratedDefaultSettings'.default.iVersion $ ": Initialization complete.");
}


function SwitchIconPack(IconPack_GA IconPackInstance) {
    LoadedIconPack = IconPackInstance;
    CacheUtilityInstance.SwitchIconPack(LoadedIconPack);
    UnitIndicatorUtility.SwitchIconPack(LoadedIconPack);
    ObjectiveIndicatorUtility.SwitchIconPack(LoadedIconPack);
}


function RealizePreviewMovementAndLOS(XComPathingPawn PathingPawn) {
    // Do the "regular" LOS indicators
    RealizePreviewEndOfMoveLOS(PathingPawn.PathTileData[PathingPawn.PathTileData.Length - 1]);

    // Do movement path indicators if enabled
    if(class'LW_GotchaAgain_IntegratedSettings'.default.bUseCustomPathIndicatorSystem && !GrappleIsActive) {
        // This MUST happen after UnitIndicatorUtility.ProcessUnitIndicators, since a sideeffect of that is updating the Cache for enemy units
        GetPathIndicatorUtility().ProcessPathIndicators(PathingPawn);
    }
}


function RealizePreviewEndOfMoveLOS(GameplayTileData MoveToTileData) {
    ControlledUnit = XComGameState_Unit(class'XComGameStateHistory'.static.GetGameStateHistory().GetGameStateForObjectID(MoveToTileData.SourceObjectID));
    ControlledUnitSightRange = class'LOSUtility_GA'.static.GetUnitSightRange(ControlledUnit);
    bControlledUnitIsVIP = class'UnitIndicatorUtility_GA'.static.UnitIsVIP(ControlledUnit);

    UnitIndicatorUtility.ProcessUnitIndicators(MoveToTileData.EventTile, (bLongWar2Detected && class'LW_GotchaAgain_IntegratedSettings'.default.bShowLoneWolfIndicator));

    if(!bControlledUnitIsVIP) {
        ObjectiveIndicatorUtility.ProcessObjectiveIndicators(MoveToTileData.EventTile);
    } else {
        ObjectiveIndicatorUtility.ResetAllObjectiveIndicators();
    }
}


private function PathIndicatorUtility_GA GetPathIndicatorUtility() {
    // Make sure the PathIndicatorUtility is instantiated if this setting was enabled after initializing
    if(PathIndicatorUtility == none) {
        PathIndicatorUtility = new(self) class'PathIndicatorUtility_GA';
        PathIndicatorUtility.Init(CacheUtilityInstance, LOSUtilityInstance);
    }
    return PathIndicatorUtility;
}


simulated function RealizeTargetedStates() {
    local UIUnitFlag UnitFlag;
    
    // If this is not enabled, use the superclass function
    if(!class'LW_GotchaAgain_IntegratedSettings'.default.bDisableDimHostileUnitFlagsWhenUsingGrapple || !class'LW_GotchaAgain_IntegratedSettings'.default.bShowLOSIndicatorsForGrappleDestinations) {
        super.RealizeTargetedStates();
        return;
    } 
    
    // In order to avoid also overriding the UIUnitFlag class, we do an extra check here and do NOT call RealizeTargetedState(), 
    // which dims the flag, for hostile units if the raised Tactical menu is for the grapple ability
    foreach m_arrFlags(UnitFlag) {
        if(!UnitFlag.m_bIsFriendly.GetValue()
           && XComPresentationLayer(Movie.Pres).m_kTacticalHUD.IsMenuRaised()
           && (X2TargetingMethod_Grapple(XComPresentationLayer(Movie.Pres).m_kTacticalHUD.GetTargetingMethod()) != none)) {
            continue;
        }

        UnitFlag.RealizeTargetedState();
    }
}


// This is called when an ability is selected for targeting stuff
simulated function ActivateExtensionForTargetedUnit(StateObjectReference ObjectRef) {
    // Do no clear indicators when this shothud is for a melee-ability
    if(X2MeleePathingPawn_GA(PathIndicatorUtility.PathingPawn) == none) {
        ClearLOSIndicators();
    }
    super.ActivateExtensionForTargetedUnit(ObjectRef);
}


public function EventListenerReturn OnAbilityActivated(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData) {
    ClearLOSIndicators();
    return ELR_NoInterrupt;
}


function OnSelectedUnitChanged() {
    ClearLOSIndicators();
}


simulated function EndTurn() {
    ClearLOSIndicators();
    super.EndTurn();
}


function ClearLOSIndicators(optional bool ForceClearCustomPathIndicators = false) {

    // Clear all unit indicators
    UnitIndicatorUtility.ClearUnitLOSIndicators();

    // Reset all objective indicators
    ObjectiveIndicatorUtility.ResetAllObjectiveIndicators();

    if(class'LW_GotchaAgain_IntegratedSettings'.default.bUseCustomPathIndicatorSystem || ForceClearCustomPathIndicators) {
        // Clear all path indicators in the custom path-indicator system
        GetPathIndicatorUtility().ClearAllPathIndicators();
    } 
}


function IconPack_GA GetIconPack() {
    return LoadedIconPack;
}


function ObjectiveIndicatorUtility_GA GetObjectiveIndicatorUtility() {
    return ObjectiveIndicatorUtility;
}