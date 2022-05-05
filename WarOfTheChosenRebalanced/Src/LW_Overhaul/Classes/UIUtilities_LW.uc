//---------------------------------------------------------------------------------------
//  FILE:    UIUtilities_LW
//  AUTHOR:  tracktwo / Pavonis Interactive
//
//  PURPOSE: Miscellanous UI helper routines
//---------------------------------------------------------------------------------------

class UIUtilities_LW extends Object config(LW_Overhaul);

var config array<name> EvacFlareMissions;
var config array<name> EvacFlareEscapeMissions;
var config array<name> FixedExitMissions;
var config array<name> DelayedEvacMissions;
var config array<name> NoEvacMissions;
var config array<name> ObjectiveTimerMissions;
var config array<name> EvacTimerMissions;
var config(LW_UI) bool USE_LARGE_INFO_PANEL;
var config(LW_UI) bool CENTER_TEXT_IN_LIP;

var const array<string> PlotTypes;

var localized string m_strInfiltrationMission;
var localized string m_strQuickResponseMission;
var localized string m_strFixedEvacLocation;
var localized string m_strFlareEvac;
var localized string m_strDelayedEvac;
var localized string m_strNoEvac;
var localized string m_strMaxSquadSize;
var localized string m_strConcealedStart;
var localized string m_strRevealedStart;
var localized string m_strObjectiveTimer;
var localized string m_strExtractionTimer;
var localized string m_strGetCorpses;
var localized string m_strSweepObjective;
var localized string m_strEvacRequired;
var localized string m_strTurnSingular;
var localized string m_strTurnPlural;
var localized string m_strMinimumInfiltration;
var localized string m_strYellowAlert;
var localized string m_sAverageScatterText;
var localized string m_strBullet;

var localized string m_strStripWeaponUpgrades;
var localized string m_strStripWeaponUpgradesLower;
var localized string m_strStripWeaponUpgradesConfirm;
var localized string m_strStripWeaponUpgradesConfirmDesc;
var localized string m_strTooltipStripWeapons;
var localized string m_strVIPCaptureReward;

// Initiate the process of taking a unit's picture. May immediately return the picture if it's available, or return none if the
// picture isn't yet available but will be taken asynchronously. The provided callback will be invoked when the picture is ready, and
// the caller should call FinishUnitPicture() when the callback is invoked.
function static Texture2D TakeUnitPicture(
	StateObjectReference UnitRef,
	delegate<X2Photobooth_AutoGenBase.OnAutoGenPhotoFinished> Callback)
{
	local Texture2D Pic;

    // First check to see if we already have one
	Pic = GetUnitPictureIfExists(UnitRef);

    // Nope: queue one up
	if (Pic == none)
	{
		`HQPRES.GetPhotoboothAutoGen().AddHeadShotRequest(UnitRef, 128, 128, Callback, , , true);
		`HQPRES.GetPhotoboothAutoGen().RequestPhotos();

		`GAME.GetGeoscape().m_kBase.m_kCrewMgr.TakeCrewPhotobgraph(UnitRef,,true);
	}

    return Pic;
}

// Complete an asynchronous unit picture request. Pass in the unit reference that is sent
// to the callback provided with TakeUnitPicture.
function static Texture2D FinishUnitPicture(StateObjectReference UnitRef)
{
	return GetUnitPictureIfExists(UnitRef);
}

function static Texture2D GetUnitPictureIfExists(StateObjectReference UnitRef)
{
	local XComGameState_CampaignSettings SettingsState;

	SettingsState = XComGameState_CampaignSettings(
		`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_CampaignSettings'));
	return `XENGINE.m_kPhotoManager.GetHeadshotTexture(SettingsState.GameIndex, UnitRef.ObjectID, 128, 128);
}


static function string GetTurnsLabel(int kounter)
{
	if (kounter == 1)
		return default.m_strTurnSingular;
	return default.m_strTurnPlural;
}

static function bool HasSweepObjective (XComGameState_MissionSite MissionState)
{
	local int ObjectiveIndex;

    ObjectiveIndex = 0;
    if(ObjectiveIndex < MissionState.GeneratedMission.Mission.MissionObjectives.Length)
    {
        if(instr(string(MissionState.GeneratedMission.Mission.MissionObjectives[ObjectiveIndex].ObjectiveName), "Sweep") != -1)
        {
            return true;
        }
    }
    return false;
}

static function bool FullSalvage (XComGameState_MissionSite MissionState)
{
	local int ObjectiveIndex;

    ObjectiveIndex = 0;
    if(ObjectiveIndex < MissionState.GeneratedMission.Mission.MissionObjectives.Length)
    {
        if(MissionState.GeneratedMission.Mission.MissionObjectives[ObjectiveIndex].bIsTacticalObjective)
        {
            return true;
        }
    }
    return false;
}

static function string GetTimerInfoString (XComGameState_MissionSite MissionState)
{
	local int Timer;

	Timer = class'SeqAct_InitializeMissionTimer'.static.GetInitialTimer(
		MissionState.GeneratedMission.Mission.sType,
		MissionState.GeneratedMission.Mission.MissionFamily);
	if (Timer > 0)
	{
		if (default.ObjectiveTimerMissions.Find (MissionState.GeneratedMission.Mission.MissionName) != -1)
		{
			return default.m_strObjectiveTimer @ string(Timer - 1) @ GetTurnsLabel(Timer);
		}
		else
		{
			if (default.EvacTimerMissions.Find (MissionState.GeneratedMission.Mission.MissionName) != -1)
			{
				if (default.FixedExitMissions.Find (MissionState.GeneratedMission.Mission.MissionName) != -1)
				{
					return default.m_strExtractionTimer @ string(Timer - 1) $ "+" @ GetTurnsLabel(Timer);
				}
				else
				{
					return default.m_strExtractionTimer @ string(Timer - 1) @ GetTurnsLabel(Timer);
				}
			}
		}
	}
	return "";
}

static function string GetEvacTypeString (XComGameState_MissionSite MissionState)
{
	if (default.EvacFlareMissions.Find (MissionState.GeneratedMission.Mission.MissionName) != -1 || default.EvacFlareEscapeMissions.Find (MissionState.GeneratedMission.Mission.MissionName) != -1)
	{
		return default.m_strFlareEvac;
	}
	else
	{
		if (default.FixedExitMissions.Find (MissionState.GeneratedMission.Mission.MissionName) != -1)
		{
			return default.m_strFixedEvacLocation;
		}
		else
		{
			if (default.DelayedEvacMissions.Find (MissionState.GeneratedMission.Mission.MissionName) != -1)
			{
				return default.m_strDelayedEvac;
			}
			else
			{
				if (default.NoEvacMissions.Find (MissionState.GeneratedMission.Mission.MissionName) != -1)
				{
					return default.m_strNoEvac;
				}
			}
		}
	}
	return "";
}

// Returns a player-friendly name for the given plot type, so they
// know what map type they'll be playing on
static function string GetPlotTypeFriendlyName(string PlotType)
{
	local int i;

	// Use the multiplayer localisation to get the friendly name for a given plot type
	i = default.PlotTypes.Find(PlotType);

	if (i == INDEX_NONE)
	{
		`REDSCREEN("Unknown plot type '" $ PlotType $ "' encountered in GetPlotTypeFriendlyName()");
		return "???";
	}
	else
	{
		return class'X2MPData_Shell'.default.arrMPMapFriendlyNames[i];
	}
}

