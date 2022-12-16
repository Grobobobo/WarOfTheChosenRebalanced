class BitterfrostHelper extends object config(LW_Overhaul);

var config array<name> AddBitterfrostEffectToWeapons, AddBitterfreezeEffectToWeapons;

var config int Chill_Turns, BitterChill_Turns, BitterfrostFreeze_MinDuration, BitterfrostFreeze_MaxDuration;
var config float Chill_Mobility, Chill_Dodge, BitterChill_Mobility, BitterChill_Dodge;
var config string ChillParticle_Name;
var config name ChillSocket_Name, ChillSocketsArray_Name;
var localized string ChillEffectName, ChillEffectDesc, BitterChillEffectName, BitterChillEffectDesc;

static function ChillVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	if (EffectApplyResult != 'AA_Success')
		return;
	if (!ActionMetadata.StateObject_NewState.IsA('XComGameState_Unit'))
		return;

	class'X2StatusEffects'.static.AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.ChillEffectName, '', eColor_Bad, "img:///UILibrary_DLC2Images.UIPerk_freezingbreath");
	class'X2StatusEffects'.static.UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

static function BChillVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	if (EffectApplyResult != 'AA_Success')
		return;
	if (!ActionMetadata.StateObject_NewState.IsA('XComGameState_Unit'))
		return;

	class'X2StatusEffects'.static.AddEffectSoundAndFlyOverToTrack(ActionMetadata, VisualizeGameState.GetContext(), default.BitterChillEffectName, '', eColor_Bad, "img:///UILibrary_DLC2Images.UIPerk_freezingbreath");
	class'X2StatusEffects'.static.UpdateUnitFlag(ActionMetadata, VisualizeGameState.GetContext());
}

static function X2Effect_PersistentStatChange ChillEffect(optional bool ExcludeRulers = false)
{
	local X2Effect_PersistentStatChange	ChillEffect;
	local X2Condition_ExcludeRuler			RulerExcludeCondition;

	ChillEffect = new class'X2Effect_PersistentStatChange';
	ChillEffect.BuildPersistentEffect(default.Chill_Turns, false, false, false, eGameRule_PlayerTurnEnd);
	ChillEffect.EffectName = 'MZChill';
	ChillEffect.DuplicateResponse = eDupe_Refresh;
	ChillEffect.bRemoveWhenTargetDies = true;
	ChillEffect.AddPersistentStatChange(eStat_Mobility, default.Chill_Mobility, MODOP_PostMultiplication);
	ChillEffect.AddPersistentStatChange(eStat_Dodge, default.Chill_Dodge, MODOP_PostMultiplication);
	ChillEffect.DamageTypes.AddItem('Frost');
	ChillEffect.SetDisplayInfo(ePerkBuff_Penalty, default.ChillEffectName , default.ChillEffectDesc, "img:///UILibrary_DLC2Images.UIPerk_freezingbreath", true);
	ChillEffect.VisualizationFn = ChillVisualization;
	if (default.ChillParticle_Name != "")
	{
		ChillEffect.VFXTemplateName = default.ChillParticle_Name;
		ChillEffect.VFXSocket = default.ChillSocket_Name;
		ChillEffect.VFXSocketsArrayName = default.ChillSocketsArray_Name;
	}
	if(ExcludeRulers)
	{
		RulerExcludeCondition = new class 'X2Condition_ExcludeRuler';
		ChillEffect.TargetConditions.AddItem(RulerExcludeCondition);
	}
	return ChillEffect;
}

static function X2Effect_PersistentStatChange BitterChillEffect(optional bool RequireChill = True, optional bool ExcludeRulers = false)
{
	local X2Effect_PersistentStatChange		BitterChillEffect;
	local X2Condition_UnitEffects			ChillDegreeCondition;
	local X2Condition_ExcludeRuler			RulerExcludeCondition;

	BitterChillEffect = new class'X2Effect_PersistentStatChange';
	BitterChillEffect.BuildPersistentEffect(default.BitterChill_Turns, false, false, false, eGameRule_PlayerTurnEnd);
	BitterChillEffect.EffectName = 'MZBitterChill';
	BitterChillEffect.DuplicateResponse = eDupe_Refresh;
	BitterChillEffect.bRemoveWhenTargetDies = true;
	BitterChillEffect.AddPersistentStatChange(eStat_Mobility, default.BitterChill_Mobility, MODOP_PostMultiplication);
	BitterChillEffect.AddPersistentStatChange(eStat_Dodge, default.BitterChill_Dodge, MODOP_PostMultiplication);
	BitterChillEffect.DamageTypes.AddItem('Frost');
	BitterChillEffect.SetDisplayInfo(ePerkBuff_Penalty, default.BitterChillEffectName , default.BitterChillEffectDesc, "img:///UILibrary_DLC2Images.UIPerk_freezingbreath", true);
	BitterChillEffect.VisualizationFn = BChillVisualization;
	if ( RequireChill )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		BitterChillEffect.TargetConditions.AddItem(ChillDegreeCondition);
	}
	if(ExcludeRulers)
	{
		RulerExcludeCondition = new class 'X2Condition_ExcludeRuler';
		BitterChillEffect.TargetConditions.AddItem(RulerExcludeCondition);
	}
	return BitterChillEffect;
}

