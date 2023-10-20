/// @description Render & logic

draw_set_valign(fa_center)
draw_set_halign(fa_center)

if mouse_check_button(mb_left) or global.desktop {
	mousex = device_mouse_x_to_gui(0)
	mousey = device_mouse_y_to_gui(0)
}
else {
	mousex = -1000
	mousey = -1000
}

var mx = mousex,
	my = mousey

option_can_change = true

if text_input_element != undefined {
	var opt = text_input_element,
		name = method_execute(opt.name_get, opt) ?? opt.name,
		val = opt.value
	
	if val == undefined
		val = ""
	
	drawx = gui_w / 2
	drawy = gui_h / 2
	
	if !global.desktop {
		if !keyboard_virtual_status() {
			scrShowVirtualKeyboard()
		}
		else drawy -= 48
	}
	
	draw_text_nt(drawx, drawy - 16, (text_input_shake > 0 ? "@r" : "@w") + loc(name))
	
	if text_input_shake > 0 {
		text_input_shake = lerp(text_input_shake, 0, 0.4)
		drawx += orandom(text_input_shake / 2)
		
		if !text_input_shake
			text_input_shake = 0
	}
	
	if opt.key == "etc_name"
		draw_set_font(fontConsole)
	
	draw_text_shadow(drawx, drawy, loc(string(val)) + text_input_cursor)
	
	if opt.key == "etc_name"
		draw_set_font(fntM1)
	
	if keyboard_string != val {
		text_input_cursor = "|"
		text_input_timer = 0
		
		// validation returns true = string is invalid
		if !method_execute(opt.validate, opt, keyboard_string, false) {
			opt.value = keyboard_string
			snd_play(sndAppear)
		}
		else {
			text_input_shake += 5
			
			snd_play_pitch(sndCrownRandom, 0.4)
			keyboard_string = val
		}
	}
	
	if keyboard_check_pressed(vk_enter) or back_pressed {
		if !global.desktop
			keyboard_virtual_hide()
		
		if !method_execute(opt.validate, opt, opt.value, true) {
			if option_can_change {
				UberCont.saveData[? opt.key] = opt.value
				scrOptionsUpdate()
			}
		}
		else opt.value = opt.previous
		
		self.category_set(category, false)
		
		text_input_element = undefined
		
		back_pressed = false
	}
	
	text_input_timer ++
	
	if text_input_timer > 20 {
		text_input_cursor = text_input_cursor == "|" ? "" : "|"
		text_input_timer = 0
	}
	
	exit
}

if rp_warning {
	if back_pressed
		rp_warning = 0
	
    draw_text_nt(view_width / 2, view_height / 2 - 44, loc("@yWARNING"))

    // resourcepack warning
	draw_set_font(fntSmall)
    draw_text_nt(view_width / 2, view_height / 2 + disclaimer_pop - 16, loc("@sRESOURCEPACKS ARE ONLY UNIQUE TO THIS RECREATION.#THESE ARE COLLECTION OF CUSTOM SPRITES, SOUNDS AND LANGUAGES#MADE BY COMMUNITY TO ADD NEW COLORS TO YOUR GAME.##THIS MAY AFFECT YOUR GAMING EXPERIENCE#IN A NOT INTENDED WAY."))
    draw_set_font(fntM1)

    if rp_warning < 90 {
        draw_text_nt(view_width / 2, view_height / 2 + 16 - disclaimer_pop, "@sOK (" + string(ceil((90 - rp_warning) / 30)) + "S.)")
    }
	else draw_text_nt(view_width / 2, view_height / 2 + 16 - disclaimer_pop, "OK")

    if rp_warning < 90 rp_warning++

    if mouse_ui_clicked() && rp_warning >= 90 && point_in_circle(mx, my, view_width / 2, view_height / 2, 16) {
        snd_play(sndClickBack)
        save_set_value("etc", "rp_warning", 1)
        rp_warning = 0
    }

    draw_set_valign(fa_top)
    draw_set_halign(fa_left)
	
	if disclaimer_pop
		disclaimer_pop --
	
    exit
}

