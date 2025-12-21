if ammo > 0 {
    if ammo = 10 snd_play(sndBigBanditShootLaugh) snd_play(sndEnemyFire)
    shot = 1
    ammo -= 1
    if ammo == 7 && GameCont.loops && instance_exists(target) gunangle = mcr_target_direction
    alarm[2] = 4
    sprite_index = spr_fire
    walk = 0
    motion_add(gunangle + 180, 1)
    wkick = 5
    with instance_create(x, y, EnemyBullet1) {
        hitid = other.hitid
        creator = other.id
        motion_add(other.gunangle + orandom(15), 8)
        image_angle = direction
        team = other.team
    }
} else {

    snd_play(sndBigBanditStopShoot)
    sprite_index = spr_idle
    alarm[1] = 60 + random(10)
}