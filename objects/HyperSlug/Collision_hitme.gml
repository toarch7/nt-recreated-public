if lockstep_stop
	exit

if other.team != team && other.hp > 0 {
    with other {
        hp -= 28
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 9)
        last_hit = other.hit_id
        inframes = 5
    }

    snd_play_hit(other.snd_hurt, 0.2)

    with instance_create(other.x, other.y, BulletHit) {
        sprite_index = sprHeavySlugHit
        image_angle = random(360)
    }

    instance_destroy()
}