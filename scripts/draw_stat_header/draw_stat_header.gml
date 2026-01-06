function draw_stat_header(name) {
	var _height = font_get_string_height("Aa")
	
	if (!(is_string(name) && string_length(name))) {
		line += (_height > 8) ? 0.2 : 1
		exit
	}
	
	draw_set_halign(fa_center)
	draw_text_nt(statx, staty + (line * _height), name)
	
    line ++
}