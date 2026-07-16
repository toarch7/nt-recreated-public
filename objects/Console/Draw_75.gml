draw_set_halign(fa_left)
draw_set_valign(fa_top)

width = display_get_gui_width()
height = display_get_gui_height()

var _base_y = round(display_get_gui_height() * 1.25),
	_input_cursor_width = string_width("> "),
	_is_readonly = false

if (!UberCont.opt_console) {
	_base_y = display_get_gui_height() * 1.9
	_is_readonly = true
}
else if (os_type == os_android) {
	_base_y = round(_base_y * 0.65)
}

display_set_gui_size(width * 2, height * 2)

var _dx, _xstart = 14;

if ((flags & 4) == 4) {
	var _dx = 48, _debug_string = "", _bottom = (height * 2 - 96);
	
	with (all) {
		if (object_index == Spiral || object_index == SpiralDebris || object_index == SpiralStar) {
			continue
		}
		
		_debug_string += object_get_name(object_index) + "\n"
		
		if (string_height(_debug_string) > _bottom) {
			draw_text_nt(_dx, 48, _debug_string)
			_dx += string_width(_debug_string) + 14
			_debug_string = ""
		}
	}
	
	if (_debug_string != "") {
		draw_text_nt(_dx, 48, _debug_string)
		_dx += string_width(_debug_string) + 14
	}
}

if ((flags & 8) == 8) {
	var _debug_string = ""
	
	draw_set_color(c_white)
	
	if (global.cheats) {
		_debug_string += "cheats active"
	}
	
	_debug_string += "\n camera: " + string(view_xview) + ", " + string(view_yview)
	_debug_string += "\n color: " + string(global.player_color)
	_debug_string += "\n      : " + string(UberCont.opt_color)
	
	draw_text_nt(_dx, 48, _debug_string)
}

if (global.console_active) {
	var _scale = 0.67
	
	draw_set_font(fntConsole)
	draw_set_color(c_black)
	draw_set_alpha(0.6)

	draw_rectangle(0, 0, display_get_gui_width(), _base_y, 0)
	draw_set_alpha(1)

	var _x = _xstart,
		_y = _base_y - string_height("Aa") - 2,
		_log_size = array_length(global.log_output)
	
	for (var i = _log_size - 1; i >= 0; i--) {
		var _debug_string = string(global.log_output[i]),
			_color = global.log_color[i]

		if (_color == (c_white - 1)) {
			__draw_text(_x - _input_cursor_width + 4, _y, "> " + _debug_string, _color, 1, _scale)
		}
		else {
			__draw_text(_x, _y, _debug_string, _color, 1, _scale)
		}
		
		_y -= string_height(_debug_string) * _scale
	}

	if (!_is_readonly) {
		draw_set_color(c_black)
		draw_set_alpha(0.3)
		draw_rectangle(0, _base_y, display_get_gui_width(), _base_y + string_height("Aa" + keyboard_string), 0)

		__draw_text(14 - string_width("> "), _base_y, "> " + keyboard_string + cursor, c_white, 1)
	}

	alert = ""
}
else if (alert != "") {
	draw_set_halign(fa_center)
	__draw_text(display_get_gui_width() / 2, 48, alert, c_red)
}

display_set_gui_size(width, height)

draw_reset_font()

if (os_type == os_android && (!_is_readonly || global.console_active)) {
	draw_set_color(c_black)
	draw_set_alpha(0.5)

	draw_rectangle(view_width - 36, 18 + 12, view_width - 18, 36 + 12, 0)
	
	draw_set_color(c_white)
	draw_set_alpha(1)

	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	
	draw_text_nt(view_width - 26, 28 + 12, "~")
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)

	if (mouse_check_button_pressed(mb_left)) {
		var _mx = device_mouse_x_to_gui(0),
			_my = device_mouse_y_to_gui(0)
		
		if (point_in_rectangle(_mx, _my, view_width - 36, 18 + 12, view_width - 18, 36 + 12)) {
			open = true
		}
	}
}

draw_set_color(c_white)
draw_set_alpha(1)