function network_get_free_id() {
    var ind = global.netfreeid

    if !ds_stack_empty(global.netidstack) {
        return ds_stack_pop(global.netidstack)
    } else global.netfreeid++

    return ind
}

function network_free_id(index) {
    ds_stack_push(global.netidstack, index)
}

function buffer_send(buffer, important = 0) {
    with CoopController {
        if global.is_server {
            var _keys = struct_keys(connectedports)

            for (var i = 0; i < array_length(_keys); i++) {
                var port = _keys[i]

                network_send_udp(socket, connectedports[$ port], real(port), buffer, buffer_tell(buffer))
            }
        } else network_send_udp(socket, ip, PORT, buffer, buffer_tell(buffer))

        if important {
            var impbuff = buffer_create(buffer_get_size(buffer), buffer_grow, 1)
            buffer_copy(buffer, 0, buffer_get_size(buffer), impbuff, 0)
            importantpackets[$ generate_uid()] = impbuff
        }
    }
}

function enemy_find_index(ind) {
    return global.coopenemylist[$ ind]
}

function enemy_remove_index(ind) {
    global.coopenemylist[$ ind] = undefined
}