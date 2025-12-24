globalvar KeyCont;

KeyCont = {
	touch: [0, 0, 0, 0],
	gamepad: [0, 0, 0, 0],
	keyboard: [0, 0, 0, 0],
	
    aimassist: [0, 0, 0, 0],
    activeforever: [0, 0, 0, 0],
	precisemovement: [ 0, 0, 0, 0 ],
    moving: [0, 0, 0, 0],
	
    dir_move: [0, 0, 0, 0],
    dir_fire: [0, 0, 0, 0],
	dis_fire: [0, 0, 0, 0],
	
	key_west: [0, 0, 0, 0],
	key_east: [0, 0, 0, 0],
	key_nort: [0, 0, 0, 0],
	key_sout: [0, 0, 0, 0],
	
    crosshair: [0, 0, 0, 0],

    players: 1
}

//
global.input_keys_list = [
	"gamepad", "keyboard", "aimassist", "activeforever",
]
var _actions = [
	"press", "release", "hold"
]
array_foreach(_actions, function(_action) {
	var _keys = [
		"fire", "spec", "pick", "swap", "paus",
		"horn", "west", "east", "nort", "sout"
	]
	
	for (var i = array_length(_keys) - 1; i >= 0; --i) {
	    var _pair = $"{_action}_{_keys[i]}"
		variable_struct_set(KeyCont, _pair, [0, 0, 0, 0])
		array_push(global.input_keys_list, _pair)
	}
})

global.input_keys_list_length = array_length(global.input_keys_list)
global.inputs_current = ""

function scrInputBitmask() {
	var val = 0
	
	global.inputs_current = ""
	
	for(var i = 0; i < global.input_keys_list_length; i ++) {
		var key = global.input_keys_list[i]
		
		if KeyCont[$ key][global.index] {
			global.inputs_current += key + ": " + string(KeyCont[$ key][global.index]) + "\n"
			
			val |= (1 << i)
		}
	}
	
	return val
}

function scrGamepadKeyName(key) {
    switch key {
        case gp_shoulderl:
            return "LEFT SHOULDER"
        case gp_shoulderr:
            return "RIGHT SHOULDER"
        case gp_shoulderlb:
            return "LEFT SHOULDER B."
        case gp_shoulderrb:
            return "RIGHT SHOULDER B."

        case gp_face1:
            return "FACE 1"
        case gp_face2:
            return "FACE 2"
        case gp_face3:
            return "FACE 3"
        case gp_face4:
            return "FACE 4"

        case gp_padd:
            return "DPAD DOWN"
        case gp_padu:
            return "DPAD UP"
        case gp_padr:
            return "DPAD RIGHT"
        case gp_padl:
            return "DPAD LEFT"

        case gp_start:
            return "START"
        case gp_select:
            return "SELECT"

        default:
            return "unknown"
    }
}

function scrKeyName(key) {
	switch key {
		case mb_left:
			return "LMB"
		case mb_right:
			return "RMB"
		case mb_middle:
			return "MIDDLE"
		
		case vk_shift:
			return "SHIFT"
		case vk_control:
			return "CTRL"
		case vk_enter:
			return "ENTER"
		case vk_space:
			return "SPACE"
		case vk_alt:
			return "ALT"
		case vk_delete:
			return "DELETE"
		case vk_end:
			return "END"
		case vk_tab:
			return "TAB"
		case vk_escape:
			return "ESC"
		case vk_tilde:
			return "~"
		case ord("/"):
			return "/"
		
		case vk_up:
			return "UP"
		case vk_down:
			return "DOWN"
		case vk_left:
			return "LEFT"
		case vk_right:
			return "RIGHT"
	}
	
	if key >= ord("A") && key <= ord("Z")
	or key >= ord("0") && key <= ord("9")
	or key == ord("/")
		return chr(key)
	
	if key >= vk_f1 && key <= vk_f12 {
		var f = key - vk_f1
		return "F" + string(f + 1)
	}
	
	return "??"
}

