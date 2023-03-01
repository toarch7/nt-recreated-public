// @description Server - pinging

alarm[2] = 30

var keys = struct_keys(connectedports)
var len = array_length(keys)

for (var i = 0; i < len; i++) {
    var port = keys[i]

    network_send_udp(socket, connectedports[$ port], real(port), pingbuffer, buffer_tell(pingbuffer))

    if get_timer() - portdelays[$ port] > 15000000 {
        var _index = portindexes[$ port]

        connectedports[$ port] = undefined
        connectedports = struct_clone(connectedports, 0)

        portdelays[$ port] = undefined
        portdelays = struct_clone(portdelays, 0)

        snd_play(sndMenuSelect)

        instance_activate_object(Player)
        instance_activate_object(Revive)

        with Player {
            if index == _index
				instance_destroy(id, 0)
        }

        with Revive {
            if index == _index instance_destroy(id, 0)
        }

        if UberCont.paused {
            instance_deactivate_object(Player)
            instance_deactivate_object(Revive)
        }

        network_free_id(_index)
        playerinstance_remove(_index)
    }
}

KeyCont.players = array_length(struct_keys(UberCont.playerinstances))