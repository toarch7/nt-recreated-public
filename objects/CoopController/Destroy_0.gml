if scrGameIsLockstep() scrGameUnlockstep()

if global.is_server {
	array_foreach(sockets, function(_socket) {
		network_destroy(_socket)
	})
}

if index >= 0 {
	packet_begin(event.disconnect)
	packet_write(buffer_u8, index)
	packet_send()
}

if is_numeric(socket) && socket >= 0 {
	self.disconnect(socket)
}

scrGameNetplayDisable()

print("Network destroyed. Current player instance was reset.", my_player)

if instance_exists(CoopMenu) {
	instance_destroy(CoopMenu)
	instance_create(0, 0, CoopMenu)
	scrShowUnlockPopup("DISCONNECTED.")
}