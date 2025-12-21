if (force_sit) with (Player) {
	motion_add(point_direction(x, y, other.x, other.y), maxspeed)
	speed = maxspeed
}