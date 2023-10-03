/*if opt_keyboard && !opt_gamepad {
    var me = noone

    if instance_exists(Player) {
        with Player
			if is_me me = id
		
        if instance_exists(me) {
            KeyCont.dir_fire[global.index] = point_direction(me.x, me.y, mouse_x, mouse_y)
        }
    }
}*/


if lockstep_stop {
	with all {
		if speed > 0 {
			x -= hspeed
			y -= vspeed
			
			speed += friction
		}
		
		if image_speed > 0 && image_number > 1
			image_index -= image_speed
		
		for(var i = 0; i < 12; i ++) {
			if alarm[i] > 0
				alarm[i] ++
		}
	}
}

if keyboard_check_pressed(ord("P")) {
	if network_is_locked() {
		network_unlock()
	}
	else network_lock()
}
