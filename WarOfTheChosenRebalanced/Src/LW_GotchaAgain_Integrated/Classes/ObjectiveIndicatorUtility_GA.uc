class ObjectiveIndicatorUtility_GA extends Object
                                   within UIUnitFlagManager_GA;

var privatewrite IconPack_GA IconPack;
var privatewrite CacheUtility_GA CacheUtility;
var privatewrite LOSUtility_GA LOSUtility;
var privatewrite UnitIndicatorUtility_GA UnitIndicatorUtility;

var private int LocalClientPlayerObjectID;
var private float LastDHIPrevention; // Used to make sure we only hide the default doorhacking indicators once per tick
var private bool InitializedArrows;

public function Init(CacheUtility_GA CacheUtilityInstance, LOSUtility_GA LOSUtilityInstance, UnitIndicatorUtility_GA UnitIndicatorUtilityInstance, IconPack_GA IconPackInstance) {
    CacheUtility = CacheUtilityInstance;
    LOSUtility = LOSUtilityInstance;
    UnitIndicatorUtility = UnitIndicatorUtilityInstance;
    IconPack = IconPackInstance;

	InitializedArrows = false;
}


public function SwitchIconPack(IconPack_GA IconPackInstance) {
    IconPack = IconPackInstance;
}


public function HideDefaultDoorHackingIndicators() {
    local XComActionIconManager ActionIconManager;
    local int i;

    if(LastDHIPrevention == class'WorldInfo'.static.GetWorldInfo().TimeSeconds) return;

    ActionIconManager = XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).GetActionIconMgr();

    for(i = 0; i < ActionIconManager.ACTION_ICON_POOL_SIZE; i++) {
        if(ActionIconManager.InteractiveIconPool[i].Component.StaticMesh == StaticMesh'UI_3D.Hacking.Hacking_Door') {
            ActionIconManager.InteractiveIconPool[i].Component.SetHidden(true);
        }
    }

    LastDHIPrevention = class'WorldInfo'.static.GetWorldInfo().TimeSeconds;
}


private function RegisterForTowerTriggers() {
    local Object ThisObj;

    ThisObj = self;
    LocalClientPlayerObjectID = X2TacticalGameRuleset(XComGameInfo(class'Engine'.static.GetCurrentWorldInfo().Game).GameRuleset).GetLocalClientPlayerObjectID();

	// Add all currently visible towers if LocationScout sitrep is active.
	AddAllVisibleTowers();

    // Register for reveal events
    class'X2EventManager'.static.GetEventManager().RegisterForEvent(ThisObj, 'ObjectVisibilityChanged', OnTowerRevealed, ELD_OnStateSubmitted);

    // Register for hacking events
    class'X2EventManager'.static.GetEventManager().RegisterForEvent(ThisObj, 'AbilityActivated', OnHackFinalized, ELD_Immediate);

    // Register for destroyed events
    class'X2EventManager'.static.GetEventManager().RegisterForEvent(ThisObj, 'ObjectDestroyed', OnTowerDestroyed, ELD_OnStateSubmitted);

	InitializedArrows = true;
}


public function ProcessDoorHackingIndicators(const out TTile DestinationTile) {
    local XComGameState_InteractiveObject InteractiveObject;
    local DoorHackingIndicator_GA DoorHackingIndicator;
    local LOSValues LOSToDoor;
    local bool CanHackDoor;
    local StateObjectReference EmptyRef;
    local int i;
    local array<TTile> VisibilityTiles;

    foreach class'XComGameStateHistory'.static.GetGameStateHistory().IterateByClassType(class'XComGameState_InteractiveObject', InteractiveObject) {
        if(InteractiveObject.IsDoor() && InteractiveObject.LockStrength > 0 && !InteractiveObject.bHasBeenHacked) {
            DoorHackingIndicator = CacheUtility.GetDoorHackingIndicator(InteractiveObject, Outer);
            
            CanHackDoor = false;
            if(Outer.ControlledUnit.FindAbility('IntrusionProtocol') != EmptyRef) {
                VisibilityTiles.Length = 0;
                InteractiveObject.NativeGetVisibilityLocation(VisibilityTiles);
                
                for(i = 0; i < VisibilityTiles.Length; i++) {
                    LOSToDoor = LOSUtility.GetLOSValues(DestinationTile, 
                                                        VisibilityTiles[i], 
                                                        Outer.ControlledUnit, 
                                                        none,
                                                        Outer.ControlledUnitSightRange);
                    if(LOSToDoor.bClearLOS && LOSToDoor.bWithinRegularRange) {
                        CanHackDoor = true;
                        break;
                    }
                }
            } else {
                CanHackDoor = CanBeHackedByRegularUnitFromTile(DestinationTile, InteractiveObject);
            }

            if(CanHackDoor) {
                DoorHackingIndicator.Show();               
            } else {
                DoorHackingIndicator.Hide();
            }
        }
    }
}