if erasing_progress {
	// 1 - reset SAVEFILE
	// 2 - reset OPTIONS
    if self[$ "funnysound"] != undefined or alarm[1] {
        with MusCont {
            if alarm[0] < 5 {
                alarm[0] = 5
            }
        }

        draw_set_color(c_black)
        draw_rectangle(0, 0, view_width, view_height, 0)
        draw_set_color(c_white)

        if alarm[1] exit
    }

    draw_set_valign(fa_top)
    draw_set_color(c_ltgray)
    draw_text_shadow(view_width / 2, 8, erasing_progress == 2 ? loc("RESET OPTIONS") : loc("ERASE PROGRESS"))

    var _x = 0,
        _y = 0

    if erasing_progress == 1 && self.press > 2 {
        _x = orandom(self.press - 2)
        _y = orandom(self.press - 2)
    }

    var o = 32

    if erasing_progress == 2 {
        draw_text_nt(view_width / 2 + _x, view_height / 2 - 64 + disclaimer_pop + _y, loc("@wWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET#ALL OF YOUR PREFERENCES.###ARE YOU SURE?@w"))
    }
	else draw_text_nt(view_width / 2 + _x, view_height / 2 - 64 + disclaimer_pop + _y, loc("@rWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET ALL OF YOUR#CHARACTERS, UNLOCKS, STATS, ACHIEVEMENTS AND#IT IS UNDOABLE.###ARE YOU SURE?@w"))

    draw_text_nt(view_width / 2, view_height / 2 - disclaimer_pop + o, (wait ? "@d" : "@w") + loc("YES") + (erasing_progress == 1 ? " (" + string(5 - self.press) + ")" : ""))
    draw_text_nt(view_width / 2, view_height / 2 - disclaimer_pop + o + 16, (wait ? "@d" : "@w") + loc("NO"))

    if self.press >= 5 or (erasing_progress == 2 && self.press > 0) {
        if erasing_progress == 2 {
            with MenuOptions {
                foreach(options, function(val) {
                    for (var i = 0; i < array_length(val); i++) {
                        var v = val[i]
						
						if is_undefined(v[$ "key"]) or v.key == "game_tutorial"
							continue
						
                        ds_map_delete(UberCont.saveData, v.key)
                    }
                })
				
                save_set_value("etc", "rp_warning", 0)
				
                scrOptionsUpdate()
				
                scrSave()
				
                event_perform(ev_create, 0)
				
                snd_play(sndMenuClick)
                snd_play(sndMutant0Cnfm)
				
                break
            }
        }
		else {
            if alarm[1] == -1
				alarm[1] = 60

            with BackButton
				instance_destroy()

            if self[$ "funnysound"] != undefined {
                audio_stop_sound(self[$ "funnysound"])
                self[$ "funnysound"] = undefined
            }
			
            audio_stop_all()
        }
    }
	else {
        if mouse_ui_clicked() or back_pressed {
            if !wait {
                if point_in_rectangle(mx, my, view_width / 2 - 10, view_height / 2 + o - 8, view_width / 2 + 10, view_height / 2 + o + 8) {
                    snd_play(sndClick)
                    wait = 30

					disclaimer_pop = 1
                    self.press ++

                    if erasing_progress == 1 && self.press == 3 {
                        with SpiralCont
							visible = 0

                        with MusCont {
                            audio_pause_sound(song)
                            audio_pause_sound(amb)
                        }

                        self[$ "funnysound"] = audio_play_sound(sndNothingSielence, 1000, 1)
                        audio_sound_pitch(self[$ "funnysound"], 0.5)
                    }
                }

                if point_in_rectangle(mx, my, view_width / 2 - 10, view_height / 2 + o + 12, view_width / 2 + 10, view_height / 2 + o + 20) or back_pressed {
                    snd_play(sndClickBack)
					
                    if self[$ "funnysound"] != undefined {
                        with SpiralCont
							visible = 1

                        __background_set_colour(c_black)

                        with MusCont {
                            audio_resume_sound(song)
                            audio_resume_sound(amb)
                        }


                        audio_stop_sound(self[$ "funnysound"])
                        self[$ "funnysound"] = undefined
                    }

                    erasing_progress = 0
                    self.press = 0
                }
            }
        }

        if wait > 0
			wait --
    }
	
	if disclaimer_pop && !wait
		disclaimer_pop --

    draw_set_halign(fa_left)

    exit
}

