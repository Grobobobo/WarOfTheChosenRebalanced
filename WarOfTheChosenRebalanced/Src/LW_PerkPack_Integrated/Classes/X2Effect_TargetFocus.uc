class X2Effect_TargetFocus extends XMBEffect_ConditionalBonus config(LW_SoldierSkills);

var() int DodgeReductionBonus;
var() int DefenseReductionBonus;

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ShotInfo;
	local int DodgeReduction;
	local int DefenseReduction;

	DodgeReduction = Min(DodgeReductionBonus, Target.GetCurrentStat(eStat_Dodge));

	ShotInfo.ModType = eHit_Graze;
	ShotInfo.Reason = FriendlyName;
	ShotInfo.Value = -1 * DodgeReduction;
	ShotModifiers.AddItem(ShotInfo);

    DefenseReduction = Min(DefenseReductionBonus, Target.GetCurrentStat(eStat_Defense)>0 ? Target.GetCurrentStat(eStat_Defense) : 0.0f);

	ShotInfo.ModType = eHit_Success;
	ShotInfo.Reason = FriendlyName;
	ShotInfo.Value = DefenseReduction;
	ShotModifiers.AddItem(ShotInfo);

}

defaultproperties
{
	DuplicateResponse=eDupe_Allow
	EffectName="TargetFocus_LW"
}
