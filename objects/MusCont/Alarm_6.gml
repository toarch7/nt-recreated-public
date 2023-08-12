if instance_exists(Campfire) {
    audio_stop_all()
	
    song = musThemeP
    song = custom_sound_check(song)
	
    snd_play_music(song)
    snd_play_ambient(amb, true)
}