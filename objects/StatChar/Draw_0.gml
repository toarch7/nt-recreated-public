if lockstep_stop
	exit

var _race = num,
	_unlocked = scr_race_is_unlocked(_race),
	_pop_frame = start + floor(pos * 0.5),
	_color = selected ? c_white : c_gray

if current_frame >= _pop_frame {
	if (current_frame == _pop_frame) {
		anim = 1
	}
	
	draw_sprite_ext(_unlocked ? sprite_index : sprCharSelectLocked, _race, x, y + anim, 1, 1, 0, _color, 1)
}

if (is_keyboard()) {
	var _hover = (mouse_ui_hovered(id, false) && !selected)
	
	if (_unlocked && (tooltip_pop != 0 || _hover)) {
		var _str;
		
		if (_race != Race.Random) {
			_str = loc("Races", _race, "Name", scrRaceGetName(_race))
		}
		else _str = loc("Stats:Total", "Total")
		
		scrDrawTooltip(bbox_center_x, y + tooltip_pop - 1, _str)
	}
	
	tooltip_pop = approach(tooltip_pop, _hover ? 1 : 0, timescale)
}
else tooltip_pop = 0

if (anim > 0) anim -= timescale