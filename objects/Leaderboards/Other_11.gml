/// @description Slider

draw_sprite_ext(sprOptionSlider, 0, view_width - 16, 48, 1.6, 1, 270, c_white, 1)

draw_sprite_ext(sprSliderEnd, 0, view_width - 18 + (dragging > 0), 48 + (view_height - 96) * (ypos / max_height), 1, 1, 90, dragging ? c_uigray : c_white, 1)

if wait
	wait --

if dragging == -1 or wait
	exit

if mouse_check_button(mb_left) {
	for(var i = 0; i < 4; i ++) {
		if !device_mouse_check_button(i, mb_left)
			continue
		
		var mx = device_mouse_x_to_gui(i),
			my = device_mouse_y_to_gui(i)
		
		if (mx >= view_width - 32 && mx <= view_width) or dragging {
			var pos = my - 48,
				pos_max = view_height - 96
			
			var _ypos = ypos
			
			ypos = max_height * clamp(pos / pos_max, 0, 1)
			
			if !dragging {
				snd_play(sndSlider)
				dragging = true
			}
			
			speed = 0
		}
		
		break
	}
}
else {
	if dragging
		snd_play(sndSliderLetGo)
	
	dragging = false
}