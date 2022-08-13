class UnitIndicatorUtility_GA extends Object
                              within UIUnitFlagManager_GA;

var private IconPack_GA IconPack;
var private CacheUtility_GA CacheUtility;
var private LOSUtility_GA LOSUtility;


public function Init(CacheUtility_GA _CacheUtility, LOSUtility_GA _LOSUtility, IconPack_GA _IconPack) {
    CacheUtility = _CacheUtility;
    LOSUtility = _LOSUtility;
    IconPack = _IconPack;
}


public function SwitchIconPack(IconPack_GA IconPackInstance) {
    IconPack = IconPackInstance;
}


public function ProcessUnitIndicators(const out TTile DestinationTile, optional bool DoLoneWolfIndicator = false) {
    local UIUnitFlag UnitFlag;
    local XComGameState_Unit TargetUnit;
    local GameRulesCache_VisibilityInfo VisibilityInfo;
    local LOSValues LOSValuesForUnit;
    local LOSValues initialLOSValues;
    local StateObjectReference EmptyRef;
    local bool LoneWolfWillBeActive, CeWillBeActive;
    local float TileDistance;
    foreach Outer.m_arrFlags(UnitFlag) {
        TargetUnit = XComGameState_Unit(class'XComGameStateHistory'.static.GetGameStateHistory().GetGameStateForObjectID(UnitFlag.StoredObjectID));
        if(TargetUnit == none) continue;

        LOSValuesForUnit = initialLOSValues;

        if(Outer.bControlledUnitIsVIP) {
            if(TargetUnit.IsEnemyUnit(Outer.ControlledUnit)) {
                // VIPs have no use for the regular indicators since they cannot shoot. Instead we process LOS from
                // hostile units to the VIP to show an indicator for the hostile unit being able to see/shoot the VIP.
                if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowVIPSpottedByEnemyIndicators) {
                    LOSValuesForUnit = LOSUtility.GetLOSValues(TargetUnit.TileLocation, 
                                                               DestinationTile, 
                                                               TargetUnit, 
                                                               Outer.ControlledUnit, 
                                                               class'LOSUtility_GA'.static.GetUnitSightRange(TargetUnit));
                }
            } else {
                // For consistency, do the regular indicator for friendly units event though VIPs have no use for them
                LOSValuesForUnit = LOSUtility.GetLOSValues(DestinationTile, 
                                                           TargetUnit.TileLocation, 
                                                           Outer.ControlledUnit, 
                                                           TargetUnit, 
                                                           Outer.ControlledUnitSightRange);
            }

        } else {
            LOSValuesForUnit = LOSUtility.GetLOSValues(DestinationTile, 
                                                       TargetUnit.TileLocation, 
                                                       Outer.ControlledUnit, 
                                                       TargetUnit, 
                                                       Outer.ControlledUnitSightRange, 
                                                       VisibilityInfo); // Set VisibilityInfo from side-effect to be used in call to flanking function
            // Only update flanked status for enemy units
            if(TargetUnit.IsEnemyUnit(Outer.ControlledUnit)) {
                LOSValuesForUnit.bFlanked = LOSUtility.TargetIsFlankedFromTile(DestinationTile, Outer.ControlledUnit, TargetUnit, VisibilityInfo);
            }
        }

        // if(DoLoneWolfIndicator 
        //    && TargetUnit == Outer.ControlledUnit
        //    && Outer.ControlledUnit.FindAbility('LoneWolf') != EmptyRef
        //    && LoneWolfActiveFromTile(DestinationTile)) {
        //     LoneWolfWillBeActive = true;
        // }

        if(TargetUnit.ObjectID != Outer.ControlledUnit.ObjectID && Outer.ControlledUnit.IsEnemyUnit(TargetUnit) && Outer.ControlledUnit.FindAbility('CloseEncounters') != EmptyRef)
        {
            TileDistance = VSize(`XWORLD.GetPositionFromTileCoordinates(DestinationTile) - `XWORLD.GetPositionFromTileCoordinates(TargetUnit.TileLocation)) / `XWORLD.WORLD_StepSize;
            if(TileDistance <= 4)
            {
                CeWillBeActive = true;
            }
        }
        else if(TargetUnit.ObjectID != Outer.ControlledUnit.ObjectID && Outer.ControlledUnit.IsEnemyUnit(TargetUnit) && Outer.ControlledUnit.FindAbility('KnifeEncounters') != EmptyRef)
        {
            TileDistance = VSize(`XWORLD.GetPositionFromTileCoordinates(DestinationTile) - `XWORLD.GetPositionFromTileCoordinates(TargetUnit.TileLocation)) / `XWORLD.WORLD_StepSize;
            if(TileDistance <= 6)
            {
                CeWillBeActive = true;
            }
        }

        CacheUtility.GetLOSIndicatorForUnitFlag(UnitFlag).SetIcon(IconPack, GetIndicatorValueForUnit(Outer.ControlledUnit, TargetUnit, LOSValuesForUnit, false, CeWillBeActive));
    }
}


