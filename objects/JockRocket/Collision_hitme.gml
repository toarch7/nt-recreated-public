if lockstep_stop
	exit

if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.team != team {
    instance_destroy()

    with other {
        hp -= 4
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 10)
    }
}