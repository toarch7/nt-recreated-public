if mode >= 3 {
    instance_create(x, y, SpiralCont)
    instance_create(x, y, Logo)
    instance_destroy()
} else {
    mode++alarm[0] = 60

    if mode == 2 {
        alarm[0] += 30
    }

    snd_play(sndRestart)
}