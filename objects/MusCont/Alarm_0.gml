/// @description Main menu theme switch-up
if !audio_is_playing(custom_sound_check(musThemeB)) {
    audio_stop_sound(custom_sound_check(musThemeA))

    song = custom_sound_check(musThemeB)

    snd_play_music(song)
	
	if instance_exists(Menu) || instance_exists(MenuGen) {
		snd_play_ambience(amb)
	}
}