if meleedamage > 0 && canmelee && team != other.team {
    if other.inframes exit

    with other {
        if sprite_index != spr_hurt {
            snd_play_hit_big(other.snd_mele, .2)
            sprite_index = spr_hurt
            image_index = 0
            last_hit = other.hit_id
            snd_play_hit(snd_hurt, .2)
            hp -= other.meleedamage
            motion_add(point_direction(other.x, other.y, x, y), 4)
        }
    }

    hp -= 3
    alarm[1] = 30
}