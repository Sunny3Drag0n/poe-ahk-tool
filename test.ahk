SetDefaultMouseSpeed 50
SetMouseDelay 2
class Position {
    __new(x, y) {
        this.X := x
        this.Y := y
    }
}
clickerInterruptionFlag := false
interruptClicker() {
	global clickerInterruptionFlag
	if (!clickerInterruptionFlag) {
		clickerInterruptionFlag := true 
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
	clickElement(r, c) {
		pos := this.getCellPos(r,c)
		MouseMove pos.X, pos.Y, 80
		sleep Random(10, 20)
		Send "^{Click " pos.X " " pos.Y "}"
		sleep Random(15, 40)
	}
	clickAllCells() {
		global clickerInterruptionFlag := false
		Loop (this.hSize) {
			c := A_Index - 1
			Loop (this.vSize) {
				r := A_Index - 1
				if (clickerInterruptionFlag) {
					return
				}
				ToolTip "clickerInterruptionFlag " clickerInterruptionFlag
				;if WinActive("Path of Exile") {
					this.clickElement(r,c)
				;} else {
				;	return
				;}
			}
		}
	}
}


sellStash := Inventory(12, 5, Position(1270, 588))
buyStash := Inventory(12, 5, Position(306, 573))
!Left::sellStash.clickAllCells()
!Right::buyStash.clickAllCells()
Esc::interruptClicker()











getMousePos() {
	MouseGetPos &xpos, &ypos 
	ToolTip "The cursor is at X" xpos " Y" ypos
	Send "^{Click " xpos " " ypos "}"
	sleep Random(30, 50)
	return
}
!g::getMousePos()