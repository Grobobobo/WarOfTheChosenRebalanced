class XGAIBehavior_override extends XGAIBehavior config(AILogs);

var config bool ENABLE_AI_LOGGING;

function bool BT_IsFlanked()
{
	return UnitState.IsFlanked(,true);
}

// function bool IsValidTarget(AvailableTarget kTarget)
// {
// 	local bool retVal;
// 	local XComGameStateHistory History;
// 	local XComGameState_Unit kTargetState;

// 	retVal = super.IsValidTarget(kTarget);

// 	// If we found a valid target and we are an AI, reconsider if the target is civilian.
// 	if (retVal &&
// 		UnitState.ControllingPlayerIsAI() && 
// 		m_kPlayer != None ) {
// 		History = `XCOMHISTORY;
// 		kTargetState = XComGameState_Unit(History.GetGameStateForObjectID(kTarget.PrimaryTarget.ObjectID));
// 		if( kTargetState != None && 
// 			kTargetState.GetTeam() == eTeam_Neutral && 
// 			!m_kPlayer.bCiviliansTargetedByAliens) // Ignore civs if the AI player has visibility of XCom.
// 		{
// 			retVal = false;
// 		}
// 	}

// 	return retVal;
// }

// Adds check to ignore mind controlled units
function bool GetAllAoETargets(out array<TTile> TargetList, AoETargetingInfo Profile, out XComGameState_Unit RequiredTarget, optional out array<int> TargetIDs, bool bBaseUnitTiles=false, optional array<Name> DeprioritizedEffects, optional out array<XComGameState_Unit> TargetStates)
{
	local array<XComGameState_Unit> UnitList;
	local XComGameState_Unit TargetState;
	local AvailableTarget Target;
	local XComGameState_Ability AbilityState;
	local array<TTile> VisTiles;
	local TTile Tile;
	local bool bValid;
	local X2Effect MultiTargetEffect;
	local X2AbilityTemplate AbilityTemplate;

	if (!GetUnfilteredAoETargetList(UnitList, Profile, RequiredTarget, DeprioritizedEffects))
	{
		return false;
	}

	FindAbilityByName(Profile.Ability, AbilityState);

	foreach UnitList(TargetState)
	{
		if( Profile.bTestLocationValidity )
		{
			Target.AdditionalTargets.Length = 0;
			AbilityState.GatherAdditionalAbilityTargetsForLocation(TopAoETarget.Location, Target);
			if( Target.AdditionalTargets.Length == 0 )
			{
				continue;
			}
		}

		if ( Profile.bTestTargetEffectsApply )
		{
			AbilityTemplate = AbilityState.GetMyTemplate();
			// Ignore units that are immune to this ability. (passes as long as any effect applies to this unit)
			foreach AbilityTemplate.AbilityMultiTargetEffects(MultiTargetEffect)
			{
				if (MultiTargetEffect.TargetIsValidForAbility(TargetState, UnitState, AbilityState))
				{
					bValid = true;
					break;
				}
			}
			if (!bValid)
			{
				continue;
			}
		}
		//Ignore mind controlled units in AOE targeting
		if(TargetState.IsMindControlled())
		{
			continue;
		}

		// Ignore inactive AI units that are not visible.
		if (TargetState.ControllingPlayerIsAI() && TargetState.IsUnrevealedAI()
			&& !class'X2TacticalVisibilityHelpers'.static.CanUnitSeeLocation(UnitState.ObjectID, TargetState.TileLocation))
		{
			continue;
		}
		if( !TargetState.GetMyTemplate().bIsCosmetic // Skip gremlins from being considered in AoE attacks.
		       && !TargetState.IsIncapacitated()   // Skip bleeding out / unconscious / Stasis lanced.
			   && !TargetState.IsConcealed() )      // Do not consider units we should not be able to see.
		{
			if (!Profile.bRequireLoS || class'X2TacticalVisibilityHelpers'.static.CanUnitSeeLocation(UnitState.ObjectID, TargetState.TileLocation))
			{
				if (bBaseUnitTiles)
				{
					TargetList.AddItem(TargetState.TileLocation);
				}
				else
				{
					VisTiles.Length = 0;
					TargetState.GetVisibilityLocation(VisTiles);
					foreach VisTiles(Tile)
					{
						TargetList.AddItem(Tile);
					}
				}
				TargetIDs.AddItem(TargetState.ObjectID);
				TargetStates.AddItem(TargetState);
			}
		}
	}
	return TargetList.Length > 0;
}


