if other.team != team {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, 0.2)

            hp -= 30
            sprite_index = spr_hurt
            image_index = 0

            motion_add(other.direction, 8)

            BackCont.shake += 5
            inframes = 5
        }
    }
}