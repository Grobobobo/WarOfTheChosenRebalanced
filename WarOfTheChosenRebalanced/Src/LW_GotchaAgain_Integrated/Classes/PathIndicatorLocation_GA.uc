class PathIndicatorLocation_GA extends Object;

var int PathTileIndex;
var TTile Tile;
var PathIndicator_GA PathIndicator;
var EWaypointUpdateMode WaypointUpdateMode;
var array<EIndicatorType> IndicatorTypes;
var array<int> TriggeredOverwatchObjectIDs;
var array<int> TriggeredActivationObjectIDs;


public function AddIndicatorToLocation(EIndicatorType Indicator) {
    if(IndicatorTypes.Find(Indicator) == INDEX_NONE) {
        IndicatorTypes.AddItem(Indicator);
    }
}