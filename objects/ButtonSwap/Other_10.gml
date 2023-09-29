event_inherited()


if instance_exists(MenuOptions) or UberCont.opt_keyboard or UberCont.opt_gamepad exit

index = get_nearest_touch(rad)

var mx = device_mouse_x(index)
var my = device_mouse_y(index)

if rot > 0 rot -= 10

KeyCont.hold_swap[global.index] = (do_thing == 2) or (index != -1 && device_mouse_check_button(index, mb_left))
KeyCont.press_swap[global.index] = (do_thing == 1) or (index != -1 && device_mouse_check_button_pressed(index, mb_left))
KeyCont.release_swap[global.index] = (do_thing == -1) or (index != -1 && device_mouse_check_button_released(index, mb_left))

if do_thing {
    do_thing = 2
}
else do_thing = 0