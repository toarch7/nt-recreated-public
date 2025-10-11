function draw_text_shadow(_x, _y, _text, _xscale = 1, _yscale = _xscale, _angle = 0) {
    var _color = draw_get_color()
    _text = string_hash_to_newline(string(_text))

    draw_set_color(c_black)
    draw_text_transformed(_x + _xscale, _y + _yscale, _text, _xscale, _yscale, _angle)
    draw_text_transformed(_x + _xscale, _y + 0, _text, _xscale, _yscale, _angle)
    draw_text_transformed(_x + 0, _y + _yscale, _text, _xscale, _yscale, _angle)

    draw_set_color(_color)
    draw_text_transformed(_x, _y, _text, _xscale, _yscale, _angle)
}

function draw_text_ext_shadow(_x, _y, _text, _sep, _width, _xscale = 1, _yscale = _xscale, _angle = 0) {
    var _color = draw_get_color()
    _text = string_hash_to_newline(string(_text))

    draw_set_color(c_black)
    draw_text_ext_transformed(_x + _xscale, _y + _yscale, _text, _sep, _width, _xscale, _yscale, _angle)
    draw_text_ext_transformed(_x + _xscale, _y + 0, _text, _sep, _width, _xscale, _yscale, _angle)
    draw_text_ext_transformed(_x + 0, _y + _yscale, _text, _sep, _width, _xscale, _yscale, _angle)

    draw_set_color(_color)
    draw_text_ext_transformed(_x, _y, _text, _sep, _width, _xscale, _yscale, _angle)
}