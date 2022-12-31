if ammo > 0 {
    snd_play_hit_big(sndEliteShielderPlasma, 0.2)
    wkick = 8
    motion_add(gunangle + 180, 0.5)

    with instance_create(x, y, PopoPlasma) {
        hit_id = sprEliteShielderIdle
        motion_add(other.gunangle + random_range(-10, 10), 1.5)
        image_angle = direction
        team = other.team
    }

    alarm[2] = 4
    ammo--
}