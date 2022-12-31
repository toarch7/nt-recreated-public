if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.inframes && other.object_index == Player exit

if other.team != team {
    with other {
        if !inframes {
            hp -= 30
            inframes = 1
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 10)
        }
    }

    snd_play_hit(other.snd_hurt, .2)
    instance_destroy()
}