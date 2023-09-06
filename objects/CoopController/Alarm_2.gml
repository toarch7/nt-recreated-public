/// @description Server - Pinging

if !global.is_server
	exit

alarm[2] = 1

var len = array_length(sockets)

for (var i = 0; i < len; i++) {
	var _socket = sockets[i],
		_index = socketindexes[$ _socket]
	
	if socketdelays[$ _socket] == undefined
		socketdelays[$ _socket] = current_time
	
    if (current_time - socketdelays[$ _socket]) > 15000 {
		self.disconnect(_socket)
		snd_play(sndHover)
    }
	else network_send_packet(_socket, pingbuffer, buffer_tell(pingbuffer))
}

KeyCont.players = variable_struct_names_count(playerinstances)