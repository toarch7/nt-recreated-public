function custom_sound_check(snd) {
	gml_pragma("forceinline")
    return global.custom_sounds[$ string(snd)] ?? snd
}