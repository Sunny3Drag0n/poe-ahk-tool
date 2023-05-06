#Include "core_functions.ahk"
;----------------------------------------------------------------------
; GUI functions
;----------------------------------------------------------------------
createGui() {
	global MyGui := Gui(, "Title of Window")
	MonitorGet 1, &Left, &Top, &Right, &Bottom
	padding := 6
	width := 100
	height := 30
	MyGui.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner -Border")  ; +Owner avoids a taskbar button.
	;MyGui.Add("Text",, "Custom text")
	global myStatusBar := MyGui.AddStatusBar(,)
	MyGui.Show("NoActivate")
	MyGui.Move(Right - width - padding, padding, width, height)
	global isHidden := false
	showOnActive()
	onStateChanged()
}
onStateChanged() {
	if UseFlasks {
		useTooltipStateString := "is on"
	} else {
		useTooltipStateString := "is off"
	}
	if myStatusBar {	
		myStatusBar.SetText("Flasks:" useTooltipStateString)
	}
}
showOnActive() {
	if WinActive("Path of Exile") {
		if (isHidden) {
			;ToolTip "Show GUI"
			MyGui.Show("NoActivate")
			global isHidden := false
		}
	} else {
		if (Not isHidden) {
			;ToolTip "Hide GUI"
			MyGui.Hide()
			global isHidden := true
		}
	}
}
onActiveWinChanged_GUI(wParam, lParam, msg, hwnd) {
	if (wParam == HSHELL_RUDEAPPACTIVATED || wParam == HSHELL_WINDOWACTIVATED) {
		sleep 500
		showOnActive()
	}
}