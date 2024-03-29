var _socket = async_load[? "socket"],
	_type = async_load[? "type"]

try {
	if _type != network_type_data {
		
		if _type == network_type_connect or _type == network_type_non_blocking_connect {
			print("Connection", _socket)
			
			if array_length(sockets) < 4 {
				array_push(sockets, _socket)
				
				packet_begin(event.tcp_handshake)
				packet_send()
			}
			else self.refuse(_socket, "Server is full")
		}
		else if _type == network_type_disconnect {
			self.disconnect(_socket)
			instance_destroy()
		}
		
		exit
	}
	
	_socket = async_load[? "id"]
	
    var data = async_load[? "buffer"],
		data_type = buffer_read(data, buffer_u8)
    
	var share = (global.is_server && array_length(sockets) > 1)
	
    switch data_type {
		// Clientside
		case event.tcp_handshake:
			if global.is_server
				break
			
			packet_begin(event.tcp_connect)
			
			packet_write(buffer_string, string(GAME_BUILD))
			packet_write(buffer_string, scrGetUid())
			packet_write(buffer_string, json_stringify(playerinstance))
			
			packet_send()
		break
		
		// Serverside
        case event.tcp_connect:
			if !global.is_server
				break
			
			var version = buffer_read(data, buffer_string)
			
			if version != string(GAME_BUILD) {
				self.refuse(_socket, "Version mismatch.#Server version: " + string(GAME_BUILD) + "#Yours: " + string(version))
				
				break
			}
			
			var user_signature = buffer_read(data, buffer_string),
				pinst_data = json_parse(buffer_read(data, buffer_string)),
				freeid = network_get_free_id(),
				pinst = new PlayerInstance(freeid)
			
			player_set_struct(pinst, pinst_data, true)
			
			array_push(playerindexes, freeid)
			
			pinst.index = freeid
			
			socketindexes[$ _socket] = freeid
			
			player_add(freeid, pinst)
			
            buffer_seek(global.buffer, buffer_seek_start, 0)
			
			packet_begin(event.player_connect)
			packet_write(buffer_u8, freeid)
			packet_write(buffer_string, user_signature)
			packet_write(buffer_string, json_stringify(pinst))
			packet_write(buffer_string, json_stringify(playerinstances))
			packet_write(buffer_u32, random_get_seed())
			packet_send()
			
            snd_play(sndRestart)
			
            share = false
			
            break
		
		// Clientside
        case event.player_connect:
			if global.is_server
				exit
			
			var _index = buffer_read(data, buffer_u8),
				_user_signature = buffer_read(data, buffer_string),
				_pinst = json_parse(buffer_read(data, buffer_string))
			
			if _user_signature == scrGetUid() { // is that for me??
				var _playerinstances = json_parse(buffer_read(data, buffer_string)),
					_seed = buffer_read(data, buffer_u32)
				
				playerinstances = {}
				
				playerinstances_set_struct_list(_playerinstances)
				
				playerinstance = player_get()
				
	            global.index = _index
	            index = _index
				
	            snd_play(sndRestart)
				
	            if instance_exists(CoopMenu)
	                CoopMenu.connected = true
				
	            loading_text = ""
				
				global.seed = _seed
				random_set_seed(_seed)
				
	            alarm[1] = -1
			}
			else player_add(_index, _pinst)
			
            share = false
			
            break
		
		// Clientside
		case event.refuse:
			if global.is_server
				break
			
			var _reason = buffer_read(data, buffer_string)
			
			with CoopMenu
				text = "@s- CONNECTION REFUSED -:##@w" + _reason
			
			print("Server connection refused refused: ", _reason)
			
			alarm[1] = -1
			
			break
		
		case event.disconnect:
			var _index = buffer_read(data, buffer_u8)
			
			snd_play(sndHover)
			
			print("DISCONNECT", _index)
			
			if !global.is_server {
				self.disconnect(_index)
				
				if _index == 0
					instance_destroy()
			}
			else self.disconnect(_socket)
			
			KeyCont.players = variable_struct_names_count(playerinstances)
			
			break
		
		case event.start:
			var _index = buffer_read(data, buffer_u8)
			
			share = false
			
			if global.is_server
				break
			
			clients_ready = array_create(network_clientcount() + 1)
			
			clients_ready[_index] = true
			clients_ready[self.index] = true
			
			started = true
			
			with CoopMenu
				instance_destroy()
			
			network_lock()
			
			packet_begin(event.ready_state)
			packet_write(buffer_u8, global.index)
			packet_send()
			
            break
		
		case event.ready_state:
			
			var _index = buffer_read(data, buffer_u8)
			clients_ready[_index] = true
			
			break
        
        case event.update_playerinstance:
            var _index = buffer_read(data, buffer_u8)
			
            var inst = player_get(_index)
			
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
				_moving = buffer_read(data, buffer_f16),
				_dir_fire = buffer_read(data, buffer_f16),
				_dis_fire = buffer_read(data, buffer_f16),
				_checksum = buffer_read(data, buffer_string),
				_event = buffer_read(data, buffer_string)
			
			inputs[_index][$ _frame] = [ _inputs, _dir_move, _moving, _dir_fire, _dis_fire, _checksum, _event ]
			
			break
		
		case event.ping:
			ping_count ++
			
			if global.is_server {
				var last = socketdelays[$ _socket],
					arr = playerdelaylist[$ _socket] ?? [],
					len = array_length(arr)
				
				array_insert(arr, 0, current_time - last)
				
				if len >= 10
					array_delete(arr, 10, 1)
				
				var total = 0
				
				for(var i = 0; i < len; i ++)
					total += arr[i]
				
				var _latency = total / len
				
				var _index = socketindexes[$ _socket]
				
				if _index != undefined {
					var inst = player_get(_index)
					
					if inst != undefined {
						inst.latency = _latency
						
						packet_begin(event.latency)
						packet_write(buffer_u8, _index)
						packet_write(buffer_f32, _latency)
						packet_send()
					}
				}
					
				socketdelays[$ _socket] = current_time
				playerdelaylist[$ _socket] = arr
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
				
			var inst = player_get(_index)
				
			if inst != undefined
				inst.latency = _latency
				
			break
		
		case event.brutesync:
			if !BruteSync
				break
			
			var _seed = buffer_read(data, buffer_u32)
			
			window_set_caption(_seed)
			
			global.seed = _seed
			random_set_seed(_seed)
			
			var _hitmes = buffer_read(data, buffer_u32)
			
			repeat _hitmes {
				var _net_index = buffer_read(data, buffer_u32)
				
				with hitme if net_index == _net_index {
					x = buffer_read(data, buffer_f32)
					y = buffer_read(data, buffer_f32)
					
					speed = buffer_read(data, buffer_f16)
					direction = buffer_read(data, buffer_f16)
					
					for(var i = 0; i < 12; i ++) {
						var num = buffer_read(data, buffer_u8)
						
						if num == 0xA0
							break
						
						alarm[num] = buffer_read(data, buffer_u16)
					}
					
					break
				}
			}
			
			break
    }
	
	if share {
	    for (var i = 0; i < array_length(sockets); i++) {
	        var _socket = sockets[i]
			
			network_send_packet(_socket, data, buffer_tell(data))
	    }
	}
}
catch (exception) {
	print(exception.longMessage)
	
	for(var i = 0; i < array_length(exception.stacktrace); i ++)
		print(exception.stacktrace[i])
	
    print("CoopController exception:", exception.message)
}