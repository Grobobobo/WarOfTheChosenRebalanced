class UISpecialMissionHUD_Arrows_GA extends UISpecialMissionHUD_Arrows;

function UpdateVisibility() {
    // If this is not enabled, call use the superclass function
    if(!class'LW_GotchaAgain_IntegratedSettings'.default.bDisableHideObjectiveArrowsWhenUsingGrapple || !class'LW_GotchaAgain_IntegratedSettings'.default.bShowLOSIndicatorsForGrappleDestinations) {
        super.UpdateVisibility();
        return;
    } 

	//We want to hide these arrows while the shotHUD is open, except when it is for the grapple ability
	if( XComPresentationLayer(Movie.Pres).m_kTacticalHUD.IsMenuRaised() && X2TargetingMethod_Grapple(XComPresentationLayer(Movie.Pres).m_kTacticalHUD.GetTargetingMethod()) == none) {
		Hide();
    } else {
		Show();
    }
}


// Restores arrows from the latest history frame. For loading.
function AddExistingArrows() {
	local XComGameState_IndicatorArrow_GA Arrow;

	foreach class'XComGameStateHistory'.static.GetGameStateHistory().IterateByClassType(class'XComGameState_IndicatorArrow_GA', Arrow) {   
        // Detect if ADVENT towers have already been hacked in this save
        if(Arrow.CurrentIndicatorValue == eAlreadyHacked && Arrow.IconSetIdentifier == eHackAdventTower) {
            UIUnitFlagManager_GA(XComPresentationLayer(XComPlayerController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).Pres).m_kUnitFlagManager).GetObjectiveIndicatorUtility().SetTowersHaveBeenHackedAlready();
        }

		ProcessArrowGameStateObject(Arrow);
	}
}


// Adds a new arrow pointing at an actor, or updates it if it already exists.
simulated function AddArrowPointingAtActor( Actor kActor, optional vector offset, 
											optional EUIState arrowState = eUIState_Warning, 
											optional int arrowCount = -1, 
											optional string icon = "")
{
	local int index;
	local T3DArrow actorArrow; 
	
	if( kActor == none )
	{
		`log( "Failing to add a UI arrow pointer to track an actor, because the actor reference is none.");
		return;
	}

	index = arr3DArrows.Find('kActor', kActor);
	if(index != -1)
	{
		// Update data on arrow
		arr3DArrows[index].offset = offset;
		arr3DArrows[index].arrowState = arrowState;
		arr3DArrows[index].arrowCounter = arrowCount;
        // Never replace with nothing!
        if(icon != "") {
		    arr3DArrows[index].icon = icon;
        }
	}
	else
	{
		actorArrow.kActor = kActor;
		actorArrow.offset = offset;
		actorArrow.arrowState = arrowState;
		actorArrow.arrowCounter = arrowCount;
		actorArrow.icon = icon;
		arr3DArrows.AddItem(actorArrow );
	}
}