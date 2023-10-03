if lockstep_stop
	exit

if mouse_check_button_pressed(mb_left) {
    speed = 0
	
	if device_mouse_x_to_gui(0) < view_width - 32
		dragging = -1
}

if !mouse_check_button(mb_left) && dragging == -1
	dragging = false


if is_gamepad() {
	var v = (gamepad_button_check(0, gp_padd) - gamepad_button_check(0, gp_padu)) * 4
	
	if v == 0
		v = gamepad_axis_value(0, gp_axislv)
	
	vspeed = v * 8
}

if mouse_wheel_up() {
	vspeed -= 5
	ypos -= 6
}

if mouse_wheel_down() {
	vspeed += 5
	ypos += 6
}

if vspeed < -20
	vspeed = -20
if vspeed > 20
	vspeed = 20

ypos += lengthdir_y(speed, direction)
ypos = clamp(ypos, 0, max_height)

if (ypos <= 0 or ypos >= max_height) && speed > 0
    speed = 0

x = 0
y = 0

camera_set_pos(0, 0)