static function X2Effect_DLC_Day60Freeze FreezeEffect(optional bool bHasChillReq=true, optional bool bRulerOnly = false, optional bool bExcludeRulers = false)
{
	local X2Condition_UnitEffects			ChillDegreeCondition;
	local X2Effect_DLC_Day60Freeze			FreezeEffect;
	local X2Condition_RequireRuler RulerOnlyCondition;
	local X2Condition_ExcludeRuler ExcludeRulerCondition;

	FreezeEffect = class'X2Effect_DLC_Day60Freeze'.static.CreateFreezeEffect(default.BitterfrostFreeze_MinDuration, default.BitterfrostFreeze_MaxDuration);
	FreezeEffect.bApplyRulerModifiers = true;
	if ( bHasChillReq )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZBitterChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		FreezeEffect.TargetConditions.AddItem(ChillDegreeCondition);
	}
	if(bRulerOnly)
	{
		RulerOnlyCondition = new class 'X2Condition_RequireRuler';
		FreezeEffect.TargetConditions.AddItem(RulerOnlyCondition);
	}
	if(bExcludeRulers)
	{
		ExcludeRulerCondition = new class 'X2Condition_ExcludeRuler';
		FreezeEffect.TargetConditions.AddItem(ExcludeRulerCondition);
	}

	return FreezeEffect;
}

static function X2Effect FreezeCleanse(optional bool bHasChillReq=true, optional bool bRulerOnly = false, optional bool bExcludeRulers = false)
{
	local X2Condition_UnitEffects			ChillDegreeCondition;
	local X2Effect							RemoveEffects; 
	local X2Condition_RequireRuler RulerOnlyCondition;
	local X2Condition_ExcludeRuler ExcludeRulerCondition;

	RemoveEffects=class'X2Effect_DLC_Day60Freeze'.static.CreateFreezeRemoveEffects();
	if ( bHasChillReq )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZBitterChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		RemoveEffects.TargetConditions.AddItem(ChillDegreeCondition);
	}
	if(bRulerOnly)
	{
		RulerOnlyCondition = new class 'X2Condition_RequireRuler';
		RemoveEffects.TargetConditions.AddItem(RulerOnlyCondition);
	}
	if(bExcludeRulers)
	{
		ExcludeRulerCondition = new class 'X2Condition_ExcludeRuler';
		RemoveEffects.TargetConditions.AddItem(ExcludeRulerCondition);
	}
	return RemoveEffects;
}

static function X2Effect UnChillEffect()
{
	local X2Effect_RemoveEffectsByDamageType	RemoveEffects;

	RemoveEffects = new class'X2Effect_RemoveEffectsByDamageType';
	RemoveEffects.DamageTypesToRemove[0] = 'frost';

	return RemoveEffects;
}

static function AddBitterfrostToMultiTarget(out X2AbilityTemplate Template)
{
	Template.AddMultiTargetEffect(FreezeCleanse());
	Template.AddMultiTargetEffect(FreezeEffect());
	Template.AddMultiTargetEffect(BitterChillEffect());
	Template.AddMultiTargetEffect(ChillEffect());
}

static function AddBitterfrostToTarget(out X2AbilityTemplate Template)
{
	Template.AddTargetEffect(FreezeCleanse());
	Template.AddTargetEffect(FreezeEffect());
	Template.AddTargetEffect(BitterChillEffect());
	Template.AddTargetEffect(ChillEffect());
}


