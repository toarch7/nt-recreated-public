/// @description Handle inputs

if index == -1 or instance_exists(CoopMenu)
    exit

if frame < netframe + delay {
	var _inputs = scrInputBitmask(),
		
		_dir_move = KeyCont.dir_move[global.index],
		_dir_fire = KeyCont.dir_fire[global.index],
		_dis_fire = KeyCont.dis_fire[global.index],
		_crosshair = KeyCont.crosshair[global.index],
		
		_event = !ds_stack_empty(event_stack) ? json_stringify(ds_stack_pop(event_stack)) : "[]"
	
	buffer_seek(inputsbuffer, buffer_seek_start, 0)
	buffer_write(inputsbuffer, buffer_u8, event.inputs)
	
	buffer_write(inputsbuffer, buffer_u8, global.index)
	buffer_write(inputsbuffer, buffer_u32, _inputs)
	buffer_write(inputsbuffer, buffer_u32, frame)
	buffer_write(inputsbuffer, buffer_f16, _dir_move)
	buffer_write(inputsbuffer, buffer_f16, _dir_fire)
	buffer_write(inputsbuffer, buffer_f16, _dis_fire)
	buffer_write(inputsbuffer, buffer_u8, _crosshair)
	buffer_write(inputsbuffer, buffer_string, _event)
	
	buffer_send(inputsbuffer)
	
	inputs[global.index][$ frame] = [ _inputs, _dir_move, _dir_fire, _dis_fire, _crosshair, _event ]
	
	frame ++
	
	
}
// if waiting for long enough, assume packets were lost and send anticipated inputs again
else {
	if netwait > 30 {
		var f = frame - (netwait % (delay + 1)),
			_input = inputs[global.index][$ f]
		
		if _input != undefined {
			buffer_seek(inputsbuffer, buffer_seek_start, 0)
			buffer_write(inputsbuffer, buffer_u8, event.inputs)
			
			buffer_write(inputsbuffer, buffer_u8, global.index)
			buffer_write(inputsbuffer, buffer_u32, _input[0])
			buffer_write(inputsbuffer, buffer_u32, f)
			buffer_write(inputsbuffer, buffer_f16, _input[1])
			buffer_write(inputsbuffer, buffer_f16, _input[2])
			buffer_write(inputsbuffer, buffer_u8, _input[3])
			buffer_write(inputsbuffer, buffer_string, _input[4])
		
			buffer_send(inputsbuffer)
		}
		else {
			print("input resend failed, ", frame, (netwait % delay + 1), netframe)
		}
	}
	
}

// read inputs

var stop = 0,
	playercount = array_length(playerindexes) + 1

//
	for(var i = 0; i < playercount; i ++) {
		var _input = inputs[i][$ netframe]
		
		// unknown input, enter locked mode
		if _input == undefined {
			last_frame = string(i) + " " + string(netframe)
			
			print(index, "Input of", i, "is not known for frame", netframe)
			
			stop = true; break
		}
		
		var _inputs = _input[0],
			_dir_move = _input[1],
			_dir_fire = _input[2],
			_crosshair = _input[3],
			_event = _input[4]
		
		for(var j = 0; j < global.input_keys_list_length; j ++) {
			KeyCont[$ global.input_keys_list[j]][i] = (_inputs & (1 << j)) != 0
		}
		
		KeyCont.dir_move[i] = _dir_move
		KeyCont.dir_fire[i] = _dir_fire
		KeyCont.dis_fire[i] = _dis_fire
		KeyCont.crosshair[i] = _crosshair
		
		if _event != "[]" {
			var _data = json_parse(_event),
				_ind = global.index
			
			event_run = 1
			global.index = i
			
			if _data[0] == "other" {
				if _data[1] == "crown" {
					GameCont.crown = _data[2]
				}
				else if _data[1] = "playerinstance" {
					playerinstances[$ string(i)] = _data[2]
					
					if instance_exists(Menu) {
						var _is_me = net_isme()
						
						with Menu {
							if _is_me {
								var race = _data[2].race
								
								if race >= 13 && race <= 15 {
									loadout = 0
								}
								
								port_x = 150
							}
							else ports_x[i] = 150
						}
					}
				}
				else if _data[1] == "console" {
					var l = []
					
					with Player if index != i {
						instance_deactivate_object(id)
						array_push(l, id)
					}
					
					with Console {
						handle_console_command(_data[2])
					}
					
					for(var j = 0; j < array_length(l); j ++) {
						instance_activate_object(l[j])
					}
				}
			}
			else { // perform events
				with _data[1] {
					if net_index == _data[0] {
						event_perform(_data[2], _data[3])
						
						break
					}
				}
			}
			
			event_run = 0
			global.index = _ind
		}
	}
//

if netwait >= 900 { // connection terminated
	if network_is_locked()
		network_unlock()
	
	with Player {
		if is_me {
			index = 0; continue
		}
		
		instance_destroy(id, 0)
	}
	
	with Revive
		instance_destroy(id, 0)
	
	if GameCont.coopultra {
		GameCont.coopultra = 0
		GameCont.ultrapoints ++
	}
	
	instance_destroy()
	
	exit
}

if stop {
	if !network_is_locked()
		network_lock()
	
	netwait ++
}
else {
	if network_is_locked()
		network_unlock()
	
	for(var i = 0; i < 2; i ++)
		delete inputs[i][$ netframe]
	
	netframe ++
}
