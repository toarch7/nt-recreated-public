if ammo > 0 {
    if ammo = 16 snd_play(sndSnowTankPreShoot) snd_play(sndSnowTankShoot)
    with instance_create(x, y, EnemyBullet4) {
        motion_add(other.gunangle + sin(other.wave) * 20, 12)
        creator = other.id
        team = other.team
        hit_id = other.spr_idle
        image_angle = direction
    }
    with instance_create(x, y, EnemyBullet4) {
        motion_add(other.gunangle - sin(other.wave) * 20, 12)
        team = other.team
        hit_id = other.spr_idle
        creator = other.id
        image_angle = direction
    }
    alarm[2] = 2
    wave += 0.1
    ammo -= 1
} else {
    snd_play(sndSnowTankCooldown)
    rest = 1
    alarm[1] = 4 / 0.4
    sprite_index = spr_idle
    image_index = 0
}