function draw_text_shadow(x, y, text) {
    var _color = draw_get_color()
    text = string_hash_to_newline(text)

    draw_set_color(c_black)
    draw_text(x + 1, y + 1, text)
    draw_text(x + 1, y, text)
    draw_text(x, y + 1, text)

    draw_set_color(_color)
    draw_text(x, y, text)
}