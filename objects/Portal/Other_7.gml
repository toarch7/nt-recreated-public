if sprite_index == sprPortalSpawn {
    instance_create(x, y, PortalShock)
	
	var _sound = snd_play_loop(sndPortalLoop)
	audio_sound_set_track_position(_sound, random(audio_sound_length(_sound)))
	
    if (type == 2) sprite_index = sprPopoPortal
    else if (type == 3) sprite_index = sprProtoPortal
	else sprite_index = sprPortal
}
else if (sprite_index == sprPortalDisappear
	|| sprite_index == sprProtoPortalDisappear
	|| sprite_index == sprPopoPortalDisappear
) {
    with Player {
        reload = 0
		breload = 0
		if scr_weapon_is_valid(wep) can_shoot = true
		if scr_weapon_is_valid(bwep) bcan_shoot = true
    }
	
    if instance_exists(Player) && !GameCont.is_level_ended {
        event_perform(ev_alarm, 1)
	}
	
    instance_destroy()
}