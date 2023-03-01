// @description Server - broadcast

if instance_exists(CoopMenu) && global.is_server {
    network_send_broadcast(server, PORT + 1, broadcast_buffer, buffer_tell(broadcast_buffer))

    alarm[0] = 30
}