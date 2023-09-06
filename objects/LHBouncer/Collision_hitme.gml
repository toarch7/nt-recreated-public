if lockstep_stop
	exit

if ((other.team != team) && (other.hp > 0) && !other.inframes) {
    if (other.object_index == Player) {
        if (!other.inframes) {
            with(other) {
                if object_index == Player last_hit = other.hit_id

                sprite_index = spr_hurt
                image_index = 0
                hp -= other.dmg
                snd_play(snd_hurt)
                motion_add(point_direction(other.x, other.y, x, y), 4)
                if (speed > 16) speed = 16
                inframes = 5
            }
        }
    } else {
        with(other) {
            snd_play_hit(snd_hurt, 0.2)
            hp -= other.dmg
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 4)
            if (speed > 16) speed = 16
        }
    }
    instance_destroy()
    with(instance_create(x, y, BulletHit))
    sprite_index = sprEnemyBulletHit
}