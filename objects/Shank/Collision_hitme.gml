if lockstep_stop
	exit

if other.team != team {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, .2)
            hp -= 6
            sprite_index = spr_hurt
            image_index = 0
            inframes = 5
            motion_add(other.direction, 6)
            sleep(40)
            BackCont.shake += 5
        }
    }
}