if image_index < image_number - 1 {
    image_index += 1
    if image_index < 7 {
        alarm[0] = 2
        snd_play(sndMachinegun)
        if image_index == 6 {
            alarm[0] = 20
        }
        shake += .5
    } else if image_index == 7 {
        audio_play_sound(sndLogoLoop, 1000, 1)
        snd_play(sndShovel)
        snd_play(sndMeatExplo)
        snd_play(sndExplosion)
        shake += 2.5
    }
}