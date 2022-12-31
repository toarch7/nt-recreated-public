if alarm[0] {
    draw_set_alpha(1 - alarm[0] / 265)
    draw_set_color(c_black)
    draw_rectangle(0, 0, view_width, view_width, 0)
    draw_set_color(c_white)
    draw_set_alpha(1)
}