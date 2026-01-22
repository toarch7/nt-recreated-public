/// @description Client - connection

//if index == -1
//	alarm[1] = 5

/*buffer_seek(global.mpbuffer, buffer_seek_start, 0)

buffer_write(global.mpbuffer, buffer_u8, event.tcp_connect)
buffer_write(global.mpbuffer, buffer_string, string(GAME_BUILD))
buffer_write(global.mpbuffer, buffer_string, scrSavedataGetUID())
buffer_write(global.mpbuffer, buffer_string, json_stringify(my_player))

var send = network_send_udp(socket, ip, global.port, global.mpbuffer, buffer_tell(global.mpbuffer))

print("Connecting..", send)*/

var send = network_connect_async(socket, global.ip, global.port)

print("Connecting..", send)

if send < 0 {
	with CoopMenu
		text = "UNABLE TO REACH THE SERVER"
	
	alarm[1] = -1
	
	instance_destroy()
	
	exit
}

switch loading_text {
    default:
        loading_text = "|"
        break
    case "|":
        loading_text = "\\"
        break
    case "\\":
        loading_text = "-"
        break
    case "-":
        loading_text = "/"
        break
    case "/":
        loading_text = "|"
        break
}