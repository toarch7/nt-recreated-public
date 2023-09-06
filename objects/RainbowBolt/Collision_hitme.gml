if lockstep_stop
	exit

if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.object_index == BecomeNothing exit
if variable_instance_exists(other.id, "hit") && other.hit exit

if speed > 0 and other.team != team {
    snd_play_hit(other.snd_hurt, .2)

    if other.hp >= 10 {
        with other {
            hp -= 20
            image_index = 0
            sprite_index = spr_hurt
            motion_add(other.direction, 8)
        }

        target = other.id
        with instance_create(x, y, BoltStick) {
            image_angle = other.image_angle
            target = other.target
        }

        instance_destroy()
        exit
    }

    if other.hp < 10 && !other.inframes {
        with other {
            hp -= 10
            inframes = 5
            image_index = 0
            sprite_index = spr_hurt
            motion_add(other.direction, 6)
        }
    }
}