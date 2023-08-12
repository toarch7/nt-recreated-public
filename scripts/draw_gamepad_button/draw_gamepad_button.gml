function draw_gamepad_button(button, big, x, y, col = c_white) {
	if !UberCont.opt_gamepad
		exit
	
	draw_sprite_ext(big ? gamepad_icon_big : gamepad_icon_small, button - 32769, x, y, 1, 1, 0, col, draw_get_alpha())
}

function draw_pickup_button(x, y) {
	var off = 7
	
	x = round(x)
	y = round(y - 7)
	
	if UberCont.opt_gamepad {
		var key = keymap_get("pick")
		
		draw_sprite(sprEPickup, 1, x, y)
		draw_sprite(gamepad_icon_small, key - 32769, x, y - 8)
		
		return off
	}
	
	if UberCont.opt_keyboard {
		var key = keymap_get("pick"),
			c = scrKeyName(key)
		
		if string_length(c) == 1 {
			draw_sprite(sprEPickup, 2, x, y)
			
			var h = draw_get_halign(),
				v = draw_get_valign()
			
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			
			draw_text_nt(x - 0.5, y - 8, c)
			
			draw_set_halign(h)
			draw_set_valign(v)
		}
		else {
			draw_sprite(sprEPickup, 1, x, y)
			
			draw_sprite(sprKeySmall, key, x, y - 8)
			var w = string_width(c) / 4
			
			return ceil(w)
		}
		
		return off
	}
	
	draw_sprite(sprEPickup, 0, x, y)
	
	return off
}