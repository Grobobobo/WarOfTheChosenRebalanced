class LOSUtility_GA extends Object;

struct LOSValues {
    var bool bClearLOS,
             bWithinRegularRange,
             bFlanked;
};


public function LOSValues GetLOSValues(const out TTile SourceTile,
                                       const out TTile TargetTile,
                                       XComGameState_Unit SourceUnit,
                                       XComGameState_Unit TargetUnit,
                                       int SightRange,
                                       optional out GameRulesCache_VisibilityInfo VisibilityInfo,
                                       optional bool DisallowStepout = false) {
    local GameRulesCache_VisibilityInfo EmptyVisibilityInfo;
    local LOSValues LOSValuesForUnit;
    local TTile TargetCheckTile;
    local TTile SourceCheckTile;
    local int UnitSize, UnitHeight;
    local int i, j, k, l;
    local bool bReverseLOS;

    // This is an out-parameter! If anything was input reset it so an empty set is returned should we not do any actual checks for some reason.
    VisibilityInfo = EmptyVisibilityInfo;

    // LOS is checked within loops that varies the target-tile based on unitsize and unitheight, making units larger than one tile have a check for all tiles!
    if(TargetUnit != none) {
        UnitSize = TargetUnit.UnitSize;
        UnitHeight = TargetUnit.UnitHeight;
    } else {
        UnitSize = 1;
        UnitHeight = 1;
    }

    // For TargetUnits that cannot take cover, we need to verify by checking reverse LOS, because LOS is weird for those when they are behind cover.
    // This should be possible do achieve by simply checking bVisibleToDefault in the VisibilityInfo returned from the real LOS check, but it isn't. Probably because we're not supplying units for the LOS check.
    // We do this first, so we will have the correct VisibilityInfo later when doing the flanking check!
    if(TargetUnit != none && !TargetUnit.CanTakeCover()) {
        // The first 3 sets of loops varies the tiles checked at the Target (which is used as the source in this reverse check)
        for(i = 0; i < UnitSize; i++) {
            for(j = 0; j < UnitSize; j++) {
                for(k = 0; k < UnitHeight; k++) {
                    TargetCheckTile = TargetTile;
                    TargetCheckTile.X += i; TargetCheckTile.Y += j; TargetCheckTile.Z += k;

                    // We need to vary the height for the SourceUnit as well for this reverse LOS check
                    // Sectopods get to check from one tile higher because of the blaster that folds out and extends the height...
                    for(l = 0; l < SourceUnit.UnitHeight + (SourceUnit.GetMyTemplateName() == 'Sectopod' ? 1 : 0); l++) {
                        SourceCheckTile = SourceTile;
                        SourceCheckTile.Z += l;

                        VisibilityInfo = EmptyVisibilityInfo;   // Reset this struct values before each call!
                        bReverseLOS = class'XComWorldData'.static.GetWorldData().CanSeeTileToTile(TargetCheckTile, SourceCheckTile, VisibilityInfo) // VisibilityInfo filled by side-effect!
                                        && (VisibilityInfo.bVisibleFromDefault);                                                                    // Must be true without stepouts!
                        if(bReverseLOS) break; // Exit loops as soon as LOS is true
                    }
                    if(bReverseLOS) break; // Exit loops as soon as LOS is true
                }
                if(bReverseLOS) break; // Exit loops as soon as LOS is true
            }
            if(bReverseLOS) break; // Exit loops as soon as LOS is true
        }
    } else {
        // If the verification check is not needed, set ClearLOS true
        bReverseLOS = true;
    }

    // This is the actual LOS check! Only do it if the verification check was passed...
    if(bReverseLOS) {
        // Again we vary the tiles checked at the target to check against all tiles occupied by it
        for(i = 0; i < UnitSize; i++) {
            for(j = 0; j < UnitSize; j++) {
                for(k = 0; k < UnitHeight; k++) {
                    TargetCheckTile = TargetTile;
                    TargetCheckTile.X += i; TargetCheckTile.Y += j; TargetCheckTile.Z += k;

                    // And again we vary the height for the SourceUnit
                    // Sectopods get to check from one tile higher because of the blaster that folds out and extends the height...
                    for(l = 0; l < SourceUnit.UnitHeight + (SourceUnit.GetMyTemplateName() == 'Sectopod' ? 1 : 0); l++) {
                        SourceCheckTile = SourceTile;
                        SourceCheckTile.Z += l;

                        VisibilityInfo = EmptyVisibilityInfo;   // Reset this struct values before each call!
                        if(class'XComWorldData'.static.GetWorldData().CanSeeTileToTile(SourceCheckTile, TargetCheckTile, VisibilityInfo) // VisibilityInfo filled by side-effect!
                           && ((!DisallowStepout && SourceUnit.CanTakeCover()) // If SourceUnit cannot take cover, LOS must be clear without stepouts from it
                               || VisibilityInfo.bVisibleFromDefault)) {
                        
                            LOSValuesForUnit.bClearLOS = true;
                            LOSValuesForUnit.bWithinRegularRange = LOSValuesForUnit.bClearLOS 
                                                                   && VisibilityInfo.DefaultTargetDist < SightRange;
                        }
                        if(LOSValuesForUnit.bWithinRegularRange) break; // Exit loops if LOS is true and it is within regular range
                    }
                    if(LOSValuesForUnit.bWithinRegularRange) break; // Exit loops if LOS is true and it is within regular range
                }
                if(LOSValuesForUnit.bWithinRegularRange) break; // Exit loops if LOS is true and it is within regular range
            }
            if(LOSValuesForUnit.bWithinRegularRange) break; // Exit loops if LOS is true and it is within regular range
        }
    } else {
        // If we're not doing the actual LOS check, we reset VisibilityInfo before returning so we don't return one from the reverse LOS check
        VisibilityInfo = EmptyVisibilityInfo;
    }

    return LOSValuesForUnit;
}


