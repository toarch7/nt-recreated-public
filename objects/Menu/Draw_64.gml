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