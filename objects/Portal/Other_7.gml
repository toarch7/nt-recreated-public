if (sprite_index == sprPortalSpawn) {
    instance_create(x, y, PortalShock)
	
	var _sound = snd_play_loop(sndPortalLoop)
	
	if (_sound >= 0) {
		audio_sound_set_track_position(_sound, random(audio_sound_length(_sound)))
	}
	
    /**/ if (type == 2) sprite_index = sprPopoPortal
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
		if (scr_weapon_is_valid(wep)) can_shoot = true
		if (scr_weapon_is_valid(bwep)) bcan_shoot = true
		
		var _extra_count = array_length(extra_weps)
		for(var i = _extra_count - 1; i >= 0; --i) {
			extra_weps_reload[i] = 0
			extra_weps_can_shoot[i] = true
		}
    }
	
    if (instance_exists(Player) && !GameCont.is_level_ended) event_perform(ev_alarm, 1)
	
    instance_destroy()
}