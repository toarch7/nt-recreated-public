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
        reload = 0
		breload = 0
		
		if wep
			can_shoot = true
		
		if bwep
			bcan_shoot = true
    }
	
    if instance_exists(Player) && !GameCont.level_end
        event_perform(ev_alarm, 1)
	
    instance_destroy()
}