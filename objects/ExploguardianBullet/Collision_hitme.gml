if other.team != team && other.hp > 0 && scr_can_hit() {
    with other {
        hp -= 2
        sprite_index = spr_hurt
        image_index = 0

        if object_index == Player inframes = 5

        motion_addm(other.direction, 2)
    }

    snd_play_hit(other.snd_hurt, 0.2)
    instance_destroy()
}