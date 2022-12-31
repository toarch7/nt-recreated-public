if instance_exists(CoopMenu) && global.is_server {
    network_send_broadcast(server, PORT + 1, bbuffer, buffer_tell(bbuffer))

    alarm[0] = 30
}