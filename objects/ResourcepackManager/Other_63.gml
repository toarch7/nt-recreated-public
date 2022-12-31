if async_load[? "id"] == message && async_load[? "status"] {
    try {
        var _if = itemsinfo[$ selected]

        _if[12] = string_copy(_if[12], 1, string_length(_if[12]) - 1)

        print("Deleting resourcepack at " + _if[12])

        directory_destroy_recursive(_if[12])

        if _if[6] != -1 sprite_delete(_if[6])

        _if[5] = -2

        snd_play(sndRestart)
        restart = 1

        mode = 0
    } catch (e) {
        print_error(e.longMessage, 1)
    }
}