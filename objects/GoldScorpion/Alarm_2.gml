if ammo > 0 {
    ammo -= 1
    alarm[2] = 1
    sprite_index = spr_fire
    snd_play(sndScorpionFire)
    with instance_create(x, y, EnemyBullet2) {
        motion_add(other.gunangle + random(10) - 5, 5 + random(1))
        image_angle = direction
        team = other.team
        creator = other.id
        hit_id = other.spr_idle
    }
    with instance_create(x, y, EnemyBullet2) {
        motion_add(other.gunangle + random(80) - 40, 1.5 + random(0.5))
        image_angle = direction
        hit_id = other.spr_idle
        team = other.team
        creator = other.id
    }
} else {
    sprite_index = spr_idle
    alarm[1] = 40 + random(10)
}