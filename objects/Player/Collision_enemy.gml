if lockstep_stop
	exit

if visible && !scrGameIsLockState() {
	var _x = other.x + orandom(1),
		_y = other.y + orandom(1)
	
	motion_add(point_direction(_x, _y, x, y), other.size * 0.5)
}