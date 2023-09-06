if !instance_exists(CoopController) && async_load[? "id"] == server {
    var _ip = async_load[? "ip"],
		_port = async_load[? "port"],
		_buffer = async_load[? "buffer"]
	
	try {
	    var _event = buffer_read(_buffer, buffer_u8)
		
		if _event == event.broadcast {
			var _name = buffer_read(_buffer, buffer_string)
			
		    if is_undefined(local_games[$ _ip]) {
		        local_games[$ _ip] = {
		            ip: _ip,
		            port: _port,
		            name: _name
				}
			}
	    }
	}
	catch(e) {
		print(e.longMessage)
	}
}