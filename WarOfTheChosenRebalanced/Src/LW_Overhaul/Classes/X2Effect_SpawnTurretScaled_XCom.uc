//From Deployable Turrets mod for WotC
class X2Effect_SpawnTurretScaled_XCom extends X2Effect_SpawnUnit;

function vector GetSpawnLocation(const out EffectAppliedData ApplyEffectParameters, XComGameState NewGameState)
{
	local Vector DropPosition;

	DropPosition = ApplyEffectParameters.AbilityInputContext.TargetLocations[0];

	if(ApplyEffectParameters.AbilityInputContext.TargetLocations.Length == 0)
	{
		`Redscreen("Attempting to create X2Effect_SpawnDeployableTurret without a target location! @dslonneger");
		return vect(0,0,0);
	}
	
	return DropPosition;
}

function ETeam GetTeam(const out EffectAppliedData ApplyEffectParameters)
{
	return GetSourceUnitsTeam(ApplyEffectParameters);
}
function AddSpawnVisualizationsToTracks_Parent(XComGameStateContext Context, XComGameState_Unit SpawnedUnit, out VisualizationActionMetadata SpawnedUnitTrack,
										XComGameState_Unit EffectTargetUnit, X2Action Parent)
{
	class'X2Action_ShowSpawnedUnit'.static.AddToVisualizationTree(SpawnedUnitTrack, Context, false, Parent);
}

function name GetUnitToSpawnName(const out EffectAppliedData ApplyEffectParameters)
{
	local XComGameStateHistory				History;
	local XComGameState_HeadquartersXCom	XComHQ;

	//This only works for templates that follow the M1, M2, M3 naming convention,
	//also only for XComTurret

	//Use a different subclass for custom turret templates instead
	if (UnitToSpawnName != 'XComTurret')
	{
		return UnitToSpawnName;		
	}

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	if (XComHQ.TacticalGameplayTags.Find('AvengerDefenseTurretsMk2') != INDEX_NONE)
	{
		return 'XCOMTurretM2';
	}

	return 'XCOMTurretM1';
	
}

defaultproperties
{
	UnitToSpawnName="XComTurret"
	bKnockbackAffectsSpawnLocation=false
}