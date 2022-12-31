if sprite_index == sprMessengerWalk y += 4

if sprite_index == sprMessengerSigh && image_index == 4 && !audio_is_playing(sndLastGrowl) {
    snd_play(sndLastGrowl)
}

if y >= 10036 {
    with Cinematic
    alarm[3] = 30

    instance_destroy()
}