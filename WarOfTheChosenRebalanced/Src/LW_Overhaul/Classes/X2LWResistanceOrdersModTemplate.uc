//---------------------------------------------------------------------------------------
//  FILE:    X2LWResistanceOrdersModTemplate.uc
//  AUTHOR:  Peter Ledbrook
//  PURPOSE: Modifies existing Resistance Order templates.
//
//           In particular, it makes sure that disabled ROs (with strength 99)
//           are removed as potential continent bonuses.
//---------------------------------------------------------------------------------------
class X2LWResistanceOrdersModTemplate extends X2LWTemplateModTemplate config(LW_Overhaul);

var config array<name> ENABLED_RESISTANCE_ORDERS;

static function UpdateResistanceOrders(X2StrategyElementTemplate Template, int Difficulty)
{
	local X2StrategyCardTemplate CardTemplate;

	CardTemplate = X2StrategyCardTemplate(Template);
	if (CardTemplate == none)
		return;
	//HardCode the Resistance orders, make sure none of them are initially assigned as continent bonuses
	//CardTemplate.bContinentBonus = false;

	if(default.ENABLED_RESISTANCE_ORDERS.Find(CardTemplate.DataName) == INDEX_NONE)
	{
		CardTemplate.Strength = 99;
	}
	
}

defaultproperties
{
	StrategyElementTemplateModFn=UpdateResistanceOrders
}
