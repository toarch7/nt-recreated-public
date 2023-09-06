if lockstep_stop
	exit

if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.inframes && other.object_index == Player exit

if other.team != team {
    if sticky = 1 {
        if speed > 0 snd_play(sndGrenadeStickWall) speed = 0
        x = other.x + offx
        y = other.y + offy
    } else {
        instance_destroy()
        snd_play_hit(other.snd_hurt, .2)
        with other {
            if !inframes {
                hp -= 15
                inframes = 1
                sprite_index = spr_hurt
                image_index = 0
                motion_add(other.direction, 10)
            }
        }
    }
}