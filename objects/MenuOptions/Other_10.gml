/// @description Render & logic

draw_set_valign(fa_middle)
draw_set_halign(fa_center)

if category == OptionCategory.Language {
	draw_set_font(fntM1)
}
else {
	draw_reset_font()
}

if mouse_check_button(mb_left) or is_desktop {
	mousex = device_mouse_x_to_gui(0)
	mousey = device_mouse_y_to_gui(0)
}
else {
	mousex = -1000
	mousey = -1000
}

var _current_category = category,
	_mx = mousex,
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
			if (is_numeric(_opt[$ "keyboard_type"])) {
				scrShowVirtualKeyboard(_opt.keyboard_type)
			}
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
	
	var _last_font = -1
	if (_opt.key == "etc_name") {
		_last_font = draw_get_font()
		
		if (!font_exists(global.language_font_cjk)) {
			scrLanguageTryLoadTTFs()
		}
		
		if (font_exists(global.language_font_cjk)) {
			draw_set_font(global.language_font_cjk)
		}
		else {
			draw_set_font(fntConsole)
		}
	}
	
	draw_text_nt(drawx, drawy, loc(string(_value)) + text_input_cursor)
	
	if (_last_font != -1) draw_set_font(_last_font)
	
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
	
	if scr_keyboard_check_pressed(vk_enter) || back_pressed {
		if (!is_desktop) keyboard_virtual_hide()
		
		if !method_execute(_opt.validate, _opt, _opt.value, true) {
			if option_can_change {
				UberCont.saveData[? _opt.key] = _opt.value
				scrOptionsUpdate()
			}
		}
		else _opt.value = _opt.previous
		
		if (_last_font != draw_get_font()) event_user(10)
		
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

if resourcepack_disclaimer {
	if (back_pressed) resourcepack_disclaimer = false
	
	draw_align(fa_center, fa_middle)
	
	_mx = device_mouse_x_to_gui(0)
	_my = device_mouse_y_to_gui(0)
	
	var _dx = gui_w div 2,
		_dy = gui_h div 2,
		_height = font_get_string_height(resourcepack_disclaimer_message),
		//_scale = (_height >= view_height - (LETTERBOX_SIZE * 3)) ? 0.85 : 1,
		_scale = resourcepack_disclaimer_scale,
		_line_height = font_get_string_height("A")
	
    // resourcepack warning
    draw_text_nt(_dx, _dy + disclaimer_pop - 10, resourcepack_disclaimer_message, _scale)
	
	var _button_y = min(gui_h - LETTERBOX_SIZE + _line_height div 2,
			_dy - disclaimer_pop + (_height div 2) * _scale + _line_height)
	
	if (resourcepack_disclaimer < 90) {
		/// @loc:note [ResourcepackOptions] Delay before the user is able to proceed to resourcepack options
		/// @loc:token [ResourcepackOptions] DisclaimerProceedWait "@sPROCEED (%)"
		var _delay = ceil((90 - resourcepack_disclaimer) / 30)
        draw_text_nt(_dx, _button_y, loc_fmt("ResourcepackOptions:DisclaimerProceedWait", "@sPROCEED (% SEC.)", _delay))
    }
	else {
		/// @loc:token [ResourcepackOptions] DisclaimerProceed "@yPROCEED"
		draw_text_nt(_dx, _button_y, loc("ResourcepackOptions", "DisclaimerProceed", "@yPROCEED"))
	}
	
    if (resourcepack_disclaimer < 90) resourcepack_disclaimer ++
	
    if mouse_ui_clicked() && resourcepack_disclaimer >= 90 && point_in_circle(_mx, _my, _dx, _button_y, 16) {
        save_set_value("etc", "resourcepack_disclaimer", true)
		last_change = current_frame + 3
        resourcepack_disclaimer = 0
        snd_play(sndMutant0Cnfm)
		scrSave()
    }
	
	draw_align()
	
	if (disclaimer_pop > 0) {
		disclaimer_pop -= timescale
	}
    exit
}

if erasing_progress {
	// 1 - reset SAVEFILE
	// 2 - reset OPTIONS
	
	_mx = device_mouse_x_to_gui(0)
	_my = device_mouse_y_to_gui(0)
	
    if (self[$ "funnysound"] != undefined || alarm[1] > 0) {
        with MusCont {
            if (alarm[0] < 5) alarm[0] = 5
        }

        draw_set_color(c_black)
        draw_rectangle(0, 0, view_width, view_height, 0)
        draw_set_color(c_white)
		
        if (alarm[1] > 0) exit
    }
	
	draw_align(fa_center, fa_middle)
    draw_set_color(c_ltgray)
	
    draw_text_nt(gui_w div 2, 8, erasing_progress == 2
		? loc("DataOptions:OptionsReset", "RESET OPTIONS")
		: loc("DataOptions:ProgressReset", "ERASE PROGRESS"))

    var _dx = gui_w div 2,
        _dy = LETTERBOX_SIZE + disclaimer_pop + 56

    if erasing_progress == 1 && press > 2 {
        _dx += orandom(press - 2)
        _dy += orandom(press - 2)
    }

    var _option_offset = 48, _disclaimer_height = 0;

    if erasing_progress == 2 {
		var _msg = "@wWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET#ALL OF YOUR PREFERENCES.###ARE YOU SURE?@w",
			/// @loc:token [DataOptions] OptionsResetDisclaimer "@wWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET#ALL OF YOUR PREFERENCES.###ARE YOU SURE?@w"
			_string = loc("DataOptions:OptionsResetDisclaimer", _msg)
        
		_disclaimer_height = font_get_string_height(_string)
		draw_text_nt(_dx, _dy, _string)
    }
	else {
		var _msg = "@rWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET ALL OF YOUR#CHARACTERS, UNLOCKS, STATS, ACHIEVEMENTS AND#IT IS NOT UNDOABLE.###ARE YOU SURE?@w",
			/// @loc:token [DataOptions] ProgressResetDisclaimer "@rWARNING!!!##@sTHIS ACTION WILL COMPLETELY RESET ALL OF YOUR#CHARACTERS, UNLOCKS, STATS, ACHIEVEMENTS AND#IT IS NOT UNDOABLE.###ARE YOU SURE?@w"
			_string = loc("DataOptions:ProgressResetDisclaimer", _msg)
		
		_disclaimer_height = font_get_string_height(_string)
		draw_text_nt(_dx, _dy, _string)
	}
	
	var _option_x = gui_w div 2,
		
		_option_yes_y = _dy + _disclaimer_height + _option_offset,
		_option_no_y = _option_yes_y + 16,
		
		_erasure_progress = (erasing_progress == 1 ? " (" + string(5 - press) + ")" : "")
	
	/// @loc:token [Options] Yes "YES"
    draw_text_nt(_option_x, _option_yes_y, (wait ? "@d" : "@w") + loc("Options:Yes", "YES") + _erasure_progress)
	/// @loc:token [Options] No "NO"
    draw_text_nt(_option_x, _option_no_y, (wait ? "@d" : "@w") + loc("Options:No", "NO"))

    if (press >= 5 || (erasing_progress == 2 && press > 0)) {
        if (erasing_progress == 1) {
			instance_destroy(BackButton)
			
			if (alarm[1] == -1) alarm[1] = 60
			
			if (self[$ "funnysound"] != undefined) {
                audio_stop_sound(self[$ "funnysound"])
                self[$ "funnysound"] = undefined
            }
			
            audio_stop_all()
        }
		else if erasing_progress == 2 {
			scrOptionsEraseSettings()
        }
    }
	else {
        if (!wait && (mouse_ui_clicked() || back_pressed)) {
			// No
            if point_in_circle(_mx, _my, _option_x, _option_no_y, 14) || back_pressed {
                snd_play(sndClickBack)
				
                if (self[$ "funnysound"] != undefined) {
                    with (SpiralCont) visible = true
					
                    background_set_colour(c_black)
					
                    with MusCont {
                        audio_resume_sound(song)
                        audio_resume_sound(amb)
                    }
					
                    audio_stop_sound(self[$ "funnysound"])
                    self[$ "funnysound"] = undefined
                }
				
                erasing_progress = 0
                press = 0
            }
			// Yes
			else if point_in_circle(_mx, _my, _option_x, _option_yes_y, 14) {
                snd_play(sndClick)
				
                wait = 30
				disclaimer_pop = 1
                press ++
				
                if erasing_progress == 1 && press == 3 {
                    with (SpiralCont) visible = false
					
					with (MusCont) {
                        audio_pause_sound(song)
                        audio_pause_sound(amb)
                    }
					
                    self[$ "funnysound"] = audio_play_sound(sndBecomeNothingIdle, 1000, true, 1, 0, 0.5)
                    audio_sound_pitch(self[$ "funnysound"], 0.5)
                }
            }
        }

        if wait > 0 {
			wait --
		}
    }
	
	if disclaimer_pop && !wait {
		disclaimer_pop --
	}

    draw_align()

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

var _press = mouse_ui_clicked()
		|| (UberCont.opt_gamepad && gamepad_button_check_pressed(0, gp_face1))
		|| (UberCont.opt_keyboard && scr_keyboard_check_pressed(vk_enter)),
	
	yoff = 6 * (_current_category != 0),
	_has_scrollbar = false,
	_items = items

if (scr_keyboard_check_held(vk_alt) || wait) _press = false

if _mx != mx_last || _my != my_last || mouse_check_button_pressed(mb_any) {
	mouse_active = true
}

var kv = KeyCont.press_sout[global.index] - KeyCont.press_nort[global.index],
	kh = KeyCont.press_east[global.index] - KeyCont.press_west[global.index]

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
drawy = font_get_height_diff()

for(var i = 0; i < item_count; i ++) {
	var _opt = _items[i]
	if is_struct(_opt) && _opt.visible {
		drawy += max(_opt.height, draw_step_size)
	}
}

var _custom_mode_menu_called = false

if (instance_exists(CustomModeMenu)) {
	with (CustomModeMenu) {
		if (other.scroll_check) {
			event_user(0)
		}
		other.scroll_max = max(0, (height - (gui_h div 2) - LETTERBOX_SIZE) div 2)
	}
	scroll_min = -scroll_max
	_has_scrollbar = true
}
else if (drawy > (gui_h - (LETTERBOX_SIZE * 2) + 5)) {
	scroll_max = (drawy - (gui_h - (LETTERBOX_SIZE * 2))) div 2
	scroll_min = -scroll_max
	_has_scrollbar = true
}

if (scroll_check) {
	if (_has_scrollbar) {
		scroll = scroll_min
		scroll_speed = 0
	}
	else {
		scroll = 0
		scroll_min = 0
		scroll_max = 0
	}
	scroll_speed = 0
	scroll_check = false
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
	drawy = gui_h * 0.5 - drawy * 0.5 + 8 - floor(scroll) + font_get_height_diff()
}
else {
	drawy = gui_h - LETTERBOX_SIZE - 14 * item_count
}

startdrawy = drawy

draw_set_color(c_white)

var _any = false

if (instance_exists(CustomModeMenu)) {
	with (CustomModeMenu) {
		scroll = other.scroll - other.scroll_min
		dragging = other.dragging
		event_user(0)
		_any = free_touch
	}
}
else for (var i = 0; i < array_length(_items); i++) {
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
		_should_draw = true,
		_in_vision = true
	
	if (drawy < LETTERBOX_SIZE || drawy > (gui_h - LETTERBOX_SIZE)) {
		_in_vision = false
		
		if (drawy < 0 || drawy >= gui_h) {
			_should_draw = false
		}
	}
	else if _opt.splat > 0 {
		var _splat_x = drawx - ((is_method(_opt.get_value) && method_execute(_opt.get_value, _opt) == "") ? 60 : 0)
		draw_sprite(sprMainMenuSplat, _opt.splat, _splat_x, drawy)
	}
	
	var _tangible = _in_vision
	
	if _opt.condition != undefined {
		_opt.available = method_execute(_opt.condition, _opt)
	}
	
	if mouse_active {
		_pointed = (!dragging && (scroll_speed == 0 || scroll == scroll_max || scroll == scroll_min))
				&& point_in_rectangle(_mx, _my, drawx - _w, drawy - _h, drawx + _w + (_opt.type == "slider" ? 96 : 0), drawy + _h)
		
		if _tangible && ((is_undefined(slider) && _pointed && _opt.available) || (slider == _opt)) {
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
				
			if _opt.type == "slider" && kh != 0 {
				slider_change = 2
				slider = _opt
				
				var _max = 1, _step = kh * 0.1;
				
				if (_opt.key == "visual_screenshake") {
					_max = 2
				}
				
				_opt.value = clamp(_opt.value + _step, 0, _max)
			}
			
			if (_has_scrollbar) {
				var _top = LETTERBOX_SIZE * 2 + 5,
					_bottom = gui_h - LETTERBOX_SIZE * 2 + 5,
					_spd = abs(scroll_max) * 0.5
				
				/**/ if (drawy > _bottom) scroll = approach(scroll, scroll_max, _spd)
				else if (drawy < _top) scroll = approach(scroll, scroll_min, _spd)
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
	
	if (_current_category == OptionCategory.Main) {
		draw_set_color(_opt.available ? c_uigray : c_uidark)
	}
	else {
		draw_set_color(_opt.available ? c_menugray : c_menudark)
	}
	
	if (!option_selected) {
		if (_opt.splat > 0) _opt.splat --
	}
	else if (_tangible) {
		draw_set_color(c_white)
		
		_opt.splat = approach(_opt.splat, sprite_get_number(sprMainMenuSplat) - 1, timescale)
		
		if _opt.type == "slider" && mouse_check_button_pressed(mb_left) {
			if slider == undefined {
				slider = _opt
				slider_x = drawx
				snd_play(sndSlider)
			}
		}
		else if (_opt.available && (_press || slider_change) && !wait) {
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
	
	if (_should_draw && is_method(_opt.draw) && method_execute(_opt.draw, _opt)) {
		_should_draw = false
	}
	
	if (_should_draw) {
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
				
				var _size = _current_category == OptionCategory.Controls_Preferences ? 60 : 32
				
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
					if (_opt.type == "slider") {
						if (_opt.scalar_slider) {
							_value = string(round(_value * 100)) + "%"
						}
						
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
			else if _opt.type == "category" && _current_category == OptionCategory.Main {
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
	if (_has_scrollbar //&& is_touch()
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