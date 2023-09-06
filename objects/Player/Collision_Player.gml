if lockstep_stop
	exit

if !instance_exists(GenCont) && speed < 4 {
	motion_add(point_direction(other.x + orandom(1), other.y + orandom(1), x, y), 1)
}