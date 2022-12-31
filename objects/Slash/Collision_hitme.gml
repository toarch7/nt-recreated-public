if other.team != team && !other.inframes {
    with other {
        if !inframes {
            snd_play_hit(snd_hurt, 0.2)

            hp -= other.dmg
            sprite_index = spr_hurt
            image_index = 0

            motion_addm(other.direction, 8)

            BackCont.shake += 5

            last_hit = other.hit_id

            inframes = 5
        }
    }

    if guitar {
        var snd = asset_get_index("sndGuitarHit" + string(irandom(6) + 1))

        if sound_exists(snd) {
            snd_play_hit(snd, 0.2)
        }
    }
}