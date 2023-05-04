;----------------------------------------------------------------------
; PoE Flasks macro for AutoHotKey
;
; Keys used and monitored:
; XButton1 - activate automatic flask usage
; 1-5 - number keys to manually use a specific flask
; ` (backtick) - use all flasks, now
; alt+0 - load flasks configuration
;----------------------------------------------------------------------
SetTimer () => ToolTip(), 2500
FlaskDurationInit := [0,0,0,0,0]
FlaskDuration := [0,0,0,0,0]
FlaskLastUsed := [0,0,0,0,0]
UseFlasks := false
FlaskDelayMinLimit := [-99,-99,-99,-99,-99]
FlaskDelayMaxLimit := [80,150,150,150,150]
;----------------------------------------------------------------------
; Main program loop
;----------------------------------------------------------------------
load_durations() {
	FlaskDurationInit[1] := IniRead("settings.ini", "flask_1", "duration")
	FlaskDurationInit[2] := IniRead("settings.ini", "flask_2", "duration")
	FlaskDurationInit[3] := IniRead("settings.ini", "flask_3", "duration")
	FlaskDurationInit[4] := IniRead("settings.ini", "flask_4", "duration")
	FlaskDurationInit[5] := IniRead("settings.ini", "flask_5", "duration")
	MsgBox "flask_1: duration " FlaskDurationInit[1] ".`nflask_2: duration " FlaskDurationInit[2] ".`nflask_3: duration " FlaskDurationInit[3] ".`nflask_4: duration " FlaskDurationInit[4] ".`nflask_5: duration " FlaskDurationInit[5] "."
}
!0::load_durations()

load_durations()

Loop {
	if (UseFlasks) {
		CycleAllFlasksWhenReady()
	}
	VariableDelay := Random(-50, 50)
	Sleep VariableDelay
}

XButton1::{
	global UseFlasks := not UseFlasks
	if UseFlasks {
		; reset usage timers for all flasks
		For Index, Value in FlaskDurationInit {
			FlaskLastUsed[Index] := 0
			FlaskDuration[Index] := FlaskDurationInit[Index]
		}
		;ToolTip "UseFlasks On : durations [" FlaskDurationInit[1] ", " FlaskDurationInit[2] ", " FlaskDurationInit[3] ", " FlaskDurationInit[4] ", " FlaskDurationInit[5] "]"
	} else {
		ToolTip "UseFlasks Off"
	}
	return
}

;----------------------------------------------------------------------
; The following 5 hotkeys allow for manual use of flasks while still
; tracking optimal recast times.
;----------------------------------------------------------------------

~1::{
	UseFlask(1)
	return
}

~2::{
	UseFlask(2)
	return
}

~3::{
	UseFlask(3)
	return
}

~4::{
	UseFlask(4)
	return
}

~5::{
	UseFlask(5)
	return
}

;----------------------------------------------------------------------
; Use all flasks, now.  A variable delay is included between flasks
;----------------------------------------------------------------------
`::{
	Send 1
	VariableDelay := Random(FlaskDelayMinLimit[2], FlaskDelayMaxLimit[2])
	Sleep VariableDelay
	Send 2
	VariableDelay := Random(FlaskDelayMinLimit[3], FlaskDelayMaxLimit[3])
	Sleep VariableDelay
	Send 3
	VariableDelay := Random(FlaskDelayMinLimit[4], FlaskDelayMaxLimit[4])
	Sleep VariableDelay
	Send 4
	VariableDelay := Random(FlaskDelayMinLimit[5], FlaskDelayMaxLimit[5])
	Sleep VariableDelay
	Send 5
	;ToolTip "Used all flasks"
	return
}

CycleAllFlasksWhenReady(){
	for flask, duration in FlaskDuration {
		; skip flasks with 0 duration and skip flasks that are still active
		if ((duration > 0) & (duration < A_TickCount - FlaskLastUsed[flask])) {
			Send flask
			UseFlask(flask)
		}
	}
	return
}

UseFlask(flask){
	FlaskLastUsed[flask] := A_TickCount
	VariableDelay := Random(FlaskDelayMinLimit[flask], FlaskDelayMaxLimit[flask])
	FlaskDuration[flask] := FlaskDurationInit[flask] + VariableDelay ; randomize duration to simulate human
	return
}

;----------------------------------------------------------------------
; Alt+c to Ctrl-Click every location in the (I)nventory screen.
;----------------------------------------------------------------------
!c::{
	return
}

;----------------------------------------------------------------------
; Alt+m - Allow setting stash tab size as normal (12x12) or large (24x24)
; 
; vMouseRow := 1 (default) means starting in row 1 of stash tab
; always place mouse pointer in starting box
;
; ItemsToMove := 50 (default) is how many items to move to Inventory
;----------------------------------------------------------------------
!m::{
	return
}
;----------------------------------------------------------------------
; Alt+g - Get the current screen coordinates of the mouse pointer.
;----------------------------------------------------------------------
!g::{
	MouseGetPos &xpos, &ypos 
	ToolTip "The cursor is at X" xpos " Y" ypos
	return
}