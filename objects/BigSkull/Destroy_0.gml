event_inherited()

var _ang = random_angle

repeat 10 {
    with instance_create(x, y, Dust) {
		motion_add(_ang, 3)
	}
	
	_ang += 36
}