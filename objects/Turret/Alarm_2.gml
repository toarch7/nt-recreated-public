if (ammo > 0) {
    ammo -= 1
    alarm[2] = 3
    sprite_index = spr_fire
    snd_play_hit_big(sndTurretFire, 0.2)
    with(instance_create(x, y, EnemyBullet1)) {
        hit_id = other.spr_idle
        motion_add(((other.gunangle + random(8)) - 4), 8)
        image_angle = direction
        team = other.team
    }
} else {
    sprite_index = spr_idle
    alarm[1] = (10 + random(5))
}