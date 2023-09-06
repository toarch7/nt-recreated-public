if lockstep_stop
	exit

if other.team != team && other.hp > 0 {
    with other {
        if object_index == Player && !cantoxic {
            exit
        }

        if !inframes or object_index != Player {
            with other {
                instance_destroy()
            }

            if object_index == Player && cantoxic {
                hit_id = other.hit_id
            }

            snd_play_hit(snd_hurt, 0.2)

            if object_index == Player inframes = 5

            hp -= 2
            sprite_index = spr_hurt
            image_index = 0
        }
    }
}