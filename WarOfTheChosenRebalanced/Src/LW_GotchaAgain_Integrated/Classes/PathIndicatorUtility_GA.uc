class PathIndicatorUtility_GA extends Object
                              within UIUnitFlagManager_GA;
                              
var private CacheUtility_GA CacheUtility;
var private LOSUtility_GA LOSUtility;

var public XComPathingPawn PathingPawn;

var private bool QualifiedForAudioWarningLastUpdate;
var private bool QualifiedForAudioWarningThisUpdate;

var private int PathIndicatorLocationIndex;
var private array<PathIndicatorLocation_GA> PathIndicatorLocations;
var private array<int> UnitObjectIDsToClear;        // Keep an array of these and clear the unit-indicators after processing the movement path to avoid flicker from turning them off and on again!


public function Init(CacheUtility_GA CacheUtilityInstance, LOSUtility_GA LOSUtilityInstance) {
    CacheUtility = CacheUtilityInstance;
    LOSUtility = LOSUtilityInstance;

    SetPathingPawn(XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).m_kPathingPawn);
    class'WorldInfo'.static.GetWorldInfo().MyWatchVariableMgr.RegisterWatchVariable(
        PathingPawn,
        'WaypointModifyMode', 
        self,
        OnUpdateWaypointMode);
}


private function SetPathingPawn(XComPathingPawn _PathingPawn) {
    PathingPawn = _PathingPawn;
}


public function ProcessPathIndicators(XComPathingPawn _PathingPawn) {
    local int LoosingConcealAtIndex;

    SetPathingPawn(_PathingPawn);

    ClearAllPathIndicators(true);

    PathIndicatorLocationIndex = INDEX_NONE;

    // Determine if this is a melee move that will break concealment immediately
    if(Outer.ControlledUnit.IsConcealed() && IsMeleeMove(PathingPawn.PathTiles)) {
        LoosingConcealAtIndex = 0;
    } else {
        LoosingConcealAtIndex = INDEX_NONE;
    }

    // Prepare markers for default indicators (fire, poison, acid, noise) and figure out if concealment is lost along the path
    LoosingConcealAtIndex = PrepareDefaultIndicators(PathingPawn.PathTiles, LoosingConcealAtIndex);

    // Prepare markers for existing waypoints. MUST happen after the default indicators are prepared since otherwise they would be removed as part of cleanup happening in that method
    PrepareWaypointMarkers();

    // Prepare custom markers
    if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowOverwatchTriggers || class'LW_GotchaAgain_IntegratedSettings'.default.bShowActivationTriggers) {
        PrepareTriggerIndicators(PathingPawn.PathTiles,
                                 class'LW_GotchaAgain_IntegratedSettings'.default.bShowOverwatchTriggers,
                                 class'LW_GotchaAgain_IntegratedSettings'.default.bShowActivationTriggers,
                                 LoosingConcealAtIndex);
    }

    if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowPsiBombIndicator) PreparePsiBombIndicator(PathingPawn.PathTiles);
    if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowSmokeIndicator) PrepareSmokeIndicator(PathingPawn.PathTiles);
	if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowHuntersMarkIndicator) PrepareHuntersMarkIndicator(PathingPawn.PathTiles);
    
    // Update the waypoint-indicator at the current tile if waypoint-updatemode is active (private access-modifier is not enforced at runtime!)
    if(PathingPawn.WaypointModifyMode) {
        UpdateWaypointIndicator(false);
    }

    // Create the prepared markers
    CreateMarkers(PathingPawn.PathTiles[PathingPawn.PathTiles.Length - 1], PathingPawn.PathTiles.Length - 1);
    DoQueuedUnitFlagUpdates();

    DoAudioWarning();
}

// This is recreated from XComPathingPawn.Tick() because even though it has already been done, it is not passed along the callstack so we can access the result.
// The result is not used for changing the MovePuck either until after our code has run, so there is no other option than redoing it short of overriding and redoing
// the XComPathingPawn.RebuildPathingInformation() function which is the last place where the result is accessible before our code...
private function bool IsMeleeMove(const out array<TTile> PathTiles) {
    local bool IsAMeleeMove;
    local XComTacticalHUD Hud;
    local int TargetObjectID;
	local XComGameState_BaseObject TargetObject;
    local TTile PathDestination;

    if(X2MeleePathingPawn_GA(PathingPawn) != none) {
        IsAMeleeMove = true;
    } else {
        Hud = XComTacticalHUD(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController().myHUD);
        
        if(XComUnitPawn(Hud.CachedMouseInteractionInterface) != none) {
		    TargetObjectId = XComUnitPawn(Hud.CachedMouseInteractionInterface).GetGameUnit().ObjectID;
	    } else if(XComDestructibleActor(Hud.CachedMouseInteractionInterface) != none) {
		    TargetObjectId = XComDestructibleActor(Hud.CachedMouseInteractionInterface).ObjectID;
	    }

        TargetObject = class'XComGameStateHistory'.static.GetGameStateHistory().GetGameStateForObjectID(TargetObjectId);

        IsAMeleeMove = (PathingPawn.SelectMeleeMovePathDestination(TargetObject, Hud, PathDestination) != none);
    }

    if(IsAMeleeMove) {
        // Add an indicator on the current tile of the unit
        PathIndicatorLocationIndex = GetPathIndicator(PathTiles[0], 0, PathIndicatorLocationIndex);
        PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(eBreakConceal);
    }
    return IsAMeleeMove;
}


