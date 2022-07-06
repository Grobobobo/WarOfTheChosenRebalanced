class YAF1_WotCCallbackHandler extends Object;

function bool CHOnInput(int iInput, int ActionMask)
{
	if (iInput == class'UIUtilities_Input'.const.FXS_BUTTON_L3)
	{
		if (ActionMask == class'UIUtilities_Input'.const.FXS_ACTION_RELEASE)
		{
			class'X2DownloadableContentInfo_LW_YetAnotherF1_Integrated'.static.PushF1Screen();
		}
		// Eat all the events -- otherwise they'll fire the tactical info screen
		return true;
	}
	if (ActionMask == class'UIUtilities_Input'.const.FXS_ACTION_RELEASE && iInput == class'UIUtilities_Input'.const.FXS_KEY_F1)
	{
		return class'X2DownloadableContentInfo_LW_YetAnotherF1_Integrated'.static.PushF1Screen();
	}
	return false;
}