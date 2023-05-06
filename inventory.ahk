;----------------------------------------------------------------------
; global variables
;----------------------------------------------------------------------
SetMouseDelay 2
clickerInterruptionFlag := false
;----------------------------------------------------------------------
interruptClicker() {
	global clickerInterruptionFlag
	if (!clickerInterruptionFlag) {
		clickerInterruptionFlag := true
	}
	Send "{Esc}"
}
;----------------------------------------------------------------------
; class Position
;----------------------------------------------------------------------
class Position {
    __new(x, y) {
        this.X := x
        this.Y := y
    }
}
;----------------------------------------------------------------------
; class Inventory
;----------------------------------------------------------------------
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
				if WinActive("Path of Exile") {
					this.clickElement(r,c)
				} else {
					return
				}
			}
		}
	}
}