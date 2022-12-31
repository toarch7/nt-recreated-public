if (ammo > 0) {
    ammo -= 1
    alarm[2] = 5
    snd_play_hit_big(sndLightningPistol, 0.2)
    sprite_index = spr_fire
    with(instance_create(x, y, EnemyLightning)) {
        image_angle = (other.gunangle + (random(30) - 15))
        team = other.team
        ammo = (6 + random(8))
        hit_id = other.hit_id
        event_perform(2, 0)
        visible = 0
        with(instance_create(x, y, LightningSpawn))
        image_angle = other.image_angle
    }
} else sprite_index = spr_idle