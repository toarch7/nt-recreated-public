if instance_exists(MenuOptions) && MenuOptions.editing_mode && !UberCont.opt_gamepad {
    var i = get_nearest_touch(rad)

    if index != -1 {
        x = device_mouse_x_to_gui(index)
        y = device_mouse_y_to_gui(index)
		
        save_set_value("controls", key + "_x", x)
        save_set_value("controls", key + "_y", y)
		
        if !device_mouse_check_button(index, mb_left) {
			event_user(10)
			index = -1
		}
    }
	else if i != -1 {
        var any = false

        with MobileUI {
            if index == i {
				any = true; break
			}
        }

        if !any
			index = i
    }
}