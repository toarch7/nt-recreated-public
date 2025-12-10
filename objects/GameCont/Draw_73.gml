/// @description Debug render

if (global.__debug_hitboxes) {
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	
	var _objects = [ hitme, projectile ]
	
	array_foreach(_objects, function(_object) {
		with (_object) {
			if (sprite_exists(mask_index)) {
				draw_sprite_ext(mask_index, image_index, x, y,
					image_xscale, image_yscale, image_angle, image_blend, image_alpha * 0.5)
			}
			else draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, false)
		}
	})
	
	draw_set_color(c_white)
	draw_set_alpha(1)
}

if (global.__debug_health) {
	draw_set_font(fntSmaller)
	draw_align(fa_center, fa_middle)
	
	with (hitme) {
		if (object_index == Player && (is_me || index == global.index)) continue
		
		var _string = $"{hp}/{max_hp}",
			_w = (string_width(_string) div 2) + 1,
			_h = (string_height(_string) div 2),
			_x = x, _y = bbox_top - 10
		
		draw_set_alpha(0.75)
		draw_set_color(c_black)
		draw_rectangle(_x - _w, _y - _h, _x + _w, _y + _h, false)
		
		draw_set_alpha(1)
		draw_set_color(c_red)
		draw_text(_x + 1, _y - 3, _string)
	}
	
	draw_reset_font()
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_align()
}