function custom_sound_check(snd) {
	gml_pragma("forceinline")
    return global.customSounds[$ string(snd)] ?? snd
}