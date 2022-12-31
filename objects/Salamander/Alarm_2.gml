if (ammo > 0) {
    if (ammo == 45) {
        snd_play_hit_big(sndSalamanderFire, 0.2)
        myloop = sndSalamanderFireLoop
        snd_loop(myloop)
    }
    walk = 0
    ammo -= 1
    wave += 0.03
    alarm[2] = 1
    sprite_index = spr_fire
    with(instance_create((x + lengthdir_x(12, (gunangle + (sin(wave) * 70)))), (y + lengthdir_y(12, (gunangle + (sin(wave) * 70)))), TrapFire)) {
        motion_add((other.gunangle + (sin(other.wave) * 70)), 6)
        image_angle = direction
        team = other.team
        hit_id = other.spr_idle
    }
    instance_create(x, y, Smoke)
} else {
    snd_play_hit_big(sndSalamanderEndFire, 0.2)
    audio_stop_sound(myloop)
    sprite_index = spr_idle
    alarm[1] = (10 + random(10))
}