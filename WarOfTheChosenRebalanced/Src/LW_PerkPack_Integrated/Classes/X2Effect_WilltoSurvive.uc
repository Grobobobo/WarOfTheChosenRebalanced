//--------------------------------------------------------------------------------------- 
//  FILE:    X2Effect_WilltoSurvive
//  AUTHOR:  John Lumpkin (Pavonis Interactive)
//  PURPOSE: Sets up bonus armor from W2S
//--------------------------------------------------------------------------------------- 

class X2Effect_WilltoSurvive extends X2Effect_BonusArmor config (GameData_SoldierSkills);

var float WTS_DR;

var int WTS_FLAT_DR;

function float GetPostDefaultDefendingDamageModifier_CH(
	XComGameState_Effect EffectState,
	XComGameState_Unit Attacker,
	XComGameState_Unit Target,
	XComGameState_Ability AbilityState,
	const out EffectAppliedData AppliedData,
	float CurrentDamage,
	X2Effect_ApplyWeaponDamage WeaponDamageEffect,
	XComGameState NewGameState)
{
	local GameRulesCache_VisibilityInfo			MyVisInfo;
	local array<GameRulesCache_VisibilityInfo>	VisInfoArray;
	local X2AbilityToHitCalc_StandardAim		StandardHit;
	local XComGameStateContext_Ability			AbilityContext;
	local Vector								SourceLocation;
	local int									k;
	local XComGameStateHistory					History;	
	local X2AbilityTarget_Cursor				TargetStyle;
	local X2AbilityMultiTarget_Radius			MultiTargetStyle;
	local array<name> IncomingTypes;

	WeaponDamageEffect.GetEffectDamageTypes(NewGameState, AppliedData, IncomingTypes);

	if (IncomingTypes.Find('Melee') != INDEX_NONE)
	{
		return 0;
	}

	StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);	
	TargetStyle = X2AbilityTarget_Cursor(AbilityState.GetMyTemplate().AbilityTargetStyle);
	MultiTargetStyle = X2AbilityMultiTarget_Radius(AbilityState.GetMyTemplate().AbilityMultiTargetStyle);
	AbilityContext=class'XComGameStateContext_Ability'.static.BuildContextFromAbility(AbilityState, EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);
	if((StandardHit != none && StandardHit.bIndirectFire) || (TargetStyle != none && MultiTargetStyle != none))
	{
		History = `XCOMHISTORY;
		SourceLocation = AbilityContext.InputContext.ProjectileTouchEnd;				
		class'X2TacticalVisibilityHelpers'.static.GetAllVisibleEnemiesForLocation(SourceLocation, Attacker.ControllingPlayer.ObjectID, VisInfoArray, true);
		for( k = 0; k < VisInfoArray.Length; ++k )
		{
			if (XComGameState_Unit(History.GetGameStateForObjectID(VisInfoArray[k].SourceID,,-1)) == Target)
			{
				MyVisInfo = VisInfoArray[k];	
				break;
			}
		}
		if (MyVisInfo.TargetCover == CT_None)
			return 0;
		if (MyVisInfo.TargetCover == CT_Midlevel || MyVisInfo.TargetCover == CT_Standing)
        return -CurrentDamage * WTS_DR;
	}
	else
	{
		if(X2TacticalGameRuleset(XComGameInfo(class'Engine'.static.GetCurrentWorldInfo().Game).GameRuleset).VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, Target.ObjectID, MyVisInfo))
		{
            if (MyVisInfo.TargetCover == CT_None)
			return 0;
            if (MyVisInfo.TargetCover == CT_Midlevel || MyVisInfo.TargetCover == CT_Standing)
            return -CurrentDamage * WTS_DR;
		}
	}
    return 0;     
}

function int GetDefendingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, X2Effect_ApplyWeaponDamage WeaponDamageEffect, optional XComGameState NewGameState)
{
	local XComGameState_Unit					Target;
	local GameRulesCache_VisibilityInfo			MyVisInfo;
	local array<GameRulesCache_VisibilityInfo>	VisInfoArray;
	local X2AbilityToHitCalc_StandardAim		StandardHit;
	local XComGameStateContext_Ability			AbilityContext;
	local Vector								SourceLocation;
	local int									k;
	local XComGameStateHistory					History;	
	local X2AbilityTarget_Cursor				TargetStyle;
	local X2AbilityMultiTarget_Radius			MultiTargetStyle;

	Target = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID));

	if (Target.IsImpaired(false) || Target.IsBurning() || Target.IsPanicked())
		return 0;

	StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);	
	TargetStyle = X2AbilityTarget_Cursor(AbilityState.GetMyTemplate().AbilityTargetStyle);
	MultiTargetStyle = X2AbilityMultiTarget_Radius(AbilityState.GetMyTemplate().AbilityMultiTargetStyle);
	AbilityContext=class'XComGameStateContext_Ability'.static.BuildContextFromAbility(AbilityState, EffectState.ApplyEffectParameters.TargetStateObjectRef.ObjectID);
	if((StandardHit != none && StandardHit.bIndirectFire) || (TargetStyle != none && MultiTargetStyle != none))
	{
		History = `XCOMHISTORY;
		SourceLocation = AbilityContext.InputContext.ProjectileTouchEnd;				
		class'X2TacticalVisibilityHelpers'.static.GetAllVisibleEnemiesForLocation(SourceLocation, Attacker.ControllingPlayer.ObjectID, VisInfoArray, true);
		for( k = 0; k < VisInfoArray.Length; ++k )
		{
			if (XComGameState_Unit(History.GetGameStateForObjectID(VisInfoArray[k].SourceID,,-1)) == Target)
			{
				MyVisInfo = VisInfoArray[k];	
				break;
			}
		}
		if (MyVisInfo.TargetCover == CT_None)
			return 0;
		
		return -WTS_FLAT_DR;
	}
	else
	{
		if(X2TacticalGameRuleset(XComGameInfo(class'Engine'.static.GetCurrentWorldInfo().Game).GameRuleset).VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, Target.ObjectID, MyVisInfo))
		{
			if (MyVisInfo.TargetCover == CT_None) 
				return 0;
			return -WTS_FLAT_DR;				
		}
	}
    return 0;     
}


function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local GameRulesCache_VisibilityInfo			VisInfo;
    local ShotModifierInfo						ShotInfo;

	if (Target != none)
	{
		if(X2TacticalGameRuleset(XComGameInfo(class'Engine'.static.GetCurrentWorldInfo().Game).GameRuleset).VisibilityMgr.GetVisibilityInfo(Attacker.ObjectID, Target.ObjectID, VisInfo))
		{
			if (Target.CanTakeCover() && !bFlanking)
			{
					if(VisInfo.TargetCover == CT_Midlevel)
					{
						ShotInfo.ModType = eHit_Success;
						ShotInfo.Reason = FriendlyName;
						ShotInfo.Value = class'X2AbilityToHitCalc_StandardAim'.default.LOW_COVER_BONUS / 2;
						ShotModifiers.AddItem(ShotInfo);		
					}
					else if(VisInfo.TargetCover == CT_Standing)
					{
						ShotInfo.ModType = eHit_Success;
						ShotInfo.Reason = FriendlyName;
						ShotInfo.Value = class'X2AbilityToHitCalc_StandardAim'.default.HIGH_COVER_BONUS / 2;
						ShotModifiers.AddItem(ShotInfo);		
					}
			}
		}
	}
}
