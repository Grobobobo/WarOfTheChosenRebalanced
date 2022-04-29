class X2Effect_Entwine extends X2Effect_Persistent;

var int Defense;
	
function GetToHitAsTargetModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
    local ShotModifierInfo ShotInfo;

	if (Target.AffectedByEffectNames.Find(class'X2Ability_Viper'.default.BindSustainedEffectName) != INDEX_NONE || Target.AffectedByEffectNames.Find('bind') != INDEX_NONE)
	{
		ShotInfo.ModType = eHit_Success;
		ShotInfo.Reason = FriendlyName;
		ShotInfo.Value = -Defense;
		ShotModifiers.AddItem(ShotInfo);
	}
}

defaultproperties
{
    DuplicateResponse=eDupe_Ignore
    EffectName="Entwine_LW"
}