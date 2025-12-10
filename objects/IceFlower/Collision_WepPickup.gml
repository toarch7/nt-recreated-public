if lockstep_stop
	exit

with other {
    motion_add_m(point_direction(other.x, other.y, x, y), 2)
}