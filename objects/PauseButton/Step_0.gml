if lockstep_stop
	exit

if global.time < start
	exit

if global.time == start {
	appear = 2
}
else if appear
	appear --

if !wait {
	var press = mouse_ui_clicked()
	
	if gamepad_button_check(0, gp_face2) && image_index == 3
		event_user(0)
	
	if mouse_hover {
		if !is_gamepad() {
			if !hover {
				snd_play(sndHover)
				hover = 1
			}
		}
		
		if press
			event_user(0)
	}
	else if !is_gamepad() && hover
		hover = 0
}
else wait --
