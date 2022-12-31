function draw_stat_sprite(argument0, argument1, argument2) {
    draw_set_halign(fa_right)
    draw_text_nt((statx - 1), (staty + (line * 8)), ("@s" + argument0))
    draw_sprite(argument1, argument2, (statx + 8), ((staty + (line * 8)) - 4))
    line = (line + 1)



}