private function DoAudioWarning() {
    if(QualifiedForAudioWarningLastUpdate != QualifiedForAudioWarningThisUpdate) {
        if(QualifiedForAudioWarningThisUpdate) {
            PlayAKEvent(AkEvent'SoundTacticalUI.Concealment_Warning');
        }
        QualifiedForAudioWarningLastUpdate = QualifiedForAudioWarningThisUpdate;
    }
}


private function PrepareSmokeIndicator(const out array<TTile> PathTiles) {
    local TTile CheckTile;

    CheckTile = PathTiles[PathTiles.Length - 1];
    // The native WorldData.TileContainsSmoke() is useless since it returns true if it contains smoke generated from fires, not smokegrenades...
    // We can get by with checking the ground-floor tile from the PathTiles array for the worldeffect from smokegrenades since the smoke seems to "fall down"
    // so we do not have to take unitheight into account.
    if(class'XComWorldData'.static.GetWorldData().TileContainsWorldEffect(CheckTile, 'X2Effect_ApplySmokeGrenadeToWorld')) {
        PathIndicatorLocationIndex = GetPathIndicator(PathTiles[PathTiles.Length - 1], PathTiles.Length - 1, PathIndicatorLocationIndex);
        PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(eMoveThroughSmoke);
    }
}

private function PrepareHuntersMarkIndicator(const out array<TTile> PathTiles) {
    local int i;
	local TTile CheckTile;

    CheckTile = PathTiles[PathTiles.Length - 1];

	// Hunter's Mark
	for(i = 0; i < PathingPawn.LaserScopeMarkers.Length; i++) {
        if(PathingPawn.LaserScopeMarkers[i] == CheckTile) {
			PathIndicatorLocationIndex = GetPathIndicator(PathTiles[PathTiles.Length - 1], PathTiles.Length - 1, PathIndicatorLocationIndex);
            PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(eHunterShot);
            break;
        }
    }
}

private function PreparePsiBombIndicator(const out array<TTile> PathTiles) {
    local XComWorldData WorldData;
    local XComGameState_Effect Effect;
    local X2AbilityTemplate AbilityTemplate;
    local float DistanceInMeters;
    local X2Effect_Persistent PersistentEffect;
    local name EffectName;
    
    WorldData = class'XComWorldData'.static.GetWorldData();

    foreach class'XComGameStateHistory'.static.GetGameStateHistory().IterateByClassType(class'XComGameState_Effect', Effect) {
        PersistentEffect = Effect.GetX2Effect();
        if(PersistentEffect == none) continue;
        EffectName = PersistentEffect.EffectName;
        if(EffectName == 'Stage1PsiBombEffect') { 
            EffectName = 'PsiBombStage2'; 
        } else if(EffectName == 'DelayedDimensionalRiftEffect') { 
            EffectName = 'PsiDimensionalRiftStage2'; 
        } else { 
            continue; 
        }

        AbilityTemplate = class'X2AbilityTemplateManager'.static.GetAbilityTemplateManager().FindAbilityTemplate(EffectName);
        DistanceInMeters = VSize(WorldData.GetPositionFromTileCoordinates(PathTiles[PathTiles.Length - 1]) - Effect.ApplyEffectParameters.AbilityInputContext.TargetLocations[0]) / WorldData.WORLD_METERS_TO_UNITS_MULTIPLIER;
        if(DistanceInMeters <= X2AbilityMultiTarget_Radius(AbilityTemplate.AbilityMultiTargetStyle).fTargetRadius) {
            PathIndicatorLocationIndex = GetPathIndicator(PathTiles[PathTiles.Length - 1], PathTiles.Length - 1, PathIndicatorLocationIndex);
            PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(ePsiBomb);
            break;
        }
    }
}


private function PrepareWaypointMarkers() {
    local int i,
              PathTilesIndex;
    
    for(i = 0; i < PathingPawn.Waypoints.Length; i++) {
        // We cannot search for structs using Find... wtf?
        for(PathTilesIndex = 0; PathTilesIndex < PathingPawn.PathTiles.Length; PathTilesIndex++) {
            if(PathingPawn.PathTiles[PathTilesIndex] == PathingPawn.Waypoints[i].Tile) break; // We are certain to find it since we cannot have a waypoint not on the path
        }

        PathIndicatorLocationIndex = GetPathIndicator(PathingPawn.Waypoints[i].Tile,
                                                      PathTilesIndex,
                                                      PathIndicatorLocationIndex);
    }
}


