if lockstep_stop
	exit

if other.inframes && other.object_index == Player exit

if other.team != team {
    instance_destroy()

    with other {
        hp -= 4
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 10)
    }
}