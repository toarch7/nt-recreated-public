print("COOP CONTROLLER DESTROY (CLEANUP)")

if network_is_locked()
	network_unlock()

if index != -1 {
	packet_begin(event.disconnect)
	packet_write(buffer_u8, global.index)
	packet_send()
	
	self.disconnect(socket)
}

if global.is_server {
	for(var i = 0; i < array_length(sockets); i ++)
		network_destroy(sockets[i])
}

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
	if index != global.index {
		instance_destroy(id, 0)
	}
	else index = 0
}

if instance_exists(GameCont) && GameCont.coopultra {
	GameCont.coopultra = 0
	GameCont.ultrapoints ++
}

with UberCont {
	global.coop = 0
	global.is_server = true
	global.index = 0
	
    playerinstances = {}
	
	var inst = new PlayerInstance()
	player_add(global.index, inst)
	player_update_prefs(inst)
	
	playerinstance = inst
}

print("PlayerInstance", playerinstance)

if instance_exists(CoopMenu) {
	with CoopMenu
		instance_destroy()
	
	instance_create(0, 0, CoopMenu)
	
	show_unlock_popup("DISCONNECTED.")
}