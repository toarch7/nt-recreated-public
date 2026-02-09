/// @description Bars & local mode switch

scrDrawLetterbox(3, true)

draw_set_font(global.language_font_bigname_default)

var _mx = device_mouse_x_to_gui(0),
	_my = device_mouse_y_to_gui(0),
	_text_scale = 0.65,
	
	_string = loc("R:MainMenu:RunHistory", "RUN HISTORY"),
	_size = font_get_string_width(string_upper(_string)) * _text_scale + 18,
	
	_l = (gui_w div 2) - (_size div 2),
	_r = (gui_w div 2) + (_size div 2),
	
	_pointed = point_in_rectangle(_mx, _my, _l, gui_h - LETTERBOX_SIZE, _r, gui_h)

if _pointed {
	if !history_pointed {
		history_pointed = true
		snd_play(sndHover)
	}
	
	if mouse_ui_clicked() {
		snd_play(sndMenuScores)
		
		if !instance_exists(DailyList) {
			with instance_create(0, 0, DailyList)
				depth = other.depth - 1
		}
	}
}
else if history_pointed {
	history_pointed = false
}

var _drawy = gui_h - LETTERBOX_SIZE div 2 - _pointed,
	_color = _pointed ? c_white : c_uigray

draw_align(fa_center, fa_middle)

draw_text_bigname(gui_w div 2, _drawy - _pointed + 4, _string, _color, 1, _text_scale)

draw_align()

draw_sprite_ext(sprDailyArrow, 0, min(_l, 20)         - _pointed, _drawy, 1, 1, 0, _color, 1)
draw_sprite_ext(sprDailyArrow, 1, max(_r, gui_w - 20) + _pointed, _drawy, 1, 1, 0, _color, 1)

draw_reset_font()