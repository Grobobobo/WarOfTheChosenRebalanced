class X2Effect_ResearchStatBonuses extends X2Effect_ModifyStats config(AlienResearch);

/* struct native SoldierClassStatType
{
	var ECharStatType   StatType;
	var int             StatAmount;
	var int             RandStatAmount;     //   if > 0, roll this number and add to StatAmount to get the new value
	var int             CapStatAmount;      //   if > 0, the stat cannot increase beyond this amount
}; */

struct ResearchStatBonus
{
	var string UpgradeID;
	var name UnitName;
	var array<SoldierClassStatType> Stats;
	var bool IgnoreFL;
	var int MinFL;
	var int MaxFL;
	var bool IgnoreAlert;
	var int MinAlert;
	var int MaxAlert;
	var bool IgnoreDoom;
	var int MinDoom;
	var int MaxDoom;
	var bool AlwaysApply;
	var int ChanceToApply;
	var int ExtraChancePerFL;
	var int ExtraChancePerAlert;
	var int ExtraChancePerDoom;
};

var config array<ResearchStatBonus> ResearchStatBonuses;

var array<StatChange> m_aStatChanges;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local int ForceLevel;
	local int Alert;
	local int Doom;
	local XComGameState_Unit UnitState;
	local ResearchStatBonus UpgradeData;
	local SoldierClassStatType Stat;
	local StatChange NewChange;
	local int FinalApplyChance;
	local int TotalHP;
	ForceLevel = GetForceLevel();
	Alert = GetAlertLevel();
	Doom = GetDoomProgress();

	UnitState = XComGameState_Unit(kNewTargetState);
	TotalHP = 0;
	foreach ResearchStatBonuses(UpgradeData)
	{
		if(UpgradeData.UnitName == UnitState.GetMyTemplate().CharacterGroupName)
		{
			if(UpgradeData.IgnoreFL || (ForceLevel >= UpgradeData.MinFl && ForceLevel <= UpgradeData.MaxFL))
			{
				if(UpgradeData.IgnoreAlert || (Alert >= UpgradeData.MinAlert && Alert <= UpgradeData.MaxAlert))
				{
					if(UpgradeData.IgnoreDoom || (Doom >= UpgradeData.MinDoom && Doom <= UpgradeData.MaxDoom))
					{
						if(UpgradeData.AlwaysApply)
						{
							foreach UpgradeData.Stats(Stat)
								{
									NewChange.StatType = Stat.StatType;
									NewChange.StatAmount = Stat.StatAmount;

									if (`SecondWaveEnabled('BetaStrike') && (Stat.StatType == eStat_HP || Stat.StatType == eStat_ShieldHP))
									{
										NewChange.StatAmount *= class'X2StrategyGameRulesetDataStructures'.default.SecondWaveBetaStrikeHealthMod;
									}
									

									NewChange.ModOp = MODOP_Addition;
									//Don't add hp 1 stat at a time
									if(Stat.StatType != eStat_HP)
									{
										m_aStatChanges.AddItem(NewChange);
									}
									else
									{
										TotalHP += NewChange.StatAmount;
									}
								}

							`LOG("Dynamic Enemy Creation - Guaranteed stat upgrade '" $ UpgradeData.UpgradeID $ "' applied to unit '" $ UpgradeData.UnitName $ "'");
						}
						else
						{
							//Requirements are fulfilled, now calculate the chance to trigger
						
							FinalApplyChance = UpgradeData.ChanceToApply;

							FinalApplyChance += UpgradeData.ExtraChancePerFL * (ForceLevel - UpgradeData.MinFL);
							FinalApplyChance += UpgradeData.ExtraChancePerAlert * (Alert - UpgradeData.MinAlert);
							FinalApplyChance += UpgradeData.ExtraChancePerDoom * (Doom - UpgradeData.MinDoom);

							if(`SYNC_RAND_TYPED(100, ESyncRandType_Generic) < FinalApplyChance)
							{
								foreach UpgradeData.Stats(Stat)
								{
									NewChange.StatType = Stat.StatType;
									NewChange.StatAmount = Stat.StatAmount;

									if (`SecondWaveEnabled('BetaStrike') && (Stat.StatType == eStat_HP || Stat.StatType == eStat_ShieldHP))
									{
										NewChange.StatAmount *= class'X2StrategyGameRulesetDataStructures'.default.SecondWaveBetaStrikeHealthMod;
									}

									NewChange.ModOp = MODOP_Addition;

									//Don't add hp 1 stat at a time
									if(Stat.StatType != eStat_HP)
									{
										m_aStatChanges.AddItem(NewChange);
									}
									else
									{
										TotalHP += NewChange.StatAmount;
									}								}
							
								`LOG("Dynamic Enemy Creation - Stat upgrade '" $ UpgradeData.UpgradeID $ "' applied to unit '" $ UpgradeData.UnitName $ "', final chance to apply was " $ string(FinalApplyChance) $ "%");
							}
							else
							{
								`LOG("Dynamic Enemy Creation - Stat upgrade '" $ UpgradeData.UpgradeID $ "' not applied to unit '" $ UpgradeData.UnitName $ "' because of random roll, final chance to apply was " $ string(FinalApplyChance) $ "%");
							}
						}
					}
				}
			}
		}
	}

	//Make The bonus scale by difficulty
	//Rounding on this doesn't work because it's not summed up

	TotalHP = FCeil(1.0f * TotalHP * class'X2LWCharactersModTemplate'.default.DIFFICULTY_HP_MODIFIER[`StrategyDifficultySetting]);
	NewChange.StatType = eStat_HP;
	NewChange.StatAmount = TotalHP;
	NewChange.ModOp = MODOP_Addition;
	m_aStatChanges.AddItem(NewChange);

	NewEffectState.StatChanges = m_aStatChanges;

	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);

	m_aStatChanges.Length = 0;
}

static function int GetForceLevel()
{
    local XComGameStateHistory History;
    local XComGameState_BattleData BattleData;
    
    History = `XCOMHISTORY;

    BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
    
    return BattleData.GetForceLevel();
}

static function int GetAlertLevel()
{
	local XComGameStateHistory History;
    local XComGameState_BattleData BattleData;
    
    History = `XCOMHISTORY;

    BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));

	return BattleData.GetAlertLevel();
}

static function int GetDoomProgress()
{
	local XComGameState_HeadquartersAlien AlienHQ;

    AlienHQ = XComGameState_HeadquartersAlien(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
    
	return AlienHQ.GetCurrentDoom();
}