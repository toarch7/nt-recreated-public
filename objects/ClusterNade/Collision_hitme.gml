if lockstep_stop
	exit

if other.team != team {
    snd_play_hit(other.snd_hurt, 0.2)

    with other {
        if object_index == Player last_hit = other.hit_id

        hp -= 7
        sprite_index = spr_hurt
        image_index = 0
        motion_add(other.direction, 10)

        if speed > 16 speed = 16
    }

    instance_destroy()
}