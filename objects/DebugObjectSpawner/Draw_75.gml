draw_align(fa_center, fa_bottom)

var _font = fntSmall,
	_object = self.__get_object(keyboard_string),
	_valid = object_exists(_object),
	_x = x - view_xview,
	_y = y - view_yview

draw_set_font(_font)

draw_set_color(_valid ? c_white : c_gray)

if string_length(keyboard_string) {
	if (_valid) {
		var _sprite = object_get_sprite(_object),
			_name = object_get_name(_object),
			_dx = _x - string_width(_name) div 2,
			_dy = _y
		
		draw_text_nt(_x, _y - 12, "LMB to spawn")
		
		if sprite_exists(_sprite) {
			var _ox = sprite_get_xoffset(_sprite),
				_oy = sprite_get_yoffset(_sprite),
				
				_w = sprite_get_width(_sprite),
				_h = sprite_get_height(_sprite),
				
				_dw = 14,
				_dh = 14
			
			// placement preview
			var _wave = (sin(current_frame * 0.5) + 1) * 0.5
			
			draw_sprite_ext(_sprite, 0, _x, _y, 1, 1, 0,
				merge_color(c_dkgray, c_white, _wave), 0.1 + _wave * 0.2)
			
			// mini icon
			sprite_set_offset(_sprite, _w div 2, _h div 2)
			draw_sprite_ext(_sprite, 0, _dx - (_dw * 0.5) - 2, _dy, _dw / _w, _dh / _h, 0, c_white, 1)
			sprite_set_offset(_sprite, _ox, _oy)
		}
		else draw_text_nt(_dx - 6, _dy, "??")
	}
}
else {
	draw_set_font(fntSmaller)
	draw_set_color(c_silver)
	draw_text_nt(_x, _y - 10, "Type to spawn")
	draw_set_font(_font)
}

var _dx = _x + (shake != 0 ? orandom(shake) : 0), _dy = _y
shake = approach(shake, 0, 0.5)

splatindex = approach(splatindex, 2, 0.5)

//
draw_set_color(_valid ? c_white : c_gray)
draw_text_nt(_dx, _dy, keyboard_string + cursor)

//
if (keyboard_check(vk_anykey)) last_input = current_time

draw_set_color(c_white)
draw_reset_font()
draw_align()

//
var _blink = ((current_time - last_input) % 500) <= 250

if (_blink) {
	if (cursor == "|") cursor = ""
}
else {
	if (cursor == "") cursor = "|"
}