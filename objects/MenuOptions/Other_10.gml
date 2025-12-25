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
		_name = method_execute(_opt.get_name, _opt) ?? _opt.name,
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
		draw_set_font(fntConsole)
	
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

    if erasing_progress == 1 && self._press > 2 {
        _x = orandom(self._press - 2)
        _y = orandom(self._press - 2)
    }

    var o = 32

    if erasing_progress == 2 {
        draw_text_nt(view_width / 2 + _x, view_height / 2 - 64 + disclaimer_pop + _y, loc("@wWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET#ALL OF YOUR PREFERENCES.###ARE YOU SURE?@w"))
    }
	else draw_text_nt(view_width / 2 + _x, view_height / 2 - 64 + disclaimer_pop + _y, loc("@rWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET ALL OF YOUR#CHARACTERS, UNLOCKS, STATS, ACHIEVEMENTS AND#IT IS NOT UNDOABLE.###ARE YOU SURE?@w"))

    draw_text_nt(view_width / 2, view_height / 2 - disclaimer_pop + o, (wait ? "@d" : "@w") + loc("YES") + (erasing_progress == 1 ? " (" + string(5 - self._press) + ")" : ""))
    draw_text_nt(view_width / 2, view_height / 2 - disclaimer_pop + o + 16, (wait ? "@d" : "@w") + loc("NO"))

    if self._press >= 5 or (erasing_progress == 2 && self._press > 0) {
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
        if (mouse_ui_clicked() || back_pressed) {
            if !wait {
                if point_in_rectangle(_mx, _my, view_width / 2 - 10, view_height / 2 + o - 8, view_width / 2 + 10, view_height / 2 + o + 8) {
                    snd_play(sndClick)
                    wait = 30

					disclaimer_pop = 1
                    self._press ++

                    if erasing_progress == 1 && self._press == 3 {
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

                        background_set_colour(c_black)

                        with MusCont {
                            audio_resume_sound(song)
                            audio_resume_sound(amb)
                        }


                        audio_stop_sound(self[$ "funnysound"])
                        self[$ "funnysound"] = undefined
                    }

                    erasing_progress = 0
                    self._press = 0
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

if (instance_exists(ResourcepackManager)) exit

if (sliderheld > 0) if (-- sliderheld) <= 0 {
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

var _press = mouse_ui_clicked()
		|| (UberCont.opt_gamepad && gamepad_button_check_pressed(0, gp_face1))
		|| (UberCont.opt_keyboard && scr_keyboard_check_pressed(vk_enter)),
	
	yoff = 6 * (category != 0),
	_has_scrollbar = false,
	_items = items

if (scr_keyboard_check_held(vk_alt) || wait) _press = false

if _mx != mx_last || _my != my_last || mouse_check_button_pressed(mb_any) {
	mouse_active = true
}

var kv = scr_keyboard_check_pressed(vk_down) - scr_keyboard_check_pressed(vk_up),
	kh = scr_keyboard_check_pressed(vk_right) - scr_keyboard_check_pressed(vk_left)

if kv == 0 {
	kv = gamepad_button_check_pressed(0, gp_padd) - gamepad_button_check_pressed(0, gp_padu)
}

if kh == 0 {
	kh = gamepad_button_check_pressed(0, gp_padr) - gamepad_button_check_pressed(0, gp_padl)
}

if item_count != -1 {
	if kv != 0 {
	    do {
			pointed_item += kv
			
			if pointed_item >= item_count
		        pointed_item = 0
			
			if pointed_item < 0
				pointed_item = item_count - 1
		}
		until _items[pointed_item].visible
		
		mouse_active = false
		
	    snd_play(sndHover)
	}
}

#region Keybind change
if await_input {
	var k = -1, type = 0
	
	if text_input_timer > 5 {
		if is_gamepad() {
			k = scrGamepadAnykey()
			type = 1
		}
		else if is_keyboard() {
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
	
	_press = false
}
#endregion

drawx = gui_w / 2
drawy = 0

for(var i = 0; i < item_count; i ++) {
	var _opt = _items[i]
	if is_struct(_opt) && _opt.visible {
		drawy += max(_opt.height, draw_step_size)
	}
}

if drawy > (gui_h - (LETTERBOX_SIZE * 2)) {
	scroll_max = (drawy - (gui_h - (LETTERBOX_SIZE * 2))) div 2
	scroll_min = -scroll_max
	
	if (scroll_check) {
		scroll = scroll_min
		scroll_check = false
		scroll_speed = 0
	}
}
else if (scroll_check) {
	scroll = 0
	scroll_min = 0
	scroll_max = 0
	scroll_check = false
	scroll_speed = 0
}

if !(scroll_max == 0 && scroll_min == 0) {
	var _wheel = mouse_wheel_down() - mouse_wheel_up()
	
	if (_wheel != 0) scroll_speed = 10 * _wheel
	
	if (is_struct(slider)) scroll_speed = 0
	
	if (scroll_speed != 0) {
		scroll = approach(scroll, scroll_speed ? scroll_max : scroll_min, abs(scroll_speed))
		scroll_speed = approach(scroll_speed, 0, 1)
	}
	
	_has_scrollbar = true
	
	#region Slider element
	
	var _slider_size = 80,
		_slider_bottom = view_height - _slider_size,
		_progress = (scroll - scroll_min) / scroll_max * 0.5
	
	draw_sprite_ext(sprOptionSlider, 0, view_width - 16, 36, 1.6, 1, 270, c_white, 1)
	
	draw_sprite_ext(sprSliderEndHorizontal, 0,
		view_width - 20 + (dragging > 0), 40 + _slider_bottom * _progress,
		1, 1, 0, dragging ? c_uigray : c_white, 1)
	
	if is_undefined(slider) && mouse_check_button(mb_left) {
		if (dragging != -1) for(var i = 0; i < 4; i ++) {
			if (!device_mouse_check_button(i, mb_left)) continue
			
			var mx = device_mouse_x_to_gui(i),
				my = device_mouse_y_to_gui(i)
			
			if (mx >= view_width - 32 && mx <= view_width) || dragging {
				var _p = clamp((my - LETTERBOX_SIZE) / _slider_bottom, 0, 1)
				scroll = scroll_min + scroll_max * _p * 2
				
				if !dragging {
					snd_play(sndSlider)
					dragging = true
				}
				
				speed = 0
			}
			
			break
		}
	}
	else if (dragging) {
		snd_play(sndSliderLetGo)
		dragging = false
	}
	
	#endregion
}

if !editing_mode {
	drawy = gui_h * 0.5 - drawy * 0.5 + 8 - scroll
}
else drawy = gui_h - 48

startdrawy = drawy

draw_set_color(c_white)

var _any = false

for (var i = 0; i < array_length(_items); i++) {
    var _opt = _items[i]
	
    if !(is_struct(_opt) && _opt.visible) continue
	
	if current_frame < last_change + i {
		_opt.anim = 1
		continue
	}
	else if current_frame == last_change + i {
		var _v = 0.75 + (1 - i / item_count) * 0.5,
			_gain = UberCont.opt_sndvol
		
		audio_play_sound(sndAppear, 0, false, _gain, 0, _v)
	}
	
    draw_align(_opt.halign, _opt.valign)
	
	var _w = _opt.width * 0.5,
		_h = _opt.height
	
	if is_touch() {
		_h *= 0.5
		
		if _opt.type != "category" {
			_h += 3
		}
	}
	else _h *= 0.4
	
	var _pointed = false,
		_should_draw = true
	
	if ((drawy - _h * 0.5) < LETTERBOX_SIZE
		|| (drawy + _h * 0.5) > (gui_h - LETTERBOX_SIZE)
	) {
		_should_draw = false
	}
	else {
		if _opt.splat > 0 {
			draw_sprite(sprMainMenuSplat, _opt.splat, drawx, drawy)
		}
		
		if _opt.draw && method_execute(_opt.draw, _opt) {
			_should_draw = false
		}
	}
	
	if _opt.condition != undefined {
		_opt.available = method_execute(_opt.condition, _opt)
	}
	
	if mouse_active {
		_pointed = (!dragging && (scroll_speed == 0 || scroll == scroll_max || scroll == scroll_min))
				&& point_in_rectangle(_mx, _my, drawx - _w, drawy - _h, drawx + _w + (_opt.type == "slider" ? 96 : 0), drawy + _h)
		
		if _should_draw && ((is_undefined(slider) && _pointed && _opt.available) || (slider == _opt)) {
			_any = true
			
			if pointed_item != i {
				snd_play(sndHover)
				pointed_item = i
			}
			
			_opt.anim = max(1, _opt.anim)
		}
		
		option_selected = (pointed_item == i)
		
		if slider == undefined {
			if _opt.type == "slider" && _pointed && mouse_ui_clicked() {
				option_selected = true
			}
		}
		else {
			option_selected = (_opt == slider)
		}
	}
	else {
		option_selected = (pointed_item == i)
		
		if option_selected {
			_pointed = true
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
	
	if (_should_draw) drawy -= _opt.anim
	
	draw_set_color(_opt.available ? c_uigray : c_uidark)
	
	if !option_selected {
		if (_opt.splat > 0) _opt.splat --
	}
	else if _should_draw {
		draw_set_color(c_white)
		
		_opt.splat = approach(_opt.splat, sprite_get_number(sprMainMenuSplat) - 1, timescale)
		
		if _opt.type == "slider" && mouse_check_button_pressed(mb_left) {
			if slider == undefined {
				slider = _opt
				slider_x = drawx
				snd_play(sndSlider)
			}
		}
		else if _opt.available && (_press || slider_change) && !wait {
			var _result = undefined
			
			if is_method(_opt.click) {
				_result = method_execute(_opt.click, _opt)
			}
			
			if is_undefined(_result) {
				_result = method_execute(element_functions[$ _opt.type], _opt)
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
			else if !slider_change {
				snd_play(sndClick)
			}
		}
	}
	
	if _should_draw {
		if !is_undefined(_opt.sprite) {
			var _sprite_info = _opt.sprite, _sprite, _image;
			
			if (is_array(_sprite_info)) {
				_sprite = _sprite_info[0]
				_image = _sprite_info[1]
			}
			else if (sprite_exists(_sprite_info)) {
				_sprite = _sprite_info
				_image = 0
			}
			else continue
			
			var _name = scrMenuButtonName(_sprite, _image)
			
			if is_undefined(_name) {
				var _ox = sprite_get_xoffset(_sprite),
					_oy = sprite_get_yoffset(_sprite)
				
				if (draw_get_halign() == fa_center) {
					sprite_set_offset(_sprite,
						sprite_get_width(_sprite) div 2,
						sprite_get_yoffset(_sprite))
				}
				
				if (draw_get_valign() == fa_middle) {
					sprite_set_offset(_sprite,
						sprite_get_xoffset(_sprite),
						sprite_get_height(_sprite) div 2)
				}
				
				draw_sprite_ext(_sprite, _image, drawx + 1, drawy + 1, 1, 1, 0, c_black, 1)
				draw_sprite_ext(_sprite, _image, drawx + 1, drawy + 0, 1, 1, 0, c_black, 1)
				draw_sprite_ext(_sprite, _image, drawx + 0, drawy + 1, 1, 1, 0, c_black, 1)
				draw_sprite_ext(_sprite, _image, drawx, drawy, 1, 1, 0, draw_get_color(), 1)
				
				sprite_set_offset(_sprite, _ox, _oy)
			}
			else {
				draw_text_bigname(drawx, drawy, _name)
			}
		}
		else {
			var _has_value = is_struct(_opt) && _opt.has_value(), _name;
			
			if is_callable(_opt.get_name) {
				_name = method_execute(_opt.get_name, _opt)
			}
			else _name = _opt.name
			
			if _has_value {
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
				
				if is_method(_opt.get_value) {
					_value = method_execute(_opt.get_value, _opt)
				}
				
				if !is_undefined(_value) {
					if _opt.type == "slider" {
						_value = string(round(_value * 100)) + "%"
						
						var _slider_x = drawx - 6,
							_slider_y = drawy - 4,
							wdefault = sprite_get_width(sprOptionSlider) - 10,
							h = sprite_get_height(sprOptionSlider),
							w = wdefault * _opt.value
						
						draw_set_color(c_white)
						
						draw_sprite(sprOptionSlider, 0, _slider_x, _slider_y)
						draw_sprite_part(sprOptionSlider, 1, 4, 0, w + 5, h + 1, _slider_x, _slider_y - 5)
						draw_sprite(sprSliderEnd, 0, _slider_x + w + 4, _slider_y + 2)
						
						if (slider == _opt) slider_x = _slider_x
					}
					else if _opt.type == "list" {
						if _opt.list_kind == "numeric" && is_numeric(_value) {
							_value = string(_value) + "/" + string(option_list_max)
						}
						else _value = "< " + string(_value) + " >"
					}
					else if _opt.type == "switch" {
						if is_numeric(_value) && _value < 2 {
							_value = _opt.states[(_value ? 1 : 0)]
						}
					}
					else if _opt.type == "keybind" {
						if await_input && await_keybind == _opt {
							_value = "@g" + loc("PRESS ANY#BUTTON")
							
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
			else if _opt.type == "category" && category == OptionCategory.Main {
				draw_text_bigname(drawx, drawy, loc(_name))
				drawy += 2
			}
			else draw_text_nt(drawx, drawy, loc(_name))
		}
		
		method_execute(element_functions[$ _opt.type + "_draw"], _opt)
	}
	
	drawy += (_should_draw ? _opt.anim : 0) + max(_opt.height, draw_step_size)
	
	if (_opt.anim > 0) _opt.anim --
}

draw_set_valign(fa_top)

if slider != undefined {
	var _width = sprite_get_width(sprSlider) - 10
	
	if _mx > 0 {
		if _mx != slider_x {
			slider_change = 1
		}
		
		slider.value = clamp(1 - (_width - (_mx - slider_x)) / _width, 0, 1)
	}
	
	if !mouse_check_button(mb_left) {
		slider_change = 2
	}
}

if (!_any) {
	if (_has_scrollbar && is_touch()
		&& !dragging && (dragging == -1 || (_press && abs(_mx - drawx) > 60))
	) {
		if (mouse_check_button(mb_left)) {
			scroll_speed = clamp((_my - my_last) * -1, -10, 10)
			
			if (dragging != -1) {
				snd_play(sndSlider)
				dragging = -1
			}
		}
		else if (dragging == -1) {
			dragging = false
		}
	}
	
	pointed_item = -1
}

draw_set_color(c_white)

draw_set_halign(fa_left)
draw_set_valign(fa_top)

if (!mouse_check_button(mb_left)) wait = false

back_pressed = false

mx_last = _mx
my_last = _my