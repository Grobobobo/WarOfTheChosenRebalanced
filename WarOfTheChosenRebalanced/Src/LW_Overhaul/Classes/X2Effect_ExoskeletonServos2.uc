class X2Effect_ExoskeletonServos2 extends X2Effect_Persistent;


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local ShotModifierInfo ShotInfo;
    local X2WeaponTemplate WeaponTemplate;
    WeaponTemplate = X2WeaponTemplate(Attacker.GetPrimaryWeapon().GetMyTemplate());

	if (WeaponTemplate != none && WeaponTemplate.WeaponCat == 'cannon')
	{
		ShotInfo.ModType = eHit_Graze;
		ShotInfo.Reason = FriendlyName;
		ShotInfo.Value = -1 * Min(WeaponTemplate.Aim,0);
		ShotModifiers.AddItem(ShotInfo);
	}
}
