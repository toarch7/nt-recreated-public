if lockstep_stop
	exit

var _race = num,
	_unlocked = scr_race_is_unlocked(_race),
	_pop_frame = start + floor(pos * 0.5),
	_color = selected ? c_white : c_gray

if current_frame >= _pop_frame {
	if (current_frame == _pop_frame) anim = 1
	sprite_index = _unlocked ? sprCharSelect : sprCharSelectLocked
	draw_sprite_ext(sprite_index, _race, x, y + anim, 1, 1, 0, _color, 1)
}

if (is_keyboard()) {
	var _hover = (mouse_ui_hovered(id, false) && !selected)
	
	if (tooltip_pop != 0 || _hover) {
		scrDrawTooltip(bbox_center_x, y + tooltip_pop - 1,
			loc(_race ? scrRaceGetName(_race) : "TOTAL"))
	}
	
	tooltip_pop = approach(tooltip_pop, _hover ? 1 : 0, timescale)
}
else tooltip_pop = 0

if (anim > 0) anim -= timescale