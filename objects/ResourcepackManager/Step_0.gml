if lockstep_stop
	exit

/// @description Scroll

x = xstart
y = ystart

ypos += vspeed

if ypos < 0
	ypos = 0

if ypos > max_height
	ypos = max_height

if mouse_wheel_up() vspeed = -24
if mouse_wheel_down() vspeed = 24

if mouse_check_button_pressed(mb_left) {
	speed = 0
	
	if device_mouse_x_to_gui(0) < view_width - 32 {
		dragging = -1
	}
}

if !mouse_check_button(mb_left) && dragging == -1
	dragging = false

