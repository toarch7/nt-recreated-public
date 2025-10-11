/// @function snd_play_music
/// @param {Asset.GMSound} sound_index
/// @param is_looped=false
function snd_play_music(_sound_index, _looped = false) {
    _sound_index = custom_sound_check(_sound_index)
	
    audio_stop_sound(_sound_index)
	
	audio_sound_gain(_sound_index, UberCont.opt_musvol, 0)
    var s = audio_play_sound(_sound_index, 128, _looped)
	
}

/// @function snd_play_ambience
/// @param {Asset.GMSound} sound_index
/// @param is_looped=false
function snd_play_ambience(_sound_index, _looped = true) {
    _sound_index = custom_sound_check(_sound_index)
	
    audio_stop_sound(_sound_index)
	
    var s = audio_play_sound(_sound_index, 128, _looped)
	
	audio_sound_gain(_sound_index, UberCont.opt_ambvol, 0)
	audio_sound_set_track_position(s, random(audio_sound_length(_sound_index)))
}