if editing_mode {
	var any = false
	
	with MobileUI {
		if index != -1 {
			any = true; break
		}
	}
	
	if any {
		mx = -1000
		my = -1000
	}
}

if instance_exists(ResourcepackManager)
	exit

if sliderheld {
    sliderheld --

    if !sliderheld
        snd_play(sndSliderLetGo)
}

var name = "SETTINGS"

if category != OptionCategory.Main
	name = options[OptionCategory.Main, category - 1].name

draw_bigname(view_width / 2, 24, loc(name), c_uigray)

var press = mouse_ui_clicked()
			or (UberCont.opt_gamepad && gamepad_button_check_pressed(0, gp_face1))
			or (UberCont.opt_keyboard && keyboard_check_pressed(vk_enter)),
	
	yoff = 6 * (category != 0),
	
	items = options[category]

if keyboard_check(vk_alt) or wait
	press = 0

if mx != mx_last or my != my_last or mouse_check_button_pressed(mb_any)
	mouse_active = true

mx_last = mx
my_last = my

var kv = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up),
	kh = keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left)

if kv == 0
	kv = gamepad_button_check_pressed(0, gp_padd) - gamepad_button_check_pressed(0, gp_padu)

if kh == 0
	kh = gamepad_button_check_pressed(0, gp_padr) - gamepad_button_check_pressed(0, gp_padl)

if item_count != -1 {
	if kv != 0 {
	    do {
			pointed_item += kv
			
			if pointed_item >= item_count
		        pointed_item = 0
			
			if pointed_item < 0
				pointed_item = item_count - 1
		}
		until items[pointed_item].visible
		
		mouse_active = false
		
	    snd_play(sndHover)
	}
}

if await_input {
	var k = -1,
		type = 0
	
	if text_input_timer > 5 {
		if is_gamepad() {
			k = scrGamepadAnykey()
			type = 1
		}
		else if is_keyboard() {
			type = 0
			
			if keyboard_lastkey != -1 && keyboard_check_pressed(keyboard_lastkey) {
				k = keyboard_lastkey
			}
			else if mouse_lastbutton != -1 && mouse_check_button_pressed(mouse_lastbutton) {
				k = mouse_lastbutton
			}
		}
	}
	
	if k != -1 {
		Key[$ await_keybind.key][type] = k
		
		scrOptionsSaveKeymaps()
		scrOptionsUpdate()
		
		await_input = false
		await_keybind = undefined
		
		snd_play(sndSliderLetGo)
	}
	
	keyboard_lastkey = -1
	mouse_lastbutton = -1
	
	text_input_timer ++
	
	if text_input_timer > 60
		text_input_timer = 0
	
	press = 0
}

draw_step_size = 16

if item_count > 10
	draw_step_size -= item_count - 10

drawx = gui_w / 2
drawy = 0

var _count = 0

for (var i = 0; i < array_length(items); i ++) {
	var opt = items[i]

    if opt == undefined or (opt != undefined && !opt.visible)
		continue
	
	drawy += max(opt.height, draw_step_size)
	
	_count ++
}

if item_count == -1
	item_count = _count

if editing_mode {
	drawy = gui_h - 48
}
else drawy = gui_h / 2 - drawy / 2 + 8

