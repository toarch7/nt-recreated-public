if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if typ != 0 && !other.inframes && other.team != team && other.hp > 0 {
    with other {
        if !inframes or object_index != Player {
            hp -= 5

            sprite_index = spr_hurt
            image_index = 0

            motion_add(other.direction, 4)

            inframes = 5

            last_hit = other.hit_id
        }
    }

    snd_play_hit(other.snd_hurt, 0.2)
    instance_destroy()
}