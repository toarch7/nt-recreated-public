if broadcast_buffer {
	buffer_delete(broadcast_buffer)
}

if server {
	network_destroy(server)
}

network_destroy(socket)

buffer_delete(global.buffer)

ds_stack_destroy(global.netidstack)

ds_stack_destroy(event_stack)

with UberCont {
	var inst = playerinstance_get(global.index)
	
	global.coop = 0
	global.is_server = 1
	global.index = 0
	
    playerinstances = {}
	
	playerinstances[$ string(global.index)] = inst
}

lockstep_stop = 0