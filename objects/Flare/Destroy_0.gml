sleep(100)
snd_play(sndFlareExplode)
repeat(20) {
    with instance_create(x, y, Flame) {
        motion_add(random(360), random(1) + 4)
        team = other.team
    }
}