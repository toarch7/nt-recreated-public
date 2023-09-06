if lockstep_stop
	exit

if other.team != team and other.hp > 0 {
    with other {
        hp -= 20 + other.bonus
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 9)
        last_hit = other.hit_id
        inframes = 5
    }

    snd_play_hit(other.snd_hurt, 0.2)

    with instance_create(x, y, BulletHit) {
        sprite_index = sprSlugDisappear
        image_angle = other.direction
    }

    instance_destroy()
}