function SaveBTTraversals()
{
	local int RootIndex;
	local array<BTDetailedInfo> arrStatusList;

	if(default.ENABLE_AI_LOGGING)
	{
		BT_GetNodeDetailList(arrStatusList);
		RootIndex = `BEHAVIORTREEMGR.GetNodeIndex(m_kBehaviorTree.m_strName);
		AddTraversalData(arrStatusList, RootIndex);
	}
	
}


// Make Sure Enemies don't heat seek concealed and super concealed soldiers
function XComGameState_Unit GetNearestKnownEnemy(vector vLocation, optional out float fClosestDistSq, optional array<GameRulesCache_VisibilityInfo> EnemyInfos, bool IncludeCiviliansOnTerrorMaps=true)
{
	local XComGameState_AIUnitData kUnitData;
	local int iDataID;
	local array<StateObjectReference> arrKnownEnemyList;
	local StateObjectReference kEnemyRef;
	local XComGameStateHistory History;
	local XComGameState_Unit kEnemy, kClosest;
	local vector vAlertLocation;
	local float fDistSq;
	local GameRulesCache_VisibilityInfo VisInfo;

	History = `XCOMHISTORY;

	// Use pre-existing info if available.
	if( EnemyInfos.Length > 0 )
	{
		foreach EnemyInfos(VisInfo)
		{
			if( kClosest == None || VisInfo.DefaultTargetDist < fClosestDistSq )
			{
				kEnemy = XComGameState_Unit(History.GetGameStateForObjectID(VisInfo.SourceID));
				if( !kEnemy.IsConcealed() && !kEnemy.IsSuperConcealed())
				{
					kClosest = XComGameState_Unit(History.GetGameStateForObjectID(VisInfo.SourceID));
					fClosestDistSq = VisInfo.DefaultTargetDist;
				}
			}
		}
		return kClosest;
	}

	iDataID = GetAIUnitDataID(m_kUnit.ObjectID);
	if( iDataID > 0 )
	{
		kUnitData = XComGameState_AIUnitData(History.GetGameStateForObjectID(iDataID));
		if( kUnitData != None )
		{
			kUnitData.GetAbsoluteKnowledgeUnitList(arrKnownEnemyList,,,IncludeCiviliansOnTerrorMaps);
			foreach arrKnownEnemyList(kEnemyRef)
			{
				kEnemy = XComGameState_Unit(History.GetGameStateForObjectID(kEnemyRef.ObjectID));
				if( kEnemy.GetTeam() == eTeam_Neutral && kEnemy.IsAlien() )
				{
					continue; // Don't consider faceless civilians in this check.
				}
				vAlertLocation = `XWORLD.GetPositionFromTileCoordinates(kEnemy.TileLocation);
				fDistSq = VSizeSq(vAlertLocation - vLocation);
				if( kClosest == None || fDistSq < fClosestDistSq )
				{
					if( !kEnemy.IsConcealed() && !kEnemy.IsSuperConcealed())
					{
						kClosest = kEnemy;
						fClosestDistSq = fDistSq;
					}
				}
			}
		}
	}
	
	if( kUnitData == None ) // This unit may not have AIUnitData if it is mind-controlled.
	{
		class'X2TacticalVisibilityHelpers'.static.GetClosestVisibleEnemy(UnitState.ObjectID, VisInfo);
		if( VisInfo.SourceID > 0 )
		{
			fClosestDistSq = VisInfo.DefaultTargetDist;
			kClosest = XComGameState_Unit(History.GetGameStateForObjectID(VisInfo.SourceID));
			return kClosest;
		}

		if ( !GetNearestEnemy(kClosest, vLocation, fClosestDistSq) )
		{
			`Log("AIBehavior::GetNearestKnownEnemy - No enemies found. ");
		}

	}
	return kClosest;
}