public function ProcessObjectiveIndicators(const out TTile DestinationTile) {
    local XComGameState_IndicatorArrow_GA Arrow;
    local XComGameState_Unit TargetUnit;
    local GameRulesCache_VisibilityInfo VisibilityInfo;
    local LOSValues LOSValuesForObjective;
    local EIndicatorValue IndicatorValue;
    local XComGameState_InteractiveObject ObjectiveObject;
    local StateObjectReference EmptyRef;
    local array<TTile> VisibilityTiles;

    if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowRemoteDoorHackingIndicators) {
        ProcessDoorHackingIndicators(DestinationTile);
    }

	if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowTowerHackingArrows && !InitializedArrows) {
        RegisterForTowerTriggers();
    }

    foreach class'XComGameStateHistory'.static.GetGameStateHistory().IterateByClassType(class'XComGameState_IndicatorArrow_GA', Arrow) {
        // First check if the objective being pointed at is an enemy unit which will mean it is a "neutralize VIP"-objective
        if(Arrow.PointsToUnit()) {
            TargetUnit = XComGameState_Unit(class'XComGameStateHistory'.static.GetGameStateHistory().GetGameStateForObjectID(Arrow.Unit.ObjectID));
            if(TargetUnit != none && TargetUnit.IsEnemyUnit(Outer.ControlledUnit)) {
                LOSValuesForObjective = LOSUtility.GetLOSValues(DestinationTile, 
                                                                TargetUnit.TileLocation, 
                                                                Outer.ControlledUnit, 
                                                                TargetUnit, 
                                                                Outer.ControlledUnitSightRange, 
                                                                VisibilityInfo); // Set VisibilityInfo from side-effect to be used in call to flanking function
                LOSValuesForObjective.bFlanked = LOSUtility.TargetIsFlankedFromTile(DestinationTile, Outer.ControlledUnit, TargetUnit, VisibilityInfo);
                
                IndicatorValue = UnitIndicatorUtility.GetIndicatorValueForUnit(Outer.ControlledUnit, TargetUnit, LOSValuesForObjective);

                Arrow.SetIcon(IconPack, IndicatorValue);
            }
            continue;
        }

        ObjectiveObject = CacheUtility.GetObjectForArrow(Arrow);
        if (ObjectiveObject == none) {
            // Some objectives don't have an associated object (evac-beacons and maybe others)
            // We don't do any processing for these
            continue;

        } else if(ObjectiveObject.MustBeHacked()) {
            // If the object cannot be hacked by the current unit we skip processing it
            if(!ObjectiveObject.CanInteractHack(Outer.ControlledUnit)) {
                continue;

            } else if(Outer.ControlledUnit.FindAbility('IntrusionProtocol') != EmptyRef) {
                VisibilityTiles.Length = 0;
                ObjectiveObject.NativeGetVisibilityLocation(VisibilityTiles);
                LOSValuesForObjective = GetBestLOSForTileArray(DestinationTile,
                                                               VisibilityTiles,
                                                               Outer.ControlledUnit,
                                                               none,
                                                               Outer.ControlledUnitSightRange);
                IndicatorValue = GetIndicatorValueForHackable(Outer.ControlledUnit, LOSValuesForObjective);
            } else {
                // If Unit is not able to hack remotely, we do a final check if it will be possible to do a "regular" hack from the destination tile
                IndicatorValue = CanbeHackedByRegularUnitFromTile(DestinationTile, ObjectiveObject) ? eHackable : eNotVisible;
            }

        } else if (ObjectiveObject.TargetIsEnemy(Outer.ControlledUnit.ObjectID)) {
            // If the objective is not hackable it must be a "destroy something" objective
            VisibilityTiles.Length = 0;
            ObjectiveObject.NativeGetVisibilityLocation(VisibilityTiles);
           
            LOSValuesForObjective = GetBestLOSForTileArray(DestinationTile,
                                                           VisibilityTiles,
                                                           Outer.ControlledUnit,
                                                           none,
                                                           Outer.ControlledUnitSightRange);
            IndicatorValue = GetIndicatorValueForDestructible(Outer.ControlledUnit, LOSValuesForObjective);
        } else {
            // If the objective is not hackable nor something we should destroy, we don't do anything
            continue;
        }
        Arrow.SetIcon(IconPack, IndicatorValue);
    }
}


