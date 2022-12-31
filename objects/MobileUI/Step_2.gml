if instance_exists(MenuOptions) && MenuOptions.editing_mode && !UberCont.opt_gamepad {
    var i = get_nearest_touch(rad)

    if index != -1 {
        x = device_mouse_x_to_gui(index)
        y = device_mouse_y_to_gui(index)

        save_set_val("controls", object_get_name(object_index) + "_x", x)
        save_set_val("controls", object_get_name(object_index) + "_y", y)

        if !device_mouse_check_button(index, mb_left) {
            index = -1
        }
    } else if i != -1 {
        var a = -1

        with MobileUI {
            if index == i a = 1
        }

        if a == -1 index = i
    }
}