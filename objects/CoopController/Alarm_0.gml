/// @description Server - broadcast

if instance_exists(CoopMenu) && global.is_server {
    network_send_broadcast(broadcast_socket, NETWORK_PORT, broadcast_buffer, buffer_tell(broadcast_buffer))
	
    alarm[0] = 30
}