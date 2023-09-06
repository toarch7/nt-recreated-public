if lockstep_stop
	exit

if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.inframes && other.object_index == Player exit

if other.team != team && speed > 0 {
    with other {
        if !inframes {
            hp -= 40
            inframes = 1
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 16)
        }
    }

    snd_play_hit(other.snd_hurt, .2)

    if other.hp > 40 instance_destroy()
}