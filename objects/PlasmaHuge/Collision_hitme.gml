if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.team != team and other.hp > 0 {
    with other {
        hp -= floor(other.dmg * other.image_xscale)
        image_index = 0
        sprite_index = spr_hurt
        motion_add(other.direction, 1)
        if speed > 16 speed = 16
    }

    if other.hp > 0 {
        image_xscale -= .1
        x -= hspeed
        y -= vspeed
    }

    snd_play_hit(other.snd_hurt, .2)
}