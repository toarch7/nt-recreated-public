if lockstep_stop
	exit

var xx = 56, yy = 48

draw_set_valign(fa_top)

for(var i = 0; i < array_length(chiev_name); i ++) {
	if view_height - (yy - ypos) > 0 {
		draw_sprite_stretched_ext(sprAchievementSplash, 0, 8, yy - ypos - 10, max(0, anim[i]), 38, c_black, 0.75)
		
		anim[i] = lerp(anim[i], view_width - 32, 0.4)
		
		if chiev_hide[i] && !chiev_have[i] {
			draw_sprite_ext(sprButtonAchievements, 0, xx - 28, yy + 10 - ypos, 1, 1, 0, c_black, 1)
			draw_text_nt(xx, yy - ypos + 5, "@d" + loc("HIDDEN"))
		}
		else {
			draw_sprite_ext(sprButtonAchievements, 0, xx - 28, yy + 11 - ypos, 1, 1, 0, c_black, 1)
			draw_sprite_ext(sprButtonAchievements, 0, xx - 27, yy + 11 - ypos, 1, 1, 0, c_black, 1)
			draw_sprite_ext(sprButtonAchievements, 0, xx - 27, yy + 10 - ypos, 1, 1, 0, c_black, 1)
			
			var c = "@s"
			
			if chiev_have[i] {
				draw_sprite(sprButtonAchievements, 0, xx - 28, yy + 10 - ypos)
				c = "@y"
			}
			else {
				draw_sprite_ext(sprButtonAchievements, 0, xx - 28, yy + 10 - ypos, 1, 1, 0, c_dkgray, 1)
			}
			
			draw_text_nt(xx, yy - ypos, c + loc(chiev_name[i]))
			
			var scale = min(1, 1 - (string_width(string_hash_to_newline(chiev_text[i])) / (view_width - 32) - 0.5))
			
			draw_text_nt(xx, yy - ypos + 10, "@s" + loc(chiev_text[i]), scale)
		}
	}
	
	yy += 40
	
	if yy - ypos > view_height {
		break
	}
}

draw_set_color(c_black)

draw_rectangle(0, view_height - 36, view_width, view_height + 2, 0)
draw_rectangle(0, -2, view_width, 36, 0)

draw_set_color(c_white)

draw_set_halign(fa_center)

draw_text_shadow(view_width / 2, 12, loc("ACHIEVEMENTS"))
draw_text_shadow(view_width / 2, 24, string(unlocks) + "/" + string(array_length(chiev_name)))

draw_set_halign(fa_left)

draw_set_valign(fa_top)

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
			
			if ypos != _ypos
				sound_play_pitchvol(sndHover, 1.1 + random(0.1), 0.3)
			
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