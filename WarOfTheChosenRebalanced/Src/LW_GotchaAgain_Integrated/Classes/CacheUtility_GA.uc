class CacheUtility_GA extends Object
                      dependson(IconPack_GA);

struct ArrowObjectRelation {
    var XComGameState_IndicatorArrow_GA Arrow;
    var int ObjectID;
};

struct DoorHackingIndicatorRelation {
    var DoorHackingIndicator_GA DoorHackingIndicator;
    var int ObjectID;
};

struct UnitFlagCacheItem {
    var int UnitObjectID;
    var UIUnitFlag UnitFlag;
    var UIUnitLOSIndicator_GA UnitLOSIcon;
    var UIUnitActivationIndicator_GA UnitActivationIcon;
};

var IconPack_GA IconPack;

var bool bAdventTowersHaveBeenHacked;
var array<ArrowObjectRelation> ArrowObjectRelations;

var array<UnitFlagCacheItem> UnitFlagCache;
var array<DoorHackingIndicatorRelation> DoorHackingIndicators;


public function Init(IconPack_GA IconPackInstance) {
    IconPack = IconPackInstance;
}

public function DoorHackingIndicator_GA GetDoorHackingIndicator(XComGameState_InteractiveObject Door, Actor SpawnObjectOwner) {
    local int CacheIndex;
    local DoorHackingIndicatorRelation newDoorHackingIndicatorRelation;

    CacheIndex = DoorHackingIndicators.Find('ObjectID', Door.ObjectID);
    if(CacheIndex == INDEX_NONE) {
        CacheIndex = DoorHackingIndicators.Length;
        newDoorHackingIndicatorRelation.ObjectID = Door.ObjectID;
        newDoorHackingIndicatorRelation.DoorHackingIndicator = SpawnObjectOwner.Spawn(class'DoorHackingIndicator_GA', SpawnObjectOwner);
        newDoorHackingIndicatorRelation.DoorHackingIndicator.Init(Door);
        DoorHackingIndicators.AddItem(newDoorHackingIndicatorRelation);
    }
    return DoorHackingIndicators[CacheIndex].DoorHackingIndicator;
}


public function DestroyAllDoorHackingIndicators() {
    local int i;

    for(i = 0; i < DoorHackingIndicators.Length; i++) {
        DoorHackingIndicators[i].DoorHackingIndicator.Destroy();
    }
    DoorHackingIndicators.Length = 0;
}


public function SwitchIconPack(IconPack_GA IconPackInstance) {
    local int i;

    IconPack = IconPackInstance;
    for(i = 0; i < ArrowObjectRelations.Length; i++) {
        ArrowObjectRelations[i].Arrow.SetIcon(IconPackInstance, ArrowObjectRelations[i].Arrow.CurrentIndicatorValue, true);
    }
}


public function bool TowerHasBeenRevealed(XComGameState_InteractiveObject Tower) {
    return ArrowObjectRelations.Find('ObjectID', Tower.ObjectID) != INDEX_NONE;
}


public function AddRevealedTower(XComGameState_InteractiveObject Tower, XComGameState_IndicatorArrow_GA Arrow, EIndicatorValue IndicatorValue) {
    local ArrowObjectRelation newRelation;

    newRelation.Arrow = Arrow;
    newRelation.ObjectID = Tower.ObjectID;
    ArrowObjectRelations.AddItem(newRelation);
}


public function UIUnitLOSIndicator_GA GetLOSIndicatorForUnitFlag(UIUnitFlag UnitFlag) {
    return GetCacheItemForUnitFlag(UnitFlag).UnitLOSIcon;
}


public function UIUnitActivationIndicator_GA GetActivationIndicatorForUnitObjectID(int ObjectID) {
    local int CacheIndex;

    CacheIndex = UnitFlagCache.Find('UnitObjectID', ObjectID);
    return UnitFlagCache[CacheIndex].UnitActivationIcon;
}


