class X2Effect_EnemySighted extends X2Effect;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
    local X2CharacterTemplate CharacterTemplate;
    CharacterTemplate = XComGameState_Unit(kNewTargetState).GetMyTemplate();
    if(`XCOMHQ.SeenCharacterTemplates.Find(CharacterTemplate.DataName) == INDEX_NONE)
    {
        `XCOMHQ.SeenCharacterTemplates.AddItem(CharacterTemplate.DataName);
    }
}
