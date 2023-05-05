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
	onStateChanged()
	MyGui.Show("NoActivate")  ; NoActivate avoids deactivating the currently active window.
	MyGui.Move(Right - width - padding, padding, width, height)
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
