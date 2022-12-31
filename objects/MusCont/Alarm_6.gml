if instance_exists(Campfire) {
    audio_stop_all()
    song = musThemeP
    song = custom_sound_check(song)
    snd_play(song)
    snd_loop(amb)
    audio_sound_set_track_position(amb, random(audio_sound_length(amb)))
}