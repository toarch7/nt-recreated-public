#macro Key global.KeyBindings_val
#macro vk_tidle 192

function scrKeymapsSetup() {
	Key = {
		// kb&m & gp
		fire: [ mb_left, gp_shoulderr ],
		spec: [ mb_right, gp_shoulderl ],
		swap: [ vk_space, gp_shoulderrb ],
		pick: [ ord("E"), gp_face1 ],
		horn: [ ord("B"), gp_stickr ],
		
		// kb
		chat: [ ord("T") ],
		north: [ ord("W") ],
		south: [ ord("S") ],
		west: [ ord("A") ],
		east: [ ord("D") ],
		console: [ vk_tidle ]
	}
}

scrKeymapsSetup()

function scrOptionsLoadKeymaps() {
	var keys = struct_keys(Key)
	
	for(var i = 0; i < array_length(keys); i ++) {
		var key = keys[i],
			control = Key[$ key]
		
		control[0] = save_get_val_s("keyboard", key, control[0])
		
		if array_length(control) > 1 {
			control[1] = save_get_val_s("gamepad", key, control[1])
		}
		
		Key[$ key] = control
	}
}

function scrOptionsSaveKeymaps() {
	var keys = struct_keys(Key)
	
	for(var i = 0; i < array_length(keys); i ++) {
		var key = keys[i],
			control = Key[$ key]
		
		save_set_val("keyboard", key, control[0])
		
		if array_length(control) > 1 {
			save_set_val("gamepad", key, control[1])
		}
	}
}

#macro keystate_hold 0
#macro keystate_press 1
#macro keystate_release 2

#macro __mouse_button_max 6

function key_check(name, state = keystate_hold) {
	var v = keymap_get(name)
	
	if v == -1 or (name != "console" && global.console_active)
		return 0
	
	if UberCont.opt_gamepad && !keymap_ret_nogamepad {
		
		if state == keystate_hold
			return input_gamepad_check(global.index, v)
		
		else if state == keystate_press
			return input_gamepad_check_pressed(global.index, v)
		
		else if state == keystate_release
			return input_gamepad_check_released(global.index, v)
		
		return 0
	}
	
	
	if state == keystate_hold
		return (v > __mouse_button_max && keyboard_check(v)) or (v <= __mouse_button_max && mouse_check_button(v))
	
	else if state == keystate_press
		return (v > __mouse_button_max && keyboard_check_pressed(v)) or (v <= __mouse_button_max && mouse_check_button_pressed(v))
	
	else if state == keystate_release
		return (v > __mouse_button_max && keyboard_check_released(v)) or (v <= __mouse_button_max && mouse_check_button_released(v))
	
	return 0
}

#macro keymap_ret_nogamepad global.keymap_get_noconsole_val

function keymap_get(name) {
	var k = Key[$ name],
		p = UberCont.opt_gamepad
	
	if k == undefined
		return -1
	
	keymap_ret_nogamepad = false
	
	if p && array_length(k) == 1 {
		keymap_ret_nogamepad = true
		p = false
	}
	
	return k[p]
}

