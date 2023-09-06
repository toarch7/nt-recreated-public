var _ip = async_load[? "ip"]
var _port = async_load[? "port"]

try {
    if async_load[? "type"] == network_type_data {
        var data = async_load[? "buffer"]
        var data_type = buffer_read(data, buffer_u8)
		
		// experimental ntt support /j
		if data_type == 171
			data_type = buffer_read(data, buffer_u8) + 1
		
        var share = (global.is_server && array_length(playerindexes) > 1)

        switch data_type {
            case event.udp_connect:
                if !is_undefined(connectedports[$ _port])
					break
				
				var version = buffer_read(data, buffer_string)
				
				if version != string(GAME_BUILD) {
					self.refuse("Version mismatch.#Server version: " + string(GAME_BUILD) + "#Provided: " + string(version), _ip, _port)
					
					break
				}
				
				var user_signature = buffer_read(data, buffer_string),
					pinst = json_parse(buffer_read(data, buffer_string))
				
				if array_length(playerindexes) < 3 {
					var freeid = network_get_free_id()
					
					pinst.index = freeid
					
                    connectedports[$ _port] = _ip
                    portindexes[$ _port] = freeid
					
                    array_push(playerindexes, freeid)
					
					playerinstance_add(freeid, pinst)
					
                    buffer_seek(global.buffer, buffer_seek_start, 0)
					
                    buffer_write(global.buffer, buffer_u8, event.connect)
                    buffer_write(global.buffer, buffer_u8, freeid)
                    buffer_write(global.buffer, buffer_string, user_signature)
                    buffer_write(global.buffer, buffer_string, json_stringify(pinst))
                    buffer_write(global.buffer, buffer_string, json_stringify(playerinstances))
					
                    //network_send_udp(socket, _ip, _port, global.buffer, buffer_tell(global.buffer))
					buffer_send(global.buffer)
					
                    snd_play(sndRestart)
                }
				else self.refuse("Server is full", _ip, _port)
				
                share = false
				
                break
			
			case event.disconnect:
				var _index = buffer_read(data, buffer_u8)
				
				snd_play(sndHover)
				
				if global.is_server {
					self.disconnect(_index, _port)
				}
				else {
					if _index == 0 {
						// server closed
						instance_destroy()
						exit
					}
					else self.disconnect(_index)
				}
				
				share = false
				
				KeyCont.players = variable_struct_names_count(playerinstances)
				
				break
			
            case event.connect:
                var _index = buffer_read(data, buffer_u8),
					_user_signature = buffer_read(data, buffer_string),
					_pinst = json_parse(buffer_read(data, buffer_string))
				
				if _user_signature == scrGetUid() { // is that for me??
					var _playerinstances = json_parse(buffer_read(data, buffer_string))
					
					playerinstances = _playerinstances
					playerinstance = _pinst
					
	                global.index = _index
	                index = _index
					
	                snd_play(sndRestart)
					
	                if instance_exists(CoopMenu)
	                    CoopMenu.connected = true
					
	                loading_text = ""
					
	                alarm[1] = -1
				}
				else playerinstance_add(_index, _pinst)

                share = false
				
                break
			
			case event.refuse:
				if global.is_server
					break
				
				var _reason = buffer_read(data, buffer_string)
				
				with CoopMenu
					text = "@s- CONNECTION REFUSED -:##@w" + _reason
				
				alarm[1] = -1
				
				break
			
            case event.start:
				share = false
				
				if global.is_server
					break;
				
                var _indexes = buffer_read(data, buffer_string)
                playerindexes = json_parse(_indexes)
				
                instance_create(0, 0, GameCont)
				
				var host = new PlayerInstance(0) // host
				
                for (var i = 0; i < array_length(playerindexes); i ++) {
                    var _ind = playerindexes[i],
						_inst = new PlayerInstance(_ind)
					
					if _ind == global.index
						_inst.update_prefs()
                }
				
                global.seed = buffer_read(data, buffer_u32)
                random_set_seed(global.seed)
				
                for (var i = 0; i <= 12; i ++) {
                    global.rng_state[i] = global.seed
                }
				
                with SpiralCont instance_destroy()
				
                UberCont.daily_run = 0
                UberCont.weekly_run = 0
				
                instance_create(0, 0, MenuGen)
				
                with FloorMaker instance_destroy()
                with ChestOpen instance_destroy()
				
                with CoopMenu {
                    server = -1
					
                    instance_destroy()
                }
				
				snd_play(sndPortalOld)
				
                break
			
            case event.update_playerinstance:
                var _index = buffer_read(data, buffer_u8)
                var inst = playerinstance_get(_index)
                var _skin = inst.skin,
                    _race = inst.race

                    inst.read(data)

                    if inst.skin != _skin or inst.race != _race {
                        with Menu ports_x[_index] = 150
                    }

                if inst.race != _race {
                    var snd_slct = asset_get_index("sndMutant" + string(inst.race) + "Slct")

                    if inst.race == 13 {
                        snd_slct = sndBigDogIntro
                    }

                    snd_play(snd_slct)
                }
                break
			
			case event.inputs:
				var _index = buffer_read(data, buffer_u8),
					_inputs = buffer_read(data, buffer_u32),
					_frame = buffer_read(data, buffer_u32),
					_dir_move = buffer_read(data, buffer_f16),
					_dir_fire = buffer_read(data, buffer_f16),
					_dis_fire = buffer_read(data, buffer_f16),
					_event = buffer_read(data, buffer_string)
				
				inputs[_index][$ _frame] = [ _inputs, _dir_move, _dir_fire, _dis_fire, _event ]
				
				break
			
			case event.ping:
				ping_count ++
				
				if global.is_server {
					var last = portdelays[$ _port],
						arr = playerdelays[$ _port] ?? [],
						len = array_length(arr)
					
					array_insert(arr, 0, current_time - last)
					
					if len >= 10
						array_delete(arr, 10, 1)
					
					var total = 0
					
					for(var i = 0; i < len; i ++)
						total += arr[i]
					
					var _latency = total / len
					
					var _index = portindexes[$ _port]
					
					if _index != undefined {
						var inst = playerinstance_get(_index)
						
						if inst != undefined {
							inst.latency = _latency
							
							buffer_seek(global.buffer, buffer_seek_start, 0)
							buffer_write(global.buffer, buffer_u8, event.latency)
							buffer_write(global.buffer, buffer_u8, _index)
							buffer_write(global.buffer, buffer_f32, _latency)
							buffer_send(global.buffer)
						}
					}
					
					portdelays[$ _port] = current_time
					playerdelays[$ _port] = arr
				}
				else buffer_send(pingbuffer)
				
				share = false
				
				break
			
			case event.latency:
				if global.is_server
					break
				
				var _index = buffer_read(data, buffer_u8),
					_latency = buffer_read(data, buffer_f32)
				
				if _index == index
					_index = 0
				
				var inst = playerinstance_get(_index)
				
				if inst != undefined
					inst.latency = _latency
				
				break
        }

	    if share {
	        var _keys = struct_keys(connectedports)
			
	        for (var i = 0; i < array_length(_keys); i++) {
	            var port = _keys[i],
	                _prt = real(port)
					
	            if _port != _prt
	                network_send_udp(socket, connectedports[$ port], _prt, data, buffer_tell(data))
	        }
	    }
    }
}
catch (exception) {
	print(exception.longMessage)
	
	for(var i = 0; i < array_length(exception.stacktrace); i ++)
		print(exception.stacktrace[i])
	
    print("CoopController exception:", exception.message)
	
    errorcount ++
}