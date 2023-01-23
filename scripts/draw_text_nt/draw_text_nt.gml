globalvar draw_text_nt_chache;
		  draw_text_nt_chache = {}

function draw_text_nt(_x, _y, _text, scale = 1) {
	draw_set_font(UberCont.font)
	
	if !string_count("@", _text) {
		return draw_text_shadow(_x, _y, string_upper(_text))
	}
	
	var _sx = _x,
		_sy = _y,
		halign = draw_get_halign(),
		valign = draw_get_valign()
	
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
	var d = draw_text_nt_chache[$ _text]
	
	if d == undefined {
		d = [
			[], // strings
			[], // line info
		]
		
		var l = string_length(_text),
			str = "", w = 0, h = 0
		
		for(var i = 1; i <= l + 1; i ++) {
			var c = string_char_at(_text, i)
			
			if c == "@" or c == "#" or c == "\n" or (i >= l && str != "") {
				if i >= l
					str += c
				
				str = string_upper(str)
				
				array_push(d[0], str, string_width(str), string_height(str))
				
				w += string_width(str)
				h = max(string_height(str), h)
				
				if c == "@" {
					c = string_char_at(_text, ++ i)
					
					var drawcol = c_white
					
					switch c {
						case "s": drawcol = make_color_rgb(125, 131, 141); break // [s]ilver (gray)
						case "b": drawcol = make_color_rgb(22, 97, 223); break // [b]lue
						case "r": drawcol = make_color_rgb(252, 56, 0); break // [r]ed
						case "Y": drawcol = make_color_rgb(137, 159, 198); break // [Y]AL's main color
						case "y": drawcol = make_color_rgb(250, 171, 0); break // [y]ellow (or more like orange)
						case "d": drawcol = make_color_rgb(59, 62, 67); break // [d]ark gray
						case "g": drawcol = make_color_rgb(68, 198, 22); break // [g]reen
						case "p": drawcol = make_color_rgb(86, 34, 110); break // [p]urple
						case "w": drawcol = c_white; break // w[hite]
						
						// case "e": drawcol = make_color_rgb(175, 143, 106); break // te [e]vent color
						// case "z": drawcol = color_RED; break // warp[z]one red
						
						case "q": // earth[q]uake
							_x = _x + random_spread(1)
							_y = _y + random_spread(1)
						break
						
						case "(": // sprite
							var asset = "",
								spd = 0
							
							while i <= l {
								var c = string_char_at(_text, ++ i)
								
								if c == ":" {
									var n = ""
									
									while i <= l {
										var c = string_char_at(_text, ++ i)
										
										if c == ")" {
											break
										}
										
										n += c
									}
									
									try { spd = real(n) } catch(e) { print(e.longMessage) }
								}
								
								// sprite
								if c == ")" {
									var spr = asset_get_index(asset)
									
									if !sprite_exists(spr)
										break
									
									var a = [
										// sprite
										spr,
										
										// size
										(sprite_get_bbox_right(spr) + 1) - sprite_get_bbox_left(spr),
										sprite_get_height(spr),
										
										
										// image index and speed
										spd,
										0
									]
									
									drawcol = -1
									h = max(a[2], h)
									array_push(d[0], a)
									
									break
								}
								else asset += c
							}
						break
					}
					
					if drawcol != -1
						array_push(d[0], drawcol)
				}
				else if c == "#" or c == "\n"{
					array_push(d[0], "\n")
					array_push(d[1], [ w, max(string_height(" "), h) ])
					w = 0
					h = 0
				}
				
				str = ""
			}
			else
				str += c
		}
		
		array_push(d[1], [ w, h ])
		
		draw_text_nt_chache[$ _text] = d
	}
	
	var l = array_length(d[0]),
		_max = string_height("a"),
		pos = 0,
		line = d[1, pos]
	
	if halign == fa_center {
		_x -= line[0] / 2 * scale
	}
	
	if valign == fa_center {
		for(var i = 0; i < array_length(d[1]); i ++) {
			_y -= d[1, i][1] / 2 * scale
		}
	}
	
	for(var i = 0; i < l; i ++) {
		var str = d[0, i]
		
		// Basic text
		if is_string(str) {
			// Newlines
			if str == "\n" {
				_x = _sx
				
				if valign == fa_bottom {
					_y -= line[1] * scale
				}
				else _y += line[1] * scale
				
				line = d[1, ++ pos]
				
				if halign == fa_center {
					_x -= line[0] / 2 * scale
				}
			}
			// Text
			else {
				if halign == fa_right // that's how mafia works
					_x -= (d[0, i + 1]) * scale
				
				draw_text_shadow_scale(_x, _y, str, scale)
				
				if halign != fa_right
					_x += (d[0, i + 1]) * scale
				
				i += 2
			}
		}
		// @(Sprites) (this thing sucks at it)
		else if is_array(str) {
			if halign == fa_right
				_x -= (str[1] - string_width("A") + 2) * scale
			
			draw_sprite_ext(
				str[0],
				global.time * str[3],
				_x + (sprite_get_xoffset(str[0]) / 2 + 6) * scale,
				_y + (sprite_get_yoffset(str[0]) / 2 + 2) * scale,
				scale,
				scale,
				0,
				c_white,
				draw_get_alpha()
			)
			
			if halign != fa_right
				_x += (str[1] - string_width("A") + 2) * scale
		}
		else {
			draw_set_color(str)
		}
	}
	
	draw_set_halign(halign)
	draw_set_valign(valign)
}