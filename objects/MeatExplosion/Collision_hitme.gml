if other.team != team {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, .2)
            hp -= 4
            inframes = 5
            sprite_index = spr_hurt
            image_index = 0
            motion_add(point_direction(other.x, other.y, x, y), 4)
            sleep(10)
            BackCont.shake += 2
        }
    }
}