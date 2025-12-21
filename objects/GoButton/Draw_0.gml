var _pointed;

if is_keyboard() {
	_pointed = point_in_rectangle(
		mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)
	
	if (_pointed) {
		if (image_speed == 0) {
			image_speed = 0.4
		}
	}
	else {
		if (image_speed != 0) {
			image_speed = 0
			image_index = 0
		}
	}
	
	tooltip = _pointed
}
else _pointed = true

if sprite_index == sprGoButton && loc_exists("button_GO") {
	draw_set_halign(fa_right)
	draw_set_valign(fa_middle)
	
	draw_text_bigname(x + 10, y + addy - _pointed,
		loc("button_GO"), _pointed ? c_ultra : merge_color(c_ultra, c_black, 0.2))
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}
else {
	draw_sprite_ext(sprite_index, image_index, x, y + addy - _pointed,
		image_xscale, image_yscale, image_angle, (_pointed ? c_white : c_uigray), image_alpha)
}

if instance_exists(Menu) {
	depth = Menu.depth - 1
}

if (visible && addy > 0) {
	addy = approach(addy, 0, timescale)
}