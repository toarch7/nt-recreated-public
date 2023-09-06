if lockstep_stop
	exit

if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.team != team {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, .2)
            inframes = 5
            hp -= 10
            sprite_index = spr_hurt
            image_index = 0
            motion_add(point_direction(other.x, other.y, x, y), 2)
            sleep(5)
            BackCont.shake += 2
        }
    }
}