if lockstep_stop
	exit

if (busycollisions) {
	var _dir = direction,
		_speed = speed
	
	move_bounce_solid(true)
	
	motion_add(_dir, speed)
	speed = _speed
	
	if (friction == 0) exit
	
	if (hspeed > 0 && !place_free(x + hspeed, y)) {
		do {
			hspeed -= friction
		}
		until (place_free(x + hspeed, y) || hspeed <= 0)
	}
	else if (hspeed < 0 && !place_free(x + hspeed, y)) {
		do {
			hspeed += friction
		}
		until (place_free(x + hspeed, y) || hspeed >= 0)
	}
	
	if (vspeed > 0 && !place_free(x, y + vspeed)) {
		do {
			vspeed -= friction
		}
		until place_free(x, y + vspeed) || vspeed <= 0
	}
	else if vspeed < 0 && !place_free(x, y + vspeed) {
		do {
			vspeed += friction
		}
		until place_free(x, y + vspeed) || vspeed >= 0
	}
}
else {
	move_bounce_solid(true)
}