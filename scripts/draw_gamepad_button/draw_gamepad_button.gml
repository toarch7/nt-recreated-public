function draw_gamepad_button(button, big, _x, _y, col = c_white) {
	if !UberCont.opt_gamepad
		exit
	
	draw_sprite_ext(big ? gamepad_icon_big : gamepad_icon_small, button - 32769, _x, _y, 1, 1, 0, col, draw_get_alpha())
}

function gamepad_button_to_image(_key) {
	switch _key {
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

function gamepad_key_to_nt_text(_key, big = false) {
	return "@(" + string(big ? gamepad_icon_big : gamepad_icon_small) + ":" + string(gamepad_button_to_image(_key)) + ")"
}

function draw_pickup_button(_x, _y) {
	var _offset = 7
	
	_x = round(_x)
	_y = round(_y - 7)
	
	if UberCont.opt_gamepad {
		var _key = keymap_get("pick")
		
		draw_sprite(sprEPickup, 1, _x, _y)
		draw_sprite(gamepad_icon_small, _key - 32769, _x, _y - 8)
		
		return _offset
	}
	
	if UberCont.opt_keyboard {
		var _key = keymap_get("pick"),
			_character = scrKeyName(_key)
		
		if string_length(_character) == 1 {
			if (_character == "E") {
				draw_sprite(sprEPickup, 0, _x, _y)
				return _offset
			}
			
			draw_set_color(c_black)
			draw_rectangle(_x - 6, _y - 5, _x + 5, _y - 4, false)
			draw_set_color(c_white)
			draw_rectangle(_x - 6, _y - 4, _x + 5, _y - 16, false)
			draw_set_color(c_black)
			draw_rectangle(_x - 5, _y - 5, _x + 4, _y - 15, false)
			draw_set_color(c_white)
			
			draw_sprite(sprEPickup, 1, _x, _y)
			
			var h = draw_get_halign(),
				v = draw_get_valign()
			
			draw_set_halign(fa_center)
			draw_set_valign(fa_middle)
			
			draw_text_nt(_x, _y - 9, _character)
			
			draw_set_halign(h)
			draw_set_valign(v)
		}
		else {
			draw_sprite(sprEPickup, 1, _x, _y)
			draw_sprite(sprKeySmall, _key, _x, _y - 8)
			return ceil(string_width(_character) * 0.25)
		}
		
		return _offset
	}
	
	draw_sprite(is_touch(global.index) ? sprMobilePickup : sprEPickup, 0, _x, _y)
	
	return _offset
}