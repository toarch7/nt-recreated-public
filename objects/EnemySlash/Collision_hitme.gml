if other.team != team {
    with other {
        if !inframes {
            if object_index == Player last_hit = other.hit_id

            snd_play_hit(snd_hurt, .2)
            hp -= other.damage
            inframes = 5
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 8)
            sleep(100)
            BackCont.shake += 8
        }
    }
}