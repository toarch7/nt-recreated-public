function scrGamepadUIControl() {
    gamepad_v = gamepad_button_check_pressed(0, gp_padd) - gamepad_button_check_pressed(0, gp_padu)
    gamepad_h = gamepad_button_check_pressed(0, gp_padr) - gamepad_button_check_pressed(0, gp_padl)
	
	if scrGamepadUIConrolMainMenu(MainMenuButton) exit
	if scrGamepadUIConrolMainMenu(PlayButton) exit
	
	if scrGamepadUIConrolCharSelect(CharSelect) exit
	if scrGamepadUIConrolCharSelect(StatChar) exit
	
	if scrGamepadUIConrolSkillIcon(SkillIcon) exit
	if scrGamepadUIConrolSkillIcon(CrownIcon) exit
	if scrGamepadUIConrolSkillIcon(UltraIcon) exit
	
	if instance_exists(PauseButton) {
		var v = gamepad_v,
			h = gamepad_h,
			
			count = instance_number(PauseButton),
			button = noone,
			sel = gamepad_sel
		
		if h != 0 && count > 2 {
			gamepad_sel += h * 2
		}
		else if v != 0
			gamepad_sel += v
		
		if gamepad_sel != sel {
			if gamepad_sel < 0
				gamepad_sel = count - 1
			
			if gamepad_sel >= count
				gamepad_sel = 0
			
			button = instance_find(PauseButton, gamepad_sel)
			
			with PauseButton {
				if id == button {
					if !hover {
						snd_play(sndHover)
						hover = 1
					}
				}
				else if hover
					hover = 0
			}
		}
		
		with PauseButton {
			if hover && gamepad_button_check_pressed(0, gp_face1)
				event_user(0)
		}
		
		exit
    }
	
	gamepad_sel = 0
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
	if !instance_exists(object)
		return 0
	
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

		if instance_exists(Menu) && Menu.loadout
			return 1
	
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
	
    if gamepad_sel < 0 || gamepad_sel >= instance_number(object) {
        gamepad_sel = gamepad_h ? 0 : (instance_number(object) - 1)
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