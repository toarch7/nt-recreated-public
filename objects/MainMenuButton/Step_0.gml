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

var press = mouse_ui_clicked()

if mouse_ui_hovered(id, false) {
	if (!is_directional_ui()) {
		if (!hover && available) {
			snd_play(sndHover)
			hover = true
		}
	}
	
	if (press) event_user(0)
}
else if (!is_directional_ui() && hover) {
	hover = false
}

splat = approach(splat, hover * 3, timescale * 0.8)
