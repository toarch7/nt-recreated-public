function snd_track_position(_sound) {
	_sound = custom_sound_check(_sound)
	if (audio_exists(_sound)) {
		return audio_sound_get_track_position(_sound)
	}
	return 0
}