private function LOSValues GetBestLOSForTileArray(const out TTile SourceTile, const out array<TTile> DestTiles, XComGameState_Unit SourceUnit, XComGameState_Unit TargetUnit, int SightRange) {
    local LOSValues CurrentLOSValues,
                    BestLOSValuesSoFar;
    local int i;

    for(i = 0; i < DestTiles.Length; i++) {
        CurrentLOSValues = LOSUtility.GetLOSValues(SourceTile, 
                                                   DestTiles[i], 
                                                   SourceUnit, 
                                                   TargetUnit,
                                                   SightRange);
        if(CurrentLOSValues.bClearLOS && !BestLOSValuesSoFar.bClearLOS ||
           CurrentLOSValues.bWithinRegularRange && !BestLOSValuesSoFar.bWithinRegularRange) {
            BestLOSValuesSoFar = CurrentLOSValues;
        }
        if(BestLOSValuesSoFar.bWithinRegularRange) break;
    }
    return BestLOSValuesSoFar;
}


public function ResetAllObjectiveIndicators() {
    local int i;

    for(i = 0; i < CacheUtility.ArrowObjectRelations.Length; i++) {
        if(CacheUtility.ArrowObjectRelations[i].Arrow.IsTowerIndicatorArrow() && CacheUtility.bAdventTowersHaveBeenHacked) {
            // Don't change indicators for any towers if one has already been hacked
            continue;
        }
        CacheUtility.ArrowObjectRelations[i].Arrow.SetIcon(IconPack, eNotVisible);
    }

    for(i = 0; i < CacheUtility.DoorHackingIndicators.Length; i++) {
        CacheUtility.DoorHackingIndicators[i].DoorHackingIndicator.Hide();
    }
}


private function EIndicatorValue GetIndicatorValueForHackable(XComGameState_Unit SourceUnit, const out LOSValues LOSValuesForObjective) {
    return (LOSValuesForObjective.bClearLOS && LOSValuesForObjective.bWithinRegularRange) ? eHackable : eNotVisible;
}


public function EIndicatorValue GetIndicatorValueForDestructible(XComGameState_Unit SourceUnit, const out LOSValues LOSValuesForUnit) {
    if(!LOSValuesForUnit.bClearLOS) return eNotVisible;

    // Reaching this, we know there is clear LOS
    if(LOSValuesForUnit.bWithinRegularRange) return eSpotted;

    // Here we also know the target is outside regular range
    return SourceUnit.HasSquadsight() ? eSquadsight : eNotVisible;
}

private function bool CanBeHackedByRegularUnitFromTile(const out TTile SourceTile, XComGameState_InteractiveObject ObjectiveObject) {
    local TTile CheckTile;  // We need an out variable for the GetTileData() call
    local TileData DestTileData;
    local int i, j;
    
    for(j = 0; j < Outer.ControlledUnit.UnitHeight; j++) {
        CheckTile = SourceTile;
        CheckTile.Z += j;
        class'XComWorldData'.static.GetWorldData().GetTileData(CheckTile, DestTileData); // DestTileData from side-effect!

        for(i = 0; i < DestTileData.InteractPoints.Length; i++) {
            if(DestTileData.InteractPoints[i].InteractiveActor.ObjectID == ObjectiveObject.ObjectID) {
                return true;
            }
        }
    }
    return false;
}


function EventListenerReturn OnTowerRevealed(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData) {
    local XComGameState_InteractiveObject Tower;
    local XComInteractiveLevelActor TowerActor;
    local XComGameState_Unit SourceUnit;
    local GameRulesCache_VisibilityInfo VisibilityInfo;

    SourceUnit = XComGameState_Unit(EventSource);
    if(SourceUnit != none && SourceUnit.ControllingPlayer.ObjectID == LocalClientPlayerObjectID) {
        Tower = XComGameState_InteractiveObject(EventData);
        if(Tower != none) {
            TowerActor = XComInteractiveLevelActor(class'XComGameStateHistory'.static.GetGameStateHistory().GetVisualizer(Tower.ObjectID));
            if(TowerActor != none && TowerActor.ActorType == Type_AdventTower && !CacheUtility.TowerHasBeenRevealed(Tower)) {
                // Get VisibilityInfo from side-effect
                X2TacticalGameRuleset(XComGameInfo(class'Engine'.static.GetCurrentWorldInfo().Game).GameRuleset).VisibilityMgr.GetVisibilityInfo(SourceUnit.ObjectID, Tower.ObjectId, VisibilityInfo);
                if(VisibilityInfo.bVisibleGameplay) {
                    AddTowerArrow(Tower);
                }
            }
        }
    }

	return ELR_NoInterrupt;
}


