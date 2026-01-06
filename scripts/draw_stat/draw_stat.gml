function draw_stat(name, value) {
	var _height = font_get_string_height("Aa")
	
    draw_set_halign(fa_right)
    draw_set_color(c_uigray)
	draw_text_nt(statx - 1, staty + line * _height, name)
    
	draw_set_color(c_white)
    draw_set_halign(fa_left)
    draw_text_nt(statx + 1, staty + line * _height, string(value))
	
    line ++
}