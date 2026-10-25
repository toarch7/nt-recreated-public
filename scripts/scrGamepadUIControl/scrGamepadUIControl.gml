function scrGamepadUIControl() {
    gamepad_h = KeyCont.press_east[global.index] - KeyCont.press_west[global.index]
	gamepad_v = KeyCont.press_sout[global.index] - KeyCont.press_nort[global.index]
	
	if (scrGamepadUIConrolMainMenu(MainMenuButton)) exit
	if (scrGamepadUIConrolMainMenu(PlayButton)) exit
	
	if (scrGamepadUIConrolCharSelect(CharSelect)) exit
	if (scrGamepadUIConrolCharSelect(StatChar)) exit
	
	if (scrGamepadUIConrolSkillIcon(SkillIcon)) exit
	if (scrGamepadUIConrolSkillIcon(CrownIcon)) exit
	if (scrGamepadUIConrolSkillIcon(UltraIcon)) exit
	
	if (!instance_exists(PauseButton)) {
		gamepad_sel = 0
		exit
	}
	
	var _count = instance_number(PauseButton)
	
	if ((_count > 2 && gamepad_h != 0) || gamepad_v != 0) {
		var _button = noone
		
		if gamepad_h != 0 && _count > 2 {
			gamepad_sel += gamepad_h * 2
		}
		else if gamepad_v != 0 {
			gamepad_sel += gamepad_v
		}
		
		if (gamepad_sel < 0) gamepad_sel = _count - 1
		if (gamepad_sel >= _count) gamepad_sel = 0
		
		_button = instance_find(PauseButton, gamepad_sel)
		
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
	
	with (PauseButton) {
		if (hover && input_gamepad_check_pressed(0, gp_face1)) {
			event_user(0)
		}
	}
}

function scrGamepadUIConrolMainMenu(_object) {
	if (!instance_exists(_object)) return false
	
	var _count = instance_number(_object)
	
	gamepad_sel += gamepad_v

    if (gamepad_sel < 0 || gamepad_sel >= _count) {
        gamepad_sel = gamepad_v ? 0 : (_count - 1)
    }
	
    var _button = instance_find(_object, gamepad_sel)
	
    if (instance_exists(_button)) {
        with (_object) {
			if (_button != id) {
				hover = false
				continue
			}
			
			if (!hover) {
				snd_play(sndHover)
	            hover = true
			}
			
            if (input_gamepad_check_pressed(0, gp_face1)) {
				event_user(0)
			}
        }
    }
	
	return true
}

function scrGamepadUIConrolCharSelect(_object) {
	if (!instance_exists(_object)) return false
	
	gamepad_sel += gamepad_h

    if (gamepad_sel < 0 || gamepad_sel >= instance_number(_object)) {
        gamepad_sel = gamepad_h ? 0 : (instance_number(_object) - 1)
    }

    var _button = instance_find(_object, gamepad_sel)

    if (instance_exists(_button)) {
        if (gamepad_h != 0) {
            with (_object) {
                if (!selected && id == _button) {
                    event_perform(ev_mouse, ev_left_press)
                }
            }
        }

		with (Menu) if (loadout_open) {
			return true
		}
		
        with (_object) {
            if (input_gamepad_check_pressed(0, gp_face1) && selected) {
                event_perform(ev_mouse, ev_left_press)
			}
        }
    }
	
	return true
}

function scrGamepadUIConrolSkillIcon(_object) {
	if (!instance_exists(_object)) return false
	
	var _any = false
	
	with (_object) {
		if (selected) {
			_any = true
			break
		}
	}
	
	if (_any) {
		gamepad_sel += gamepad_h
	}
	else {
		gamepad_sel = 0
	}
	
    if (gamepad_sel < 0 || gamepad_sel >= instance_number(_object)) {
		if (UberCont.opt_griller && instance_exists(SkillIcon)) {
			with (LevCont) {
				grillpadchange = other.gamepad_h
			}
		}
		else {
			gamepad_sel = gamepad_h ? 0 : (instance_number(_object) - 1)
		}
	}
	
    var _button = instance_find(_object, gamepad_sel)
	
    if (instance_exists(_button)) {
        if (gamepad_h != 0) {
            with (_button) {
	            if (!selected) {
	                event_perform(ev_mouse, ev_left_press)
					snd_play(sndHover)
				}
			}
        }

        with (_button) {
            if (input_gamepad_check_pressed(0, gp_face1)) {
				event_perform(ev_mouse, ev_left_press)
            }
        }
    }
	
	return true
}