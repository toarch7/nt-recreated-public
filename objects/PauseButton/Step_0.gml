if lockstep_stop
	exit

if current_frame < start
	exit

if wait {
	wait --
	exit
}

// Back
if (input_gamepad_check_pressed(0, gp_face2) && image_index == 3) {
	event_user(0)
}

if (mouse_ui_hovered(id, false)) {
	if (!is_directional_ui()) {
		if (!hover) {
			snd_play(sndHover)
			hover = true
		}
	}
	
	if (mouse_ui_clicked()) event_user(0)
}
else if (!is_directional_ui() && hover) {
	hover = false
}
