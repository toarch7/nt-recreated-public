function scrStickRegions(touch) {
	var mx = device_mouse_x_to_gui(touch),
		my = device_mouse_y_to_gui(touch)
	
	if mx > gui_w / 2 {
		if object_index == JoystickMove
			exit
	}
	else if object_index == JoystickAttack
		exit
	
	if device_mouse_check_button_pressed(touch, mb_left) {
		with MobileUI {
			if get_nearest_touch(rad) == touch
				exit
		}
		
		if object_index == JoystickAttack {
			x = lerp(x, mx, 0.8)
			y = lerp(y, my, 0.8)
		}
		else {
			x = mx
			y = my
		}
	}
}