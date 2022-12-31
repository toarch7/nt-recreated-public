if variable_instance_exists(other.id, "hit") && other.hit exit

if other.inframes && other.object_index == BecomeNothing exit

if speed > 0 && other.team != team && other.hp > 0 {
    with other {
        hp -= 4
        sprite_index = spr_hurt
        image_index = 0
        inframes = 5
        motion_add(other.direction, 2)

        if speed > 14 speed = 14

        snd_play_hit(snd_hurt, .2)
    }

    target = other.id

    with instance_create(x, y, BoltStick) {
        sprite_index = sprSplinterStick
        image_angle = other.image_angle
        target = other.target
    }

    instance_destroy()
}