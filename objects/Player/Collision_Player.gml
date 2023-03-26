if !instance_exists(GenCont) && speed < 4 {
	motion_add(point_direction(other.x, other.y, x, y) + orandom(1), 1)
}