function EventListenerReturn OnTowerDestroyed(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData) {
    local XComGameState_InteractiveObject Tower;
    local XComGameState_IndicatorArrow_GA Arrow;
    local XComInteractiveLevelActor TowerActor;
    
    Tower = XComGameState_InteractiveObject(EventSource);
    if(Tower != none) {
        TowerActor = XComInteractiveLevelActor(class'XComGameStateHistory'.static.GetGameStateHistory().GetVisualizer(Tower.ObjectID));
        if(TowerActor != none && TowerActor.ActorType == Type_AdventTower) {
            Arrow = CacheUtility.RemoveTowerFromCache(Tower);
            if(Arrow != none) {
                class'XComGameState_IndicatorArrow_GA'.static.RemoveArrowPointingAtLocation(Arrow.Location);
            }
        }
    }

	return ELR_NoInterrupt;
}

private function AddAllVisibleTowers() {
	local XComInteractiveLevelActor InteractiveActor;
	local XComGameState_InteractiveObject InteractiveObject;
	local XComGameStateHistory History;
	local XComGameState_BattleData BattleData;

	History = `XCOMHISTORY;
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));

	if (BattleData.ActiveSitReps.Find('LocationScout') != INDEX_NONE)
	{
		foreach class'WorldInfo'.static.GetWorldInfo().AllActors(class'XComInteractiveLevelActor', InteractiveActor)
		{
			InteractiveObject = InteractiveActor.GetInteractiveState(History.GetStartState());
			if(InteractiveActor.ActorType == Type_AdventTower && !CacheUtility.TowerHasBeenRevealed(InteractiveObject))
			{
				AddTowerArrow(InteractiveObject);
			}
		}
	}
}

private function AddTowerArrow(XComGameState_InteractiveObject Tower) {
    local EIndicatorValue IndicatorValue;
    local vector ArrowLocation;
    local string ArrowIcon;
    local XComGameState_IndicatorArrow_GA Arrow;

    if(!CacheUtility.bAdventTowersHaveBeenHacked) {
        IndicatorValue = eNotVisible;
    } else {
        IndicatorValue = eAlreadyHacked;
    }

    ArrowIcon = IconPack.GetIconFromIconSet(eHackAdventTower, IndicatorValue);
    ArrowLocation = class'XComWorldData'.static.GetWorldData().GetPositionFromTileCoordinates(Tower.TileLocation);
    Arrow = XComGameState_IndicatorArrow_GA(class'XComGameState_IndicatorArrow_GA'.static.CreateArrowPointingAtLocation(ArrowLocation, , , , ArrowIcon));

    CacheUtility.AddRevealedTower(Tower, Arrow, IndicatorValue);
}


function EventListenerReturn OnHackFinalized(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData) {
    local XComGameState_Ability AbilityState;
    local XComInteractiveLevelActor TowerActor;
    local Object ThisObj;

    // We're only interested in FinalizeIntrusion events
    AbilityState = XComGameState_Ability(EventData);
    if(AbilityState != none && AbilityState.GetMyTemplateName() == 'FinalizeIntrusion') {
        // Check if the hacked object was a tower
        TowerActor = XComInteractiveLevelActor(class'XComGameStateHistory'.static.GetGameStateHistory().GetVisualizer(XComGameStateContext_Ability(GameState.GetContext()).InputContext.PrimaryTarget.ObjectID));
        if(TowerActor != none && TowerActor.ActorType == Type_AdventTower) {
            SetTowersHaveBeenHackedAlready();

            // Unregister from this event since only one tower can be hacked per mission
            ThisObj = self;
            class'X2EventManager'.static.GetEventManager().UnRegisterFromEvent(ThisObj, 'AbilityActivated');
        }
    }
    
    return ELR_NoInterrupt;
}


function SetTowersHaveBeenHackedAlready() {
    local Object ThisObj;
    local int i;

    CacheUtility.bAdventTowersHaveBeenHacked = true;
    
    for(i = CacheUtility.ArrowObjectRelations.Length - 1; i > -1; i--) {
        if(CacheUtility.ArrowObjectRelations[i].Arrow.IsTowerIndicatorArrow()) {
            if(class'LW_GotchaAgain_IntegratedSettings'.default.bHideTowerArrowsAfterHacking) {
                class'XComGameState_IndicatorArrow_GA'.static.RemoveArrowPointingAtLocation(CacheUtility.ArrowObjectRelations[i].Arrow.Location);
                CacheUtility.ArrowObjectRelations.RemoveItem(CacheUtility.ArrowObjectRelations[i]);
            } else {
                CacheUtility.ArrowObjectRelations[i].Arrow.SetIcon(IconPack, eAlreadyHacked);
            }
        }
    }

    if(class'LW_GotchaAgain_IntegratedSettings'.default.bHideTowerArrowsAfterHacking) {
        // We can unregister from this event now since we no longer care about revealed towers
        ThisObj = self;
        class'X2EventManager'.static.GetEventManager().UnRegisterFromEvent(ThisObj, 'ObjectVisibilityChanged');
    }
}