if ammo > 0 {
    ammo -= 1
    alarm[2] = 5
    snd_play(sndLaser)
    sprite_index = spr_fire
    with instance_create(x, y, EnemyLaser) {
        image_angle = other.gunangle + random(6) - 3
        team = other.team
        hit_id = other.spr_idle
        event_perform(ev_alarm, 0)
    }
} else {
    sprite_index = spr_idle
}