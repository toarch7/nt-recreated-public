image_speed = 0.4

dir = random(360)
repeat(6) {
    with instance_create(x, y, Smoke)
    motion_add(other.dir, 4 + random(1))
    dir += 360 / 6
}

snd_play(sndMeatExplo)

BackCont.shake += 6

team = 2