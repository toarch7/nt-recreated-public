/// @description Drawing

var _color = (can && selected) ? c_white : c_gray,
	_player_race = my_player.get_race(),
	_this_race = _player_race == race,
	_pointed = false

can = scr_race_is_unlocked(race) || UberCont.weekly_run

draw_sprite_ext(can ? sprite_index : sprCharSelectLocked, race, x, y, 1, 1, 0, _color, 1)

if is_keyboard() {
	var _pointed = point_in_rectangle(
			device_mouse_x_to_gui(0),
			device_mouse_y_to_gui(0),
			bbox_left - view_xview,
			bbox_top - view_yview,
			bbox_right - view_xview,
			bbox_bottom - view_yview)
	
	if (selected != (_pointed || _this_race)) {
		if (_pointed || _this_race) {
			with (CharSelect) {
				selected = (id == other.id || _player_race == race)
			}
		}
		else selected = false
	}
}

tooltip = (!_this_race && ((is_gamepad() && selected) || (is_keyboard() && _pointed)))

if instance_exists(Menu) {
	depth = Menu.depth - 1
}