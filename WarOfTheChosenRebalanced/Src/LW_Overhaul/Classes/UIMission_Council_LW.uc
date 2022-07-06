
class UIMission_Council_LW extends UIMission_Council;



simulated function BuildMissionPanel()
{


	LibraryPanel.MC.BeginFunctionOp("UpdateCouncilInfoBlade");
	LibraryPanel.MC.QueueString(GetMissionImage());
	LibraryPanel.MC.QueueString("../AssetLibraries/ProtoImages/Proto_HeadFirebrand.tga"); //TODO: Get VIP image 
	LibraryPanel.MC.QueueString("../AssetLibraries/TacticalIcons/Objective_VIPGood.tga");
	LibraryPanel.MC.QueueString(m_strImageGreeble);
	LibraryPanel.MC.QueueString(GetRegion().GetMyTemplate().DisplayName);
	LibraryPanel.MC.QueueString(GetOpName());
	LibraryPanel.MC.QueueString(m_strMissionObjective);
	LibraryPanel.MC.QueueString(GetObjectiveString());
	LibraryPanel.MC.QueueString(GetRewardIcon());
	LibraryPanel.MC.QueueString(m_strReward);
	LibraryPanel.MC.QueueString(GetModifiedRewardString());

	LibraryPanel.MC.QueueString(m_strLaunchMission);
	LibraryPanel.MC.QueueString(m_strIgnore);
	LibraryPanel.MC.EndOp();

	Button1.OnClickedDelegate = OnLaunchClicked;
	Button2.OnClickedDelegate = OnCancelClicked;
	Button3.Hide();
	ConfirmButton.Hide();
}

simulated function string GetModifiedRewardString()
{
	local XComGameState_MissionSite MissionState;
	local string RewardString;

	MissionState = GetMission();
	RewardString = GetRewardString();
	if (MissionState.GeneratedMission.Mission.MissionFamily == "Neutralize")
	{
		///RewardString = "$$$" $ RewardString;	// LW2 : This is intended to handle any repeats.
		//OldCaptureRewardString = Mid(RewardString, 0, Instr(RewardString, ","));
		//NewCaptureRewardString = OldCaptureRewardString @ class'UIUtilities_LW'.default.m_strVIPCaptureReward;
        //Make all rewards count only towards VIP capture
		RewardString = Repl (RewardString, ",", "," @ class'UIUtilities_LW'.default.m_strVIPCaptureReward);
		///RewardString -= "$$$";
	}
	return RewardString;
}


defaultproperties
{
	Package = "/ package/gfxAlerts/Alerts";
	InputState = eInputState_Consume;
}