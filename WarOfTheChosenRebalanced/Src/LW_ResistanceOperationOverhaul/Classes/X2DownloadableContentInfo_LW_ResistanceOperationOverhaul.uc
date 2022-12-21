//---------------------------------------------------------------------------------------
//  FILE:   XComDownloadableContentInfo_LW_ResistanceOperationOverhaul.uc                                    
//           
//	Use the X2DownloadableContentInfo class to specify unique mod behavior when the 
//  player creates a new campaign or loads a saved game.
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------

class X2DownloadableContentInfo_LW_ResistanceOperationOverhaul extends X2DownloadableContentInfo;

/// <summary>
/// This method is run if the player loads a saved game that was created prior to this DLC / Mod being installed, and allows the 
/// DLC / Mod to perform custom processing in response. This will only be called once the first time a player loads a save that was
/// create without the content installed. Subsequent saves will record that the content was installed.
/// </summary>
static event OnLoadedSavedGame()
{}

/// <summary>
/// Called when the player starts a new campaign while this DLC / Mod is installed
/// </summary>
static event InstallNewCampaign(XComGameState StartState)
{}


exec function SetLadderWeaponImagePos(int X, int Y)
{
    class'UILadderSquadUpgradeScreen'.default.WEAPON_IMAGE_X_POSITION = X;
    class'UILadderSquadUpgradeScreen'.default.WEAPON_IMAGE_Y_POSITION = Y;
}

exec function SetLadderWeaponTooltipPos(int X, int Y)
{
    class'UILadderSquadUpgradeScreen'.default.WEAPON_TOOLTIP_X_POSITON = X;
    class'UILadderSquadUpgradeScreen'.default.WEAPON_TOOLTIP_Y_POSIITON = Y;
}