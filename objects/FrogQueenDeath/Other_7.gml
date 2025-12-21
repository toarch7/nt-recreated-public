if sprite_index == sprFrogQueenDying {
    var _ang = random_angle
	
    repeat 80 {
		scr_projectile_create(x, y, EnemyBullet2, _ang, 4)
		
        with instance_create(x, y, AcidStreak) {
            motion_add(_ang, 8)
            image_angle = _ang
        }

        _ang += 4.5
    }

    instance_create(x - 32, y - 32, PortalClear)
    instance_create(x - 32, y + 32, PortalClear)
    instance_create(x + 32, y - 32, PortalClear)
    instance_create(x + 32, y + 32, PortalClear)
    snd_play_hit_big(sndBallMamaDead2, 0.1)

    with instance_create(x, y, Corpse) {
        sprite_index = sprFrogQueenDead
        mask_index = sprite_index
        image_xscale = other.image_xscale
        size = 2
    }

    instance_destroy()
}