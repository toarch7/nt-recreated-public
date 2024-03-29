if lockstep_stop
	exit

var col = hover ? c_white : c_uigray,
	name = scrMenuButtonName()

y -= appear

if loc_exists(name) {
	var a = 0
	
	/*if sprite_index == sprPauseButtons {
		if image_index == 0 or image_index == 1 or image_index == 4 or image_index == 7 {
			a = 3
		}
		else if image_index == 2 or image_index == 3 or image_index == 5 or image_index == 6 {
			a = -3
		}
	}*/
	
	draw_set_halign(fa_center)
	
	draw_bigname(x + sign(a) * 8, y - 8, loc(name), col, 0.65, a)
	
	draw_set_halign(fa_left)
}
else {
	draw_sprite_ext(sprite_index, image_index, x,     y + 1, 1, 1, 0, c_black, 1)
	draw_sprite_ext(sprite_index, image_index, x + 1, y + 1, 1, 1, 0, c_black, 1)
	draw_sprite_ext(sprite_index, image_index, x,     y    , 1, 1, 0, col, 1)
}

y += appear

if image_index == 5 && !instance_exists(CoopController) && !save_get_value("etc", "saving_tip", 0) {
    draw_set_valign(fa_center)
    draw_set_halign(fa_center)

    draw_set_color(make_color_rgb(59, 62, 67))
    draw_text_shadow(view_xview + view_width / 2, view_yview + view_height - 16, loc("QUIT WITHOUT EXITING THROUGH MAIN MENU#TO SAVE AND CONTINUE LATER"))
    draw_set_color(c_white)

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
}