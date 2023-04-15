globalvar BigNameSurfaces;
BigNameSurfaces = {}

#macro BIGNAME_YOFFSET 8

function draw_bigname(_x, _y, _text, col = draw_get_color(), _shiftY = 0, offset = 1, scale = 0.75) {
    var s = BigNameSurfaces[$ _text],
		h = draw_get_halign(),
		v = draw_get_valign()

    if offset {
        _x -= sprite_get_xoffset(sprite_index)
        _y -= sprite_get_yoffset(sprite_index) + 12
    }

    if !is_undefined(s) && surface_exists(s) {
		
		if h == fa_center {
			_x -= surface_get_width(s) / 2
		}
		
		if v == fa_center {
			_y -= surface_get_height(s) / 2
		}
		
		_y += BIGNAME_YOFFSET
		
		draw_rectangle(_x, _y, _x + surface_get_width(s), _y + surface_get_height(s), 1)
		
        draw_surface(s, _x, _y)

        return undefined
    }
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)

    draw_set_font(fntBig)

    s = surface_create(ceil(string_width(_text) * scale), ceil(string_height(_text) / 2 * scale))

    surface_set_target(s)

    draw_set_color(c_black)
    draw_text_transformed(1, -BIGNAME_YOFFSET + 1, _text, scale, scale, 0)
    draw_text_transformed(0, -BIGNAME_YOFFSET + 1, _text, scale, scale, 0)

    draw_set_color(col)
    draw_text_transformed(0, -BIGNAME_YOFFSET, _text, scale, scale, 0)

    surface_reset_target()

    BigNameSurfaces[$ _text] = s

    draw_surface(s, _x, _y)

    draw_set_font(UberCont.font)
	
	draw_set_halign(h)
	draw_set_valign(v)
}