public function OnUpdateWaypointMode() {
    if(!class'LW_GotchaAgain_IntegratedSettings'.default.bUseCustomPathIndicatorSystem) return;

    // Make sure we have the correct PathingPawn since this function can be called externally!
    SetPathingPawn(XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).m_kPathingPawn);
    // Reset PathIndicatorLocationIndex for the same reason
    PathIndicatorLocationIndex = INDEX_NONE;    
    UpdateWaypointIndicator(true);
}


private function UpdateWaypointIndicator(bool UpdateMarkerImmediately) {
    PathIndicatorLocationIndex = GetPathIndicator(PathingPawn.PathTiles[PathingPawn.PathTiles.Length - 1], PathingPawn.PathTiles.Length - 1, PathIndicatorLocationIndex, false);
    // Private access-modifier not enforced at runtime
    if(PathingPawn.WaypointModifyMode) {
        if(PathIndicatorLocationIndex == INDEX_NONE) {
            PathIndicatorLocationIndex = GetPathIndicator(PathingPawn.PathTiles[PathingPawn.PathTiles.Length - 1], PathingPawn.PathTiles.Length - 1, PathIndicatorLocationIndex);
        }

        if(PathingPawn.Waypoints.Find('Tile',  PathIndicatorLocations[PathIndicatorLocationIndex].Tile) != INDEX_NONE) {
            PathIndicatorLocations[PathIndicatorLocationIndex].WaypointUpdateMode = eRemove;
        } else {
            PathIndicatorLocations[PathIndicatorLocationIndex].WaypointUpdateMode = eCreate;
        }
    } else if(PathIndicatorLocationIndex != INDEX_NONE) {
        PathIndicatorLocations[PathIndicatorLocationIndex].WaypointUpdateMode = eNoUpdate;
    }

    if(UpdateMarkerImmediately && PathIndicatorLocationIndex != INDEX_NONE) {
        if(PathIndicatorLocations[PathIndicatorLocationIndex].PathIndicator == none
           && PathIndicatorLocations[PathIndicatorLocationIndex].WaypointUpdateMode != eNoUpdate) {
            PathIndicatorLocations[PathIndicatorLocationIndex].PathIndicator = Outer.Spawn(class'PathIndicator_GA', Outer);
            PathIndicatorLocations[PathIndicatorLocationIndex].PathIndicator.Init(PathIndicatorLocations[PathIndicatorLocationIndex].Tile, 
                                                                                  PathIndicatorLocations[PathIndicatorLocationIndex].IndicatorTypes,
                                                                                  PathIndicatorLocations[PathIndicatorLocationIndex].WaypointUpdateMode);

        } else if(PathIndicatorLocations[PathIndicatorLocationIndex].PathIndicator != none
                  && PathIndicatorLocations[PathIndicatorLocationIndex].WaypointUpdateMode == eNoUpdate
                  && PathIndicatorLocations[PathIndicatorLocationIndex].IndicatorTypes.Length == 0
                  && PathingPawn.Waypoints.Find('Tile', PathIndicatorLocations[PathIndicatorLocationIndex].Tile) == INDEX_NONE) {
            PathIndicatorLocations[PathIndicatorLocationIndex].PathIndicator.Destroy();
            PathIndicatorLocations.RemoveItem(PathIndicatorLocations[PathIndicatorLocationIndex]);

        } else if(PathIndicatorLocations[PathIndicatorLocationIndex].PathIndicator != none) {
            PathIndicatorLocations[PathIndicatorLocationIndex].PathIndicator.UpdateWaypointMode(PathIndicatorLocations[PathIndicatorLocationIndex].WaypointUpdateMode);
        }
    }
}


