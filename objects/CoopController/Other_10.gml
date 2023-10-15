/// @description Handle inputs

if index == -1 or instance_exists(CoopMenu)
    exit

if frame <= netframe + max(1, delay) {
	var _inputs = scrInputBitmask(),
		
		_dir_move = KeyCont.dir_move[index],
		_moving = KeyCont.moving[index],
		_dir_fire = KeyCont.dir_fire[index],
		_dis_fire = KeyCont.dis_fire[index],
		
		_event = !ds_stack_empty(event_stack) ? json_stringify(ds_stack_pop(event_stack)) : "[]"
	
	packet_begin(event.inputs)
	
	packet_write(buffer_u8, index)
	packet_write(buffer_u32, _inputs)
	packet_write(buffer_u32, frame)
	packet_write(buffer_f16, _dir_move)
	packet_write(buffer_f16, _moving)
	packet_write(buffer_f16, _dir_fire)
	packet_write(buffer_f16, _dis_fire)
	packet_write(buffer_string, _event)
	
	packet_send()
	
	inputs[index][$ frame] = [ _inputs, _dir_move, _moving, _dir_fire, _dis_fire, _event ]
	
	frame ++
	
	
}
// if waiting for long enough, assume packets were lost and send anticipated inputs again
else {
	if netwait > 30 {
		var f = frame - (netwait % (delay + 1)),
			_input = inputs[index][$ f]
		
		if _input != undefined {
			packet_begin(event.inputs)
			
			packet_write(buffer_u8, index)
			packet_write(buffer_u32, _input[0])
			packet_write(buffer_u32, f)
			packet_write(buffer_f16, _input[1])
			packet_write(buffer_f16, _input[2])
			packet_write(buffer_f16, _input[3])
			packet_write(buffer_f16, _input[4])
			packet_write(buffer_string, _input[5])
			
			packet_send()
		}
		else {
			print("input resend failed, ", frame, (netwait % (delay + 1)), netframe)
		}
	}
	
}

// read inputs

var stop = false,
	playercount = array_length(playerindexes) + 1

//
	for(var i = 0; i < playercount; i ++) {
		var _input = inputs[i][$ netframe]
		
		// unknown input, enter locked mode
		if _input == undefined or array_length(inputs) < delay {
			last_frame = string(i) + " " + string(netframe)
			
			print(index, "Input of", i, "is not known for frame", netframe)
			
			stop = true; break
		}
		
		var _inputs = _input[0],
			_dir_move = _input[1],
			_moving = _input[2],
			_dir_fire = _input[3],
			_dis_fire = _input[4],
			_event = _input[5]
		
		for(var j = 0; j < global.input_keys_list_length; j ++)
			KeyCont[$ global.input_keys_list[j]][i] = bit_check(_inputs, 1 << j)
		
		KeyCont.dir_move[i] = _dir_move
		KeyCont.moving[i] = _moving
		KeyCont.dir_fire[i] = _dir_fire
		KeyCont.dis_fire[i] = _dis_fire
		
		if _event != "[]" {
			var _data = json_parse(_event)
			
			event_run = true
			global.index = i
			
			if _data[0] == "other" {
				var handle = event_handlers[$ _data[1]]
				
				if handle != undefined
					method_execute(handle, i, _data)
			}
			else { // perform events
				with _data[1] {
					if net_index == _data[0] {
						event_perform(_data[2], _data[3])
						
						break
					}
				}
			}
			
			event_run = false
			global.index = index
		}
	}
	
	global.random_state = global.seed + netframe
//

if netwait >= 900 { // connection terminated
	if network_is_locked()
		network_unlock()
	
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
	
	for(var i = 0; i < playercount; i ++)
		delete inputs[i][$ netframe]
	
	if netframe % 30 == 0 {
		for(var i = 0; i < array_length(inputs); i ++)
			inputs[i] = struct_clone(inputs[i], false)
	}
	
	netwait = 0
	
	netframe ++
}

if global.is_server && BruteSync {
	var _seed = global.seed + netframe
	
	window_set_caption(_seed)
	
	random_set_seed(_seed)
	
	packet_begin(event.brutesync)
	
	packet_write(buffer_u32, _seed + 1)
	
	packet_write(buffer_u32, instance_number(hitme))
	
	with hitme {
		packet_write(buffer_u32, net_index)
		
		packet_write(buffer_f32, x)
		packet_write(buffer_f32, y)
		
		packet_write(buffer_f16, speed)
		packet_write(buffer_f16, direction)
		
		for(var i = 0; i < 12; i ++) {
			if alarm[i] > 0 {
				packet_write(buffer_u8, i)
				packet_write(buffer_u16, alarm[i])
			}
		}
		
		packet_write(buffer_u8, 0xA0)
	}
	
	packet_send()
}