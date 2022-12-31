function draw_text_shadow(x, y, text, xscale, yscale = xscale, angle = 0) {
    var _color = draw_get_color(),
		_text = string_hash_to_newline(text)
	
    draw_set_color(c_black)
    draw_text_transformed(x + xscale, y + yscale, _text, xscale, yscale, angle)
    draw_text_transformed(x + xscale, y         , _text, xscale, yscale, angle)
    draw_text_transformed(x         , y + yscale, _text, xscale, yscale, angle)
	
    draw_set_color(_color)
    draw_text_transformed(x         , y         , _text, xscale, yscale, angle)
}