if variable_instance_exists(other.id, "hit") && other.hit exit

if other.inframes && other.object_index == BecomeNothing exit

if speed > 0 && other.team != team {
    with other {
        hp -= 9
        sprite_index = spr_hurt
        image_index = 0
        inframes = 5
        motion_add(other.direction, 6)

        snd_play_hit(snd_hurt, 0.2)
    }

    target = other.id

    with instance_create(x, y, BoltStick) {
        sprite_index = sprSeekerStick
        image_angle = other.image_angle
        target = other.target
    }

    instance_destroy()
}