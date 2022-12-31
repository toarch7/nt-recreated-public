if blink < 0 {
    instance_create(x, y, SmallExplosion)
    snd_play(sndExplosionS)
    snd_play(sndCursedPickupDisappear)
    instance_destroy()
} else {
    alarm[0] = 2
    blink -= 1
    if visible = 1 visible = 0
    else visible = 1
}