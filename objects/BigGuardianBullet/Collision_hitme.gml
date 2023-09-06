if lockstep_stop
	exit

if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if typ != 0 && other.team != team && other.hp > 0 {
    with other {
        hp -= 12
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 4)
    }

    snd_play_hit(other.snd_hurt, .2)
    instance_destroy()
}