static function AddBitterfrostToWeaponEffects(out X2WeaponTemplate Template, optional bool bAlwaysFreeze=false)
{
	local X2Effect_ImmediateAbilityActivation ImpairingAbilityEffect;
	local X2Condition_UnitEffects			ChillDegreeCondition;

	ImpairingAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	ImpairingAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	ImpairingAbilityEffect.EffectName = 'MZBitterFrostFreezeEffect';
	ImpairingAbilityEffect.AbilityName = 'MZBitterFrostFreeze';
	ImpairingAbilityEffect.bRemoveWhenTargetDies = true;
	ImpairingAbilityEffect.VisualizationFn = ApplyChillAbilityEffectTriggeredVisualization;

	If ( !bAlwaysFreeze )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZBitterChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		ImpairingAbilityEffect.TargetConditions.AddItem(ChillDegreeCondition);
	}

	Template.BonusWeaponEffects.AddItem(ImpairingAbilityEffect);
	Template.BonusWeaponEffects.AddItem(BitterChillEffect());
	Template.BonusWeaponEffects.AddItem(ChillEffect());

	Template.Abilities.AddItem('MZBitterFrostFreeze');
}

static function AddBitterfrostToWeaponEffectsPaired(out X2PairedWeaponTemplate Template, optional bool bAlwaysFreeze=false)
{
	local X2Effect_ImmediateAbilityActivation ImpairingAbilityEffect;
	local X2Condition_UnitEffects			ChillDegreeCondition;

	ImpairingAbilityEffect = new class 'X2Effect_ImmediateAbilityActivation';
	ImpairingAbilityEffect.BuildPersistentEffect(1, false, true, , eGameRule_PlayerTurnBegin);
	ImpairingAbilityEffect.EffectName = 'MZBitterFrostFreezeEffect';
	ImpairingAbilityEffect.AbilityName = 'MZBitterFrostFreeze';
	ImpairingAbilityEffect.bRemoveWhenTargetDies = true;
	ImpairingAbilityEffect.VisualizationFn = ApplyChillAbilityEffectTriggeredVisualization;

	If ( !bAlwaysFreeze )
	{
		ChillDegreeCondition = new class'X2Condition_UnitEffects';
		ChillDegreeCondition.AddRequireEffect('MZBitterChill', 'AA_MissingRequiredEffect'); // name effect, name reason
		ImpairingAbilityEffect.TargetConditions.AddItem(ChillDegreeCondition);
	}

	Template.BonusWeaponEffects.AddItem(ImpairingAbilityEffect);
	Template.BonusWeaponEffects.AddItem(BitterChillEffect());
	Template.BonusWeaponEffects.AddItem(ChillEffect());

	Template.Abilities.AddItem('MZBitterFrostFreeze');
}

static function ApplyChillAbilityEffectTriggeredVisualization(XComGameState VisualizeGameState, out VisualizationActionMetadata ActionMetadata, const name EffectApplyResult)
{
	local XComGameStateContext_Ability AbilityContext;
	local XComGameStateContext Context;
	local XComGameStateContext_Ability TestAbilityContext;
	local int i, j, ChildIndex;
	local XComGameStateHistory History;
	local bool bAbilityWasSuccess;
	local X2AbilityTemplate AbilityTemplate;
	local X2VisualizerInterface TargetVisualizerInterface;
	local XComGameStateVisualizationMgr VisMgr;
	local X2Action_ApplyWeaponDamageToUnit DamageAction;
	local X2Action TempAction;
	local X2Action_MarkerNamed HitReactAction;

	if( (EffectApplyResult != 'AA_Success') || (XComGameState_Unit(ActionMetadata.StateObject_NewState) == none) )
	{
		return;
	}

	Context = VisualizeGameState.GetContext();
	AbilityContext = XComGameStateContext_Ability(Context);

	if( AbilityContext.EventChainStartIndex != 0 )
	{
		History = `XCOMHISTORY;

		// This GameState is part of a chain, which means there may be a stun to the target
		for( i = AbilityContext.EventChainStartIndex; !Context.bLastEventInChain; ++i )
		{
			Context = History.GetGameStateFromHistory(i).GetContext();

			TestAbilityContext = XComGameStateContext_Ability(Context);
			bAbilityWasSuccess = (TestAbilityContext != none) && class'XComGameStateContext_Ability'.static.IsHitResultHit(TestAbilityContext.ResultContext.HitResult);

			if( bAbilityWasSuccess &&
				TestAbilityContext.InputContext.AbilityTemplateName == 'MZ_FDImmediateApplyChill' &&
				TestAbilityContext.InputContext.SourceObject.ObjectID == AbilityContext.InputContext.SourceObject.ObjectID &&
				TestAbilityContext.InputContext.PrimaryTarget.ObjectID == AbilityContext.InputContext.PrimaryTarget.ObjectID )
			{
				// The Melee Impairing Ability has been found with the same source and target
				// Move that ability's visualization forward to this track
				AbilityTemplate = class'XComGameState_Ability'.static.GetMyTemplateManager().FindAbilityTemplate(TestAbilityContext.InputContext.AbilityTemplateName);

				for( j = 0; j < AbilityTemplate.AbilityTargetEffects.Length; ++j )
				{
					AbilityTemplate.AbilityTargetEffects[j].AddX2ActionsForVisualization(TestAbilityContext.AssociatedState, ActionMetadata, TestAbilityContext.FindTargetEffectApplyResult(AbilityTemplate.AbilityTargetEffects[j]));
				}

				TargetVisualizerInterface = X2VisualizerInterface(ActionMetadata.VisualizeActor);
				if (TargetVisualizerInterface != none)
				{
					TargetVisualizerInterface.BuildAbilityEffectsVisualization(Context.AssociatedState, ActionMetadata);
				}

				VisMgr = `XCOMVISUALIZATIONMGR;

				DamageAction = X2Action_ApplyWeaponDamageToUnit(VisMgr.GetNodeOfType(VisMgr.BuildVisTree, class'X2Action_ApplyWeaponDamageToUnit', ActionMetadata.VisualizeActor));

				if( DamageAction.ChildActions.Length > 0 )
				{
					HitReactAction = X2Action_MarkerNamed(class'X2Action_MarkerNamed'.static.AddToVisualizationTree(ActionMetadata, AbilityContext, true, DamageAction));
					HitReactAction.SetName("ImpairingReact");
					HitReactAction.AddInputEvent('Visualizer_AbilityHit');

					for( ChildIndex = 0; ChildIndex < DamageAction.ChildActions.Length; ++ChildIndex )
					{
						TempAction = DamageAction.ChildActions[ChildIndex];
						VisMgr.DisconnectAction(TempAction);
						VisMgr.ConnectAction(TempAction, VisMgr.BuildVisTree, false, , DamageAction.ParentActions);
					}

					VisMgr.DisconnectAction(DamageAction);
					VisMgr.ConnectAction(DamageAction, VisMgr.BuildVisTree, false, ActionMetadata.LastActionAdded);
				}

				break;
			}
		}
	}
}

