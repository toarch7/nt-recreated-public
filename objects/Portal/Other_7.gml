if !isset("type") type = 1

if sprite_index == sprPortalSpawn {
    instance_create(x, y, PortalShock)
	
	var s = snd_loop(sndPortalLoop)
	audio_sound_set_track_position(s, random(audio_sound_length(s)))

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