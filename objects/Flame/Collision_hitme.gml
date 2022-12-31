if other.team != team && !other.inframes && hit_id > 0 {
    other.last_hit = hit_id
}

if other.inframes exit

if other.team != team and other.hp > 0 {
    immune = 0
    if other.object_index == Player {
        if other.hp - 2 == 4 other.hp = min(other.max_hp, 4)
        else if skill_get(14) && other.hp <= 4 immune = 2
    }

    snd_play(sndBurn)

    with other {
        if !other.immune hp -= 2

        sprite_index = spr_hurt
        image_index = 0
        inframes = 5 + (team == 2 * 25)
        motion_add(other.direction, 0.5)
    }

    snd_play_hit(other.snd_hurt, .2)
    x = (x + other.x) / 2 + random(6) - 3
    y = (y + other.y) / 2 + random(6) - 3
    speed *= 0.8
}