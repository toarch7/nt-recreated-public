if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.inframes && other.object_index == Player exit

if team != other.team {
    with other {
        hp -= 5
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 5)
        inframes = 5
    }

    instance_destroy()
    snd_play_hit(other.snd_hurt, .2)
}