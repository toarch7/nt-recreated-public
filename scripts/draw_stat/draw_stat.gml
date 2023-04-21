function draw_stat(name, value) {
	name = loc(string_upper(name))
	
    draw_set_halign(fa_right)
    draw_set_color(9274237)
    draw_text_shadow(statx - 1, staty + line * 8, name)
    draw_set_color(c_white)
    draw_set_halign(fa_left)
    draw_text_shadow(statx + 1, staty + line * 8, value)

    line ++
}