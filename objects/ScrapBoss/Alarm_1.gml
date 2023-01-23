if ammo > 0 {
    spr_hurt = sprScrapBossHurtSpin
    snd_play(sndEnemyFire)
    ammo -= 1
    alarm[1] = 5
    sprite_index = spr_fire
    walk = 0
    scrTarget()
    if instance_exists(target) motion_add(target_direction + turn * 80, 0.3) repeat(6) {
        with instance_create(x + lengthdir_x(24, gunangle), y + lengthdir_y(16, gunangle), EnemyBullet1) {
            hit_id = other.spr_idle
            creator = other.id
            motion_add(other.gunangle, 2)
            image_angle = direction
            team = other.team
        }
        gunangle += 360 / 6
    }

    gunangle += 4 * turn
} else {
    spr_hurt = sprScrapBossHurt
    spr_idle = sprScrapBossStop
    image_index = 0
    sprite_index = spr_idle
    alarm[0] = 20
}