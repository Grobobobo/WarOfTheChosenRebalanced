//---------------------------------------------------------------------------------------
//  FILE:    UILadderModeScoringDialog_GTO.uc
//  AUTHORS: Grobobobo
//
//  PURPOSE: Removes the unneeded score screens
//  NOTE: Reuses the flash elements from the MP HUD. 
//---------------------------------------------------------------------------------------

class UILadderModeScoringDialog_Override extends UILadderModeScoringDialog;

// var UIButton m_ContinueButton;

// var localized string m_TotalLabel;
// var localized string m_ScoreLabels[ChallengeModePointType.EnumCount]<BoundEnum = ChallengeModePointType>;
// var localized string m_ScoreDescription1;
// var localized string m_ScoreDescription2;
// var localized string m_ButtonLabel;

// var localized string m_LongDescription;
// var localized string m_PerMinute;
// var localized string m_ParScore;

// var localized string m_LadderHeader;
// var localized string m_StartLadderString;

simulated function InitScreen( XComPlayerController InitController, UIMovie InitMovie, optional name InitName )
{
	//super.InitScreen( InitController, InitMovie, InitName );
	Remove();
}

simulated function Remove( )
{
	super.Remove( );
}
simulated function OnInit( )
{
	`PRES.ScreenStack.PopFirstInstanceOfClass( class'UILadderModeScoringDialog_Override' ); 
	Remove();
}
function OnContinueButtonPress( UIButton Button )
{
	// Movie.Pres.PlayUISound(eSUISound_MenuSelect);
	// `PRES.ScreenStack.PopFirstInstanceOfClass( class'UILadderModeScoringDialog' ); 
	// XComTacticalController(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController()).HideInputButtonRelatedHUDElements(false);
}


// ===========================================================================
//  DEFAULTS:
// ===========================================================================
defaultproperties
{
	MCName = "";
	Package = "";
}