function scrGamepadAnykey() {
    if gamepad_button_check_pressed(0, gp_shoulderl) {
        return gp_shoulderl
    }
	else if gamepad_button_check_pressed(0, gp_shoulderr) {
        return gp_shoulderr
    }
	else if gamepad_button_check_pressed(0, gp_shoulderlb) {
        return gp_shoulderlb
    }
	else if gamepad_button_check_pressed(0, gp_shoulderrb) {
        return gp_shoulderrb
    }
	else if gamepad_button_check_pressed(0, gp_face1) {
        return gp_face1
    }
	else if gamepad_button_check_pressed(0, gp_face2) {
        return gp_face2
    }
	else if gamepad_button_check_pressed(0, gp_face3) {
        return gp_face3
    }
	else if gamepad_button_check_pressed(0, gp_face4) {
        return gp_face4
    }
	else if gamepad_button_check_pressed(0, gp_padd) {
        return gp_padd
    }
	else if gamepad_button_check_pressed(0, gp_padu) {
        return gp_padu
    }
	else if gamepad_button_check_pressed(0, gp_padr) {
        return gp_padr
    }
	else if gamepad_button_check_pressed(0, gp_padl) {
        return gp_padl
    }
	else if gamepad_button_check_pressed(0, gp_start) {
        return gp_start
    }
	else if gamepad_button_check_pressed(0, gp_select) {
        return gp_select
    }
	else if scr_keyboard_check_pressed(vk_space) {
        return gp_face1
    }
	else if gamepad_button_check_pressed(0, gp_stickl) {
        return gp_stickl
    }
	else if scr_keyboard_check_pressed(gp_stickr) {
        return gp_stickr
    }

    return -1
}

function scrHandleInputsGeneral(_index) {
	var _k = KeyCont
	
	_k.press_horn[_index] = 0
	_k.gamepad[_index] = opt_gamepad
	_k.keyboard[_index] = opt_keyboard
	_k.aimassist[_index] = opt_assist
	_k.crosshair[_index] = opt_crosshair
	
	_k.touch[_index] = !(opt_gamepad || opt_keyboard)
	
	_k.precisemovement[_index] = (_k.touch[_index] || _k.gamepad[_index])
	
	// generic inputs
	if opt_gamepad || opt_keyboard {
	    _k.hold_fire[_index] = key_check("fire", keystate_hold)
	    _k.press_fire[_index] = key_check("fire", keystate_press)
	    _k.release_fire[_index] = key_check("fire", keystate_release)
		
	    _k.hold_spec[_index] = key_check("spec", keystate_hold)
	    _k.press_spec[_index] = key_check("spec", keystate_press)
	    _k.release_spec[_index] = key_check("spec", keystate_release)
		
	    _k.hold_swap[_index] = key_check("swap", keystate_hold)
	    _k.press_swap[_index] = key_check("swap", keystate_press)
	    _k.release_swap[_index] = key_check("swap", keystate_release)
		
	    _k.hold_pick[_index] = key_check("pick", keystate_hold)
	    _k.press_pick[_index] = key_check("pick", keystate_press)
	    _k.release_pick[_index] = key_check("pick", keystate_release)
		
	    _k.hold_horn[_index] = key_check("horn", keystate_hold)
	    _k.press_horn[_index] = key_check("horn", keystate_press)
	    _k.release_horn[_index] = key_check("horn", keystate_release)
	}
	
	// gamepad
	if opt_gamepad {
	    scrSetGamepadInputs(_index)
	}
	// keyboard
	else if opt_keyboard {
	    scrSetKeyboardInputs(_index)
		
	    if localcoop {
	        scrSetGamepadInputs(1)
	    }
		else if gamepad_button_check(0, gp_start) {
	        opt_gamepad = true
	    }
		
		// keyboard ui control
		if instance_exists(ParButton) {
			var _count = min(10, instance_number(ParButton))
	        for (var i = 0; i < _count; i++) {
	            if scr_keyboard_check_pressed(ord(string(i + 1))) {
	                with instance_find(ParButton, i) {
	                    selected = 1
	                    event_perform(ev_mouse, ev_left_press)
	                }
	                break
	            }
	        }
	    }
	}
	// mobile touchscreen
	else {
		// reset swap inputs in case of using wepsticks
		if opt_wepstick {
			KeyCont.hold_swap[_index] = false
			KeyCont.press_swap[_index] = false
			KeyCont.release_swap[_index] = false
		}
		
		// reset previous input states
		if !instance_exists(MobileUI) {
			KeyCont.press_swap[_index] = false
		}
		
		if volqueue != -1 && ds_queue_size(volqueue) {
			var _volume_input = ds_queue_dequeue(volqueue)
			scrHandleVolumeControl(_volume_input[0], _volume_input[1])
		}
		
		// call control elements logic
		with MobileUI {
			if UberCont.opt_stickregions && !instance_exists(MenuOptions) {
				if (object_index == JoystickMove || object_index == JoystickAttack) {
					for(var i = 0; i <= 4; i ++) scrStickRegions(i)
				}
			}
			
			if (object_index != ButtonActive) event_user(0)
		}
		
		// always ran last
		with (ButtonActive) event_user(0)
		
		// keep track of touch durations
		var _count = array_length(touch_duration)
	    for (var i = 0; i < _count; ++i) {
	        if device_mouse_check_button(i, mb_left) {
	            touch_duration[i] ++
	        }
			else {
				touch_duration[i] = 0
			}
		}
	}
}

