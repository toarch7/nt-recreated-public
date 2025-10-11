#macro NETWORK_PORT 25000

global.ip = UberCont.opt_remote_ip
global.port = UberCont.opt_remote_port

text = ""

var _listner_port = NETWORK_PORT

server = network_create_server(network_socket_udp, _listner_port, 1)

print($"Local game listener ({server}) started at {_listner_port}")

network_set_config(network_config_use_non_blocking_socket, 1)

local_games = {}
local_count = 0

local_wait = 0

refresh = 0

active = 0

ipprompt = -1

connected = true

host_game = function() {
    instance_destroy(menu, true)
	
    global.is_server = true
	
	print("Listener destroyed", server)
	
    network_destroy(server)
    
	server = -1

    instance_create(0, 0, CoopController)
    
	text = "WAIT FOR OTHER PLAYER..."
}

join_remote = function(ip, port) {
    instance_destroy(menu, true)
	
	global.ip = ip
	global.port = port

    global.is_server = 0
	
    network_destroy(server)
	connected = false
    server = -1

    instance_create(0, 0, CoopController)
	
    text = "CONNECTING TO#" + global.ip + "..."
}

menu = noone
