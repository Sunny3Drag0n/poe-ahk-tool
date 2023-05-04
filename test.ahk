global iOn := true
global str := "Is Enabled"
createGui() {
	global MyGui := Gui(, "Title of Window")
	MonitorGet 1, &Left, &Top, &Right, &Bottom
	padding := 6
	width := 100
	height := 30
	MyGui.Opt("+AlwaysOnTop +Disabled -SysMenu +Owner -Border")  ; +Owner avoids a taskbar button.
	;MyGui.Add("Text",, "Custom text")
	global myStatusBar := MyGui.AddStatusBar(,)
	myStatusBar.SetText("Flasks:" str)
	MyGui.Show("NoActivate")  ; NoActivate avoids deactivating the currently active window.
	MyGui.Move(Right - width - padding, padding, width, height)
}

getGuiPos() {
	MyGui.GetPos(&x, &y)
	ToolTip "X: " x " Y:" y
}

createGui()
!4::{
	getGuiPos()
	str := "Is Disabled"
	myStatusBar.SetText("Flasks:" str)
}