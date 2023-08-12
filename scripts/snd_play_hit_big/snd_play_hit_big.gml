function snd_play_hit_big(snd, pitch = 0.2) {
    snd = custom_sound_check(snd)
	var dir;

    if instance_exists(Player) {
		dir = instance_nearest(x, y, Player)
	}
	else dir = self
	
    if GameCont.area == 101 {
        if snd == sndExplosion or snd == sndExplosionL or snd == sndExplosionXL
			snd = sndOasisExplosion
		
        if snd == sndExplosionS
			snd = sndOasisExplosionSmall
    }
	
    audio_stop_sound(snd)
	
    audio_sound_pitch(snd, (1 + random(pitch)) - pitch / 2)
    audio_sound_gain(snd, UberCont.opt_sndvol, 0)
	
	if !UberCont.opt_3Dsound
		return snd_play(snd)
	
    if (dir == self) audio_play_sound_at(snd, ((view_xview + (view_width / 2)) - x), ((view_yview + (view_height / 2)) - y), 0, 320, 64000, 1, false, 0)
    else audio_play_sound_at(snd, (dir.x - x), (dir.y - y), 0, 320, 64000, 1, false, 0)



}