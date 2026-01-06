if instance_exists(DailyList) exit

if !instance_exists(Player) scrDrawGameModeIndication()

// render loadout
event_user(1)

with (CharSelect) if (tooltip) {
	var _str = can
		? loc("Races", race, "Name", scrRaceGetName(race))
		: loc("Races", race, "Unlock", scrRaceGetUnlockDescription(race))
	
	scrDrawTooltip(bbox_center_x - view_xview, bbox_top - view_yview, loc(_str), true)
}

with (GoButton) if (tooltip) {
	scrDrawTooltip(bbox_center_x - view_xview, bbox_top - view_yview, loc("MainMenu:Start", "START RUN"), true)
}

//
if string_length(unlock_hint) {
    var _message = string_hash_to_newline(loc(string_upper(unlock_hint)))
	
	draw_align(fa_center, fa_middle)
	
	var _width = string_width_pure(_message) * 0.5 + 8 + unlock_hint_pop,
		_height = string_height_pure(_message) * 0.5 + 8,
		_xpos = gui_w div 2, _ypos = gui_h - 30
	
    draw_set_colour(c_tooltip)
    draw_roundrect_ext(
		_xpos - _width, _ypos - _height,
		_xpos + _width, _ypos + _height, 4, 4, 0)
	
	draw_set_color(c_white)
	draw_text_nt(_xpos, _ypos + unlock_hint_pop, _message)
	
	draw_align()
	
	unlock_hint_pop = approach(unlock_hint_pop, 0, timescale)
}