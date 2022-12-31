if ammo > 0 {
    alarm[2] = 5
    snd_play_hit_big(sndLaser, 0.2)
    sprite_index = spr_fire
    spr_hurt = sprLaserCrystalFire

    with instance_create(x, y, EnemyLaser) {
        image_angle = other.gunangle + random(6) - 3
        team = other.team
        hit_id = other.spr_idle
        event_perform(2, 0)
    }

    ammo--
} else {
    sprite_index = spr_idle
    spr_hurt = sprLaserCrystalHurt
}