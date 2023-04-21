globalvar BigNameSurfaces;
BigNameSurfaces = {}

#macro BIGNAME_YOFFSET 8

function draw_bigname(_x, _y, _text, col = draw_get_color(), scale = 0.65, angle = 0) {
	_text = string_hash_to_newline(_text)
	
    var s = BigNameSurfaces[$ _text],
		h = draw_get_halign(),
		v = draw_get_valign(),
		a = draw_get_alpha()
	
    if !is_undefined(s) && surface_exists(s) {
		if h == fa_center {
			_x -= surface_get_width(s) / 2
		}
		else if h == fa_right {
			_x -= surface_get_width(s)
		}
		
		if v == fa_center {
			_y -= surface_get_height(s) / 2
		}
		else if v == fa_bottom {
			_y += surface_get_height(s) / 2
		}
		
        draw_surface_ext(s, _x, _y, 1, 1, angle, col, a)

        return undefined
    }
	
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_alpha(1)
	
	var _c = draw_get_color()
	
    draw_set_font(fntBig)

    s = surface_create(ceil(string_width(_text) * scale) + 6, ceil(string_height(_text) * scale) + 2)

    surface_set_target(s)

    draw_set_color(c_black)
	
	if scale >= 1 {
	    draw_text_transformed(5, 2, _text, scale, scale, 0)
	    draw_text_transformed(5, 4, _text, scale, scale, 0)
	    draw_text_transformed(4, 4, _text, scale, scale, 0)
	}
	else {
	    draw_text_transformed(5, 3, _text, scale, scale, 0)
	    draw_text_transformed(4, 3, _text, scale, scale, 0)
	}
	
    draw_set_color(c_white)
    draw_text_transformed(4, 2, _text, scale, scale, 0)

    surface_reset_target()

    BigNameSurfaces[$ _text] = s

    draw_set_font(UberCont.font)
	
	draw_set_halign(h)
	draw_set_valign(v)
	draw_set_alpha(a)
	
	draw_set_color(_c)
	
    draw_bigname(_x, _y, _text, scale)
}