//---------------------------------------------------------------------------------------
//  FILE:    UIScreenListener_TacticalHUD
//  AUTHOR:  Amineri (Pavonis Interactive)
//
//  PURPOSE: A big ball of event listeners we need to set up for tactical games.
//--------------------------------------------------------------------------------------- 

class UIScreenListener_TacticalHUD extends UIScreenListener
	config(LW_Overhaul);

var localized string strEvacRequestTitle;
var localized string strEvacRequestSubtitle;

// This event is triggered after a screen is initialized
event OnInit(UIScreen Screen)
{
	local Object ThisObj;
	local X2EventManager EventMgr;

	`LWTRACE("Starting TacticalHUD Listener OnInit");

	ThisObj = self;
	EventMgr = `XEVENTMGR;

	// Event management for evac zones.
	EventMgr.RegisterForEvent(ThisObj, 'PlayerTurnBegun', OnTurnBegun, ELD_OnStateSubmitted);
	EventMgr.RegisterForEvent(ThisObj, 'TileDataChanged', OnTileDataChanged, ELD_OnStateSubmitted);
	
	// As this handler updates the UI, don't do it on the game state thread but within a visualization
	// block instead.
	EventMgr.RegisterForEvent(ThisObj, 'EvacRequested', OnEvacRequested, ELD_OnVisualizationBlockStarted);
	EventMgr.RegisterForEvent(ThisObj, 'PlayerTurnBegun', OnEvacRequested, ELD_OnVisualizationBlockStarted);

	// Update the evac timer so it will appear if we are loading a save with an active evac timer.
	UpdateEvacTimer(false);

	// Used for when a campaign is loaded from a save in tactical.
	if (`LWOVERHAULOPTIONS == none)
		class'XComGameState_LWOverhaulOptions'.static.CreateModSettingsState_ExistingCampaign(class'XComGameState_LWOverhaulOptions');
}

// Update/refresh the evac timer.
function UpdateEvacTimer(bool DecrementCounter)
{
	local XComGameState_LWEvacSpawner EvacState;
	local XComGameStateHistory History;
	local UISpecialMissionHUD SpecialMissionHUD;

	History = `XCOMHISTORY;
	EvacState = XComGameState_LWEvacSpawner(History.GetSingleGameStateObjectForClass(class'XComGameState_LWEvacSpawner', true));
	SpecialMissionHUD = `PRES.GetSpecialMissionHUD();

	if (EvacState == none)
	{
		return;
	}

	// Update the UI
	if (EvacState.GetCountdown() > 0)
	{
		SpecialMissionHUD.m_kTurnCounter2.SetUIState(eUIState_Normal);
		SpecialMissionHUD.m_kTurnCounter2.SetLabel(strEvacRequestTitle);
		SpecialMissionHUD.m_kTurnCounter2.SetSubLabel(strEvacRequestSubtitle);
		SpecialMissionHUD.m_kTurnCounter2.SetCounter(string(EvacState.GetCountdown()));
	}
	else
	{
		SpecialMissionHUD.m_kTurnCounter2.Hide();
	}
}

// Called when the player's turn has begun. Check if we have an active evac zone placement state with a countdown. If so,
// display it.
function EventListenerReturn OnTurnBegun(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_Player Player;
	local XComGameState_LWEvacSpawner EvacState;
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local bool NeedsUpdate;

	History = `XCOMHISTORY;
	EvacState = XComGameState_LWEvacSpawner(History.GetSingleGameStateObjectForClass(class'XComGameState_LWEvacSpawner', true));

	Player = XComGameState_Player(EventData);
	NeedsUpdate = Player != none && Player.GetTeam() == eTeam_XCom;

	if (EvacState.GetCountdown() > 0 && NeedsUpdate)
	{
		// Decrement the counter if necessary
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("UpdateEvacCountdown");
		EvacState = XComGameState_LWEvacSpawner(NewGameState.CreateStateObject(class'XComGameState_LWEvacSpawner', EvacState.ObjectID));
		EvacState.SetCountdown(EvacState.GetCountdown() - 1);
		NewGameState.AddStateObject(EvacState);
		`TACTICALRULES.SubmitGameState(NewGameState);

		// We've hit zero: time to spawn the evac zone!
		if (EvacState.GetCountdown() == 0)
		{
			EvacState.SpawnEvacZone();
		}
	}

	return ELR_NoInterrupt;
}

function EventListenerReturn OnEvacRequested(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	UpdateEvacTimer(false);
	return ELR_NoInterrupt;
}

function EventListenerReturn OnTileDataChanged(Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XComGameState_LWEvacSpawner EvacState;
	local XComGameStateHistory History;
	local UISpecialMissionHUD SpecialMissionHUD;
	local XComGameState NewGameState;
	local XComGameState_Player NewPlayerState;
	local TTile CenterTile;

	History = `XCOMHISTORY;
	EvacState = XComGameState_LWEvacSpawner(History.GetSingleGameStateObjectForClass(class'XComGameState_LWEvacSpawner', true));

	// If no evac or it doesn't have an active timer, there isn't anything to do.
	if (EvacState == none || EvacState.GetCountdown() < 1)
	{
		return ELR_NoInterrupt;
	}

	CenterTile = EvacState.GetCenterTile();
	if (!class'X2TargetingMethod_EvacZone'.static.ValidateEvacArea(CenterTile, false))
	{
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Invalidating Delayed Evac Zone");

		// update the cooldown on the player
		NewPlayerState = class'Utilities_LW'.static.FindPlayer(eTeam_XCom);
		if (NewPlayerState.GetCooldown('PlaceDelayedEvacZone') > 0)
		{
			NewPlayerState = XComGameState_Player(NewGameState.CreateStateObject(class'XComGameState_Player', NewPlayerState.ObjectID));
			NewPlayerState.SetCooldown('PlaceDelayedEvacZone', 0);
			NewGameState.AddStateObject(NewPlayerState);
		}

		// update the evac zone
		EvacState = XComGameState_LWEvacSpawner(NewGameState.CreateStateObject(class'XComGameState_LWEvacSpawner', EvacState.ObjectID));
		EvacState.ResetCountdown();
		XComGameStateContext_ChangeContainer(NewGameState.GetContext()).BuildVisualizationFn = EvacState.BuildVisualizationForFlareDestroyed;

		NewGameState.AddStateObject(EvacState);
		`XEVENTMGR.TriggerEvent('EvacSpawnerDestroyed', EvacState, EvacState);
		SpecialMissionHUD = `PRES.GetSpecialMissionHUD();
		SpecialMissionHUD.m_kTurnCounter2.Hide();
		`TACTICALRULES.SubmitGameState(NewGameState);
	}

	return ELR_NoInterrupt;
}

defaultProperties
{
	// Leaving this assigned to none will cause every screen to trigger its signals on this class
	ScreenClass = UITacticalHUD
}