private function PrepareTriggerIndicators(const out array<TTile> PathTiles, bool DoOverwatchIndicators, bool DoActivationIndicators, int BrokeConcealAtIndex) {
    local int i;
    local array<XComGameState_Unit> RevealedEnemies;
    local array<XComGameState_Unit> Shooters;
    local array<XComGameState_Unit> Viewers;
    local array<XComGameState_Unit> TriggeredOverwatches;
    local array<XComGameState_AIGroup> TriggeredActivations;
    local array<XComGameState_AIGroup> CurrentTileActivations;
    local XComGameState_Unit EnemyUnit;
    local XComGameState_AIGroup AIGroup;
	local bool alwaysShowEnemies;

	alwaysShowEnemies = class'LW_GotchaAgain_IntegratedSettings'.default.bAlwaysShowPodActivation;

    // Only do our custom indicators if we're not concealed since they're not relevant when we are.
    if(!Outer.ControlledUnit.IsConcealed() || BrokeConcealAtIndex != INDEX_NONE) {
        RevealedEnemies = CacheUtility.GetRevealedEnemiesOfUnit(Outer.ControlledUnit, alwaysShowEnemies);

        // We can skip the first tile since overwatches only trigger when moving through a tile (and the first we're only exiting)
        // and activations would have already happened for this tile if they were to.
        for(i = 1; i < PathTiles.Length; i++) {
            // No indicators are possible until concealment is broken
            if(Outer.ControlledUnit.IsConcealed() && i < BrokeConcealAtIndex) continue;

            GetShootersAndViewersForTile(PathTiles[i], RevealedEnemies, Shooters, Viewers, (i == PathTiles.Length - 1));
            
            // Overwatch triggers when passing through a tile that is visible to an overwatching unit. So the final
            // tile which we're only entering will never trigger either so we skip that as well
			// WOTC Update - Overwatch now triggers when moving into a tile, so we need to check the final destination tile as well.
            if(DoOverwatchIndicators && i < PathTiles.Length) {
                foreach Shooters(EnemyUnit) {
                    if(TriggeredOverwatches.Find(EnemyUnit) == INDEX_NONE) {
                        TriggeredOverwatches.AddItem(EnemyUnit);
                                
                        PathIndicatorLocationIndex = GetPathIndicator(PathTiles[i], i, PathIndicatorLocationIndex);
                        PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(eTriggerOverwatch);
                        PathIndicatorLocations[PathIndicatorLocationIndex].TriggeredOverwatchObjectIDs.AddItem(EnemyUnit.ObjectID);
                        
                        // Set indicator on enemy unit and remove it from the list of UnitFlags to have the overwatch-indicator reset
                        // If the unit is not on overwatch it must be suppressing (either single or area)
                        CacheUtility.GetActivationIndicatorForUnitObjectID(EnemyUnit.ObjectID).SetIcon(((EnemyUnit.ReserveActionPoints.Find('Overwatch') != INDEX_NONE) ? eOverwatchTriggered : eSuppressionTriggered));
                        UnitObjectIDsToClear.RemoveItem(EnemyUnit.ObjectID);
                    }
                }
            }
            
            if(DoActivationIndicators) {
                foreach Viewers(EnemyUnit) {
                    AIGroup = EnemyUnit.GetGroupMembership();
                    
                    if(EnemyUnit.IsUnrevealedAI()
                       && !EnemyUnit.IsMindControlled() // For some reason mind controlled XCom units return true for IsUnrevealedAI(), so we check that it is not mindcontrolled as well
                       && !EnemyUnit.IsUnitAffectedByEffectName('SireZombieLink') // Raised PsiZombies also return true for IsUnrevealedAI(), but they are always activated, so ignore these too
                       && TriggeredActivations.Find(AIGroup) == INDEX_NONE) {
                        if(CurrentTileActivations.Find(AIGroup) == INDEX_NONE) CurrentTileActivations.AddItem(AIGroup); // Add these to an intermediate array before adding to TriggeredActivations, so we find all units from the pod activating on current tile
                                                
                        PathIndicatorLocationIndex = GetPathIndicator(PathTiles[i], i, PathIndicatorLocationIndex);
                        PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(eTriggerActivation);
                        PathIndicatorLocations[PathIndicatorLocationIndex].TriggeredActivationObjectIDs.AddItem(EnemyUnit.ObjectID);

                        // Set indicator on enemy unit and remove it from the list of UnitFlags to have the overwatch-indicator reset
                        CacheUtility.GetActivationIndicatorForUnitObjectID(EnemyUnit.ObjectID).SetIcon(ePodActivated);
                        UnitObjectIDsToClear.RemoveItem(EnemyUnit.ObjectID);
                    }
                }

                // Now add the activated pods to the check-array so we don't indicate any enemies from it as activating on a later tile
                foreach CurrentTileActivations(AIGroup) {
                    TriggeredActivations.AddItem(AIGroup);
                }
            }
        }
    }
}


