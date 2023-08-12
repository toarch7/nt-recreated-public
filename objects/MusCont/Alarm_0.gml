if !audio_is_playing(custom_sound_check(musThemeB)) {
    audio_stop_sound(custom_sound_check(musThemeA))

    song = custom_sound_check(musThemeB)

    snd_play_music(song)
    snd_play_ambient(amb)
}