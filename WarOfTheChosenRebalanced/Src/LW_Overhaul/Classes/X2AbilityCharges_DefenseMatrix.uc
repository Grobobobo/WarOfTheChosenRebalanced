//---------------------------------------------------------------------------------------
//  FILE:    X2AbilityCharges.uc
//  AUTHOR:  Joshua Bouscher  --  2/5/2015
//  PURPOSE: Base class for setting charges on an X2AbilityTemplate.
//           
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2AbilityCharges_DefenseMatrix extends X2AbilityCharges;

var int ExtraCharges;

function int GetInitialCharges(XComGameState_Ability Ability, XComGameState_Unit Unit) 
{ 
	local int Charges;
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));

	Charges = InitialCharges;
	if(XComHQ.TacticalGameplayTags.Find('AvengerDefenseTurrets_Upgrade') != INDEX_NONE || XComHQ.TacticalGameplayTags.Find('AvengerDefenseTurretsMk2_Upgrade') != INDEX_NONE)
	{
			Charges += default.ExtraCharges;
	}

	return Charges; 
}