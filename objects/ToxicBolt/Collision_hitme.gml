if lockstep_stop
	exit

if speed > 0 and other.team != team {
    snd_play_hit(other.snd_hurt, .2)
    if other.hp >= 8 {
        instance_destroy()

        with other {
            hp -= 16
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 8)
        }
        target = other.id
        with instance_create(x, y, BoltStick) {
            image_angle = other.image_angle
            target = other.target
        }
    }
    if other.hp < 8 and other.sprite_index != other.spr_hurt {
        with other {
            hp -= 8
            sprite_index = spr_hurt
            image_index = 0
            motion_add(other.direction, 6)
        }
    }
}