if scr_projectile_generic_hit(false) {
    if (guitar || electricguitar) {
        var _sound_name = electricguitar ? "sndElectricGuitarHit" : "sndGuitarHit",
			_sound_index = asset_get_index(_sound_name + string(irandom(6) + 1))
		
        if (audio_exists(_sound_index)) snd_play_pitch(_sound_index, 0.2)
	}
}