if ammo {
    if instance_number(Exploder) + instance_number(SuperFrog) * 2 < 8 {
        instance_create(x, y, Egg)
    }

    ammo--

    if ammo > 0 {
        alarm[2] = 10
    }
} else {
    scrTarget()

    if instance_exists(target) {
        var t = target

        with instance_create(x, y, MomProjectile) {
            motion_add(point_direction(x, y, t.x, t.y) + orandom(30), 4)
            snd_play_gun(sndBallMamaFire, 0)
            image_angle = direction
            team = other.team
        }

        sprite_index = spr_fire
        snd_play_gun(sndBallMamaFire, 0)
    }
}