function scrSetGamepadInputs(_index = 0) {
	var _kh, _kv;
	
    _kh = gamepad_axis_value(0, gp_axislh)
	_kv = gamepad_axis_value(0, gp_axislv)
	
    if !(abs(_kh) == 0 && abs(_kv) == 0) {
        KeyCont.dir_move[_index] = point_direction(0, 0, _kh, _kv)
        KeyCont.moving[_index] = true
    }
	else KeyCont.moving[_index] = false
	
    _kh = gamepad_axis_value(0, gp_axisrh)
	_kv = gamepad_axis_value(0, gp_axisrv)

    if !(abs(_kh) == 0 && abs(_kv) == 0) {
        KeyCont.dir_fire[_index] = point_direction(0, 0, _kh, _kv)
		KeyCont.dis_fire[_index] = point_distance(0, 0, _kh, _kv)
    }
}

function scrSetKeyboardInputs(_index = 0) {
	KeyCont.hold_east[_index] = key_check("east", keystate_hold)
	KeyCont.press_east[_index] = key_check("east", keystate_press)
	KeyCont.release_east[_index] = key_check("east", keystate_release)
	
	KeyCont.hold_west[_index] = key_check("west", keystate_hold)
	KeyCont.press_west[_index] = key_check("west", keystate_press)
	KeyCont.release_west[_index] = key_check("west", keystate_release)
	
	KeyCont.hold_sout[_index] = key_check("south", keystate_hold)
	KeyCont.press_sout[_index] = key_check("south", keystate_press)
	KeyCont.release_sout[_index] = key_check("south", keystate_release)
	
	KeyCont.hold_nort[_index] = key_check("north", keystate_hold)
	KeyCont.press_nort[_index] = key_check("north", keystate_press)
	KeyCont.release_nort[_index] = key_check("north", keystate_release)
	
    var _kh = (KeyCont.hold_east[_index] - KeyCont.hold_west[_index]),
		_kv = (KeyCont.hold_sout[_index] - KeyCont.hold_nort[_index])
	
    if !(_kh == 0 && _kv == 0) {
        KeyCont.dir_move[_index] = point_direction(0, 0, _kh, _kv)
        KeyCont.moving[_index] = true
    }
	else {
		KeyCont.moving[_index] = false
	}
	
	if !is_mouse_over_debug_overlay() && !scrGameIsGenerationScreen() {
		with Player {
			if (index != _index) continue
			KeyCont.dis_fire[_index] = point_distance(x, y, mouse_x, mouse_y)
			KeyCont.dir_fire[_index] = point_direction(x, y, mouse_x, mouse_y)
		}
	}
}