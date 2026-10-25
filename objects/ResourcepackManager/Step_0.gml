if lockstep_stop
	exit

/// @description Scroll

x = xstart
y = ystart

ypos += vspeed

if !show_details {
	if mouse_wheel_up() {
		vspeed -= 5
		ypos -= 6
	}
	
	if mouse_wheel_down() {
		vspeed += 5
		ypos += 6
	}
	
	vspeed = clamp(vspeed, -20, 20)
	
	if (is_gamepad()) {
		var v = (input_gamepad_check(0, gp_padd) - input_gamepad_check(0, gp_padu)) * 4
		
		if (v == 0) v = gamepad_axis_value(0, gp_axislv)
		
		if (v != 0) vspeed = v * 8
	}
}

ypos = clamp(ypos, 0, max_height)

if (speed > 0) wait = 5

if (mouse_check_button_pressed(mb_left)) {
	if (!scroll) speed = 0
	
	mx_last = device_mouse_x_to_gui(0)
	my_last = device_mouse_y_to_gui(0)
	
	if (device_mouse_x_to_gui(0) < view_width - 32) {
		dragging = -1
	}
}

if (scroll) scroll --

if (!mouse_check_button(mb_left) && dragging == -1) {
	dragging = false
}