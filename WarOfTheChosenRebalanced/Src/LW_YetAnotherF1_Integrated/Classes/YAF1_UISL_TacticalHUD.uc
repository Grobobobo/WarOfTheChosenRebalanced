// this class updates KeyBinds dynamically
// PC: F1 for both enemy and unit screen
// Controller: Stick_l3 for both enemy and unit screen

// we intentionally override the other commands, we don't want anything to interfere (hotkey targeting, UITacticalCharInfo)
class YAF1_UISL_TacticalHUD extends UIScreenListener config(UI);

var config bool bDisableKeybindTricks;

event OnInit(UIScreen Screen)
{
	local XComTacticalInput TI;
	local name key;

	if (UITacticalHUD(Screen) != none)
	{
		if (!RegisterWotCHandler() && !bDisableKeybindTricks)
		{
			// explicitly check for TacticalInput, we don't want to change keybinds for HeadquartersInput
			TI = XComTacticalInput(Screen.PC.PlayerInput);
			if (TI != none)
			{
				key = 'F1';
				if (InStr(TI.GetBind(key), "YAF1_") == INDEX_NONE)
				{
					SetBind(TI, key, "YAF1_OnF1Press | onrelease YAF1_OnF1Release");
				}
				key = 'XboxTypeS_LeftThumbstick';
				if (InStr(TI.GetBind(key), "YAF1_") == INDEX_NONE)
				{
					SetBind(TI, key, "YAF1_OnLeftThumbPress | onrelease YAF1_OnLeftThumbRelease");
				}
			}
		}
	}
	// spawn screen preemptively, since it will always exist during tactical
	// class'X2DownloadableContentInfo_YetAnotherF1'.static.GetScreen();
	// Note: This was a bad mistake, as the check was outside of the UITacticalHUD check
}

// HAXHAXHAX: Copy from Input.uc without SaveConfig();, which interferes with some mods
// Lol @ UnrealScript, apparently `input` is a keyword for variables so you can't have a
// variable of type `Input`.
static function SetBind(XComTacticalInput In, const out name BindName, string Command)
{
	local KeyBind	NewBind;
	local int		BindIndex;

	if ( Left(Command,1) == "\"" && Right(Command,1) == "\"" )
	{
		Command = Mid(Command, 1, Len(Command) - 2);
	}

	for(BindIndex = In.Bindings.Length-1;BindIndex >= 0;BindIndex--)
	{
		if(In.Bindings[BindIndex].Name == BindName)
		{
			In.Bindings[BindIndex].Command = Command;
			// `log("Binding '"@BindName@"' found, setting command '"@Command@"'");
			// SaveConfig();
			return;
		}
	}

	// `log("Binding '"@BindName@"' NOT found, adding new binding with command '"@Command@"'");
	NewBind.Name = BindName;
	NewBind.Command = Command;
	In.Bindings[In.Bindings.Length] = NewBind;
	// SaveConfig();
}

function bool RegisterWotCHandler()
{
	local YAF1_WotCCallbackHandler CallbackOwner;
	if (Function'XComGame.UIScreenStack.SubscribeToOnInput' != none)
	{
		`log("Registered");
		CallbackOwner = new class'YAF1_WotCCallbackHandler';
		`SCREENSTACK.SubscribeToOnInput(CallbackOwner.CHOnInput);
		return true;
	}
	`log("Not Registered");
	return false;
}