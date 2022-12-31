function get_nearest_touch(rad) {
    if object_index == JoystickMove or object_index == JoystickAttack rad *= 1.75

    rad *= UberCont.opt_controls_scale * 1.5 + 0.5

    for (var i = 0; i <= 4; i++) {
        if distance_to_point(device_mouse_x_to_gui(i), device_mouse_y_to_gui(i)) <= rad {
            if device_mouse_check_button(i, mb_left) {
                var a = noone

                with MobileUI {
                    if index == i && id != other.id a = id
                    break
                }

                var n = instance_nearest(device_mouse_x_to_gui(i), device_mouse_y_to_gui(i), MobileUI)

                if n != id && n != a
                continue

                if !a
                return i
            }
        }
    }

    return -1
}