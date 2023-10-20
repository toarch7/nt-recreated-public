friction = 0.5


repeat(4) {
    with instance_create(x, y, Smoke)
    motion_add(random_angle, random(2))
}

snd_play(sndIDPDNadeLoad)