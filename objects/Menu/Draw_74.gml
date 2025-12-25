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
if UberCont.opt_practice {
	var py = 48
	
	draw_sprite(sprBossNameSplat, seed_splat, 0, 36)
	
	var mx = device_mouse_x_to_gui(0),
		my = device_mouse_y_to_gui(0)
	
	draw_set_color(seed_pointed ? c_white : c_uigray)
	
	draw_set_valign(fa_middle)
	
	draw_text_shadow(4, py + 4 + seed_pointed, "CUSTOM SEED")
	
	draw_set_color(global.custom_seed > 0 ? make_color_rgb(250, 171, 0) : c_uigray)
	draw_text_shadow(4, py + 14, string_upper(seed_text))
	
	draw_set_color(c_white)
	
	draw_set_valign(fa_top)
	
	if point_in_rectangle(mx, my, 0, py, 56, py + 20) {
		if mouse_ui_clicked() {
			seed_prompt = get_string_async("Change seed", seed_text != "random" ? seed_text : "")
		}
		
		if !seed_pointed {
			snd_play(sndHover)
		}
		
		seed_pointed = true
	}
	else seed_pointed = false
	
	if seed_splat < (sprite_get_number(sprBossNameSplat) - 1) {
		seed_splat ++
	}
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