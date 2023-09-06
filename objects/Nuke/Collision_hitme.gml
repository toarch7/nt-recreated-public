if lockstep_stop
	exit

if other.team != team {
    instance_destroy()

    with other {
        hp -= 50
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 10)
    }
}