function scrGamepadUIControl() {
	var _index = global.index
	
	directional_ui_click = false
	
	if (is_gamepad()) {
		directional_ui_click = input_gamepad_check_pressed(0, gp_face1)
	}
	else if (is_keyboard()) {
		directional_ui_click = keyboard_check_pressed(vk_enter)
		if (!instance_exists(Menu) && keyboard_check_pressed(vk_space)) {
			directional_ui_click = true
		}
	}
	
    directional_ui_h = KeyCont.press_east[_index] - KeyCont.press_west[_index]
	directional_ui_v = KeyCont.press_sout[_index] - KeyCont.press_nort[_index]
	
	if (is_keyboard(_index)) {
		if (!(window_mouse_get_delta_x() == 0 && window_mouse_get_delta_y() == 0)) {
			directional_ui_control = false
		}
		if (!(directional_ui_h == 0 && directional_ui_v == 0) || directional_ui_click) {
			directional_ui_control = true
		}
	}
	else if (is_gamepad(_index)) directional_ui_control = true
	
	if (!(is_gamepad(_index) || is_keyboard(_index))) exit
	
	if (scrGamepadUIConrolMainMenu(MainMenuButton)) exit
	if (scrGamepadUIConrolMainMenu(PlayButton)) exit
	
	if (scrGamepadUIConrolCharSelect(CharSelect)) exit
	if (scrGamepadUIConrolCharSelect(StatChar)) exit
	
	if (scrGamepadUIConrolSkillIcon(SkillIcon)) exit
	if (scrGamepadUIConrolSkillIcon(CrownIcon)) exit
	if (scrGamepadUIConrolSkillIcon(UltraIcon)) exit
	
	if (!instance_exists(PauseButton)) {
		gamepad_ui_selection = 0
		exit
	}
	
	var _count = instance_number(PauseButton)
	
	if ((_count > 2 && directional_ui_h != 0) || directional_ui_v != 0) {
		var _button = noone
		
		if (directional_ui_h != 0 && _count > 2) {
			gamepad_ui_selection += directional_ui_h * 2
		}
		else if (directional_ui_v != 0) {
			gamepad_ui_selection += directional_ui_v
		}
		
		if (gamepad_ui_selection < 0) gamepad_ui_selection = _count - 1
		if (gamepad_ui_selection >= _count) gamepad_ui_selection = 0
		
		_button = instance_find(PauseButton, gamepad_ui_selection)
		
		with (PauseButton) {
			if (id == _button) {
				if (!hover) {
					snd_play(sndHover)
					hover = true
				}
			}
			else if (hover) hover = false
		}
	}
	
	if (directional_ui_click) {
		with (PauseButton) if (hover) {
			event_user(0)
		}
	}
}

function scrGamepadUIConrolMainMenu(_object) {
	if (!instance_exists(_object)) return false
	
	var _count = instance_number(_object), _move = false;
	
	if (directional_ui_v != 0) {
		var _any = false
		
		with (_object) {
			if (hover) {
				_any = true
				break
			}
		}
		
		gamepad_ui_selection += directional_ui_v
		
		if (!_any) {
			gamepad_ui_selection = (directional_ui_v ? infinity : -infinity)
			
			for(var i = 0; i < instance_number(_object); ++i) {
				var _button = instance_find(_object, i)
				if (!instance_exists(_button)) continue
				
				if (_button.object_index == ButtonDiscord
					|| _button.object_index == ButtonAchievements
				) {
					continue
				}
				
				if (directional_ui_v) {
					if (i < gamepad_ui_selection) gamepad_ui_selection = i
				}
				else {
					if (i > gamepad_ui_selection) gamepad_ui_selection = i
				}
			}
			
			if (is_infinity(gamepad_ui_selection)) gamepad_ui_selection = 0
		}
	    else if (gamepad_ui_selection < 0 || gamepad_ui_selection >= _count) {
	        gamepad_ui_selection = directional_ui_v ? 0 : (_count - 1)
	    }
		
		_move = true
	}
	
    var _button = instance_find(_object, gamepad_ui_selection)
	
    if (instance_exists(_button)) {
        with (_object) {
			if (_move) {
				if (_button != id) {
					hover = false
					continue
				}
				
				if (!hover) {
					snd_play(sndHover)
		            hover = true
				}
			}
        }
		
		if (directional_ui_click) {
			with (_button) event_user(0)
        }
    }
	
	return true
}

function scrGamepadUIConrolCharSelect(_object) {
	if (!instance_exists(_object)) return false
	
	if (directional_ui_h != 0) {
		gamepad_ui_selection += directional_ui_h
		
	    if (gamepad_ui_selection < 0 || gamepad_ui_selection >= instance_number(_object)) {
	        gamepad_ui_selection = directional_ui_h ? 0 : (instance_number(_object) - 1)
	    }
	}

    var _button = instance_find(_object, gamepad_ui_selection)

    if (instance_exists(_button)) {
        if (directional_ui_h != 0) {
            with (_object) {
                if (!selected && id == _button) {
                    event_perform(ev_mouse, ev_left_press)
                }
            }
        }

		with (Menu) if (loadout_open) {
			return true
		}
		
        if (directional_ui_click) {
			with (_button) event_perform(ev_mouse, ev_left_press)
        }
    }
	
	return true
}

function scrGamepadUIConrolSkillIcon(_object) {
	if (!instance_exists(_object)) return false
	
	if (directional_ui_h != 0) {
		var _any = false
		
		with (_object) {
			if (selected) {
				_any = true
				break
			}
		}
		
		if (_any) {
			gamepad_ui_selection += directional_ui_h
		}
		else {
			gamepad_ui_selection = 0
		}
	}
	
    if (gamepad_ui_selection < 0 || gamepad_ui_selection >= instance_number(_object)) {
		if (UberCont.opt_griller && instance_exists(SkillIcon)) {
			with (LevCont) {
				grillpadchange = other.directional_ui_h
			}
		}
		else {
			gamepad_ui_selection = directional_ui_h ? 0 : (instance_number(_object) - 1)
		}
	}
	
    var _button = instance_find(_object, gamepad_ui_selection)
	
    if (instance_exists(_button)) {
        if (directional_ui_h != 0) {
            with (_button) {
	            if (!selected) {
	                event_perform(ev_mouse, ev_left_press)
					snd_play(sndHover)
				}
			}
		}
		
		if (directional_ui_click) {
			with (_button) event_perform(ev_mouse, ev_left_press)
        }
    }
	
	return true
}