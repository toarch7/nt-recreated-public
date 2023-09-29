event_inherited()

if instance_exists(MenuOptions) or UberCont.opt_keyboard
	exit

KeyCont.dis_fire[global.index] = 0

if UberCont.opt_aimbot {
    with Player if index == global.index {
        var aim_target = instance_nearest(x, y, enemy)

        if instance_exists(NothingInactive) {
            aim_target = instance_nearest(x, y, NothingInactive)

            if !aim_target[$ "hitable"] {
                aim_target = noone
            }
        }
		else if instance_exists(LastIntro) {
            aim_target = instance_nearest(x, y, LastIntro)
        }
		else if distance_to_object(BigGenerator) <= 32 {
            aim_target = instance_nearest(x, y, BigGenerator)
        }

        var _dir = -1

        if aim_target && !collision_line(x, y, aim_target.x, aim_target.y, Wall, 1, 1) {
            var _dis = point_distance(x, y, aim_target.x, aim_target.y),
				_dir = point_direction(x, y, aim_target.x, aim_target.y)
			
			KeyCont.dis_fire[global.index] = min(1, (_dis / view_width) * 3)
        }
		else {
			_dir = KeyCont.dir_move[index]
			KeyCont.dis_fire[global.index] = KeyCont.moving[global.index]
		}
		
        if _dir != -1
            KeyCont.dir_fire[index] = angle_lerp(KeyCont.dir_fire[index], _dir, 0.75)
		
        break
    }
}

if UberCont.opt_gamepad
	exit

var i = get_nearest_touch(rad)

// reset movement
KeyCont.hold_fire[global.index] = 0
KeyCont.press_fire[global.index] = 0
KeyCont.release_fire[global.index] = 0

if index == -1
	index = i


if !UberCont.opt_aimbot {
    if index != -1 {
        var mx = device_mouse_x_to_gui(index),
			my = device_mouse_y_to_gui(index)

        var dir = point_direction(x, y, mx, my)
        dis = min(rad, point_distance(x, y, mx, my))

        KeyCont.dir_fire[global.index] = dir
        KeyCont.dis_fire[global.index] = dis / rad

        // note: press & release are swapped intentionally
		if (dis / rad) > ATTACK_BUTTON_DEADZONE {
			KeyCont.hold_fire[global.index] = 1
			
	        if device_mouse_check_button_pressed(index, mb_left)
				KeyCont.release_fire[global.index] = 1
			
	        if device_mouse_check_button_released(index, mb_left)
				KeyCont.press_fire[global.index] = 1
		}

        if !device_mouse_check_button(index, mb_left) or (distance_to_point(mx, my) > rad * 3) {
            index = -1
        }

        vdis = dis * 2
        hold = 30
    }
	else {
        dis = 0

        if !hold {
            if vdis > 0 {
                vdis--
            }
        }
		else hold--
    }
}
else {
	index = -1
	dis = 0
	
	if !UberCont.opt_splitfire && i != -1 {
		var mx = device_mouse_x_to_gui(i),
			my = device_mouse_y_to_gui(i)
		
		dis = min(rad, point_distance(x, y, mx, my))
		
		if !UberCont.opt_swapstick or (dis / rad) > ATTACK_BUTTON_DEADZONE {
		    KeyCont.hold_fire[global.index] = device_mouse_check_button(i, mb_left)
		    KeyCont.press_fire[global.index] = device_mouse_check_button_pressed(i, mb_left)
		    KeyCont.release_fire[global.index] = device_mouse_check_button_released(i, mb_left)
		}
		
		index = i
	}
}

scrControlAutoSnare()