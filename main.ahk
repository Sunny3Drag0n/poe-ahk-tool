;----------------------------------------------------------------------
;
; PoE Flasks macro for AutoHotKey
;
;----------------------------------------------------------------------
; Include
;----------------------------------------------------------------------
#Include "core_functions.ahk"
#Include "gui.ahk"
#HotIf WinActive("Path of Exile")
;----------------------------------------------------------------------
; Waiting system signals on active window change
;----------------------------------------------------------------------
DllCall( "RegisterShellHookWindow", "UInt", A_ScriptHwnd)
MsgNum := DllCall( "RegisterWindowMessage", "Str","SHELLHOOK" )
;----------------------------------------------------------------------
; Hotkeys
; Keys used and monitored:
; XButton1 - activate automatic flask usage
; 1-5 - number keys to manually use a specific flask
; ` (backtick) - use all flasks, now
; alt+0 - load flasks configuration
;----------------------------------------------------------------------
!0::load_durations()
~1::onUseFlask(1)
~2::onUseFlask(2)
~3::onUseFlask(3)
~4::onUseFlask(4)
~5::onUseFlask(5)
`::useAllFlasks()
XButton1::{
	changeCurrentState()
	onStateChanged()
}
!g::getMousePos()
;----------------------------------------------------------------------
; Start
;----------------------------------------------------------------------
load_durations()
createGui()
OnMessage(MsgNum, onActiveWinChanged_GUI)
mainLoopFunc()