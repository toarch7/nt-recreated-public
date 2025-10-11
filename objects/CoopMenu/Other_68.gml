if async_load[? "id"] != server or global.is_server
	exit

if !instance_exists(CoopController) {
    var _ip = async_load[? "ip"],
		_port = async_load[? "port"],
		_buffer = async_load[? "buffer"]
	
	print("Broadcast", _ip, _port)
	
	try {
	    var _event = buffer_read(_buffer, buffer_u8)
		
		if _event == event.broadcast {
			var _name = buffer_read(_buffer, buffer_string)
			
		    if is_undefined(local_games[$ _ip]) && local_count < 5 {
		        local_games[$ _ip] = true
				
				with menu {
					var info = variable_clone(local_game_template)
					
					print(_name)
					
					info.ip = _ip
					info.port = _port
					info.name = _name
					
					scrOptionsMenuCreateElement(info, true)
					
					item_count = -1
					
				}
				
				local_count ++
			}
	    }
	}
	catch(e) {
		print(e.longMessage)
	}
}