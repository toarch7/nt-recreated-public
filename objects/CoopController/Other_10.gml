/// @description Handle inputs

if index == -1 or instance_exists(CoopMenu)
    exit

if frame < netframe + delay {
	var _inputs = scrCollectInputs(),
		_dir_move = KeyCont.dir_move[global.index],
		_dir_fire = KeyCont.dir_fire[global.index],
		_crosshair = KeyCont.crosshair[global.index]
	
	buffer_seek(inputsbuffer, buffer_seek_start, 0)
	buffer_write(inputsbuffer, buffer_u8, event.inputs)
	
	buffer_write(inputsbuffer, buffer_u8, global.index)
	buffer_write(inputsbuffer, buffer_u32, _inputs)
	buffer_write(inputsbuffer, buffer_u32, frame)
	buffer_write(inputsbuffer, buffer_f16, _dir_move)
	buffer_write(inputsbuffer, buffer_f16, _dir_fire)
	buffer_write(inputsbuffer, buffer_u8, _crosshair)
	
	buffer_send(inputsbuffer)
	
	inputs[index][$ frame] = [ _inputs, _dir_move, _dir_fire, _crosshair ]
	
	frame ++
}


// read inputs
var stop = 0

//
	for(var i = 0; i < 2; i ++) {
		var _input = inputs[i][$ netframe]
		
		if _input == undefined {
			stop = 1
			break
		}
		
		var _inputs = _input[0],
			_dir_move = _input[1],
			_dir_fire = _input[2],
			_crosshair = _input[3]
		
		for(var j = 0; j < global.input_keys_list_length; j ++) {
			var n = power(2, j + 1)
			KeyCont[$ global.input_keys_list[j]][i] = (_inputs & n) == n
		}
		
		KeyCont.dir_move[i] = _dir_move
		KeyCont.dir_fire[i] = _dir_fire
		KeyCont.crosshair[i] = _crosshair
	}
//

if disconnect >= 900 {
	lockstep_stop = 1
	stop = 0
}

if stop {
	if !lockstep_stop {
		lockstep_stop = 1
		
		draw_enable_drawevent(false)
		instance_deactivate_all(true)
		instance_activate_object(UberCont)
	}
	
	disconnect ++
}
else {
	if lockstep_stop {
		lockstep_stop = 0
		
		draw_enable_drawevent(true)
		
		if UberCont.paused {
		    instance_activate_object(BackCont)
		    instance_activate_object(GameCont)
		    instance_activate_object(TopCont)
		    instance_activate_object(PauseButton)
		    instance_activate_object(MusCont)
		    instance_activate_object(Console)
		}
		else instance_activate_all()
		
		disconnect = 0
	}
	
	for(var i = 0; i < 2; i ++) {
		delete inputs[i][$ netframe]
	}
	
	netframe ++
}

if disconnect >= 900 { // connection terminated
	with Player {
		if is_me {
			index = 0
			continue
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
}