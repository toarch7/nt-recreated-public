if pause pause--
if hold hold--

if instance_exists(MenuOptions) or pause or UberCont.opt_keyboard exit

index = get_nearest_touch(max_rad)

if !instance_exists(Player) exit

var mx = device_mouse_x(index)
var my = device_mouse_y(index)

var anyone_else = 0

with MobileUI {
    if id != other.id && point_in_circle(mx, my, x, y, rad) {
        anyone_else = 1
    }
}

var collision = !anyone_else && point_in_circle(mx, my, x, y, max_rad)

if instance_exists(Player) && !hold {
    with Player {
	    if is_me {
	        KeyCont.dir_fire[index] = direction
			KeyCont.dis_fire[index] = 0.67
	    }
	}
}

if !anyone_else && !pause {
    with Player
    if index == global.index {
        var aim_target = instance_nearest(x, y, enemy)

        if !instance_exists(aim_target) {
            break
        }

        if instance_exists(NothingInactive) {
            aim_target = instance_nearest(x, y, NothingInactive)

            if !aim_target.hitable {
                aim_target = noone
            }
        }
		else if instance_exists(LastIntro) {
            aim_target = instance_nearest(x, y, LastIntro)
        }
		else if distance_to_object(BigGenerator) <= 48 {
            aim_target = instance_nearest(x, y, BigGenerator)
        }

        if aim_target && !collision_line(x, y, aim_target.x, aim_target.y, Wall, 1, 1) {
			var dir = point_direction(x, y, aim_target.x, aim_target.y)
			
            KeyCont.dir_fire[index] = dir
			
			KeyCont.dis_fire[index] = point_distance(0, 0, ldrx(1, dir), ldry(1, dir))
        }
    }

    KeyCont.hold_fire[global.index] = 0
    KeyCont.press_fire[global.index] = 0
    KeyCont.release_fire[global.index] = 0

    if collision {
        KeyCont.hold_fire[global.index] = device_mouse_check_button(index, mb_left)
        KeyCont.press_fire[global.index] = device_mouse_check_button_pressed(index, mb_left)
        KeyCont.release_fire[global.index] = device_mouse_check_button_released(index, mb_left)

        if KeyCont.hold_fire[global.index]
			hold = 5
    }
}