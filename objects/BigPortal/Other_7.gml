if sprite_index == sprBigPortalSpawn {
    instance_create(x, y, PortalShock)
    sprite_index = sprBigPortal
}

if sprite_index == sprBigPortalDisappear {
    with Player {
        reload = 0
        breload = 0
		can_shoot = true
		bcan_shoot = true
		scrPlayerUncurse(id)
    }

    GameCont.is_level_ended = true

    snd_stop(sndPortalLoop)

    if instance_exists(Player) {
        instance_activate_all()
        room_restart()
    }

    instance_destroy()
}