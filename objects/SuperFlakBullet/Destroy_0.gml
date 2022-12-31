ang = random(360)
repeat 5 {
    with instance_create(x, y, FlakBullet) {
        motion_add(other.ang, 12 + random(4))
        image_angle = direction
        team = other.team
    }

    ang += 72
}

with instance_create(x, y, BulletHit)
sprite_index = sprSuperFlakDestroy

repeat(6) {
    with instance_create(x, y, Smoke)
    motion_add(random(360), random(3))
}

BackCont.shake += 8
snd_play_hit_big(sndSuperFlakExplode, 0.2)