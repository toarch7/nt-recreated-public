if bbuffer buffer_delete(bbuffer) if server network_destroy(server)

network_destroy(socket)

buffer_delete(global.buffer)

ds_stack_destroy(global.netidstack)

global.coop = 0
global.is_server = 1
global.index = 0

with UberCont {
    playerinstances = {}
}