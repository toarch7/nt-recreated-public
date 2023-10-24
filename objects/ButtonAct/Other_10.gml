event_inherited()

index = get_nearest_touch(rad)

if active {
    alpha = 1.1
    active = 0
}
else if alpha > 0 {
    alpha -= 0.1
}

if instance_exists(MenuOptions) or UberCont.opt_keyboard or UberCont.opt_gamepad exit

var mx = device_mouse_x(index)
var my = device_mouse_y(index)

KeyCont.press_pick[global.index] = /*(do_thing == 1) or */
(index != -1 && device_mouse_check_button_pressed(index, mb_left))

/*if do_thing {
	do_thing = 2
}
else do_thing = 0*/