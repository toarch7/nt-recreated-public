function draw_gamepad_button(button, big, x, y, col = c_white) {
	if !UberCont.opt_gamepad
		exit
	
	draw_sprite_ext(big ? gamepad_icon_big : gamepad_icon_small, button - 32769, x, y, 1, 1, 0, col, draw_get_alpha())
}

function gamepad_button_to_image(key) {
	switch key {
		case gp_face1: return 0
		case gp_face2: return 1
		case gp_face3: return 2
		case gp_face4: return 3
		case gp_shoulderl: return 4
		case gp_shoulderr: return 5
		case gp_shoulderlb: return 6
		case gp_shoulderrb: return 7
		case gp_stickl: return 8
		case gp_stickr: return 9
		case gp_padu: return 11
		case gp_padd: return 12
		case gp_padl: return 13
		case gp_padr: return 14
		case gp_start: return 15
		case gp_select: return 16
		
		case "dpad": return 10
		case "stickl": return 17
		case "stickr": return 18
	}
	
	return -1
}

function gamepad_key_to_nt_text(key, big = false) {
	return "@(" + string(big ? gamepad_icon_big : gamepad_icon_small) + ":" + string(gamepad_button_to_image(key)) + ")"
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