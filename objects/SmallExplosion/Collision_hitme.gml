var immune

if other.team != team && !other.inframes {
    with other {
        immune = 0
        if object_index == Player {
            if skill_get(14) {
                immune = 1
            }
        }

        if !(other.sprite_index == spr_hurt && immune) {
            snd_play_hit(snd_hurt, .2)

            if immune {
                if hp > 4 {
                    if (hp - 5) < 4 {
                        hp = 4
                    } else {
                        hp -= 5
                    }
                }

                smoke = 30
            } else {
                if object_index == Player {
                    last_hit = other.hit_id
                }

                hp -= 5
            }

            sprite_index = spr_hurt
            motion_add(point_direction(other.x, other.y, x, y), 3)
            if speed > 16 speed = 16 image_index = 0 BackCont.shake += 1
        }
    }
}