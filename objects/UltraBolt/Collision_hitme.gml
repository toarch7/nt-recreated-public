if damage && other.team != team {
    snd_play_hit(other.snd_hurt, 0.2)
    if other.hp >= 20 {
        with other {
            hp -= 45

            if object_index == Player {
                hit_id = other.hit_id
            }

            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 8)
            if speed > 16 speed = 16
        }

        target = other.id
        with instance_create(x, y, BoltStick) {
            sprite_index = other.sprite_index
            image_angle = other.image_angle
            target = other.target
        }

        instance_destroy()
    } else if other.hp < 20 {
        with other {
            hp -= 20
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 6)
        }
    }
}