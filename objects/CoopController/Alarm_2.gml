/// @description Server - Pinging

if !global.is_server
	exit

alarm[2] = 1

var keys = struct_keys(connectedports)
var len = array_length(keys)

for (var i = 0; i < len; i++) {
	var port = keys[i],
		index = portindexes[$ port]
	
	if portdelays[$ port] == undefined
		portdelays[$ port] = current_time
	
    if (current_time - portdelays[$ port]) > 15000 {
		var _index = portindexes[$ port]
		
		self.disconnect(_index, port)
		
		snd_play(sndHover)
    }
	else {
		network_send_udp(socket, connectedports[$ port], real(port), pingbuffer, buffer_tell(pingbuffer))
	}
}

KeyCont.players = variable_struct_names_count(playerinstances)