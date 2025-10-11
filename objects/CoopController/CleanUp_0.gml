print("NETWORK CONTROLLER CLEANUP")

ds_stack_destroy(global.netidstack)
ds_stack_destroy(event_stack)

if buffer_exists(pingbuffer) buffer_delete(pingbuffer)
if buffer_exists(global.buffer) buffer_delete(global.buffer)

if buffer_exists(broadcast_buffer) buffer_delete(broadcast_buffer)
if buffer_exists(broadcast_socket) network_destroy(broadcast_socket)
if buffer_exists(socket) network_destroy(socket)
