//---------------------------------------------------------------------------------------
//  FILE:    XComGameState_AlienAggression.uc
//  AUTHOR:  Grobobobo
//  PURPOSE: Singleton state for checking the time for Alien Aggression
//---------------------------------------------------------------------------------------

class XComGameState_AlienAggression extends XComGameState_BaseObject;

	var int AggressionValue;



event OnCreation(optional X2DataTemplate InitTemplate)
{
	AggressionValue = 0;
}

static function XComGameState_AlienAggression CreateAggressionState(optional XComGameState StartState)
{
	local XComGameState_AlienAggression AggressionState;
	local XComGameState NewGameState;

	//first check that there isn't already a singleton instance of this manager
	AggressionState = GetAggressionState(true);
	if (AggressionState != none)
	{
		return AggressionState;
	}

	if(StartState != none)
	{
		AggressionState = XComGameState_AlienAggression(StartState.CreateNewStateObject(class'XComGameState_AlienAggression'));
	}
	else
	{
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Creating Alien Aggression Quasi-singleton");
		AggressionState = XComGameState_AlienAggression(NewGameState.CreateNewStateObject(class'XComGameState_AlienAggression'));
	}

	return AggressionState;
}


static function XComGameState_AlienAggression GetAggressionState(optional bool AllowNULL = false)
{
    return XComGameState_AlienAggression(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_AlienAggression', AllowNULL));
}

function AdjustAggressionValueBasedOnResults(XComGameState_BattleData BattleData)
{

}


function DelayAvatarProjectBasedOnAggression(XComGameState_BattleData BattleData)
{
	
}