public function bool TargetIsFlankedFromTile(const out TTile SourceTile, XComGameState_Unit SourceUnit, XComGameState_Unit TargetUnit, GameRulesCache_VisibilityInfo VisibilityInfo) {
    local vector SourceVector,
                 TargetVector;
    local CachedCoverAndPeekData PeekData;
    local ECoverType TargetCover;
    local array<int> CoverDirectionsToCheck;
    local int i;

    // Some units cannot take cover and thus cannot be flanked, and some units cannot flank (melee-only units I guess?)
    // Here we use bCanTakeCover from the template, since we want to be able to get a flanking indicator for unactivated units and these are not able to use cover yet
    if(!TargetUnit.GetMyTemplate().bCanTakeCover || !SourceUnit.CanFlank()) return false;

    // Parameters for GetCoverTypeForTarget() are out variables, so we need local copies of the values we use        
    SourceVector = class'XComWorldData'.static.GetWorldData().GetPositionFromTileCoordinates(SourceTile);
    TargetVector = class'XComWorldData'.static.GetWorldData().GetPositionFromTileCoordinates(TargetUnit.TileLocation);
    TargetCover = class'XComWorldData'.static.GetWorldData().GetCoverTypeForTarget(SourceVector, TargetVector, VisibilityInfo.TargetCoverAngle); // TargetCoverAngle is an out parameter! It is never used...

    // VisibilityInfo is shady as fuck and cannot be trusted!
    // If bVisibleFromDefault is false, the LOS requires peeking, but we don't always know to which side (the PeekSide value can be eNoPeek regardless)!
    // But if it is true, the LOS is from the actual tile without stepping out
    if(VisibilityInfo.bVisibleFromDefault && TargetCover == CT_None) return true;

    // Determine in which direction covers will be relevant to check for peeks
    CoverDirectionsToCheck = GetPotentialCoverDirections(SourceVector, TargetVector);
    PeekData = class'XComWorldData'.static.GetWorldData().GetCachedCoverAndPeekData(SourceTile);
        
    // PeekSide seem to be reliable when it is not eNoPeek... let's hope that it actually is!
    switch(VisibilityInfo.PeekSide) {
        case ePeekLeft:
            foreach CoverDirectionsToCheck(i) {
                if(PeekData.CoverDirectionInfo[i].bHasCover == 1 && 
                   PeekData.CoverDirectionInfo[i].LeftPeek.bHasPeekaround == 1) {
                    if(TargetHasCoverFromPeekTile(PeekData.CoverDirectionInfo[i].LeftPeek, TargetUnit.TileLocation, TargetVector, TargetUnit, SourceUnit)) return true;
                }
            }
            break;

        case ePeekRight:
            foreach CoverDirectionsToCheck(i) {
                if(PeekData.CoverDirectionInfo[i].bHasCover == 1 && 
                   PeekData.CoverDirectionInfo[i].RightPeek.bHasPeekaround == 1) {
                    if(TargetHasCoverFromPeekTile(PeekData.CoverDirectionInfo[i].RightPeek, TargetUnit.TileLocation, TargetVector, TargetUnit, SourceUnit)) return true;
                }
            }
            break;

        case eNoPeek:
            // We don't know which side we're peeking to (eNoPeek ought to mean we're not, but it doesn't... WTF?!)
            // Check both sides
            foreach CoverDirectionsToCheck(i) {
                if(PeekData.CoverDirectionInfo[i].bHasCover == 1) {
                    if(PeekData.CoverDirectionInfo[i].LeftPeek.bHasPeekaround == 1) {
                        if(TargetHasCoverFromPeekTile(PeekData.CoverDirectionInfo[i].LeftPeek, TargetUnit.TileLocation, TargetVector, TargetUnit, SourceUnit, true)) return true;
                    }
                    if(PeekData.CoverDirectionInfo[i].RightPeek.bHasPeekaround == 1) {
                        if(TargetHasCoverFromPeekTile(PeekData.CoverDirectionInfo[i].RightPeek, TargetUnit.TileLocation, TargetVector, TargetUnit, SourceUnit, true)) return true;
                    }
                }
            }
            break;
    }
    
    return false;
}


