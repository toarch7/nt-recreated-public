col = light ? c_white : c_ltgray

y -= appear

draw_sprite_ext(sprite_index, image_index, x, y + 1 - hover, 1, 1, 0, c_black, 1)
draw_sprite_ext(sprite_index, image_index, x + 1, y + 1 - hover, 1, 1, 0, c_black, 1)
draw_sprite_ext(sprite_index, image_index, x, y - hover, 1, 1, 0, col, 1)

y += appear

if appear appear--

if image_index == 5 && !instance_exists(CoopController) && !save_get_val("etc", "saving_tip", 0) {
    draw_set_valign(fa_center)
    draw_set_halign(fa_center)

    draw_set_color(make_color_rgb(59, 62, 67))
    draw_text_shadow(view_xview + view_width / 2, view_yview + view_height - 16, loc("CLOSE THE GAME DIRECTLY#TO SAVE CURRENT RUN"))
    draw_set_color(c_white)

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
}