private function CreateMarkers(TTile SummaryTile, int SummaryTilePathTileIndex) {
    local int SummaryIndicatorIndex,
              i;
    local EIndicatorType Indicator;

    QualifiedForAudioWarningThisUpdate = false;

    // Now determine what to show in the summary-indicator and actually create the path indicators.
    PathIndicatorLocations.Sort(IndicatorSortFunction); // Sort the indicators so the summary is order in order of encountering the thing that is indicated

    SummaryIndicatorIndex = GetPathIndicator(SummaryTile, SummaryTilePathTileIndex, INDEX_NONE);
    
    for(i = 0; i < PathIndicatorLocations.Length; i++) {
        if(i == SummaryIndicatorIndex) continue;    // We handle the summary indicator last

        PathIndicatorLocations[i].PathIndicator = Outer.Spawn(class'PathIndicator_GA', Outer);
        PathIndicatorLocations[i].PathIndicator.Init(PathIndicatorLocations[i].Tile,
                                                     PathIndicatorLocations[i].IndicatorTypes,
                                                     PathIndicatorLocations[i].WaypointUpdateMode);
        foreach PathIndicatorLocations[i].IndicatorTypes(Indicator) {
            PathIndicatorLocations[SummaryIndicatorIndex].AddIndicatorToLocation(Indicator);
        }
    }

    // Only create the summary indicator if there is something to summarize or it is on top of a waypoint
    if(PathIndicatorLocations[SummaryIndicatorIndex].IndicatorTypes.Length > 0
       || PathIndicatorLocations[SummaryIndicatorIndex].WaypointUpdateMode != eNoUpdate
       || PathingPawn.Waypoints.Find('Tile', PathIndicatorLocations[SummaryIndicatorIndex].Tile) != INDEX_NONE) {
        PathIndicatorLocations[SummaryIndicatorIndex].PathIndicator = Outer.Spawn(class'PathIndicator_GA', Outer);
        PathIndicatorLocations[SummaryIndicatorIndex].PathIndicator.Init(PathIndicatorLocations[SummaryIndicatorIndex].Tile,
                                                                         PathIndicatorLocations[SummaryIndicatorIndex].IndicatorTypes,
                                                                         PathIndicatorLocations[SummaryIndicatorIndex].WaypointUpdateMode);
        // If the summary-indicator was created because of indicators (could be a waypoint as well which is not relevant), we qualify for an audio-warning
        if(PathIndicatorLocations[SummaryIndicatorIndex].IndicatorTypes.Length > 0) {
            QualifiedForAudioWarningThisUpdate = true;
        }
    } else {
        PathIndicatorLocations.RemoveItem(PathIndicatorLocations[SummaryIndicatorIndex]);
    }
}

private function int IndicatorSortFunction(PathIndicatorLocation_GA A, PathIndicatorLocation_GA B) {
    return (A.PathTileIndex > B.PathTileIndex) ? -1 : 0;
}


