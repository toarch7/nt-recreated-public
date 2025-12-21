event_inherited()

if instance_exists(MenuOptions) or UberCont.opt_keyboard or UberCont.opt_gamepad
	exit

var i = get_nearest_touch(rad)

// reset movement
KeyCont.moving[global.index] = 0

if index == -1
	index = i

if index != -1 {
    var mx = device_mouse_x_to_gui(index),
		my = device_mouse_y_to_gui(index),
		
		dir = point_direction(x, y, mx, my),
		dis = point_distance(x, y, mx, my),
		
		mh = sign(ldrx(1, dir)),
		mv = sign(ldry(1, dir))
	
	if (dis == 0) {
		mh = 0
		mv = 0
	}
	
    KeyCont.dir_move[global.index] = dir
    KeyCont.moving[global.index] = min(1, dis / rad)
	
	KeyCont.key_east[global.index] = (mh == 1)
	KeyCont.key_west[global.index] = (mh == -1)
	KeyCont.key_sout[global.index] = (mv == 1)
	KeyCont.key_nort[global.index] = (mv == -1)

    if device_mouse_check_button_released(index, mb_left) {
		index = -1
	}
}

if UberCont.opt_hiddensticks {
	image_alpha = lerp(image_alpha, (index != -1) * 0.2, 0.4)
}