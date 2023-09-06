if lockstep_stop
	exit

with other {
    motion_add(point_direction(other.x, other.y, x, y), 2)
}