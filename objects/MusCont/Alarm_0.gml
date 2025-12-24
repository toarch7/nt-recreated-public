/// @description Main menu theme switch-up
if !audio_is_playing(custom_sound_check(musThemeB)) {
	var _sound = custom_sound_check(musThemeA)
	
	if (audio_exists(_sound)) audio_sound_gain(_sound, 0, 1500)
	
    song = custom_sound_check(musThemeB)
	
    snd_play_music(song, false)
	
	if (instance_exists(Menu) || instance_exists(MenuGen)) {
		snd_play_ambience(amb)
	}
}