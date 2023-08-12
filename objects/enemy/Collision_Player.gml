if meleedamage > 0 && canmelee && team != other.team {

    if other.inframes or (hp <= 6 && skill_get(8)) exit

    with other {
        if sprite_index != spr_hurt {
            snd_play_hit_big(other.snd_mele, 0.2)
            sprite_index = spr_hurt
            image_index = 0
            last_hit = other.hit_id
            snd_play_hit(snd_hurt, 0.2)
            hp -= other.meleedamage
            motion_add(point_direction(other.x, other.y, x, y), 4)
        }
    }

    canmelee = 0
    alarm[11] = 30
}

if size <= 2 {
    motion_add(point_direction(other.x, other.y, x, y), 1)
}