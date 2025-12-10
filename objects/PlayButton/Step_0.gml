if lockstep_stop
	exit

if current_frame < start
	exit

if current_frame == start {
	snd_play(sndAppear, 1.2)
	
	visible = 1
	appear = 2
}
else if appear
	appear --

if !wait && available {
	var press = mouse_ui_clicked()
	
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

if wait
	wait --

splat = lerp(splat, hover * 4, 0.4)
