if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.inframes && other.object_index == Player exit

if other.team != team {
    with other {
        immune = 0
        if object_index == Player && skill_get(14) {
            immune = 1
        }

        if !inframes {
            snd_play_hit(snd_hurt, 0.2)
            if immune {
                if hp > 4 {
                    if hp - 12 < 4 {
                        hp = 4
                    } else hp -= 12
                }
            } else {
                hp -= 12
            }

            sprite_index = spr_hurt
            image_index = 0
            motion_add(point_direction(other.x, other.y, x, y), 6)
            if speed > 16 speed = 16
        }
    }
}