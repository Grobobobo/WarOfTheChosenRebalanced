class X2SchematicTemplate_LW extends X2SchematicTemplate;


function string GetItemFriendlyName(optional int ItemID = 0, optional bool bShowSquadUpgrade = true)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_Item ItemState;
	local string strTemp;
	local int idx, BoostValue;
	local bool bHasStatBoostBonus;
	local string NameStr, Label;
	if(FriendlyName != "")
	{
		strTemp = FriendlyName;
		History = `XCOMHISTORY;
		ItemState = XComGameState_Item(History.GetGameStateForObjectID(ItemID));

		if(ItemState != none && ItemState.Nickname != "")
			strTemp = ItemState.Nickname;

		if(ItemState != none && ItemState.StatBoosts.Length > 0)
		{
			XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none)
			{
				bHasStatBoostBonus = XComHQ.SoldierUnlockTemplates.Find('IntegratedWarfareUnlock') != INDEX_NONE;
			}

			strTemp @= "(";

			for(idx = 0; idx < ItemState.StatBoosts.Length; idx++)
			{
				BoostValue = ItemState.StatBoosts[idx].Boost;
				if (bHasStatBoostBonus)
				{
					if (X2EquipmentTemplate(ItemState.GetMyTemplate()).bUseBoostIncrement)
						BoostValue += class'X2SoldierIntegratedWarfareUnlockTemplate'.default.StatBoostIncrement;
					else
						BoostValue += Round(BoostValue * class'X2SoldierIntegratedWarfareUnlockTemplate'.default.StatBoostValue);
				}

				if ((ItemState.StatBoosts[idx].StatType == eStat_HP) && `SecondWaveEnabled('BetaStrike'))
				{
					BoostValue *= class'X2StrategyGameRulesetDataStructures'.default.SecondWaveBetaStrikeHealthMod;
				}

				if(idx > 0)
				{
					strTemp $= ", ";
				}

				strTemp $= "+" $ string(BoostValue) @ class'X2TacticalGameRulesetDataStructures'.default.m_aCharStatLabels[ItemState.StatBoosts[idx].StatType];
			}

			strTemp $= ")";
		}

		NameStr = class'UIUtilities_Text'.static.FormatCommaSeparatedNouns(strTemp);

	if (bSquadUpgrade && bShowSquadUpgrade)
	{
		Label = m_strSquadUpgradeTag; 
		Label = Repl(Label, "%CLASSLABEL", m_strClassLabel);
		Label = Repl(Label, "%UPGRADELABEL", m_strUpgradeLabel);
		NameStr @= Label;
	}

		return NameStr;
	}
	else
	{
		return "Error! " $ string(DataName) $ " has no FriendlyName!";
	}
}

function string GetItemBriefSummary(optional int ItemID = 0)
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_Item ItemState;
	local X2AbilityTag AbilityTag;
	local string strTemp;
	local int idx, BoostValue;
	local bool bHasStatBoostBonus;

	if(BriefSummary != "")
	{
		strTemp = "";
		History = `XCOMHISTORY;
		ItemState = XComGameState_Item(History.GetGameStateForObjectID(ItemID));

		if(ItemState != none && ItemState.StatBoosts.Length > 0)
		{
			XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom', true));
			if (XComHQ != none)
			{
				bHasStatBoostBonus = XComHQ.SoldierUnlockTemplates.Find('IntegratedWarfareUnlock') != INDEX_NONE;
			}

			strTemp @= "(";

			for(idx = 0; idx < ItemState.StatBoosts.Length; idx++)
			{
				BoostValue = ItemState.StatBoosts[idx].Boost;
				if (bHasStatBoostBonus)
				{
					if (X2EquipmentTemplate(ItemState.GetMyTemplate()).bUseBoostIncrement)
						BoostValue += class'X2SoldierIntegratedWarfareUnlockTemplate'.default.StatBoostIncrement;
					else
						BoostValue += Round(BoostValue * class'X2SoldierIntegratedWarfareUnlockTemplate'.default.StatBoostValue);
				}

				if ((ItemState.StatBoosts[idx].StatType == eStat_HP) && `SecondWaveEnabled('BetaStrike'))
				{
					BoostValue *= class'X2StrategyGameRulesetDataStructures'.default.SecondWaveBetaStrikeHealthMod;
				}

				if(idx > 0)
				{
					strTemp $= ", ";
				}

				strTemp $= "+" $ string(BoostValue) @ class'X2TacticalGameRulesetDataStructures'.default.m_aCharStatLabels[ItemState.StatBoosts[idx].StatType];
			}

			strTemp $= ")\n";
		}
		
		AbilityTag = X2AbilityTag(`XEXPANDCONTEXT.FindTag("Ability"));
		AbilityTag.ParseObj = self;
		strTemp = class'UIUtilities_Text'.static.GetColoredText(strTemp, eUIState_Good) $ `XEXPAND.ExpandString(BriefSummary);
		AbilityTag.ParseObj = none;

		return class'UIUtilities_Text'.static.FormatCommaSeparatedNouns(strTemp);
	}
	else
	{
		return "Error! " $ string(DataName) $ " has no BriefSummary!";
	}
}

DefaultProperties
{
	ItemCat="schematic"
	CanBeBuilt = true;
	bOneTimeBuild = true;
	HideInInventory = true;
	HideInLootRecovered = true;
	bSquadUpgrade = true
	bShouldCreateDifficultyVariants=true
}