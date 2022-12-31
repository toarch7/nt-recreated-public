if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.team != team {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, .2)
            hp -= 44
            inframes = 5
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 8)
            sleep(60)
            BackCont.shake += 7
        }
    }
}