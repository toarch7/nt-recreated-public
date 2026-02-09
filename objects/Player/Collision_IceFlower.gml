if lockstep_stop
	exit

if (KeyCont.press_pick[index]) {
    scr_hit_self(1, HitId.IceFlower)
	
	var _dir = random_angle
    repeat (2 + random(3)) {
        with instance_create(x, y, BloodStreak) {
            motion_add(_dir, 5)
            image_angle = direction
        }
		
        _dir += 60 + random(30)
    }
	
	other.feed ++
	
	with (other) {
		event_perform(ev_step, ev_step_normal)
	}
}

if (visible && !scrGameIsLockState()) {
	var _x = other.x + orandom(1),
		_y = other.y + orandom(1)
	
	motion_add(point_direction(_x, _y, x, y), 1)
}