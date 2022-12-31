if ammo {
    if ammo == 16 {
        with instance_create(x, y, JockRocket) {
            hit_id = other.hit_id
            motion_add(other.gunangle, 2)
            sprite_index = sprGoldRocket
            image_angle = direction
            team = other.team
        }

        snd_play_hit_big(sndGoldTankPreShoot, 0.2)
    }

    snd_play_hit_big(sndGoldTankShoot, 0.2)

    with instance_create(x, y, EnemyBullet4) {
        motion_add(other.gunangle + sin(other.wave) * 15, 12)
        team = other.team
        hit_id = other.hit_id
        image_angle = direction
    }

    with instance_create(x, y, EnemyBullet4) {
        motion_add(other.gunangle - sin(other.wave) * 15, 12)
        team = other.team
        hit_id = other.hit_id
        image_angle = direction
    }

    alarm[2] = 2
    wave += .1
    ammo -= 1
} else {
    snd_play_hit_big(sndGoldTankCooldown, .2)
    rest = 1
    alarm[1] = 10
    sprite_index = spr_idle
    image_index = 0
}