private function int PrepareDefaultIndicators(const out array<TTile> PathTiles, int LoosingConcealAtIndex) {
    local int i, j,
              CorrectedNoiseMarkerPosition,
              HazardMarkersIndex;
    local EIndicatorType HazardMarkerType;
    local array<PathPoint> PathPoints;
    local bool FireTriggered,
               AcidTriggered,
               PoisonTriggered,
               BrokeConceal;
    local int BrokeConcealAtIndex;

    // Set the already triggered bools to the immunity value of the moving unit to avoid indicators of that type
    FireTriggered = Outer.ControlledUnit.IsImmuneToDamage('Fire');
    AcidTriggered = Outer.ControlledUnit.IsImmuneToDamage('Acid');
    PoisonTriggered = Outer.ControlledUnit.IsImmuneToDamage('Poison');
    BrokeConcealAtIndex = LoosingConcealAtIndex;
    BrokeConceal = !Outer.ControlledUnit.IsConcealed() || LoosingConcealAtIndex != INDEX_NONE;
    

    for(i = 0; i < PathTiles.Length; i++) {
        // The private modifier is not enforced at runtime, which allows us to read the markers already prepared by native functions!
        // Concealment-markers
        if(!BrokeConceal && PathingPawn.ConcealmentMarkers.Length > 0 && PathingPawn.ConcealmentMarkers[0] == PathTiles[i]) {
            PathIndicatorLocationIndex = GetPathIndicator(PathTiles[i], i, PathIndicatorLocationIndex);
            PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(eBreakConceal);
            PathingPawn.ConcealmentMarkers.Length = 0;
            BrokeConceal = true;
            BrokeConcealAtIndex = i;
        }

        // Noise-markers
        if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowNoiseIndicators || !BrokeConceal) {
            for(j = 0; j < PathingPawn.NoiseMarkers.Length; j++) {
                if(PathingPawn.NoiseMarkers[j] == PathTiles[i]) {
                    // Noise-markers generated by the native code are placed 1 tile too early!
                    CorrectedNoiseMarkerPosition = (i < PathTiles.Length - 1) ? i + 1 : i;
                    PathIndicatorLocationIndex = GetPathIndicator(PathTiles[CorrectedNoiseMarkerPosition], CorrectedNoiseMarkerPosition, PathIndicatorLocationIndex);
                    PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(eMakeNoise);
                    
                    PathingPawn.NoiseMarkers.RemoveItem(PathingPawn.NoiseMarkers[j]);
                    break;
                }
            }
        }

         // HazardMarkers
        HazardMarkersIndex = PathingPawn.HazardMarkers.Find('Tile', PathTiles[i]);
        if(HazardMarkersIndex != INDEX_NONE) {
            for(j = 0; j < PathingPawn.HazardMarkers[HazardMarkersIndex].HazardEffectNames.Length; j++) {
                switch(PathingPawn.HazardMarkers[HazardMarkersIndex].HazardEffectNames[j]) {
                    case 'X2Effect_ApplyAcidToWorld':
                        HazardMarkerType = AcidTriggered ? eNone : eMoveThroughAcid;
                        AcidTriggered = true;
                        break;
                    case 'X2Effect_ApplyPoisonToWorld':
                        HazardMarkerType = PoisonTriggered ? eNone : eMoveThroughPoison;
                        PoisonTriggered = true;
                        break;
                    case 'X2Effect_ApplyFireToWorld':
                        HazardMarkerType = FireTriggered ? eNone : eMoveThroughFire;
                        FireTriggered = true;
                        break;
                    default:
                        HazardMarkerType = eNone;
                        break;
                }
                if(HazardMarkerType != eNone) {
                    PathIndicatorLocationIndex = GetPathIndicator(PathTiles[i], i, PathIndicatorLocationIndex);
                    PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(HazardMarkerType);
                }
            }
            PathingPawn.HazardMarkers.RemoveItem(PathingPawn.HazardMarkers[HazardMarkersIndex]);
        }
    }
    // Make sure nothing is left over for the standard function indicator function! This is not strictly necessary since we override that function to do nothing
    // as this code will not run before every call of it...
    PathingPawn.HazardMarkers.Length = 0; 
    PathingPawn.NoiseMarkers.Length = 0;

    // Only concealment-breaking noise-markers are stored in the PathingPawn.NoiseMarkers array, so we do a manual investigation to check if noise-only markers are needed
    if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowNoiseIndicators) {
        class'X2PathSolver'.static.GetPathPointsFromPath(Outer.ControlledUnit, PathTiles, PathPoints);
        for(i = 0; i < PathPoints.Length; i++) {
            switch(PathPoints[i].Traversal) {
                case eTraversal_BreakWindow:
                case eTraversal_KickDoor:
                    PathIndicatorLocationIndex = GetPathIndicator(PathTiles[PathPoints[i].PathTileIndex], PathPoints[i].PathTileIndex, PathIndicatorLocationIndex);
                    PathIndicatorLocations[PathIndicatorLocationIndex].AddIndicatorToLocation(eMakeNoise);
                    break;
            }
        }
    }

    // Check if we have to convert a noise-marker to a break-concealment marker or if noise-markers are not enabled remove any that comes after a concealment-breaking marker!
    BrokeConceal = !Outer.ControlledUnit.IsConcealed();
    PathIndicatorLocations.Sort(IndicatorSortFunction);
    for(i = 0; i < PathIndicatorLocations.Length; i++) {
        for(j = PathIndicatorLocations[i].IndicatorTypes.Length - 1; j > -1; j--) {
            if(!BrokeConceal) {
                if(PathIndicatorLocations[i].IndicatorTypes[j] == eBreakConceal) {
                    BrokeConceal = true;
                    if(BrokeConcealAtIndex == INDEX_NONE || BrokeConcealAtIndex > PathIndicatorLocations[i].PathTileIndex) BrokeConcealAtIndex = PathIndicatorLocations[i].PathTileIndex;
                } else if(PathIndicatorLocations[i].IndicatorTypes[j] == eMakeNoise) {
                    // The first time we make noise, we will also break concealment!
                    PathIndicatorLocations[i].IndicatorTypes[j] = eBreakConceal;
                    BrokeConceal = true;
                    if(BrokeConcealAtIndex == INDEX_NONE || BrokeConcealAtIndex > PathIndicatorLocations[i].PathTileIndex) BrokeConcealAtIndex = PathIndicatorLocations[i].PathTileIndex;
                }
            } else if(BrokeConceal) {
                if(PathIndicatorLocations[i].IndicatorTypes[j] == eBreakConceal) {
                    // If we already broke concealment at this point, remove this indicator
                    PathIndicatorLocations[i].IndicatorTypes.RemoveItem(PathIndicatorLocations[i].IndicatorTypes[j]);
                } else if(PathIndicatorLocations[i].IndicatorTypes[j] == eMakeNoise && !class'LW_GotchaAgain_IntegratedSettings'.default.bShowNoiseIndicators) {
                    // If we don't need any more breakconceal-indicators and noise-indicators are not enabled, remove them!
                    PathIndicatorLocations[i].IndicatorTypes.RemoveItem(PathIndicatorLocations[i].IndicatorTypes[j]);
                }
            }
        }
        
        // If there are no more indicatortypes left at this tile, remove the indicator completely!
        if(PathIndicatorLocations[i].IndicatorTypes.Length == 0) {
            PathIndicatorLocations.RemoveItem(PathIndicatorLocations[i]);
            i--;
        }
    }

    return BrokeConcealAtIndex;
}