private function bool LoneWolfActiveFromTile(const out TTile DestinationTile) {
    local UIUnitFlag UnitFlag;
    local XComGameState_Unit TargetUnit;
    local XComWorldData WorldData;
    local int TileDistance;
    
    WorldData = class'XComWorldData'.static.GetWorldData();

    foreach Outer.m_arrFlags(UnitFlag) {
        TargetUnit = XComGameState_Unit(class'XComGameStateHistory'.static.GetGameStateHistory().GetGameStateForObjectID(UnitFlag.StoredObjectID));
        if(TargetUnit == none 
           || TargetUnit == Outer.ControlledUnit
           || TargetUnit.IsEnemyUnit(Outer.ControlledUnit)
           || TargetUnit.IsBleedingOut()) continue;

        TileDistance = VSize(WorldData.GetPositionFromTileCoordinates(DestinationTile) - WorldData.GetPositionFromTileCoordinates(TargetUnit.TileLocation)) / WorldData.WORLD_StepSize;

        // Grabing the distance from the LW2 file causes a conflict (depending on loadorder it seems) breaking loot-drops... WTF?!
        //if(TileDistance <= class'X2Effect_LoneWolf'.default.LONEWOLF_MIN_DIST_TILES) {
        if(TileDistance <= 7) {
            return false;
        }
    }
    return true;
}


public function EIndicatorValue GetIndicatorValueForUnit(XComGameState_Unit SourceUnit, XComGameState_Unit TargetUnit, const out LOSValues LOSValuesForUnit, optional bool LoneWolfIndicator = false, optional bool CeIndicator = false) {
    local StateObjectReference EmptyRef;

    // Handle indicator on the moving units flag
    if(SourceUnit == TargetUnit) {
        if(LoneWolfIndicator) {
            return eLoneWolfActive;
        } else {
            return eNotVisible;
        }
    }


    if(!LOSValuesForUnit.bClearLOS) return eNotVisible;

    if (SourceUnit.ObjectId != TargetUnit.ObjectId){
        if(CeIndicator)
        {
            return LOSValuesForUnit.bFlanked ? eSquadsightFlanked : eSquadsight;
        } 
    }
    // Handle friendly unit indicators
    if(!TargetUnit.IsEnemyUnit(Outer.ControlledUnit)) return (class'LW_GotchaAgain_IntegratedSettings'.default.bShowFriendlyLOSIndicators && LOSValuesForUnit.bWithinRegularRange) ? eSpottedFriendly : eNotVisible;
    
    // Handle VIPs
    if(Outer.bControlledUnitIsVIP) return LOSValuesForUnit.bWithinRegularRange ? eSpottedByEnemy : eNotVisible;

    // Reaching this, we know there is clear LOS
    if(LOSValuesForUnit.bWithinRegularRange) return LOSValuesForUnit.bFlanked ? eFlanked : eSpotted;

    // Here we also know the target is outside regular range
    if(SourceUnit.HasSquadsight()) return LOSValuesForUnit.bFlanked ? eSquadsightFlanked : eSquadsight;
    
    // Here we check whether to show the indicator for hackable units
    if(class'LW_GotchaAgain_IntegratedSettings'.default.bShowSquadsightHackingIndicator
       && (SourceUnit.FindAbility('CombatProtocol') != EmptyRef
           || ((SourceUnit.FindAbility('HaywireProtocol') != EmptyRef 
                || SourceUnit.FindAbility('FullOverride') != EmptyRef)
               && TargetUnit.IsRobotic()
               && !TargetUnit.HasBeenHacked())
           || (SourceUnit.FindAbility('Interference') != EmptyRef
               && TargetUnit.ReserveActionPoints.Find('Overwatch') != INDEX_NONE ))) return eHackable;

    // Reaching this, we know there is clear LOS to the target, but it is outside regular range
    // and the source unit does not qualify for a squadsight indicator, so we return not visible
    return eNotVisible;
}


public function ClearUnitLOSIndicators() {
    local int i;

    for(i = 0; i < CacheUtility.UnitFlagCache.Length; i++) {
        // This might not have been created yet
        if(CacheUtility.UnitFlagCache[i].UnitLOSIcon != none) {
            CacheUtility.UnitFlagCache[i].UnitLOSIcon.SetIcon(IconPack, eNotVisible);
        }
    }    
}


public static function bool UnitIsVIP(XComGameState_Unit Unit) {
    // Civilians that can flank units will not be VIPs (e.g. resistance units from LW2)
    return Unit.GetMyTemplate().bIsCivilian && !Unit.GetMyTemplate().CanFlankUnits;
}