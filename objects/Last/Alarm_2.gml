if (attacktype == 0) {
    if (ammo > 0) {
        ammo -= 4
        alarm[2] = 4
        snd_play_hit_big(sndGruntFire, 0.2)
        gunangle += 9
        repeat(4) {
            with(instance_create(x, y, IDPDBullet)) {
                hit_id = other.spr_idle
                motion_add(other.gunangle, 4)
                image_angle = direction
                team = other.team
            }
            with(instance_create(x, y, IDPDBullet)) {
                hit_id = other.spr_idle
                motion_add((-other.gunangle), 4)
                image_angle = direction
                team = other.team
            }
            gunangle += 90
        }
    }
}
if (attacktype == 1) {
    if (ammo > 0) {
        ammo -= 1
        alarm[2] = 2
        drawimg -= 0.4
        alarm[5] += 1
        motion_add((gunangle + 180), 0.5)
        snd_play_hit_big(sndGruntFire, 0.2)
        with(instance_create(x, y, IDPDBullet)) {
            hit_id = other.spr_idle
            motion_add((other.gunangle - ((other.ammo * 5) + 16)), 12)
            image_angle = direction
            team = other.team
        }
        with(instance_create(x, y, IDPDBullet)) {
            hit_id = other.spr_idle
            motion_add((other.gunangle - (((other.ammo * 5) + 16) / 2)), 12)
            image_angle = direction
            team = other.team
        }
        with(instance_create(x, y, IDPDBullet)) {
            hit_id = other.spr_idle
            motion_add((other.gunangle + (((other.ammo * 5) + 16) / 2)), 12)
            image_angle = direction
            team = other.team
        }
        with(instance_create(x, y, IDPDBullet)) {
            hit_id = other.spr_idle
            motion_add((other.gunangle + ((other.ammo * 5) + 16)), 12)
            image_angle = direction
            team = other.team
        }
    }
}