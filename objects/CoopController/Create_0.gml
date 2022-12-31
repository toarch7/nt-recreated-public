global.coop = 1

socket = -1

ip = global.ip

index = -1

global.netfreeid = 1
global.buffer = buffer_create(1, buffer_grow, 1)
global.netidstack = ds_stack_create()
global.coopenemylist = {}
inputsbuffer = buffer_create(72, buffer_grow, 1)

bbuffer = -1
pingbuffer = -1
server = -1

if global.is_server {
    //socket = network_create_server(network_socket_tcp, PORT, 1)
    //server = network_create_server(network_socket_udp, PORT + 1, 1)

    socket = network_create_socket_ext(network_socket_udp, PORT)
    server = network_create_server(network_socket_tcp, PORT, 8)

    bbuffer = buffer_create(24, buffer_grow, 1)
    buffer_write(bbuffer, buffer_u8, event.broadcast)
    buffer_write(bbuffer, buffer_string, string_copy(save_get_val("etc", "name", "username"), 1, 10))

    pingbuffer = buffer_create(8, buffer_grow, 1)
    buffer_write(pingbuffer, buffer_u8, event.ping)

    global.index = 0
    index = 0

    alarm[0] = 5
    alarm[2] = 30
} else {
    socket = network_create_socket(network_socket_udp)

    alarm[1] = 1
    alarm[3] = 30
}

portdelays = {}
connectedports = {}
portindexes = {}
playerindexes = []
localdelay = get_timer()

enum event {
    _PLACEHOLDER,

    udp_connect,
    udp_disconnect,
    ping,

    connect,
    leave,
    set_config,

    broadcast,

    start,
    restart,

    update_playerinstance,

    run_start,

    syncai,
    syncplayer,
    verifyenemy,
    enemyremove,
    //spawnportal,
    syncportal,

    hitmekill,
    floorclear,
    setarea,

    skillselect,
    skillpick,
    ultraselect,
    ultrapick,
    crownselect,
    crownpick,

    unpause,
    recieved_packet
}

ai_seed = 0
global.hitme_index = 0

doPause = 0

protowep = 56

debug_text = ""
loading_text = ""

importantpackets = {}

global.coopoptions = {
    //pvp: false
}
/*
if UberCont.hardgot {
	global.coopoptions[$ "hardmode"] = false
}*/

depth = -1000

debugstr = ""

errorlist = ""
errorcount = 0
errormax = save_get_val("coop", "bruh", errorcount)