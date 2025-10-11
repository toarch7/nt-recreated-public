if lockstep_stop
	exit

var _color = hover ? c_white : c_uigray,
	_button_name = scrMenuButtonName(),
	_dx = x, _dy = y + appear

if appear != 2 {
	if loc_exists(_button_name) {
		// currently unused
		var _angle = 0
		
		draw_set_halign(fa_center)
		
		draw_text_bigname(
			_dx + sign(_angle) * 8,
			_dy - 8,
			loc(_button_name),
			_color, _angle, 0.65)
		
		draw_set_halign(fa_left)
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
	
	draw_text_shadow(view_xview_center, view_yview + view_height + appear - 12,
		loc("CLOSING THE GAME WITHOUT QUITTING TO MAIN MENU#ALLOWS YOU TO SAVE AND CONTINUE LATER"))
	
	draw_set_color(c_white)
	draw_align()
}

if appear {
	appear --
}