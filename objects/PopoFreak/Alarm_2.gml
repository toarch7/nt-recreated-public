if (ammo > 0) {
    if ((ammo == 8) && instance_exists(target)) gunangle = ((target_direction + random(90)) - 45)
    ammo -= 1
    snd_play_hit_big(sndGruntFire, 0.2)
    wkick = 5
    with(instance_create(x, y, IDPDBullet)) {
        hit_id = other.spr_idle
        motion_add(((other.gunangle + random(100)) - 50), (4 + random(3)))
        image_angle = direction
        team = other.team
    }
    with(instance_create(x, y, IDPDBullet)) {
        hit_id = other.spr_idle
        motion_add(((other.gunangle + random(40)) - 20), (4 + random(3)))
        image_angle = direction
        team = other.team
    }
    alarm[2] = 1
}