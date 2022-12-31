if other.team != team && other.hp > 0 && !disappear {
    if other.object_index == Player {
        if other.sprite_index != other.spr_hurt {
            with other {
                if object_index == Player {
                    last_hit = sprKilledByThrone
                }

                sprite_index = spr_hurt
                image_index = 0
                hp -= 5
                snd_play(snd_hurt)
                motion_add(270, 12)
                if speed > 16 {
                    speed = 16
                }
            }
        }
    } else {
        with other {
            hp -= 5
            sprite_index = spr_hurt
            image_index = 0
            motion_add(270, 12)
            if speed > 16 {
                speed = 16
            }
        }
    }
}