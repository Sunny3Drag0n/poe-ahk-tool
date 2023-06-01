#Include "core_functions.ahk"
;----------------------------------------------------------------------
; GUI functions
;----------------------------------------------------------------------
createGui() {
	global MyGui := Gui(, "Title of Window")
	MonitorGet 1, &Left, &Top, &Right, &Bottom
	padding := 6
	width := 130
	height := 38
	MyGui.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner -Border")  ; +Owner avoids a taskbar button.
	;MyGui.Add("Text",, "Custom text")
	global myStatusBar := MyGui.AddStatusBar(,)
	MyGui.Show("NoActivate")
	MyGui.Move(Right - width - padding, padding, width, height)
	global isHidden := false
	showOnActive()
	onStateChanged()
	myStatusBar.SetFont("bold italic", "Arial")
}
onStateChanged() {
	if UseFlasks {
		MyGui.BackColor := "Red"
		myStatusBar.SetText("Flask autousage: on")
	} else {
		MyGui.BackColor := "Default"
		myStatusBar.SetText("Flask autousage: off")
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