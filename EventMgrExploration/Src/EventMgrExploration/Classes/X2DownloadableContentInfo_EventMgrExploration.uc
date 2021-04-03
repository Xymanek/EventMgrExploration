class X2DownloadableContentInfo_EventMgrExploration extends X2DownloadableContentInfo;

exec function EME_Test1 ()
{
	local XComGameState NewGameState;
	local XCGS_Test TestState;
	local X2EventManager Mgr;

	Mgr = `XEVENTMGR;

	`log(GetFuncName(),, 'EventMgrExploration');
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("EME_Test1");
	TestState = XCGS_Test(NewGameState.CreateNewStateObject(class'XCGS_Test'));

	`log("Before setting",, 'EventMgrExploration');
	Mgr.TriggerEvent('EME_Test1', TestState, TestState, NewGameState);
	
	`log("After setting",, 'EventMgrExploration');
	TestState.iVar = 1;
	Mgr.TriggerEvent('EME_Test1', TestState, TestState, NewGameState);
	
	`log("Submit",, 'EventMgrExploration');
	`GAMERULES.SubmitGameState(NewGameState);

	`log("Updating",, 'EventMgrExploration');
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("EME_Test1 updating");
	TestState = XCGS_Test(NewGameState.ModifyStateObject(class'XCGS_Test', TestState.ObjectID));
	Mgr.TriggerEvent('EME_Test1', TestState, TestState, NewGameState);

	`log("After setting",, 'EventMgrExploration');
	TestState.iVar = 2;
	Mgr.TriggerEvent('EME_Test1', TestState, TestState, NewGameState);

	`log("Submit",, 'EventMgrExploration');
	`GAMERULES.SubmitGameState(NewGameState);

	`log("Removing",, 'EventMgrExploration');
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("EME_Test1 updating");
	NewGameState.RemoveStateObject(TestState.ObjectID);
	Mgr.TriggerEvent('EME_Test1', TestState, TestState, NewGameState);

	`log("Submit",, 'EventMgrExploration');
	`GAMERULES.SubmitGameState(NewGameState);
}