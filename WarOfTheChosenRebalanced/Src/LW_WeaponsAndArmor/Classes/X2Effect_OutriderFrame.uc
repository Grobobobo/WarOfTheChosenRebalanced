// Adds check for actual damage before applying crit to prevent 

class X2Effect_OutriderFrame extends X2Effect_BiggestBooms;

var int CRIT_CHANCE;
function int GetAttackingDamageModifier(XComGameState_Effect EffectState, XComGameState_Unit Attacker, Damageable TargetDamageable, XComGameState_Ability AbilityState, const out EffectAppliedData AppliedData, const int CurrentDamage, optional XComGameState NewGameState)
{
    local X2AbilityToHitCalc_StandardAim StandardHit;
	local bool Explosives;
	local X2Effect_ApplyWeaponDamage WeaponDamageEffect;

	if(AppliedData.AbilityResultContext.HitResult == eHit_Crit)
	{
		StandardHit = X2AbilityToHitCalc_StandardAim(AbilityState.GetMyTemplate().AbilityToHitCalc);
		if(StandardHit != none && StandardHit.bIndirectFire) 
		{
			Explosives = true;
		}
		if (AbilityState.GetMyTemplateName() == 'IRI_FireRocket' || AbilityState.GetMyTemplateName() == 'IRI_FireRocketLauncher' || AbilityState.GetMyTemplateName() == 'MicroMissiles')
		{
			Explosives = true;
		}
		if (Explosives)
		{
			if (CurrentDamage > 0)
			{
				WeaponDamageEffect = X2Effect_ApplyWeaponDamage(class'X2Effect'.static.GetX2Effect(AppliedData.EffectRef));
				if (WeaponDamageEffect != none)
				{			
					if (WeaponDamageEffect.bIgnoreBaseDamage)
					{	
						return 0;
					}
				}
				//return CurrentDamage;
                return 0;
			}
		}
    }
	return 0;
}


function GetToHitModifiers(XComGameState_Effect EffectState, XComGameState_Unit Attacker, XComGameState_Unit Target, XComGameState_Ability AbilityState, class<X2AbilityToHitCalc> ToHitType, bool bMelee, bool bFlanking, bool bIndirectFire, out array<ShotModifierInfo> ShotModifiers)
{
    local ShotModifierInfo BoomInfo;
    local XComGameState_Item SourceWeapon;
    local X2WeaponTemplate WeaponTemplate;
    SourceWeapon =  XComGameState_Item(`XCOMHISTORY.GetGameStateForObjectID(AbilityState.SourceWeapon.ObjectID));

    WeaponTemplate = X2WeaponTemplate(SourceWeapon.GetMyTemplate());
    
	if(WeaponTemplate != none && (WeaponTemplate.WeaponCat == 'lwChemthrower' || WeaponTemplate.WeaponCat == 'lwCanister' && WeaponTemplate.DataName != 'MZSmokeCanister' && WeaponTemplate.DataName != 'MZMedicalCanister'))
	{
		BoomInfo.ModType = eHit_Crit;
		BoomInfo.Value = default.CRIT_CHANCE;
	    BoomInfo.Reason = FriendlyName;
		ShotModifiers.AddItem(BoomInfo);
	}
}