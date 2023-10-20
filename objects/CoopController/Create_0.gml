// jsut for testing..
#macro BruteSync false

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

started = false

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

pingbuffer = buffer_create(1, buffer_fixed, 1)
buffer_write(pingbuffer, buffer_u8, event.ping)

if global.is_server {
    socket = network_create_server(network_socket_tcp, global.port, 3)

    broadcast_buffer = buffer_create(24, buffer_grow, 1)
    buffer_write(broadcast_buffer, buffer_u8, event.broadcast)
    buffer_write(broadcast_buffer, buffer_string, string_copy(save_get_value("etc", "name", "username"), 1, 10))

    global.index = 0
    index = 0

    alarm[0] = 5
    alarm[2] = 30
}
else {
    socket = network_create_socket(network_socket_tcp)

    alarm[1] = 1
}

// stores last player ping
socketdelays = {}
// stores list of delays
playerdelaylist = {}

// connections
sockets = []
socketindexes = {}
playerindexes = []


checksum = ""
desynced = false


enum event {
    _,
	
	tcp_handshake,
    tcp_connect,
    disconnect,
    ping,
	latency,
	inputs,
	
    player_connect,
    leave,
	refuse,
    set_config,

    broadcast,

    start,
	
    restart,

    update_playerinstance,

    run_start,
	
	brutesync
}

protowep = 56

loading_text = ""

importantpackets = {}

depth = -1000

ping_count = 0

refuse = function(socket, message) {
	packet_begin(event.refuse)
	packet_write(buffer_string, message)
	packet_send_to(socket)
	
	self.disconnect(socket, true)
}

disconnect = function(_socket, _silent = false) {
	var _index = socketindexes[$ _socket]
	
	if !global.is_server
		_index = _socket
	
	socketindexes[$ _socket] = undefined
	array_delete_val(sockets, _socket)
	
	if global.is_server
		network_destroy(_socket)
	
	if _index == undefined
		exit
	
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
	
	player_remove(_index)
	
	if global.is_server {
		if _index != global.index {
			array_delete(playerindexes, _index, 1)
			network_free_id(_index)
		}
		
		if !_silent {
			packet_begin(event.disconnect)
			packet_write(buffer_u8, _index)
			packet_send()
		}
	}
}

#region event handlers

event_handlers = {}

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
	
	player_set_struct(playerinstances[$ _index], pinst, true)
	
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

#endregion

depth = UberCont.depth - 1