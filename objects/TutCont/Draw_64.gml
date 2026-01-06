if lockstep_stop
	exit

if (step_current >= TutorialStep.NUM_TUTORIAL_STEPS || instance_exists(Spiral)) exit

if (instance_exists(TopCont)) depth = TopCont.depth - 1

if (!instance_exists(Portal)) {
    draw_set_color(c_black)
    draw_rectangle(0, view_height, view_width, view_height - LETTERBOX_SIZE, 0)
    draw_set_color(c_white)

    draw_align(fa_center, fa_middle)
	
	var _strings = text[step_current],
		_key = "Tutorial:Touch",
		_input_index = 0,
		_string;
	
	if is_keyboard(global.index) {
		_key = "Tutorial:Default"
		_input_index = 1
	}
	else if is_gamepad(global.index) {
		_key = "Tutorial:Gamepad"
		_input_index = 2
	}
	
	if (_input_index >= array_length(_strings)) {
		_input_index = array_length(_strings) - 1
	}
	
	if (step_current < TutorialStep.NUM_TUTORIAL_STEPS) {
		_string = loc(_key, step_current, _strings[_input_index])
	}
	
	var _keys = [ "move", "pick", "fire", "swap", "spec" ]
	
	if (_input_index == 1) {
		if step_current == TutorialStep.Walking {
			_string = loc_fmt($"{_key}:{step_current}", _strings[_input_index],
				scrKeyName(Key.north[0]), scrKeyName(Key.west[0]), scrKeyName(Key.south[0]), scrKeyName(Key.east[0]))
		}
		else if step_current < TutorialStep.Fin {
			var _key_code = keymap_get(_keys[step_current - 1]),
				_key_name = scrKeyName(_key_code)
			
			_string = loc_fmt($"{_key}:{step_current}", _string, _key_name)
		}
	}
	else if (_input_index == 2) {
		var _key_code = keymap_get(_keys[step_current - 1])
		
		if (step_current == TutorialStep.Walking) {
			_string = string_replace_all(_string, "@1(butsmall:move)", gamepad_key_to_nt_text(gp_stickl, false))
		}
		else if (step_current == TutorialStep.PickingUp) {
			_string = string_replace_all(_string, "@1(butsmall:pick)", gamepad_key_to_nt_text(_key_code, false))
		}
		else if (step_current == TutorialStep.Shooting) {
			_string = string_replace_all(_string, "@1(butsmall:fire)", gamepad_key_to_nt_text(_key_code, false))
			_string = string_replace_all(_string, "@1(butsmall:aim)", gamepad_key_to_nt_text(gp_stickr, false))
		}
		else if (step_current == TutorialStep.Swapping) {
			_string = string_replace_all(_string, "@1(butsmall:swap)", gamepad_key_to_nt_text(_key_code, false))
		}
		else if (step_current == TutorialStep.Power) {
			_string = string_replace_all(_string, "@1(butsmall:spec)", gamepad_key_to_nt_text(_key_code, false))
		}
	}
	
	draw_text_nt(view_width / 2, view_height - 18, "@s" + string(_string))
	
    draw_align()
}

draw_set_color(c_lime)

if (is_touch()) {
	var _poi = noone
	
	switch step_current {
		case TutorialStep.Walking: _poi = JoystickMove break
		
        case TutorialStep.PickingUp:
			with ButtonAct {
				if (alpha > 0) _poi = ButtonAct
			}
			break
        
        case TutorialStep.Swapping: _poi = ButtonSwap break
		case TutorialStep.Power: _poi = ButtonActive break
    }
	
	var w = sin(wave) * 4
	
	if instance_exists(_poi) {
		if circle_active {
			drawx = lerp(drawx, _poi.x, 0.4)
			drawy = lerp(drawy, _poi.y, 0.4)
		}
		else {
			drawx = _poi.x
			drawy = _poi.y
		}
		
		draw_circle_part(drawx, drawy, _poi.rad * 1.25 + w, 2, 1)
		
		circle_active = true
	}
	else if step_current == TutorialStep.PickingUp {
		draw_set_color(c_red)
		
		with WepPickup {
			other.drawx = lerp(other.drawx, x - view_xview, 0.4)
			other.drawy = lerp(other.drawy, y - view_yview, 0.4)
		}
		
		with WeaponChest {
			other.drawx = lerp(other.drawx, x - view_xview, 0.4)
			other.drawy = lerp(other.drawy, y - view_yview, 0.4)
		}
		
		draw_circle_part(drawx, drawy, 16 + w, 1, 1)
	}
}

wave += 0.1

if (wave > 6.2) wave = 0

draw_set_color(c_white)