event_inherited()

if instance_exists(MenuOptions) or UberCont.opt_keyboard or UberCont.opt_gamepad exit

var i = get_nearest_touch(rad)

// reset movement
KeyCont.moving[global.index] = 0

if index == -1 index = i

if index != -1 {
    var mx = device_mouse_x_to_gui(index)
    var my = device_mouse_y_to_gui(index)

    var dir = point_direction(x, y, mx, my)
    var dis = point_distance(x, y, mx, my)

    KeyCont.dir_move[global.index] = dir
    KeyCont.moving[global.index] = min(1, dis / rad)

    if device_mouse_check_button_released(index, mb_left) index = -1
}