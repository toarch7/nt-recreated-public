if lockstep_stop
	exit

with other {
	if team == other.team break
	
	if typ == 1 {
		image_angle = other.image_angle
		direction = other.direction
	}
	else if typ == 2 {
		instance_destroy()
	}
}