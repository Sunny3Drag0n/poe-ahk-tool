;----------------------------------------------------------------------
; global variables
;----------------------------------------------------------------------
FlaskDurationInit := [0,0,0,0,0]
FlaskDuration := [0,0,0,0,0]
FlaskLastUsed := [0,0,0,0,0]
global UseFlasks := false
FlaskDelayMinLimit := [-99,-99,-99,-99,-99]
FlaskDelayMaxLimit := [80,150,150,150,150]
SetTimer () => ToolTip(), 1000
HSHELL_RUDEAPPACTIVATED := 32772
HSHELL_WINDOWACTIVATED := 4
;----------------------------------------------------------------------
class Position {
    __new(x, y) {
        this.X := x
        this.Y := y
    }
}
class Inventory {
    __new(hSize, vSize, topLeft) {
        this.hSize := hSize
        this.vSize := vSize
		this.cellSide := 54
		this.precision := 8
		this.topLeft := topLeft
    }
	getCellPos(r, c) {
		x := this.topLeft.X + this.cellSide * c + (this.cellSide /2) + Random(-this.precision, this.precision)
		y := this.topLeft.Y + this.cellSide * r + (this.cellSide /2) + Random(-this.precision, this.precision)
		return Position(x,y)
	}
	clickAllCells() {
		Loop (this.hSize) {
			c := A_Index - 1
			Loop (this.vSize) {
				r := A_Index - 1
				pos := this.getCellPos(r,c)
				Send "^{Click " pos.X " " pos.Y " Left}"
				sleep Random(10, 60)
			}
		}
	}
}
sellStash := Inventory(12, 5, Position(1270, 588))
buyStash := Inventory(12, 5, Position(306, 573))
;----------------------------------------------------------------------
; functions
;----------------------------------------------------------------------
load_durations() {
	FlaskDurationInit[1] := IniRead("settings.ini", "flask_1", "duration")
	FlaskDurationInit[2] := IniRead("settings.ini", "flask_2", "duration")
	FlaskDurationInit[3] := IniRead("settings.ini", "flask_3", "duration")
	FlaskDurationInit[4] := IniRead("settings.ini", "flask_4", "duration")
	FlaskDurationInit[5] := IniRead("settings.ini", "flask_5", "duration")
	MsgBox "flask_1: duration " FlaskDurationInit[1] ".`nflask_2: duration " FlaskDurationInit[2] ".`nflask_3: duration " FlaskDurationInit[3] ".`nflask_4: duration " FlaskDurationInit[4] ".`nflask_5: duration " FlaskDurationInit[5] "."
}
useFlasksWhenReady(){
	for flask, duration in FlaskDuration {
		; skip flasks with 0 duration and skip flasks that are still active
		if (duration > 0) {
			if (duration < A_TickCount - FlaskLastUsed[flask]) {
				Send flask
				onUseFlask(flask)
			}
		}
	}
}
onUseFlask(flask){
	if (FlaskDurationInit[flask] > 0) {
		FlaskLastUsed[flask] := A_TickCount
		VariableDelay := Random(FlaskDelayMinLimit[flask], FlaskDelayMaxLimit[flask])
		FlaskDuration[flask] := FlaskDurationInit[flask] + VariableDelay ; randomize duration to simulate human
	}
}
changeCurrentState() {
	global UseFlasks := not UseFlasks
	if UseFlasks {
		; reset usage timers for all flasks
		For Index, Value in FlaskDurationInit {
			FlaskLastUsed[Index] := 0
			FlaskDuration[Index] := FlaskDurationInit[Index]
		}
	}
}
useAllFlasks() {
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
}
getMousePos() {
	MouseGetPos &xpos, &ypos 
	ToolTip "The cursor is at X" xpos " Y" ypos
	return
}
mainLoopFunc() {
	Loop {
		if WinActive("Path of Exile") {
			if (UseFlasks) {
				useFlasksWhenReady()
			}
		}
		VariableDelay := Random(-50, 50)
		Sleep VariableDelay
	}
}