/// @description Render & logic

draw_set_valign(fa_middle)
draw_set_halign(fa_center)

if mouse_check_button(mb_left) or is_desktop {
	mousex = device_mouse_x_to_gui(0)
	mousey = device_mouse_y_to_gui(0)
}
else {
	mousex = -1000
	mousey = -1000
}

var _mx = mousex,
	_my = mousey

option_can_change = true

if text_input_element != undefined {
	var _opt = text_input_element,
		_name = method_execute(_opt.name_get, _opt) ?? _opt.name,
		_value = _opt.value
	
	if _value == undefined
		_value = ""
	
	drawx = gui_w / 2
	drawy = gui_h / 2
	
	if !is_desktop {
		if !keyboard_virtual_status() {
			scrShowVirtualKeyboard()
		}
		else drawy -= 48
	}
	
	draw_text_nt(drawx, drawy - 16, (text_input_shake > 0 ? "@r" : "@w") + loc(_name))
	
	if text_input_shake > 0 {
		text_input_shake = lerp(text_input_shake, 0, 0.4)
		drawx += orandom(text_input_shake / 2)
		
		if !text_input_shake
			text_input_shake = 0
	}
	
	if _opt.key == "etc_name"
		draw_set_font(fontConsole)
	
	draw_text_shadow(drawx, drawy, loc(string(_value)) + text_input_cursor)
	
	if _opt.key == "etc_name"
		draw_set_font(fntM1)
	
	if keyboard_string != _value {
		text_input_cursor = "|"
		text_input_timer = 0
		
		// validation returns true = string is invalid
		if !method_execute(_opt.validate, _opt, keyboard_string, false) {
			_opt.value = keyboard_string
			snd_play(sndAppear)
		}
		else {
			text_input_shake += 5
			
			snd_play_pitch(sndCrownRandom, 0.4)
			keyboard_string = _value
		}
	}
	
	if scr_keyboard_check_pressed(vk_enter) or back_pressed {
		if !is_desktop
			keyboard_virtual_hide()
		
		if !method_execute(_opt.validate, _opt, _opt.value, true) {
			if option_can_change {
				UberCont.saveData[? _opt.key] = _opt.value
				scrOptionsUpdate()
			}
		}
		else _opt.value = _opt.previous
		
		scrOptionsMenuChangeCategory(category, false)
		
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
	
	_mx = device_mouse_x_to_gui(0)
	_my = device_mouse_y_to_gui(0)
	
    draw_text_nt(view_width / 2, view_height / 2 - 44, loc("@yWARNING"))

    // resourcepack warning
    draw_text_nt(view_width / 2, view_height / 2 + disclaimer_pop - 16, loc("@sRESOURCEPACKS ARE ONLY UNIQUE TO THIS RECREATION.#THESE ARE COLLECTION OF CUSTOM SPRITES, SOUNDS AND LANGUAGES#MADE BY COMMUNITY TO ADD NEW COLORS TO YOUR GAME.##THIS MAY AFFECT YOUR GAMING EXPERIENCE#IN A NOT INTENDED WAY."), 0.67)
    
    if rp_warning < 90 {
        draw_text_nt(view_width / 2, view_height / 2 + 16 - disclaimer_pop, "@sOK (" + string(ceil((90 - rp_warning) / 30)) + "S.)")
    }
	else draw_text_nt(view_width / 2, view_height / 2 + 16 - disclaimer_pop, "OK")

    if rp_warning < 90 rp_warning++

    if mouse_ui_clicked() && rp_warning >= 90 && point_in_circle(_mx, _my, view_width / 2, view_height / 2, 16) {
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
	
	_mx = device_mouse_x_to_gui(0)
	_my = device_mouse_y_to_gui(0)
	
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
	else draw_text_nt(view_width / 2 + _x, view_height / 2 - 64 + disclaimer_pop + _y, loc("@rWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET ALL OF YOUR#CHARACTERS, UNLOCKS, STATS, ACHIEVEMENTS AND#IT IS NOT UNDOABLE.###ARE YOU SURE?@w"))

    draw_text_nt(view_width / 2, view_height / 2 - disclaimer_pop + o, (wait ? "@d" : "@w") + loc("YES") + (erasing_progress == 1 ? " (" + string(5 - self.press) + ")" : ""))
    draw_text_nt(view_width / 2, view_height / 2 - disclaimer_pop + o + 16, (wait ? "@d" : "@w") + loc("NO"))

    if self.press >= 5 or (erasing_progress == 2 && self.press > 0) {
        if erasing_progress == 2 {
            with MenuOptions {
                foreach(options, function(_value) {
                    for (var i = 0; i < array_length(_value); i++) {
                        var v = _value[i]
						
						if is_undefined(v[$ "key"]) or v.key == "game_tutorial"
							continue
						
                        ds_map_delete(UberCont.saveData, v.key)
                    }
                })
				
                save_set_value("etc", "rp_warning", 0)
				
                scrOptionsUpdate()
				
                scrSave()
				
                event_perform(ev_create, 0)
				
                snd_play(sndClick)
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
                if point_in_rectangle(_mx, _my, view_width / 2 - 10, view_height / 2 + o - 8, view_width / 2 + 10, view_height / 2 + o + 8) {
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

                        self[$ "funnysound"] = audio_play_sound(sndBecomeNothingIdle, 1000, 1)
                        audio_sound_pitch(self[$ "funnysound"], 0.5)
                    }
                }

                if point_in_rectangle(_mx, _my, view_width / 2 - 10, view_height / 2 + o + 12, view_width / 2 + 10, view_height / 2 + o + 20) or back_pressed {
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
	var _any = false
	
	with MobileUI {
		if index != -1 {
			_any = true; break
		}
	}
	
	if _any {
		_mx = -1000
		_my = -1000
	}
}

if instance_exists(ResourcepackManager)
	exit

if sliderheld {
    sliderheld --

    if !sliderheld
        snd_play(sndSliderLetGo)
}

var _name = "SETTINGS"

if category != OptionCategory.Main {
	var _main_options = options[OptionCategory.Main],
		_category = category - 1
	
	if _category < array_length(_main_options) {
		_name = _main_options[_category].name
	}
}

draw_text_bigname(view_width / 2, 24, loc(_name), c_uigray)

var press = mouse_ui_clicked()
		|| (UberCont.opt_gamepad && gamepad_button_check_pressed(0, gp_face1))
		|| (UberCont.opt_keyboard && scr_keyboard_check_pressed(vk_enter)),
	
	yoff = 6 * (category != 0),
	
	items = options[category]

if scr_keyboard_check_held(vk_alt) or wait
	press = 0

if _mx != mx_last or _my != my_last or mouse_check_button_pressed(mb_any)
	mouse_active = true

mx_last = _mx
my_last = _my

var kv = scr_keyboard_check_pressed(vk_down) - scr_keyboard_check_pressed(vk_up),
	kh = scr_keyboard_check_pressed(vk_right) - scr_keyboard_check_pressed(vk_left)

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
			
			if keyboard_lastkey != -1 && scr_keyboard_check_pressed(keyboard_lastkey) {
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
	var _opt = items[i]

    if _opt == undefined or (_opt != undefined && !_opt.visible)
		continue
	
	drawy += max(_opt.height, draw_step_size)
	
	_count ++
}

item_count = _count

if editing_mode {
	drawy = gui_h - 48
}
else drawy = gui_h / 2 - drawy / 2 + 8

startdrawy = drawy

draw_set_color(c_white)

var _any = false

for (var i = 0; i < item_count; i++) {
    var _opt = items[i]
	
    if !(is_struct(_opt) && _opt.visible) continue
	
	if current_frame < last_change + i {
		_opt.anim = 1
		continue
	}
	else if current_frame == last_change + i {
		var _v = 0.75 + (1 - i / item_count) * 0.5
		audio_play_sound(sndAppear, 0, false, 1, 0, _v)
	}
	
    draw_align(_opt.halign, _opt.valign)
	
	var _w = _opt.width * 0.5,
		_h = _opt.height
	
	if !is_desktop {
		_h *= 0.5
		
		if _opt.type != "category" {
			_h += 3
		}
	}
	else _h *= 0.33
	
	var pointed = 0
	
	if _opt.condition != undefined
		_opt.available = method_execute(_opt.condition, _opt)
	
	if mouse_active {
		pointed = point_in_rectangle(_mx, _my, drawx - _w, drawy - _h, drawx + _w + (_opt.type == "slider" ? 96 : 0), drawy + _h)
		
		if (!slider && pointed && _opt.available) or (slider == _opt) {
			_any = true
			
			if pointed_item != i {
				snd_play(sndHover)
				pointed_item = i
			}
			
			_opt.anim = max(1, _opt.anim)
		}
		
		option_selected = (pointed_item == i)
		
		if slider == undefined {
			if _opt.type == "slider" && pointed && mouse_ui_clicked() {
				option_selected = true
			}
		}
		else option_selected = (_opt == slider)
	}
	else {
		option_selected = (pointed_item == i)
			
		if option_selected {
			pointed = true
			_any = true
				
			if _opt.type == "slider" {
				if kh != 0 {
					slider_change = 2
					slider = _opt
					
					var _max = 1,
						_step = kh * 0.1
					
					if _opt.key == "visual_screenshake"
						_max = 2
					
					_opt.value = clamp(_opt.value + _step, 0, _max)
				}
			}
		}
	}
	
	if await_input {
		if await_keybind == _opt {
			option_selected = true
		}
		else option_selected = false
	}
	
	drawy -= _opt.anim
	
	draw_set_color(_opt.available ? c_uigray : c_uidark)
	
	if option_selected {
		draw_set_color(c_white)
		
		if _opt.splat < sprite_get_number(sprMainMenuSplat) - 1
			_opt.splat ++
		
		if _opt.type == "slider" && mouse_check_button_pressed(mb_left) {
			if slider == undefined {
				slider = _opt
				slider_x = drawx + 20
				snd_play(sndSlider)
			}
		}
		else if _opt.available && (press or slider_change) && !wait {
			var r = undefined
			
			if is_method(_opt.click) {
				r = method_execute(_opt.click, _opt)
			}
			
			if is_undefined(r) {
				r = method_execute(element_functions[$ _opt.type], _opt)
			}
			
			if _opt.key != undefined && option_can_change {
				UberCont.saveData[? _opt.key] = _opt.value
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
	else if _opt.splat > 0
		_opt.splat --
	
	var draw = true
	
	if _opt.splat > 0
		draw_sprite(sprMainMenuSplat, _opt.splat, drawx, drawy)
	
	if _opt.draw && method_execute(_opt.draw, _opt)
		draw = false
	
	if draw {
		if !is_undefined(_opt.sprite) {
			var sprite = _opt.sprite,
				
				spr = sprite[0],
				img = sprite[1],
				
				n = scrMenuButtonName(spr, img)
			
			if !loc_exists(n) {
				draw_sprite_ext(spr, img, drawx + 1, drawy + 1, 1, 1, 0, c_black, 1)
				draw_sprite_ext(spr, img, drawx + 1, drawy, 1, 1, 0, c_black, 1)
				draw_sprite_ext(spr, img, drawx, drawy + 1, 1, 1, 0, c_black, 1)
				
				draw_sprite_ext(spr, img, drawx, drawy, 1, 1, 0, draw_get_color(), 1)
			}
			else draw_text_bigname(drawx, drawy, loc(n))
		}
		else {
			var has_value = (_opt.value != undefined && _opt.value != "" && _opt.type != "category") or _opt.type == "keybind"
			
			var _name = _opt.name
			
			if _opt.name_get != undefined
				_name = method_execute(_opt.name_get, _opt)
			
			if has_value {
				drawx -= _opt.width / 2
				
				var _text_scale = 1,
					_value = _opt.value
				
				if is_string(_name) {
					draw_text_nt(drawx, drawy, loc(_name), _text_scale)
				}
				
				drawx += _opt.width / 2
				
				var _size = category == OptionCategory.Controls_Preferences ? 60 : 32
				
				drawx += _size
				
				if _opt.type == "keybind" {
					if is_gamepad() {
						var k = keymap_get(_opt.key)
						
						_value = scrGamepadKeyName(k)
						
						if keymap_ret_nogamepad {
							_value = scrKeyName(k)
						}
					}
					else if is_keyboard() {
						_value = scrKeyName(keymap_get(_opt.key))
					}
					else _value = "???"
				}
				
				option_list_max = _opt.type == "list" ? array_length(_opt.list) : 0
				
				if is_method(_opt.value_get) {
					_value = method_execute(_opt.value_get, _opt)
				}
				
				if !is_undefined(_value) {
					if _opt.type == "slider" {
						_value = string(round(_value * 100)) + "%"
						
						var wdefault = sprite_get_width(sprOptionSlider) - 10,
							h = sprite_get_height(sprOptionSlider),
							w = wdefault * _opt.value
						
						draw_set_color(c_white)
						
						var offset = 0
						draw_sprite(sprOptionSlider, 0, drawx + offset, drawy)
						draw_sprite_part(sprOptionSlider, 1, 0, 0, w + 1, h + 1, drawx - (10 + offset), drawy - 9)
						draw_sprite(sprSliderEnd, 0, drawx + (44 - offset) + w - wdefault / 2, drawy)
					}
					else if _opt.type == "list" {
						if _opt.list_kind == "numeric" && is_numeric(_value) {
							_value = string(_value) + "/" + string(option_list_max)
						}
						else _value = "< " + string(_value) + " >"
					}
					else if _opt.type == "switch" {
						if (is_real(_value) or is_bool(_value)) && _value < 2
							_value = _opt.states[_value]
					}
					else if _opt.type == "keybind" {
						if await_input && await_keybind == _opt {
							_value = "@g" + loc("PRESS _any#BUTTON")
							
							if (current_frame % 30) > 20
								_value = "@q" + _value
						}
						else if is_gamepad() {
							draw_gamepad_button(keymap_get(_opt.key), 0, drawx, drawy)
							
							_value = ""
						}
					}
					
					if _value != undefined && _value != "" {
						draw_text_nt(drawx, drawy, loc(_value))
					}
				}
				
				drawx -= _size
			}
			else draw_text_nt(drawx, drawy, loc(_name))
		}
		
		method_execute(element_functions[$ _opt.type + "_draw"], _opt)
	}
	
	drawy += _opt.anim + max(_opt.height, draw_step_size)
	
	if _opt.anim > 0 {
		_opt.anim --
	}
	
    draw_set_valign(fa_top)
}

if slider != undefined {
	var _width = sprite_get_width(sprSlider)
	
	if _mx > 0 {
		if _mx != slider_x {
			slider_change = 1
		}
		
		slider.value = clamp(1 - (_width - (_mx - slider_x)) / sprite_get_width(sprSlider), 0, 1)
	}
	
	if !mouse_check_button(mb_left) {
		slider_change = 2
	}
}

if !_any {
	pointed_item = -1
}

draw_set_color(c_white)

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if !mouse_check_button(mb_left) wait = 0

back_pressed = false
