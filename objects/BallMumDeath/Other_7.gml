if sprite_index == sprBallMumDying {
    var ang = random(360)
    team = 1

    repeat 80 {
        with instance_create(x, y, EnemyBullet2) {
            motion_add(ang, 4)
            image_angle = direction
            team = other.team
            hit_id = sprBallMumIdle
        }

        with instance_create(x, y, AcidStreak) {
            motion_add(ang, 8)
            image_angle = direction
        }

        ang += 4.5
    }

    instance_create(x - 32, y - 32, PortalClear)
    instance_create(x - 32, y + 32, PortalClear)
    instance_create(x + 32, y - 32, PortalClear)
    instance_create(x + 32, y + 32, PortalClear)
    snd_play_hit_big(sndBallMamaDead2, 0.1)

    with instance_create(x, y, Corpse) {
        sprite_index = sprBallMumDead
        mask_index = sprite_index
        image_xscale = other.image_xscale
        size = 2
    }

    instance_destroy()
}