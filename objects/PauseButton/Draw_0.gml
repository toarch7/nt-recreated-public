if lockstep_stop
	exit

var _color = hover ? c_white : c_uigray,
	_button_name = scrMenuButtonName(),
	_dx = x, _dy = y + appear

if appear < 2 {
	if is_string(_button_name) {
		draw_set_font(fntBig)
		
		var	_scale = 0.65,
			_subimage = floor(image_index),
			_half_w = floor(string_width(_button_name) * _scale * 0.5),
			_halign = fa_center
		
		if ((_subimage >= 0 && _subimage <= 1) || _subimage == 4 || _subimage == 7) {
			_halign = fa_left
			var _overlap = min(0, _dx - _half_w - view_xview)
			if (_overlap > 0) _dx -= _overlap
			_dx -= _half_w
		}
		else if ((_subimage >= 2 && _subimage <= 3) || (_subimage >= 5 && _subimage <= 6)) {
			_halign = fa_right
			var _overlap = max(0, _dx + _half_w - (view_xview + view_width))
			if (_overlap > 0) _dx -= _overlap
			_dx += _half_w
		}
		
		draw_set_halign(_halign)
		draw_text_bigname(_dx, _dy - 8, _button_name, _color, 1, _scale)
		draw_set_halign(fa_left)
		
		draw_reset_font()
	}
	else {
		// backdrop
		draw_sprite_ext(sprite_index, image_index, _dx, _dy + 1, 1, 1, 0, c_black, 1)
		draw_sprite_ext(sprite_index, image_index, _dx + 1, _dy + 1, 1, 1, 0, c_black, 1)
		draw_sprite_ext(sprite_index, image_index, _dx + 1, _dy, 1, 1, 0, c_black, 1)
	
		//
		draw_sprite_ext(sprite_index, image_index, _dx, _dy, 1, 1, 0, _color, 1)
	}
}

// draw the `Quit` option hint
if image_index == 5 && !instance_exists(CoopController) && !save_get_value("etc", "saving_tip", 0) {
    draw_align(fa_center, fa_bottom)
	
	if appear >= 2 draw_set_color(c_gray)
	else if appear == 1 draw_set_color(c_dkgray)
    else draw_set_color(#3b3e43)
	
	draw_text_nt(view_xview_center, view_yview + view_height + appear - 12,
		loc("YOU CAN SAVE AND CONTINUE LATER#IF YOU EXIT WITHOUT QUITTING TO MAIN MENU"))
	
	draw_set_color(c_white)
	draw_align()
}

if appear {
	appear --
}