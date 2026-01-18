if lockstep_stop
	exit

var _race = num,
	_unlocked = (!_race || UberCont.ctot_time[_race] != 0),
	_pop_frame = start + floor(pos * 0.5),
	_hover = (mouse_ui_hovered(id, false) && !selected),
	_color = selected ? c_white : c_gray

if (_hover && _unlocked && !selected) _color = c_ltgray

if current_frame >= _pop_frame {
	if (current_frame == _pop_frame) {
		anim = 1
	}
	
	draw_sprite_ext(_unlocked ? sprite_index : sprCharSelectLocked,
		_race, x, y - (selected || (_unlocked && _hover)) + anim, 1, 1, 0, _color, 1)
}

if (is_keyboard()) {
	if (_unlocked && (tooltip_pop != 0 || _hover)) {
		var _str;
		
		if (_race != Race.Random) {
			_str = loc("Races", _race, "Name", scrRaceGetName(_race))
		}
		else _str = loc("Stats:Total", "Total")
		
		scrDrawTooltip(bbox_center_x, y - 1, _str, tooltip_pop)
	}
	
	tooltip_pop = approach(tooltip_pop, _hover ? 1 : 0, timescale)
}
else tooltip_pop = 0

if (anim > 0) anim -= timescale