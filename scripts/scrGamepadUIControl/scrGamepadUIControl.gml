function scrGamepadUIControl() {
    gamepad_h = KeyCont.press_east[global.index] - KeyCont.press_west[global.index]
	gamepad_v = KeyCont.press_sout[global.index] - KeyCont.press_nort[global.index]
	
	if (gamepad_h == 0 && gamepad_v == 0) exit
	
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
	
	var count = instance_number(PauseButton)
	if ((count > 2 && gamepad_h != 0) || gamepad_v != 0) {
		var button = noone
		
		if gamepad_h != 0 && count > 2 {
			gamepad_sel += gamepad_h * 2
		}
		else if gamepad_v != 0 {
			gamepad_sel += gamepad_v
		}
		
		if (gamepad_sel < 0) gamepad_sel = count - 1
		if (gamepad_sel >= count) gamepad_sel = 0
		
		button = instance_find(PauseButton, gamepad_sel)
		
		print("Selection", gamepad_sel)
		
		with PauseButton {
			if id == button {
				if !hover {
					snd_play(sndHover)
					hover = true
				}
			}
			else if hover {
				hover = false
			}
		}
	}
	
	with PauseButton {
		if hover && gamepad_button_check_pressed(0, gp_face1) {
			event_user(0)
		}
	}
}

function scrGamepadUIConrolMainMenu(object) {
	if !instance_exists(object)
		return 0
	
	var count = instance_number(object)
	
	gamepad_sel += gamepad_v

    if gamepad_sel < 0 || gamepad_sel >= count {
        gamepad_sel = gamepad_v ? 0 : (count - 1)
    }
	
    var button = instance_find(object, gamepad_sel)
	
    if instance_exists(button) {
        with object {
			if button != id {
				hover = 0
				
				continue
			}
			
			if !hover {
				snd_play(sndHover)
	            hover = 1
			}
			
            if gamepad_button_check_pressed(0, gp_face1)
				event_user(0)
        }
    }
	
	return 1
}

function scrGamepadUIConrolCharSelect(object) {
	if (!instance_exists(object)) return 0
	
	gamepad_sel += gamepad_h

    if gamepad_sel < 0 || gamepad_sel >= instance_number(object) {
        gamepad_sel = gamepad_h ? 0 : (instance_number(object) - 1)
    }

    var button = instance_find(object, gamepad_sel)

    if instance_exists(button) {
        if gamepad_h != 0 {
            with object {
                if !selected && id == button {
                    event_perform(ev_mouse, ev_left_press)
                }
            }
        }

		with (Menu) if (loadout_open) {
			return true
		}
		
        with object {
            if gamepad_button_check_pressed(0, gp_face1) && selected
                event_perform(ev_mouse, ev_left_press)
        }
    }
	
	return 1
}

function scrGamepadUIConrolSkillIcon(object) {
	if !instance_exists(object)
		return 0
	
	var any = 0
	
	with object {
		if selected {
			any = true; break
		}
	}
	
	if any {
		gamepad_sel += gamepad_h
	}
	else gamepad_sel = 0
	
    if gamepad_sel < 0 or gamepad_sel >= instance_number(object) {
		if UberCont.opt_griller && instance_exists(SkillIcon) {
			with LevCont
				grillpadchange = other.gamepad_h
		}
		else gamepad_sel = gamepad_h ? 0 : (instance_number(object) - 1)
    }
	
    var button = instance_find(object, gamepad_sel)
	
    if instance_exists(button) {
        if gamepad_h != 0 {
            with button {
	            if !selected {
	                event_perform(ev_mouse, ev_left_press)
					snd_play(sndHover)
				}
			}
        }

        with button {
            if gamepad_button_check_pressed(0, gp_face1) {
                event_perform(ev_mouse, ev_left_press)
            }
        }
    }
	
	return 1
}