private function UnitFlagCacheItem GetCacheItemForUnitFlag(UIUnitFlag UnitFlag) {
    local UnitFlagCacheItem newCacheItem;
    local int CacheIndex;

    CacheIndex = UnitFlagCache.Find('UnitFlag', UnitFlag);
    if(CacheIndex == INDEX_NONE) {
        newCacheItem.UnitObjectID = UnitFlag.StoredObjectID;
        newCacheItem.UnitFlag = UnitFlag;
        newCacheItem.UnitLOSIcon = UnitFlag.Spawn(class'UIUnitLOSIndicator_GA', UnitFlag).InitIndicator(UnitFlag);
        newCacheItem.UnitActivationIcon = UnitFlag.Spawn(class'UIUnitActivationIndicator_GA', UnitFlag).InitIndicator();
        UnitFlagCache.AddItem(newCacheItem);
        return newCacheItem;
    }
    return UnitFlagCache[CacheIndex];
}


public function XComGameState_InteractiveObject GetObjectForArrow(XComGameState_IndicatorArrow_GA Arrow) {
    local TTile ArrowTile;
    local XComGameState_InteractiveObject InteractiveObject;
    local ArrowObjectRelation newRelation;
    local int i;

    // Try the local cache first
    i = ArrowObjectRelations.Find('Arrow', Arrow);
    if (i != INDEX_NONE) {
        return XComGameState_InteractiveObject(class'XComGameStateHistory'.static.GetGameStateHistory().GetGameStateForObjectID(ArrowObjectRelations[i].ObjectID));
    }

    // Else search all interactive objects and insert in the local cache before returning it
    ArrowTile = class'XComWorldData'.static.GetWorldData().GetTileCoordinatesFromPosition(Arrow.Location);
    foreach class'XComGameStateHistory'.static.GetGameStateHistory().IterateByClassType(class'XComGameState_InteractiveObject', InteractiveObject) {
        if(ArrowTile == InteractiveObject.TileLocation) {
            newRelation.Arrow = Arrow;
            newRelation.ObjectID = InteractiveObject.ObjectID;
            ArrowObjectRelations.AddItem(newRelation);
            return InteractiveObject;
        }
    }
    return none;
}


public function XComGameState_IndicatorArrow_GA RemoveTowerFromCache(XComGameState_InteractiveObject TowerObject) {
    local int i;
    local XComGameState_IndicatorArrow_GA Arrow;

    i = ArrowObjectRelations.Find('ObjectID', TowerObject.ObjectID);
    if (i != INDEX_NONE) {
        Arrow = ArrowObjectRelations[i].Arrow;
        ArrowObjectRelations.RemoveItem(ArrowObjectRelations[i]);
    }
    return Arrow;
}


public function array<XComGameState_Unit> GetRevealedEnemiesOfUnit(XComGameState_Unit Unit, bool forceAllRevealed) {
    local int i;
    local array<XComGameState_Unit> RevealedEnemies;
    local XComGameState_Unit EnemyUnit;
    
    for(i=UnitFlagCache.Length - 1; i > -1; i--) {
        // Do some cleanup since we're going through the Cache anyway
        // Dead units don't have UnitFlags anymore, so if this is none we can remove it!
        if(UnitFlagCache[i].UnitFlag == none) {
            UnitFlagCache.RemoveItem(UnitFlagCache[i]);
            continue;
        }
        EnemyUnit = XComGameState_Unit(class'XComGameStateHistory'.static.GetGameStateHistory().GetGameStateForObjectID(UnitFlagCache[i].UnitFlag.StoredObjectId));
        
        if(EnemyUnit.IsEnemyUnit(Unit) && (EnemyUnit.GetVisualizer().IsVisible() || forceAllRevealed)) {
            RevealedEnemies.AddItem(EnemyUnit);
        }
    }
    return RevealedEnemies;
}