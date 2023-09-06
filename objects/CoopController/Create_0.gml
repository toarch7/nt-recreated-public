inputs = [
	{}, {}, {}, {}
]

event_stack = ds_stack_create()
event_run = 0

delay = 4
netwait = 0
netwait_max = 900

frame = 0 // real inputs (anticipated)
netframe = 0 // network inputs (synced)

last_frame = "" // last frame w/o inputs (debug)

global.coop = 1

socket = -1

ip = global.ip

index = -1

global.netfreeid = 1
global.netidstack = ds_stack_create()

global.buffer = buffer_create(1, buffer_grow, 1)
inputsbuffer = buffer_create(128, buffer_grow, 1)
broadcast_buffer = -1
pingbuffer = -1
server = -1

pingbuffer = buffer_create(1, buffer_fixed, 1)
buffer_write(pingbuffer, buffer_u8, event.ping)

if global.is_server {
    socket = network_create_socket_ext(network_socket_udp, global.port)
    server = network_create_server(network_socket_tcp, global.port, 8)

    broadcast_buffer = buffer_create(24, buffer_grow, 1)
    buffer_write(broadcast_buffer, buffer_u8, event.broadcast)
    buffer_write(broadcast_buffer, buffer_string, string_copy(save_get_val("etc", "name", "username"), 1, 10))

    global.index = 0
    index = 0

    alarm[0] = 5
    alarm[2] = 30
}
else {
    socket = network_create_socket(network_socket_udp)

    alarm[1] = 1
}

portdelays = {}
playerdelays = {}
playerlatency = {}
connectedports = {}
portindexes = {}
playerindexes = []

localdelay = current_time

enum event {
    _,

    udp_connect,
    disconnect,
    ping,
	latency,
	inputs,
	
    connect,
    leave,
	refuse,
    set_config,

    broadcast,

    start,
	
    restart,

    update_playerinstance,

    run_start
}

protowep = 56

loading_text = ""

importantpackets = {}

depth = -1000

errorcount = 0
errormax = save_get_val("coop", "bruh", errorcount)

ping_count = 0

event_handlers = {}

refuse = function(message, ip, port) {
	buffer_seek(global.buffer, buffer_seek_start, 0)
	
	buffer_write(global.buffer, buffer_u8, event.refuse)
	buffer_write(global.buffer, buffer_string, message)
	
	return network_send_udp(socket, ip, port, global.buffer, buffer_tell(global.buffer))
}

disconnect = function(_index, port = -1) {
	instance_activate_object(Player)
	instance_activate_object(Revive)
	
	with Player {
		if index == _index
			instance_destroy(id, 0)
	}
	
	with Revive {
		if index == _index
			instance_destroy(id, 0)
	}
	
	if UberCont.paused {
		instance_deactivate_object(Player)
		instance_deactivate_object(Revive)
	}
	
	playerinstance_remove(_index)
	
	if global.is_server {
		if _index != global.index {
			array_delete(playerindexes, _index, 1)
			
			connectedports[$ port] = undefined
			connectedports = struct_clone(connectedports, 0)
			network_free_id(_index)
		}
		
		buffer_seek(global.buffer, buffer_seek_start, 0)
		buffer_write(global.buffer, buffer_u8, event.disconnect)
		buffer_write(global.buffer, buffer_u8, _index)
		buffer_send(global.buffer)
	}
}

// Crown Change
event_handlers[$ "crown"] = function(_index, _data) {
	GameCont.crown = _data[2]
	
	with Menu
		loadout_crown = _data[2]
	
	snd_play(sndMenuCrown)
}

// PlayerInstance update
event_handlers[$ "playerinstance"] = function(_index, _data) {
	var pinst = _data[2]
	
	playerinstances[$ _index] = pinst
	
	if instance_exists(Menu) {
		var _is_me = net_isme()
		
		with Menu {
			if _is_me {
				var race = pinst.race
				
				if race >= 13 && race <= 15
					loadout = 0
				
				port_x = 150
			}
			else ports_x[_index] = 150
		}
	}
}

// Run command
event_handlers[$ "console"] = function(_index, _data) {
	var l = [],
		cmd = _data[2]
	
	with Player if index != _index {
		instance_deactivate_object(id)
		array_push(l, id)
	}
	
	with Console {
		handle_console_command(cmd)
	}
	
	for(var j = 0; j < array_length(l); j ++) {
		instance_activate_object(l[j])
	}
}


