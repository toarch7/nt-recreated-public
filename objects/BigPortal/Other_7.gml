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
        instance_activate_all()
        room_restart()
    }

    instance_destroy()
}