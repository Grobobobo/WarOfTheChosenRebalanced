class YAF1_DefaultScreenStyles extends X2StrategyElement config(UI);

// for friendlies
var config name FriendlyTemplate;

var config array<name> TemplateNames;


static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;
	local YAF1_InfoScreenStyleTemplate Template;
	local name TemplateName;
	
	foreach default.TemplateNames(TemplateName)
	{
		`CREATE_X2TEMPLATE(class'YAF1_InfoScreenStyleTemplate', Template, TemplateName);
		Templates.AddItem(Template);
	}

	return Templates;
}


static function YAF1_InfoScreenStyleTemplate GetDefaultScreenStyleTemplate()
{
	return YAF1_InfoScreenStyleTemplate(class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager().FindStrategyElementTemplate(default.FriendlyTemplate));
}


static function YAF1_InfoScreenStyleTemplate ChooseScreenStyleTemplate(XComGameState_BaseObject TargetState)
{
	local bool Friendly;
	local int Score;
	local int BestScore;
	local int i;
	local YAF1_InfoScreenStyleTemplate BestTemplate, CurrTemplate;
	local array<X2StrategyElementTemplate> AllTemplates;
	local X2StrategyElementTemplateManager Mgr;

	local LWTuple Tuple;
	local LWTValue Value, EmptyValue;
	
	if (class'YAF1_Config'.default.bDisableStyles)
		return GetDefaultScreenStyleTemplate();

	Mgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	AllTemplates = Mgr.GetAllTemplatesOfClass(class'YAF1_InfoScreenStyleTemplate');

	BestScore = MinInt;
	Friendly = TargetState.GetVisualizer().IsFriendly(class'WorldInfo'.static.GetWorldInfo().GetALocalPlayerController());

	for (i = AllTemplates.Length - 1; i >= 0; i--)
	{
		CurrTemplate = YAF1_InfoScreenStyleTemplate(AllTemplates[i]);
		if (CurrTemplate.ScoreTarget(TargetState, Friendly, Score))
		{
			if (Score > BestScore)
			{
				BestScore = Score;
				BestTemplate = CurrTemplate;
			}
		}
	}


	// allow mods to change the description
	Tuple = new class'LWTuple';
	Tuple.Id = 'YAF1_OverrideUnitStyle';

	Value = EmptyValue;
	Value.kind = LWTVObject;
	Value.o = TargetState;
	Tuple.Data.AddItem(Value);

	// yes, this is the object and not a name
	// modders can just get it as a X2StrategyElementTemplate and not cast it
	Value = EmptyValue;
	Value.kind = LWTVObject;
	Value.o = BestTemplate;
	Tuple.Data.AddItem(Value);

	`XEVENTMGR.TriggerEvent('YAF1_OverrideUnitStyle', Tuple);

	return YAF1_InfoScreenStyleTemplate(Tuple.Data[1].o);
}