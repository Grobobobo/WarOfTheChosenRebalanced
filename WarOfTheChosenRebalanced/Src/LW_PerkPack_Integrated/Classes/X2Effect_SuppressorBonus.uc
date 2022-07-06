class X2Effect_SuppressorBonus extends X2Effect_Persistent;

var int CritBonus;
var int AimBonus;

function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
	local XComGameState_Item SourceWeapon;
	local ShotModifierInfo ShotMod;

	SourceWeapon = AbilityState.GetSourceWeapon();
	if (SourceWeapon != none && !bIndirectFire && SourceWeapon.InventorySlot == eInvSlot_PrimaryWeapon)
	{
        ShotMod.ModType = eHit_Success;
        ShotMod.Reason = FriendlyName;
        ShotMod.Value = AimBonus;
        ShotModifiers.AddItem(ShotMod);

        ShotMod.ModType = eHit_Crit;
        ShotMod.Reason = FriendlyName;
        ShotMod.Value = CritBonus;
        ShotModifiers.AddItem(ShotMod);
	}
}