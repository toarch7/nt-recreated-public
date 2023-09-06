if lockstep_stop
	exit

if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.team != team {
    instance_destroy()
    snd_play_hit(other.snd_hurt, .2)
    with other {
        hp -= 10
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 5)
    }
}