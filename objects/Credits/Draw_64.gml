if !visible && !instance_exists(Logo) exit

try {
    if show < array_length(credittext) {
        draw_set_color(c_white)
        draw_set_halign(fa_center)
        draw_set_valign(fa_center)
        draw_text_nt(view_width / 2, view_height / 2, string(credittext[show]))
        draw_set_halign(fa_left)
        draw_set_valign(fa_top)
    }
}
catch (e) {
    show_debug_message(e.message)
}