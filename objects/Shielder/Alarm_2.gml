if ammo > 0 && !place_meeting(x, y, PopoShield) {
    snd_play(sndGruntFire)
    wkick = 5
    motion_add(gunangle + 180, .5)

    with instance_create(x, y, IDPDBullet) {
        hit_id = other.spr_idle
        motion_add(other.gunangle + random(20) - 10, 8)
        image_angle = direction
        team = other.team
        walk = 0
    }

    alarm[2] = 3
    ammo -= 1
}