private function int GetPathIndicator(TTile Tile, int PathTileIndex, int CurrentIndex, optional bool CreateIfNoneFound = true) {
    local int i;
    local PathIndicatorLocation_GA newPathIndicatorLocation;

    if(CurrentIndex != INDEX_NONE && PathIndicatorLocations[CurrentIndex].Tile == Tile) {  // Skip searching if we have the correct index already
        return CurrentIndex;
    }

    PathIndicatorLocationIndex = INDEX_NONE;
    for(i = 0; i < PathIndicatorLocations.Length; i++) {
        if(PathIndicatorLocations[i].Tile == Tile) {
            PathIndicatorLocationIndex = i;
            break;
        }
    }

    if(PathIndicatorLocationIndex == INDEX_NONE && CreateIfNoneFound) {
        PathIndicatorLocationIndex = PathIndicatorLocations.Length;
        newPathIndicatorLocation = new class'PathIndicatorLocation_GA';
        newPathIndicatorLocation.PathTileIndex = PathTileIndex;
        newPathIndicatorLocation.Tile = Tile;
        PathIndicatorLocations.AddItem(newPathIndicatorLocation);
    }
    return PathIndicatorLocationIndex;
}


public function ClearAllPathIndicators(optional bool QueueUnitFlagUpdates = false) {
    local int i;
    local int TriggeredObjectID;

    for(i = 0; i < PathIndicatorLocations.Length; i++) {
        PathIndicatorLocations[i].PathIndicator.Destroy();

        foreach PathIndicatorLocations[i].TriggeredOverwatchObjectIDs(TriggeredObjectID) {
            UnitObjectIDsToClear.AddItem(TriggeredObjectID);
        }
        foreach PathIndicatorLocations[i].TriggeredActivationObjectIDs(TriggeredObjectID) {
            UnitObjectIDsToClear.AddItem(TriggeredObjectID);
        }
    }
    PathIndicatorLocations.Length = 0;

    if(!QueueUnitFlagUpdates) {
        DoQueuedUnitFlagUpdates();
    }
}


private function DoQueuedUnitFlagUpdates() {
    local int UnitObjectID;

    foreach UnitObjectIDsToClear(UnitObjectID) {
        CacheUtility.GetActivationIndicatorForUnitObjectID(UnitObjectID).SetIcon(eNone);
    }
    UnitObjectIDsToClear.Length = 0;
}

