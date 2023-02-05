function get_nearest_touch(rad) {
    if object_index == JoystickMove or object_index == JoystickAttack {
		rad *= 1.75
	}
	
    rad *= UberCont.opt_controls_scale * 1.5 + 0.5

    for (var i = 0; i <= 4; i ++) {
		if !device_mouse_check_button(i, mb_left)
			continue
		
		var mx = device_mouse_x_to_gui(i),
			my = device_mouse_y_to_gui(i)
		
        if distance_to_point(mx, my) <= rad {
			var a = noone
			
            with MobileUI {
                if index == i && id != other.id {
					a = id
					break
				}
            }
			
            var n = instance_nearest(mx, my, MobileUI)
			
            if n != id && n != a {
				continue
			}
			
            if !a {
	            return i
	        }
        }
    }

    return -1
}