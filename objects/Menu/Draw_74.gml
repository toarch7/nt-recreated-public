if !instance_exists(Player)
	scrGamemodePlaybuttons()


// loadout
event_user(1)

if UberCont.opt_practice {
	var py = 48
	
	draw_sprite(sprBossNameSplat, seed_splat, 0, 36)
	
	var mx = device_mouse_x_to_gui(0),
		my = device_mouse_y_to_gui(0)
	
	draw_set_color(seed_pointed ? c_white : c_uigray)
	
	draw_set_valign(fa_center)
	
	draw_text_shadow(4, py + 4 + seed_pointed, "CUSTOM SEED")
	
	draw_set_color(global.custom_seed > 0 ? make_color_rgb(250, 171, 0) : c_uigray)
	draw_text_shadow(4, py + 14, string_upper(seed_text))
	
	draw_set_color(c_white)
	
	draw_set_valign(fa_top)
	
	if point_in_rectangle(mx, my, 0, py, 56, py + 20) {
		if mouse_ui_clicked() {
			seed_prompt = get_string_async("Change seed", seed_text != "random" ? seed_text : "")
		}
		
		if !seed_pointed
			snd_play(sndHover)
		
		seed_pointed = true
	}
	else seed_pointed = false
	
	if seed_splat < (sprite_get_number(sprBossNameSplat) - 1)
		seed_splat ++
}
// hint
if hint != "" {
    var txt = string_hash_to_newline(loc(string_upper(hint)))
	
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    
	var w = string_width(txt) / 2 + 8,
		h = string_height(txt) / 2 + 8
	
    draw_set_colour(c_tooltip)
    draw_roundrect_ext(view_width / 2 + w, view_height - 30 + h, view_width / 2 - w, view_height - 30 - h, 4, 4, 0)
    
	draw_set_color(c_white)
	draw_text_shadow(view_width / 2, view_height - 30, txt)

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
}