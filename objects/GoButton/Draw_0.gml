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

draw_sprite_ext(sprite_index, image_index, x, y + addy - _pointed,
	image_xscale, image_yscale, image_angle, (_pointed ? c_white : c_uigray), image_alpha)

if instance_exists(Menu) {
	depth = Menu.depth - 1
}

if (visible && addy > 0) {
	addy = approach(addy, 0, timescale)
}