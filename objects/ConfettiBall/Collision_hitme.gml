if team != other.team {
    snd_play_hit(other.snd_hurt, .2)

    with other {
        if object_index == Player {
            last_hit = other.hit_id
        }

        hp -= 4
        sprite_index = spr_hurt
        image_index = 0

        motion_add(other.direction, 5)

        if speed > 16 {
            speed = 16
        }
    }

    if !other.hp {
        repeat 30 {
            with instance_create(x, y, Confetti) {
                motion_add(random(360), random(14))
                team = other.team
            }
        }

        snd = asset_get_index("sndConfetti" + string(irandom(6) + 1))

        if !sound_exists(snd) {
            snd = sndConfetti1
        }

        snd_play_hit_big(snd, .2)
    }

    instance_destroy()
}