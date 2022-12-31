if blink < 0 {
    instance_create(x, y, SmallChestFade)
    snd_play(sndPickupFade)
    instance_destroy()
} else {
    alarm[0] = 2
    blink -= 1
    if visible = 1 visible = 0
    else visible = 1
}