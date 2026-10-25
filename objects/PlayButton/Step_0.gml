if lockstep_stop
	exit

if current_frame < start
	exit

if current_frame == start {
	snd_play(sndAppear, 1.2)
	
	visible = 1
	appear = 2
}
else if (appear) appear --

if (!wait && available) {
	var press = mouse_ui_clicked()
	
	if (mouse_ui_hovered(id, false)) {
		if (!is_directional_ui()) {
			if (!hover) {
				snd_play(sndHover)
				hover = 1
			}
		}
		
		if (press) event_user(0)
	}
	else if (!is_directional_ui() && hover) hover = false
}

if (wait) wait --

splat = lerp(splat, hover * 4, 0.4)
