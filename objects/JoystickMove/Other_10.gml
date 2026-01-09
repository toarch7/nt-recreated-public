event_inherited()

if instance_exists(MenuOptions) or UberCont.opt_keyboard or UberCont.opt_gamepad
	exit

var i = get_nearest_touch(rad)

// reset movement
KeyCont.moving[global.index] = 0

if (index == -1) index = i

if (index != -1) {
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
	
	if (abs(angle_difference(dir, KeyCont.dir_move[global.index])) < 10) {
		if (current_move_direction_time < 30) {
			current_move_direction_time ++
		}
	}
	else if (current_move_direction_time > 0) {
		current_move_direction_time -= 3
		if (!current_move_direction_time) {
			current_move_direction_time = 0
		}
	}
	
	var _same_move = max(0, current_move_direction_time - 10) / 20
	
    KeyCont.dir_move[global.index] = dir
    KeyCont.moving[global.index] = min(1, _same_move + (dis / rad))
	
	KeyCont.hold_east[global.index] = (mh == 1)
	KeyCont.hold_west[global.index] = (mh == -1)
	KeyCont.hold_sout[global.index] = (mv == 1)
	KeyCont.hold_nort[global.index] = (mv == -1)

    if device_mouse_check_button_released(index, mb_left) {
		index = -1
	}
}
else if (current_move_direction_time > 0) {
	current_move_direction_time -= 3
	if (!current_move_direction_time) {
		current_move_direction_time = 0
	}
}

if UberCont.opt_hiddensticks {
	image_alpha = lerp(image_alpha, (index != -1) * 0.2, 0.4)
}