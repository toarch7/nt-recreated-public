if lockstep_stop
	exit

var xx = 56, yy = 48

draw_set_valign(fa_top)

for(var i = 0; i <= achievementmax; i ++) {
	if view_height - (yy - ypos) > 0 {
		draw_sprite_stretched_ext(sprAchievementSplash, 0, 8, yy - ypos - 10, max(0, anim[i]), 38, c_black, 0.75)
		
		anim[i] = lerp(anim[i], view_width - 32, 0.4)
		
		if chiev_hide[i] && !scrAchievementIsUnlocked(i) {
			draw_sprite_ext(sprButtonAchievements, 0, xx - 28, yy + 10 - ypos, 1, 1, 0, c_black, 1)
			/// @loc:token [R:MainMenu] AchievementHidden "HIDDEN"
			draw_text_nt(xx, yy - ypos + 5, "@d" + loc("R:MainMenu:AchievementHidden", "HIDDEN"))
		}
		else {
			draw_sprite_ext(sprButtonAchievements, 0, xx - 28, yy + 11 - ypos, 1, 1, 0, c_black, 1)
			draw_sprite_ext(sprButtonAchievements, 0, xx - 27, yy + 11 - ypos, 1, 1, 0, c_black, 1)
			draw_sprite_ext(sprButtonAchievements, 0, xx - 27, yy + 10 - ypos, 1, 1, 0, c_black, 1)
			
			var c = "@s"
			
			if scrAchievementIsUnlocked(i) {
				draw_sprite(sprButtonAchievements, 0, xx - 28, yy + 10 - ypos)
				c = "@y"
			}
			else {
				draw_sprite_ext(sprButtonAchievements, 0, xx - 28, yy + 10 - ypos, 1, 1, 0, c_uidark, 1)
			}
			
			var _name = loc("Achievements", i, "name", chiev_name[i]),
				_text = loc("Achievements", i, "text", chiev_text[i])
			
			if (!variable_struct_exists(wrapped_strings, _text)) {
				var _wrapped = string_insert_wordwraps(_text, view_width - xx - 80)
				wrapped_strings[$ _text] = _wrapped
				_text = _wrapped
			}
			else {
				_text = wrapped_strings[$ _text]
			}
			
			var _name_height = font_get_string_height(_name),
				_scale = 1,//clamp(1 - (font_get_string_width(string_hash_to_newline(_text)) / (view_width - 32) - 0.5), 1, 0.8),
				_offset = floor(font_get_string_height(_text) * _scale * 0.5)
			
			draw_text_nt(xx, yy - ypos - _offset, c + _name)
			
			draw_set_color(c_silver)
			draw_text_nt(xx, yy - ypos - _offset + (1 - _scale) + _name_height, "@s" + _text, _scale)
			
			draw_set_color(c_white)
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


draw_set_halign(fa_center)

draw_set_color(c_white)
/// @loc:token [R:MainMenu] Achievements "ACHIEVEMENTS"
draw_text_nt(view_width / 2, 12, loc("R:MainMenu:Achievements", "ACHIEVEMENTS"))

draw_set_color(c_uisilver)
var _progress = unlocks / achievementmax
draw_text_nt(view_width / 2, 24, $"{unlocks}/{achievementmax} ({floor(_progress * 100)}%)")

draw_set_halign(fa_left)

draw_set_valign(fa_top)

draw_sprite_ext(sprOptionSlider, 0, view_width - 16, 36, 1.6, 1, 270, c_white, 1)

var _slider_size = 80,
	_slider_bottom = view_height - _slider_size

draw_sprite_ext(sprSliderEndHorizontal, 0, view_width - 20 + (dragging > 0), 40 + _slider_bottom * (ypos / max_height), 1, 1, 0, dragging ? c_uigray : c_white, 1)

if (wait > 0) wait --

if (dragging == -1 || wait) exit

if mouse_check_button(mb_left) {
	for(var _touch = 0; _touch < 4; _touch ++) {
		if (!device_mouse_check_button(_touch, mb_left)) continue
		
		var _mx = device_mouse_x_to_gui(_touch),
			_my = device_mouse_y_to_gui(_touch)
		
		if (_mx >= view_width - 32 && _mx <= view_width) || dragging {
			ypos = max_height * clamp((_my - LETTERBOX_SIZE) / _slider_bottom, 0, 1)
			
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