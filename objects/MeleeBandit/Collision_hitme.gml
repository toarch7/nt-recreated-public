if lockstep_stop
	exit

if other.team != team motion_add(point_direction(other.x, other.y, x, y), 4)