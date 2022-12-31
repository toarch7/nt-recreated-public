if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.team != team {
    instance_destroy()
    snd_play_hit(other.snd_hurt, .2)
    sleep(50)
    with other {
        hp -= 6
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 6)
    }
}