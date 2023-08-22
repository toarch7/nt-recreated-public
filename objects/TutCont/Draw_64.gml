if pos >= array_length(text) or instance_exists(Spiral)
	exit

if !instance_exists(Portal) {
    draw_set_color(c_black)
    draw_rectangle(0, view_height, view_width, view_height - 32, 0)
    draw_set_color(c_white)

    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
	
	var str = text[pos],
		sub = 0
	
	if is_keyboard(global.index)
		sub = 1
	
	if is_gamepad(global.index)
		sub = 2
	
	if pos < 4
		str = text[pos, sub]
	
	str = loc(str)
	
	if pos == 0 {
		if sub == 1 {
			var keys = ""
			
			keys += loc(scrKeyName(Key.north[0])) + ", "
			keys += loc(scrKeyName(Key.west[0])) + ", "
			keys += loc(scrKeyName(Key.south[0])) + loc(" @sAND@w ")
			keys += loc(scrKeyName(Key.east[0])) + "@s"
			
			str = string_replace(str, "%", keys)
		}
	}
	else if pos < 4 {
		var keys = [ "pick", "swap", "spec" ],
			key_name = scrKeyName(keymap_get(keys[pos - 1]))
		
		str = string_replace(str, "%", "@w" + loc(key_name) + "@s")
	}
	
    draw_text_nt(view_width / 2, view_height - 18, "@s" + str)

    draw_set_halign(fa_left)
    draw_set_valign(fa_top)
}

draw_set_color(c_lime)

if !global.desktop && !UberCont.opt_gamepad {
    switch pos {
        case 0:
            with JoystickMove {
                draw_circle_part(x, y, rad * 1.25 + sin(other.wave) * 4, 2, 1)
            }
            break

        case 1:
            with ButtonAct {
                draw_circle_part(x, y, rad * 1.25 + sin(other.wave) * 4, 2, 1)
                alpha += 0.4
            }
            break

        case 2:
            with ButtonSwap {
                draw_circle_part(x, y, rad * 1.25 + sin(other.wave) * 4, 2, 1)
            }
            break

        case 3:
            with ButtonActive {
                draw_circle_part(x, y, rad * 1.25 + sin(other.wave) * 4, 2, 1)
            }
            break
    }
}

wave += 0.1

if wave > 6.2
	wave = 0

draw_set_color(c_white)