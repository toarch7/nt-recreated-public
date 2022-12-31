if !instance_exists(CoopController) && async_load[? "id"] == server {
    var _ip = async_load[? "ip"]
    var _port = async_load[? "port"]
    var b = async_load[? "buffer"]
	
    var _asdf = buffer_read(b, buffer_u8)
    var _name = buffer_read(b, buffer_string)

    if is_undefined(local_games[$ _ip]) {
        local_games[$ _ip] = {
            ip: _ip,
            port: _port,
            name: _name
        }
    }
}