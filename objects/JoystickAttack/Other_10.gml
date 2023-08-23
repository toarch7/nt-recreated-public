event_inherited()

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

        var d = -1

        if aim_target && !collision_line(x, y, aim_target.x, aim_target.y, Wall, 1, 1) {
            d = point_direction(x, y, aim_target.x, aim_target.y)
        }
		else d = KeyCont.dir_move[index]

        if d != -1 {
            KeyCont.dir_fire[index] = angle_lerp(KeyCont.dir_fire[index], d, 0.75)
			KeyCont.dis_fire[global.index] = point_distance(0, 0, ldrx(1, d), ldry(1, d))
        }

        break
    }
}

if instance_exists(MenuOptions) or UberCont.opt_keyboard or UberCont.opt_gamepad
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
        var mx = device_mouse_x_to_gui(index)
        var my = device_mouse_y_to_gui(index)

        var dir = point_direction(x, y, mx, my)
        dis = min(rad, point_distance(x, y, mx, my))

        KeyCont.dir_fire[global.index] = dir
        KeyCont.dis_fire[global.index] = point_distance(0, 0, ldrx(1, dir), ldry(1, dir))

        KeyCont.hold_fire[global.index] = 1

        // note: press & release are swapped intentionally
        if device_mouse_check_button_pressed(index, mb_left)
			KeyCont.release_fire[global.index] = 1

        if device_mouse_check_button_released(index, mb_left)
			KeyCont.press_fire[global.index] = 1

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
    KeyCont.hold_fire[global.index] = device_mouse_check_button(i, mb_left)
    KeyCont.press_fire[global.index] = device_mouse_check_button_pressed(i, mb_left)
    KeyCont.release_fire[global.index] = device_mouse_check_button_released(i, mb_left)

    index = -1
}

with Player {
	if index != global.index
		continue
	
	if race == 5 && playerinstance.pref("plant") && KeyCont.release_fire[index] {
		var _x = x + ldrx(426 / 2, gunangle),
			_y = y + ldry(240 / 2, gunangle)
		
		var e = collision_line(x, y, _x, _y, enemy, true, false)
		
		with instance_create(_x, _y, Dust)
			depth = -1000
		
		print("UHh", e)
		
		if instance_exists(e) && !collision_line(x, y, e.x, e.y, Wall, true, false) {
			var g = gunangle,
				need = true
			
			with e {
				if place_meeting(x, y, Tangle)
					need = false
			}
			
			if instance_exists_var(TangleSeed, "creator", id)
				need = false
			
			if need {
				gunangle = point_direction(x, y, e.x, e.y)
				
				KeyCont.press_spec[index] = true
				scrPowers()
				
				gunangle = g
			}
		}
	}
}