startdrawy = drawy

draw_set_color(c_white)

var any = false

for (var i = 0; i < item_count; i++) {
    var opt = items[i]

    if opt == undefined or (opt != undefined && !opt.visible)
		continue
	
	if global.time < last_change + i {
		opt.anim = 2
		
		continue
	}
	else if global.time == last_change + i {
		snd_play_pitch(sndAppear, 1.3 - i / ((i + item_count) + category) / 2 + random(0.01))
	}
	
    draw_set_halign(opt.halign)
    draw_set_valign(opt.valign)
	
	var _w = opt.width * 0.5,
		_h = opt.height
	
	if !global.desktop {
		_h *= 0.5
		
		if opt.type != "category"
			_h += 3
	}
	else _h *= 0.33
	
	var pointed = 0
	
	if opt.condition != undefined
		opt.available = method_execute(opt.condition, opt)
	
	if mouse_active {
		pointed = point_in_rectangle(mx, my, drawx - _w, drawy - _h, drawx + _w + (opt.type == "slider" ? 96 : 0), drawy + _h)
		
		if (!slider && pointed && opt.available) or (slider == opt) {
			any = true
			
			if pointed_item != i {
				snd_play(sndHover)
				pointed_item = i
			}
			
			opt.anim = max(1, opt.anim)
		}
		
		option_selected = (pointed_item == i)
		
		if slider == undefined {
			if opt.type == "slider" && pointed && mouse_ui_clicked() {
				option_selected = true
			}
		}
		else option_selected = (opt == slider)
	}
	else {
		option_selected = (pointed_item == i)
			
		if option_selected {
			pointed = true
			any = true
				
			if opt.type == "slider" {
				if kh != 0 {
					slider_change = 2
					slider = opt
					
					var _max = 1,
						_step = kh * 0.1
					
					if opt.key == "visual_screenshake"
						_max = 2
					
					opt.value = clamp(opt.value + _step, 0, _max)
				}
			}
		}
	}
	
	if await_input {
		if await_keybind == opt {
			option_selected = true
		}
		else option_selected = false
	}
	
	drawy -= opt.anim
	
	draw_set_color(opt.available ? c_uigray : c_uidark)
	
	if option_selected {
		draw_set_color(c_white)
		
		if opt.splat < sprite_get_number(sprMenuButtonSplat) - 1
			opt.splat ++
		
		if opt.type == "slider" && mouse_check_button_pressed(mb_left) {
			if slider == undefined {
				slider = opt
				slider_x = drawx + UI_SLIDER_OFFSET
				
				snd_play(sndSlider)
			}
		}
		else if opt.available && (press or slider_change) && !wait {
			var r = undefined
			
			if is_method(opt.click)
				r = method_execute(opt.click, opt)
			
			if r == undefined
				r = method_execute(element_functions[$ opt.type], opt)
			
			if opt.key != undefined && option_can_change {
				UberCont.saveData[? opt.key] = opt.value
				scrOptionsUpdate()
			}
			
			if slider_change == 2 {
				snd_play(sndSliderLetGo)
				slider_change = false
				slider = undefined
			}
			else if !slider_change
				snd_play(sndClick)
		}
	}
	else if opt.splat > 0
		opt.splat --
	
	var draw = true
	
	if opt.splat > 0
		draw_sprite(sprMenuButtonSplat, opt.splat, drawx, drawy)
	
	if opt.draw && method_execute(opt.draw, opt)
		draw = false
	
	if draw {
		if !is_undefined(opt.sprite) {
			var sprite = opt.sprite,
				
				spr = sprite[0],
				img = sprite[1],
				
				n = scrMenuButtonName(spr, img)
			
			if !loc_exists(n) {
				draw_sprite_ext(spr, img, drawx + 1, drawy + 1, 1, 1, 0, c_black, 1)
				draw_sprite_ext(spr, img, drawx + 1, drawy, 1, 1, 0, c_black, 1)
				draw_sprite_ext(spr, img, drawx, drawy + 1, 1, 1, 0, c_black, 1)
				
				draw_sprite_ext(spr, img, drawx, drawy, 1, 1, 0, draw_get_color(), 1)
			}
			else draw_bigname(drawx, drawy, loc(n))
		}
		else {
			var has_value = (opt.value != undefined && opt.value != "" && opt.type != "category") or opt.type == "keybind"
			
			if has_value {
				drawx -= opt.width / 2
				var name = opt.name
				
				if opt.name_get != undefined
					name = method_execute(opt.name_get, opt)
				
				if name != undefined
					draw_text_nt(drawx, drawy, loc(name))
				
				drawx += opt.width / 2
				
				var _size = 32
				
				if category == OptionCategory.Controls_Preferences
					_size = 60
				
				drawx += _size
				
				var val = opt.value
				
				if opt.type == "keybind" {
					if is_gamepad() {
						var k = keymap_get(opt.key)
						
						val = scrGamepadKeyName(k)
						
						if keymap_ret_nogamepad
							val = scrKeyName(k)
					}
					else if is_keyboard() {
						val = scrKeyName(keymap_get(opt.key))
					}
					else val = "???"
				}
				
				option_list_max = opt.type == "list" ? array_length(opt.list) : 0
				
				if opt.value_get != undefined
					val = method_execute(opt.value_get, opt)
				
				if val != undefined {
					if opt.type == "slider" {
						val = string(round(val * 100)) + "%"
						
						var wdefault = sprite_get_width(sprOptionSlider) - 10,
							h = sprite_get_height(sprOptionSlider),
							w = wdefault * opt.value
						
						draw_set_color(c_white)
						
						var offset = 0
						draw_sprite(sprOptionSlider, 0, drawx + offset, drawy)
						draw_sprite_part(sprOptionSlider, 1, 0, 0, w + 1, h + 1, drawx - (10 + offset), drawy - 9)
						draw_sprite(sprSliderEnd, 0, drawx + (44 - offset) + w - wdefault / 2, drawy)
					}
					else if opt.type == "list" {
						if opt.list_kind == "numeric" && is_numeric(val) {
							val = string(val) + "/" + string(option_list_max)
						}
						else val = "< " + string(val) + " >"
					}
					else if opt.type == "switch" {
						if (is_real(val) or is_bool(val)) && val < 2
							val = opt.states[val]
					}
					else if opt.type == "keybind" {
						if await_input && await_keybind == opt {
							val = "@g" + loc("PRESS ANY#BUTTON")
							
							if (global.time % 30) > 20
								val = "@q" + val
						}
						else if is_gamepad() {
							draw_gamepad_button(keymap_get(opt.key), 0, drawx, drawy)
							
							val = ""
						}
					}
					
					if val != undefined && val != ""
						draw_text_nt(drawx, drawy, loc(val))
				}
				
				drawx -= _size
			}
			else draw_text_nt(drawx, drawy, loc(opt.name))
		}
		
		method_execute(element_functions[$ opt.type + "_draw"], opt)
	}
	
	drawy += opt.anim
	
	drawy += max(opt.height, draw_step_size)
	
	if opt.anim > 0
		opt.anim --
	
    draw_set_valign(fa_top)
}

if slider != undefined {
	var width = sprite_get_width(sprSlider)
	
	if mx > 0 {
		if mx != slider_x
			slider_change = 1
		
		slider.value = clamp(1 - (width - (mx - slider_x)) / sprite_get_width(sprSlider), 0, 1)
	}
	
	if !mouse_check_button(mb_left)
		slider_change = 2
}

if !any
	pointed_item = -1

draw_set_color(c_white)

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if !mouse_check_button(mb_left)
    wait = 0

for(var i = 0; i < array_length(options); i ++) {
	if keyboard_check_pressed(ord(i + 1))
		self.category_set(i)
}

back_pressed = false