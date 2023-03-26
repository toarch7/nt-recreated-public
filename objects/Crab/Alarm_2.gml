if ammo > 0 {
    walk = 0

    with instance_create(x, y, EnemyBullet2) {
        hit_id = other.hit_id
        motion_add(other.gunangle + orandom(3) - 20, 5 + random(2))
        image_angle = direction
        team = other.team
    }

    with instance_create(x, y, EnemyBullet2) {
        hit_id = other.hit_id
        motion_add(other.gunangle + orandom(3) + 20, 5 + random(2))
        image_angle = direction
        team = other.team
    }

    snd_play(sndOasisCrabAttack)
    sprite_index = spr_fire
    alarm[2] = 1

    ammo--
} else {
    alarm[1] = 40 + random(10)
    sprite_index = spr_idle
}