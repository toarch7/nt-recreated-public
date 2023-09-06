if lockstep_stop
	exit

if mouse_check_button_pressed(mb_left) {
    click = 1
	
    mousex = mouse_x
    mousey = mouse_y
	
    speed = 0
}

if is_gamepad() {
	var v = (gamepad_button_check(0, gp_padd) - gamepad_button_check(0, gp_padu)) * 4
	
	if v == 0
		v = gamepad_axis_value(0, gp_axislv)
	
	vspeed = v * 8
}

if mouse_wheel_up() speed = 16
if mouse_wheel_down() speed = -16

var p = ypos div 40

if p != least {
	sound_play_pitchvol(sndHover, 1.1 + random(0.1), 0.3)
	
	least = p
	
	for(var i = 0; i < array_length(anim); i ++) {
		if i < p or i > (p + (view_height div 40)) {
			anim[i] = -120
		}
	}
}

ypos += lengthdir_y(speed, direction)
ypos = clamp(ypos, 0, max_height)

if (ypos <= 0 or ypos >= max_height) && speed > 0 {
    speed = 0
}

camera_set_pos(0, 0)
