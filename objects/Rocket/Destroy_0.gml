snd_stop(snd)

snd_play(sndExplosionL)

instance_create(x, y, Explosion)

dir = random(360)

repeat 3 {
    with instance_create(x + lengthdir_x(16, dir), y + lengthdir_y(16, dir), SmallExplosion) {
        team = other.team
        hit_id = other.hit_id
    }

    dir += 360 / 3
}