// This has side-effects! (Shooters and Viewers arrays)
private function GetShootersAndViewersForTile(const out TTile Tile, const out array<XComGameState_Unit> RevealedEnemies, out array<XComGameState_Unit> Shooters, out array<XComGameState_Unit> Viewers, bool IsFinalTile) {
    local XComGameState_Unit EnemyUnit,
                             EnemySpotter;
    local LOSValues UnitLOSValues;
    local array<int> IndexesToCheckForSpotters;
    local int i;
    local bool SpotterFound;
    local StateObjectReference EmptyRef;
    local int SuppressionEffectIndex,
              SuppressionEffectID;
    local UnitValue OverwatchUnitValue;
    local Name OverwatchValueName;
    local float TileDistance;

    Shooters.Length = 0;
    Viewers.Length = 0;
    foreach RevealedEnemies(EnemyUnit) {
        // On all but the final tile our unit is moving so would logically not be used for overwatching units LOS checks, BUT IT IS!
        // The final tile is not relevant for shooters since overwatch cannot trigger on that
        // WOTC Update - Overwatch can now trigger on the final tile.
        UnitLOSValues = LOSUtility.GetLOSValues(EnemyUnit.TileLocation, 
                                                Tile, 
                                                EnemyUnit, 
                                                Outer.ControlledUnit, 
                                                LOSUtility.GetUnitSightRange(EnemyUnit), 
                                                , 
                                                !EnemyUnit.CanTakeCover());
        
        if(UnitLOSValues.bClearLOS) {
            if(UnitLOSValues.bWithinRegularRange) 
            {
                Viewers.AddItem(EnemyUnit); // Shooters within regular range are always viewers too
                // Enemies on overwatch are relevant for shooters

                OverwatchValueName = name("OverwatchMark" $ EnemyUnit.ObjectId);
	            Outer.ControlledUnit.GetUnitValue(OverwatchValueName, OverwatchUnitValue);
                if(EnemyUnit.ReserveActionPoints.Find('Overwatch') != INDEX_NONE && OverwatchUnitValue.fValue > 0) 
                {

                    Shooters.AddItem(EnemyUnit);

                // As well as enemies suppressing the moving unit
                } 
                else if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowOverwatchTriggerForSuppression && EnemyUnit.ReserveActionPoints.Find('Suppression') != INDEX_NONE) 
                {
                    SuppressionEffectIndex = EnemyUnit.AppliedEffectNames.Find('Suppression');
                    if(SuppressionEffectIndex == INDEX_NONE) SuppressionEffectIndex = EnemyUnit.AppliedEffectNames.Find('AreaSuppression');
                    // Check that the found suppression is applied to the moving unit before adding the enemy to Shooters
                    if(SuppressionEffectIndex != INDEX_NONE) 
                    {
                        SuppressionEffectID = EnemyUnit.AppliedEffects[SuppressionEffectIndex].ObjectID;
                        if(Outer.ControlledUnit.AffectedByEffects.Find('ObjectID', SuppressionEffectID) != INDEX_NONE) 
                        {
                            Shooters.AddItem(EnemyUnit);
                        }
                    }
                }
                else if(EnemyUnit.FindAbility('LongWatch') != EmptyRef) 
                {
                    if(EnemyUnit.ReserveActionPoints.Find('Overwatch') != INDEX_NONE && OverwatchUnitValue.fValue > 0) 
                    {
                        // We need to check if there is another enemy viewer of the tile for squadsight to be possible, but we are not done building the Viewer array yet, so save a list
                        // of indexes to be verified!
                        // By design, we only check revealed enemies here since checking all of them would be using more info than is available to the player from the UI and thus cheating
                        IndexesToCheckForSpotters.AddItem(Shooters.Length);
                        Shooters.AddItem(EnemyUnit);
                    }
                }
                else if (EnemyUnit.FindAbility('CloseCombatSpecialistAttack') != EmptyRef)
                {
                    TileDistance = VSizeSq(`XWORLD.GetPositionFromTileCoordinates(Tile) - `XWORLD.GetPositionFromTileCoordinates(EnemyUnit.TileLocation));
                    // 4 tiles * 96 squared
                    if(TileDistance <= 147456 && EnemyUnit.GetPrimaryWeapon().Ammo > 0)
                    {
                        if(EnemyUnit.AffectedByEffectNames.Find(class'X2Effect_Suppression'.default.EffectName) == INDEX_NONE && EnemyUnit.AffectedByEffectNames.Find(class'X2Effect_AreaSuppression'.default.EffectName) == INDEX_NONE)
                        {
                            Shooters.AddItem(EnemyUnit);
                        }
                    }
                }
                else if(EnemyUnit.FindAbility('BladestormAttack') != EmptyRef || EnemyUnit.FindAbility('BerserkerBladestormAttack') != EmptyRef || EnemyUnit.FindAbility('AssassinBladestormAttack') != EmptyRef || EnemyUnit.FindAbility('TemplarBladeStormAttack') != EmptyRef)
                {
                    TileDistance = VSizeSq(`XWORLD.GetPositionFromTileCoordinates(Tile) - `XWORLD.GetPositionFromTileCoordinates(EnemyUnit.TileLocation));
                    //1.5 tiles times 96 squared
                    if(TileDistance <= 20736)
                    {
                        if(EnemyUnit.AffectedByEffectNames.Find(class'X2Effect_Suppression'.default.EffectName) == INDEX_NONE && EnemyUnit.AffectedByEffectNames.Find(class'X2Effect_AreaSuppression'.default.EffectName) == INDEX_NONE)
                        {
                            Shooters.AddItem(EnemyUnit);
                        }
                    }
                }
            } 
        }

        if(!UnitLOSValues.bClearLOS || !UnitLOSValues.bWithinRegularRange) {
            // If this is the final tile, we need to get actual LOS values!
            if(IsFinalTile) {
                UnitLOSValues = LOSUtility.GetLOSValues(EnemyUnit.TileLocation, 
                                                        Tile, 
                                                        EnemyUnit, 
                                                        Outer.ControlledUnit, 
                                                        LOSUtility.GetUnitSightRange(EnemyUnit), 
                                                        , 
                                                        !EnemyUnit.CanTakeCover());
            }
            if(UnitLOSValues.bClearLOS && UnitLOSValues.bWithinRegularRange) {
                Viewers.AddItem(EnemyUnit);
            }
        }
    }

    // Perform check of Shooters that will shoot because of squadsight!
    for(i = IndexesToCheckForSpotters.Length - 1; i > -1; i--) {    // Run backwards since we will be removing shooters with no spotter!
        SpotterFound = false;
        foreach Viewers(EnemySpotter) {
            if(EnemySpotter != Shooters[i]) {
                SpotterFound = true;
                break; // No need to look further
            }
        }
        if(!SpotterFound) {
            // No spotter found, this is not a valid shooter
            Shooters.RemoveItem(Shooters[i]);
        }
    }
}