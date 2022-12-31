num = 8
snd_play_hit(sndClusterOpen, 0.2)

if GameCont.crown == 2 num++

repeat num {
    with instance_create(x + random(4) - 2, y + random(4) - 2, SmallGrenade) {
        motion_add(random(360), 3 + random(5))
        motion_add(other.direction, 2)
        hit_id = other.hit_id
        team = other.team
        friction = 0.4
    }
}

repeat 8 {
    with instance_create(x, y, Smoke)
    motion_add(random(360), random(2) + 3)
}