private function array<int> GetPotentialCoverDirections(const out vector SourceVector, const out vector TargetVector) {     // out parameters to pass-by-ref
    local vector PeekFromCoverInDirection;
    local array<int> CoverDirections;

    PeekFromCoverInDirection = TargetVector - SourceVector;
    if(PeekFromCoverInDirection.X < 0) CoverDirections.AddItem(2);
    if(PeekFromCoverInDirection.X > 0) CoverDirections.AddItem(3);
    if(PeekFromCoverInDirection.Y < 0) CoverDirections.AddItem(1);
    if(PeekFromCoverInDirection.Y > 0) CoverDirections.AddItem(0);
    return CoverDirections;
}


private function bool TargetHasCoverFromPeekTile(const out PeekAroundInfo PeekData, TTile TargetTile, vector TargetVector, XComGameState_Unit TargetUnit, XComGameState_Unit SourceUnit, optional bool CheckVisibility = false) {
    local float CoverAngle; // Is not used, but GetCoverTypeForTarget needs an out parameter

    // We only check visibility in certain cases (when PeekSide is noPeek), since shots can be taken from a tile being peeked to even though there
    // is no visibility from that tile. Hopefully that will not be needed when PeekSide is noPeek...
    // Do not allow visibility from a stepout from this tile and don't care about range, so just pass 0 as sightrange.
    if(CheckVisibility && !GetLOSValues(PeekData.PeekTile, 
                                        TargetTile, 
                                        SourceUnit, 
                                        TargetUnit, 
                                        0, 
                                        , 
                                        true).bClearLOS) return false;

    return class'XComWorldData'.static.GetWorldData().GetCoverTypeForTarget(PeekData.PeekaroundLocation, TargetVector, CoverAngle) == CT_None;
}



static function int GetUnitSightRange(XComGameState_Unit Unit) {
    local float DistInUnits;

    // Macros are evil, but it kind of makes sense to use one here
    DistInUnits = `METERSTOUNITS(Unit.GetVisibilityRadius());
    return DistInUnits * DistInUnits;
}

