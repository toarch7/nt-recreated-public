if index != -1
	self.disconnect(socket)

if broadcast_buffer
	buffer_delete(broadcast_buffer)

if socket != -1
	network_destroy(socket)

buffer_delete(pingbuffer)

buffer_delete(global.buffer)

ds_stack_destroy(global.netidstack)

ds_stack_destroy(event_stack)

with Revive
	instance_destroy()

with Player {
	if index == global.index {
		index = 0
	}
	else instance_destroy(id, 0)
}

with UberCont {
	global.coop = 0
	global.is_server = 1
	global.index = 0
	
    playerinstances = {}
	
	var inst = new PlayerInstance()
	playerinstance_add(global.index, inst)
	inst.update_prefs()
	
	playerinstance = inst
}

print("PlayerInstance", playerinstance)

if network_is_locked()
	network_unlock()