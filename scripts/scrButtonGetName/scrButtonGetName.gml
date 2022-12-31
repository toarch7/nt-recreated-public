globalvar BigNameSurfaces;
BigNameSurfaces = {}

function draw_bigname(_x, _y, _text, col = draw_get_color(), _shiftY = 0, offset = 1, scale = 0.75) {
    var s = BigNameSurfaces[$ _text]

    if offset {
        _x -= sprite_get_xoffset(sprite_index)
        _y -= sprite_get_yoffset(sprite_index) + 12
    }

    if !is_undefined(s) && surface_exists(s) {
        draw_surface(s, _x, _y)

        return undefined
    }

    draw_set_font(fontBig)

    s = surface_create(ceil(string_width(_text) * scale), ceil(string_height(_text) * scale))

    surface_set_target(s)

    draw_set_color(c_black)
    draw_text_transformed(1, 1, _text, scale, scale, 0)
    draw_text_transformed(0, 1, _text, scale, scale, 0)

    draw_set_color(col)
    draw_text_transformed(0, 0, _text, scale, scale, 0)

    surface_reset_target()

    BigNameSurfaces[$ _text] = s

    draw_surface(s, _x, _y)

    draw_set_font(UberCont.font)
}