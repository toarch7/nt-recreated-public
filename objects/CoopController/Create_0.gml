inputs = [
	ds_stack_create(),
	ds_stack_create(),
	ds_stack_create(),
	ds_stack_create()
]

delay = 3
disconnect = 0

input_frames = delay
frame = 0

global.coop = 1

socket = -1

ip = global.ip

index = -1

global.netfreeid = 1
global.netidstack = ds_stack_create()

global.buffer = buffer_create(1, buffer_grow, 1)
inputsbuffer = buffer_create(90, buffer_fixed, 1)
broadcast_buffer = -1
pingbuffer = -1
server = -1

if global.is_server {
    socket = network_create_socket_ext(network_socket_udp, PORT)
    server = network_create_server(network_socket_tcp, PORT, 8)

    broadcast_buffer = buffer_create(24, buffer_grow, 1)
    buffer_write(broadcast_buffer, buffer_u8, event.broadcast)
    buffer_write(broadcast_buffer, buffer_string, string_copy(save_get_val("etc", "name", "username"), 1, 10))
	
    pingbuffer = buffer_create(8, buffer_grow, 1)
    buffer_write(pingbuffer, buffer_u8, event.ping)

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
connectedports = {}
portindexes = {}
playerindexes = []

localdelay = get_timer()

enum event {
    _,

    udp_connect,
    udp_disconnect,
    ping,
	inputs,
	
    connect,
    leave,
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