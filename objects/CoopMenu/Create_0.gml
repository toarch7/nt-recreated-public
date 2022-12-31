text = ""

global.ip = save_get_val("coop", "lastip", "127.0.0.1")

#macro PORT 25000

server = network_create_server(network_socket_udp, PORT + 1, 1)

network_set_config(network_config_use_non_blocking_socket, 1)

local_games = {}
lastpoint = "127.0.0.1"
refresh = 0

active = 0

ipprompt = -1

host_game = function() {
    global.is_server = 1
    network_destroy(server)
    server = -1

    instance_create(0, 0, CoopController)
    text = "WAIT FOR OTHER PLAYER..."
}

join_remote = function(ip) {
    global.ip = ip

    global.is_server = 0
    network_destroy(server)
    server = -1

    instance_create(0, 0, CoopController)
    text = "CONNECTING TO#" + global.ip + "..."
}