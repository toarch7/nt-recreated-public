if !isset("type") type = 1

if sprite_index == sprPortalSpawn {
    instance_create(x, y, PortalShock)

    if type = 1 sprite_index = sprPortal

    if type = 2 sprite_index = sprPopoPortal

    if type = 3 sprite_index = sprProtoPortal
}

if sprite_index = sprPortalDisappear or sprite_index = sprProtoPortalDisappear or sprite_index = sprPopoPortalDisappear {
    with Player {
        if reload > 1 reload = 1

        if breload > 1 breload = 1
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

        with WepPickup {
            if wep == 46 && GameCont.area == 1 {
                GameCont.blacksword = 1
            }
        }
		
		instance_activate_all()

        room_restart()
    }

    instance_destroy()
}