static function AddBitterfrostToWeapons()
{
	local X2ItemTemplateManager			ItemManager;
	local array<X2DataTemplate>			DifficultyTemplates;
	local X2DataTemplate				DifficultyTemplate;
	local Name							TemplateName;
	local X2WeaponTemplate				WeaponTemplate;
	
	ItemManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();

	Foreach default.AddBitterfrostEffectToWeapons(TemplateName)
	{
		ItemManager.FindDataTemplateAllDifficulties(TemplateName, DifficultyTemplates);
		foreach DifficultyTemplates(DifficultyTemplate) {
			WeaponTemplate = X2WeaponTemplate(DifficultyTemplate);
			if ( WeaponTemplate != none) {
				AddBitterfrostToWeaponEffects(WeaponTemplate, false);
			}
		}
	}

	Foreach default.AddBitterfreezeEffectToWeapons(TemplateName)
	{
		ItemManager.FindDataTemplateAllDifficulties(TemplateName, DifficultyTemplates);
		foreach DifficultyTemplates(DifficultyTemplate) {
			WeaponTemplate = X2WeaponTemplate(DifficultyTemplate);
			if ( WeaponTemplate != none) {
				AddBitterfrostToWeaponEffects(WeaponTemplate, true);
			}
		}
	}	
}

simulated function ApplyChill_BuildVisualization(XComGameState VisualizeGameState)
{
	local XComGameStateHistory History;
	local XComGameStateContext_Ability  Context;
	local StateObjectReference InteractingUnitRef;
	local VisualizationActionMetadata EmptyTrack;
	local VisualizationActionMetadata ActionMetadata;

	History = `XCOMHISTORY;

	Context = XComGameStateContext_Ability(VisualizeGameState.GetContext());
	InteractingUnitRef = Context.InputContext.SourceObject;

	//Configure the visualization track for the shooter
	//****************************************************************************************
	ActionMetadata = EmptyTrack;
	ActionMetadata.StateObject_OldState = History.GetGameStateForObjectID(InteractingUnitRef.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
	ActionMetadata.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(InteractingUnitRef.ObjectID);
	ActionMetadata.VisualizeActor = History.GetVisualizer(InteractingUnitRef.ObjectID);

	class'X2Action_AbilityPerkStart'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);
	class'X2Action_AbilityPerkEnd'.static.AddToVisualizationTree(ActionMetadata, Context, false, ActionMetadata.LastActionAdded);

}
