if hint != "" {
    var txt = string_hash_to_newline(loc(string_upper(hint)))
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    var w = string_width(txt) / 2 + 8
    var h = string_height(txt) / 2 + 8

    draw_set_colour(c_text_background)
    draw_roundrect_ext(view_width / 2 + w, view_height - 30 + h, view_width / 2 - w, view_height - 30 - h, 4, 4, 0)
    draw_set_colour(c_black)
    draw_text(view_width / 2 + 1, view_height - 29, string_hash_to_newline(txt))
    draw_set_colour(c_white)
    draw_text(view_width / 2, view_height - 30, string_hash_to_newline(txt))

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
}