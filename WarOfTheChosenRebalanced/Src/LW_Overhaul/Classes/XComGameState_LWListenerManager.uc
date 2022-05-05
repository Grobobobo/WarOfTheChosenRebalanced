//---------------------------------------------------------------------------------------
//  FILE:    XComGameState_LWListenerManager.uc
//  AUTHOR:  Amineri / Pavonis Interactive
//  PURPOSE: This singleton object manages general persistent listeners that should live for both strategy and tactical play
//---------------------------------------------------------------------------------------
class XComGameState_LWListenerManager extends XComGameState_BaseObject config(LW_Overhaul);

var config int DEFAULT_LISTENER_PRIORITY;

var localized string ResistanceHQBodyText;


var config array<int>INITIAL_PSI_TRAINING;

// Allow mods to query the LW version number. Trigger the 'GetLWVersion' event with an empty tuple as the eventdata and it will
// return a 3-tuple of ints with Data[0]=Major, Data[1]=Minor, and Data[2]=Build.
function EventListenerReturn OnGetLWVersion(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
    local XComLWTuple Tuple;
    local int Major, Minor, Build;
    Tuple = XComLWTuple(EventData);
    if (Tuple == none)
    {
        return ELR_NoInterrupt;
    }

    class'LWVersion'.static.GetVersionNumber(Major, Minor, Build);
    Tuple.Data.Add(3);
    Tuple.Data[0].Kind = XComLWTVInt;
    Tuple.Data[0].i = Major;
    Tuple.Data[1].Kind = XComLWTVInt;
    Tuple.Data[1].i = Minor;
    Tuple.Data[2].Kind = XComLWTVInt;
    Tuple.Data[2].i = Build;

    return ELR_NoInterrupt;
}


