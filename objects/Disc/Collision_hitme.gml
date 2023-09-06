if lockstep_stop
	exit

if other.team != team && !other.inframes && hit_id > 0 {
    if team == -1 other.last_hit = sprDisc
}

if other.team != team {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, .2)
            hp -= 6
            inframes = 5
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 4)
            BackCont.shake += 3
        }

        if !hp && object_index == Player && !spirit {
            scrAchievement(29)
        }
    }

    sleep(10)
}