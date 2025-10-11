if lockstep_stop
	exit

if current_frame < start
	exit

if wait {
	wait --
	exit
}

// Back
if gamepad_button_check(0, gp_face2) && image_index == 3 {
	event_user(0)
}

if mouse_hover {
	if !is_gamepad() {
		if !hover {
			snd_play(sndHover)
			hover = true
		}
	}
	
	if mouse_ui_clicked() {
		event_user(0)
	}
}
else if !is_gamepad() && hover {
	hover = false
}
