if lockstep_stop
	exit

if speed < 4 && visible motion_add(point_direction(other.x, other.y, x, y), 2)