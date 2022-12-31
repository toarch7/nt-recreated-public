if other.object_index == ProtoStatue {
    instance_create(x, y, Rad)
    instance_destroy()
    exit
}

if !scr_can_hit() exit

if other.team != team && other.hp > 0 && (!other.inframes or other.object_index != Player) {
    with other {
        hp -= 2

        if other.team == 2 {
            raddrop++
        }

        inframes = 5
        last_hit = other.hit_id

        image_index = 0
        sprite_index = spr_hurt
        motion_addm(other.direction, 2)
    }

    snd_play_hit(other.snd_hurt, 0.2)
    instance_destroy()
}