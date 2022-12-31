if index == -1 {
    alarm[1] = 5
}

buffer_seek(global.buffer, buffer_seek_start, 0)
buffer_write(global.buffer, buffer_u8, event.udp_connect)
network_send_udp(socket, ip, PORT, global.buffer, buffer_tell(global.buffer))

switch loading_text {
    case "":
        loading_text = "|"
        break
    case "|":
        loading_text = "\\"
        break
    case "\\":
        loading_text = "-"
        break
    case "-":
        loading_text = "/"
        break
    case "/":
        loading_text = "|"
        break
}