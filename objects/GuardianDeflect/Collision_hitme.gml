if other.team != team {
    with other {
        if sprite_index != spr_hurt {
            snd_play_hit(snd_hurt, .2)
            hp -= 2
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 8)
            sleep(100)
            BackCont.shake += 8
        }
    }
}