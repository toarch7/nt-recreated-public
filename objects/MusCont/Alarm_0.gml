if !audio_is_playing(custom_sound_check(musThemeB)) {
    audio_stop_sound(custom_sound_check(musThemeA))

    song = custom_sound_check(musThemeB)

    snd_play(song)

    audio_sound_set_track_position(amb, random(audio_sound_length(amb)))
}