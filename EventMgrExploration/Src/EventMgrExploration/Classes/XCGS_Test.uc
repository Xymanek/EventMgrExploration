class XCGS_Test extends XComGameState_BaseObject;

var int iVar;

event OnStateSubmitted ()
{
	`log(`showvar(PathName(self)),, GetFuncName());
	`log(`showvar(bReadOnly),, GetFuncName());
	`log(`showvar(bRemoved),, GetFuncName());

	`log(`showvar(PathName(GetParentGameState())),, GetFuncName());
	`log(`showvar(GetParentGameState().bReadOnly),, GetFuncName());
	`log(`showvar(GetParentGameState().HistoryIndex),, GetFuncName());
	`log(`showvar(GetParentGameState().GetNumGameStateObjects()),, GetFuncName());
}