static function vector2d GetMouseCoords()
{
	local PlayerController PC;
	local PlayerInput kInput;
	local vector2d vMouseCursorPos;

	foreach `XWORLDINFO.AllControllers(class'PlayerController',PC)
	{
		if ( PC.IsLocalPlayerController() )
		{
			break;
		}
	}
	kInput = PC.PlayerInput;

	XComTacticalInput(kInput).GetMouseCoordinates(vMouseCursorPos);
	return vMouseCursorPos;
}

static function string GetHTMLAverageScatterText(float value, optional int places = 2)
{
	local XGParamTag LocTag;
	local string ReturnString, FloatString, TempString;
	local int i;
	local float TempFloat, TestFloat;

	TempFloat = value;
	for (i=0; i< places; i++)
	{
		TempFloat *= 10.0;
	}
	TempFloat = Round(TempFloat);
	for (i=0; i< places; i++)
	{
		TempFloat /= 10.0;
	}

	TempString = string(TempFloat);
	for (i = InStr(TempString, ".") + 1; i < Len(TempString) ; i++)
	{
		FloatString = Left(TempString, i);
		TestFloat = float(FloatString);
		if (TempFloat ~= TestFloat)
		{
			break;
		}
	}

	if (Right(FloatString, 1) == ".")
	{
		FloatString $= "0";
	}

	LocTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
	LocTag.StrValue0 = FloatString;
	ReturnString = `XEXPAND.ExpandString(default.m_sAverageScatterText);

	return class'UIUtilities_Text'.static.GetColoredText(ReturnString, eUIState_Bad, class'UIUtilities_Text'.const.BODY_FONT_SIZE_3D);
}

static function bool ShouldShowPsiOffense(XComGameState_Unit UnitState)
{
	return UnitState.IsPsiOperative() ||
		(UnitState.GetRank() == 0 && !UnitState.CanRankUpSoldier() && `XCOMHQ.IsTechResearched('AutopsySectoid'));
}

// KDM : Adds a UIButton, if it exists and is visible, to a UIScreen's Navigator; furthermore, it selects this button
// if SelectionSet was false.
simulated static function bool AddBtnToNavigatorAndSelect(UIScreen TheScreen, UIButton TheButton, bool SelectionSet)
{
	if (TheButton != none && TheButton.bIsVisible)
	{
		TheScreen.Navigator.AddControl(TheButton);
		if (!SelectionSet)
		{
			TheScreen.Navigator.SetSelected(TheButton);
			return true;
		}
	}

	return SelectionSet;
}

defaultproperties
{
	PlotTypes[0]="Duel"
	PlotTypes[1]="Facility"
	PlotTypes[2]="SmallTown"
	PlotTypes[3]="Shanty"
	PlotTypes[4]="Slums"
	PlotTypes[5]="Wilderness"
	PlotTypes[6]="CityCenter"
	PlotTypes[7]="Rooftops"
	PlotTypes[8]="Abandoned"
	PlotTypes[9]="Tunnels_Sewer"
	PlotTypes[10]="Tunnels_Subway"
	PlotTypes[11]="Stronghold"
}
