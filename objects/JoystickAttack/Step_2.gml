event_inherited()

var aimbot = save_get_val("controls", "aimbot", 0)

if aimbot {
    with Player
    if index == global.index {
        var _aim_target = instance_nearest(x, y, enemy)

        if instance_exists(NothingInactive) {
            _aim_target = instance_nearest(x, y, NothingInactive)

            if !_aim_target[$ "hitable"] {
                _aim_target = noone
            }
        } else if instance_exists(LastIntro) {
            _aim_target = instance_nearest(x, y, LastIntro)
        } else if distance_to_object(BigGenerator) <= 32 {
            _aim_target = instance_nearest(x, y, BigGenerator)
        }

        var d = -1

        if _aim_target && !collision_line(x, y, _aim_target.x, _aim_target.y, Wall, 1, 1) {
            d = point_direction(x, y, _aim_target.x, _aim_target.y)
        } else d = KeyCont.dir_move[index]

        if d != -1 {
            KeyCont.dir_fire[index] = angle_lerp(KeyCont.dir_fire[index], d, 0.75)
        }

        break
    }
}

if instance_exists(MenuOptions) or UberCont.opt_keyboard or UberCont.opt_gamepad exit

var i = get_nearest_touch(rad)

// reset movement
KeyCont.hold_fire[global.index] = 0
KeyCont.press_fire[global.index] = 0
KeyCont.release_fire[global.index] = 0

if index == -1 index = i

if !aimbot {
    if index != -1 {
        var mx = device_mouse_x_to_gui(index)
        var my = device_mouse_y_to_gui(index)

        var dir = point_direction(x, y, mx, my)
        dis = min(rad, point_distance(x, y, mx, my))

        KeyCont.dir_fire[global.index] = dir

        KeyCont.hold_fire[global.index] = 1

        // note: press & release are swapped intentionally
        if device_mouse_check_button_pressed(index, mb_left) KeyCont.release_fire[global.index] = 1

        if device_mouse_check_button_released(index, mb_left) KeyCont.press_fire[global.index] = 1

        if !device_mouse_check_button(index, mb_left) or(distance_to_point(mx, my) > rad * 3) {
            index = -1
        }

        vdis = dis * 2
        hold = 30
    } else {
        dis = 0

        if !hold {
            if vdis > 0 {
                vdis--
            }
        } else hold--
    }
} else {
    KeyCont.hold_fire[global.index] = device_mouse_check_button(i, mb_left)
    KeyCont.press_fire[global.index] = device_mouse_check_button_pressed(i, mb_left)
    KeyCont.release_fire[global.index] = device_mouse_check_button_released(i, mb_left)

    index = -1
}