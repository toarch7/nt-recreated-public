if ammo > 0 {
    snd_play(sndScorpionFire)
    ammo -= 1
    alarm[2] = 2
    sprite_index = spr_fire
    with instance_create(x, y, EnemyBullet2) {
        motion_add(other.gunangle + rng_spread(11, 20), 3 + random(1))
        image_angle = direction
        creator = other.id
        team = other.team
        hit_id = other.spr_idle
    }
} else {
    sprite_index = spr_idle
    alarm[1] = 40 + random(10)
}