if other.object_index == BecomeNothing exit
if variable_instance_exists(other.id, "hit") && other.hit exit

if speed > 0 and other.team != team {
    snd_play_hit(other.snd_hurt, 0.2)

    if other.hp >= 25 {
        with other {
            hp -= 50
            inframes = 5
            image_index = 0
            sprite_index = spr_hurt
            motion_add(other.direction, 8)
        }

        with instance_create(x, y, BoltStick) {
            sprite_index = sprHeavyBoltStick
            image_angle = other.image_angle
            target = other.id
        }

        instance_destroy()
        exit
    }

    if other.hp < 25 {
        with other {
            hp -= 50
            inframes = 5
            image_index = 0
            sprite_index = spr_hurt
            motion_add(other.direction, 6)
        }
    }
}