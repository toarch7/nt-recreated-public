/// @function snd_play_pitch
/// @param {Asset.GMSound} sound_index
/// @param random_pitch=0.2
function snd_play_pitch(_sound_index, _random_pitch = 0.2) {
    _sound_index = custom_sound_check(_sound_index)

    audio_stop_sound(_sound_index)

    var _pitch = ((1 + random(_random_pitch)) - (_random_pitch / 2)),
        _gain = UberCont.opt_sndvol
    
    return audio_play_sound_on(UberCont.mainsound,
        _sound_index, false, 2, _gain, 0, _pitch)
}