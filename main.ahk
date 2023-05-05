;----------------------------------------------------------------------
;
; PoE Flasks macro for AutoHotKey
;
;----------------------------------------------------------------------
; Include
;----------------------------------------------------------------------
#Include "core_functions.ahk"
#Include "gui.ahk"
;----------------------------------------------------------------------
; Hotkeys
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
mainLoopFunc()