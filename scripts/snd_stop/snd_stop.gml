function snd_stop(_sound) {
	_sound = custom_sound_check(_sound)
	if (audio_exists(_sound)) {
		audio_stop_sound(_sound)
	}
	return -1
}