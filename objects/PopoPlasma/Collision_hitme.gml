if other.team != team and other.hp > 0 {

    with other {
        if !inframes {
            hp -= round(other.dmg * other.image_xscale)
            image_index = 0
            sprite_index = spr_hurt
            motion_add(other.direction, 1)
            inframes = 5
        }
    }

    if other.hp > 0 {
        image_xscale -= .1
        x -= hspeed
        y -= vspeed
    }

    snd_play_hit(other.snd_hurt, .2)
}

if hit_id > 0 {
    other.last_hit = hit_id
}