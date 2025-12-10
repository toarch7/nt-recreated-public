if scr_projectile_generic_hit(false) {
    if guitar {
        var _sound_index = asset_get_index("sndGuitarHit" + string(irandom(6) + 1))
		
        if audio_exists(_sound_index) {
            snd_play_pitch(_sound_index, 0.2)
		}
	}
}