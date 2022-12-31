var dmg = 1 + skill_get(20)

if size >= other.size - 1 && speed > 2 && !other.inframes {
    with other {
        hp -= round(dmg + other.speed / 5)

        sprite_index = spr_hurt
        image_index = 0

        motion_add(other.direction, other.speed / 2)
        snd_play_hit(snd_hurt, 0.2)

        inframes = 5
    }

    if skill_get(20) {
        instance_create(x, y, ImpactWrists)

        snd_play_hit(sndImpWristHit, 0.2)

        if !other.hp {
            snd_play_hit(sndImpWristKill, 0.2)
        }
    }

    //sleep(2 * size * size)

    speed /= 2
}