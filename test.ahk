class Position {
    __new(x, y) {
        this.X := x
        this.Y := y
    }
}
stashTopLeft := Position(1270, 588)
topLeft := Position(1270, 588)
SetDefaultMouseSpeed 50
SetMouseDelay 2
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
				Send "^{Click " pos.X " " pos.Y "}"
				sleep Random(20, 50)
			}
			return
		}
	}
}
sellStash := Inventory(12, 5, Position(1270, 588))
buyStash := Inventory(12, 5, Position(306, 573))
!Left::sellStash.clickAllCells()
!Right::buyStash.clickAllCells()

getMousePos() {
	MouseGetPos &xpos, &ypos 
	ToolTip "The cursor is at X" xpos " Y" ypos
	return
}
!g::getMousePos()