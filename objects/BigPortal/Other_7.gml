if sprite_index = sprBigPortalSpawn {
    instance_create(x, y, PortalShock)
    sprite_index = sprBigPortal
}
if sprite_index = sprBigPortalDisappear {
    with Player {
        reload = 0
        breload = 0

        if curse or bcurse snd_play(sndUncurse)

        curse = 0
        bcurse = 0
    }

    GameCont.level_end = 1

    snd_stop(sndPortalLoop)

    if instance_exists(Player) {
        if instance_exists(CoopController) {
            buffer_seek(global.buffer, buffer_seek_start, 0)
            buffer_write(global.buffer, buffer_u8, event.setarea)
            buffer_write(global.buffer, buffer_u8, GameCont.area)
            buffer_write(global.buffer, buffer_u8, GameCont.subarea)
            buffer_write(global.buffer, buffer_u8, GameCont.hard)
            buffer_write(global.buffer, buffer_u8, GameCont.loops)
            buffer_write(global.buffer, buffer_string, string(GameCont.rad))
            buffer_write(global.buffer, buffer_u8, GameCont.skillpoints)
            buffer_write(global.buffer, buffer_string, string(GameCont.kills))
            buffer_write(global.buffer, buffer_u8, GameCont.level)
            buffer_write(global.buffer, buffer_u8, GameCont.ultrapoints)
            buffer_write(global.buffer, buffer_u8, GameCont.crownpoints)
            buffer_send(global.buffer)
        }

        room_restart()
    }

    instance_destroy()
}