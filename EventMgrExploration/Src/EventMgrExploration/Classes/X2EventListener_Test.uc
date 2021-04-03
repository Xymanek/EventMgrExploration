class X2EventListener_Test extends X2EventListener;

static function array<X2DataTemplate> CreateTemplates ()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateTemplate());

	return Templates;
}

static function CHEventListenerTemplate CreateTemplate ()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'EventMgrExploration_Listener');
	Template.AddCHEvent('EME_Test1', On_ELD_Immediate, ELD_Immediate);
	Template.AddCHEvent('EME_Test1', On_ELD_OnStateSubmitted, ELD_OnStateSubmitted);
	Template.AddCHEvent('EME_Test1', On_ELD_OnVisualizationBlockCompleted, ELD_OnVisualizationBlockCompleted);
	Template.AddCHEvent('EME_Test1', On_ELD_PreStateSubmitted, ELD_PreStateSubmitted);
	Template.AddCHEvent('EME_Test1', On_ELD_OnVisualizationBlockStarted, ELD_OnVisualizationBlockStarted);
	Template.RegisterInTactical = true;
	Template.RegisterInStrategy = true;

	return Template;
}

//static protected function EventListenerReturn OnStuff (Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)

static protected function EventListenerReturn On_ELD_Immediate (Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	DumpListener(ELD_Immediate, EventData, EventSource, GameState, EventID, CallbackData);
	return ELR_NoInterrupt;
}

static protected function EventListenerReturn On_ELD_OnStateSubmitted (Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	DumpListener(ELD_OnStateSubmitted, EventData, EventSource, GameState, EventID, CallbackData);
	return ELR_NoInterrupt;
}

static protected function EventListenerReturn On_ELD_OnVisualizationBlockCompleted (Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	DumpListener(ELD_OnVisualizationBlockCompleted, EventData, EventSource, GameState, EventID, CallbackData);
	return ELR_NoInterrupt;
}

static protected function EventListenerReturn On_ELD_PreStateSubmitted (Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	DumpListener(ELD_PreStateSubmitted, EventData, EventSource, GameState, EventID, CallbackData);
	return ELR_NoInterrupt;
}

static protected function EventListenerReturn On_ELD_OnVisualizationBlockStarted (Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	DumpListener(ELD_OnVisualizationBlockStarted, EventData, EventSource, GameState, EventID, CallbackData);
	return ELR_NoInterrupt;
}

static protected function DumpListener (EventListenerDeferral Def, Object EventData, Object EventSource, XComGameState GameState, Name EventID, Object CallbackData)
{
	local XCGS_Test TestState, FromHistoryState;
	local XComGameStateHistory History;
	local name nDef;

	nDef = name(string(Def));
	History = `XCOMHISTORY;
	TestState = XCGS_Test(EventSource);
	
	`log("Starting",, nDef);

	`log(`showvar(History.GetNumGameStates()),, nDef);
	`log(`showvar(History.GetCurrentHistoryIndex()),, nDef);
	`log(`showvar(PathName(History.GetGameStateFromHistory())),, nDef);

	`log(`showvar(PathName(GameState)),, nDef);
	`log(`showvar(GameState.bReadOnly),, nDef);
	`log(`showvar(GameState.HistoryIndex),, nDef);
	`log(`showvar(GameState.GetNumGameStateObjects()),, nDef);

	`log(`showvar(TestState != none),, nDef);
	if (TestState != none)
	{
		`log(`showvar(PathName(TestState)),, nDef);
		`log(`showvar(TestState.bReadOnly),, nDef);
		`log(`showvar(TestState.bRemoved),, nDef);
		`log(`showvar(TestState.iVar),, nDef);

		FromHistoryState = XCGS_Test(History.GetGameStateForObjectID(TestState.ObjectID,, GameState.HistoryIndex));
		`log(`showvar(PathName(FromHistoryState)),, nDef);
	}

	`log("Finished",, nDef);
}