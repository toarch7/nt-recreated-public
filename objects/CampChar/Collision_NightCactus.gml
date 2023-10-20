if lockstep_stop
	exit

motion_add(point_direction(other.x, other.y, x, y), 1)

if speed > 8
	speed = 8