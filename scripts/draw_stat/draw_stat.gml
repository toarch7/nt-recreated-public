function draw_stat(argument0, argument1) {
    draw_set_halign(fa_right)
    draw_set_color(9274237)
    draw_text_shadow(statx - 1, staty + line * 8, string_upper(argument0))
    draw_set_color(c_white)
    draw_set_halign(fa_left)
    draw_text_shadow(statx + 1, staty + line * 8, argument1)

    line++
}