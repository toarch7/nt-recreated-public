if (distance_to_object(Player) > 64) {
    if (sprite_index != spr_idle) {
        if (sprite_index == spr_to) sprite_index = spr_idle
        else {
            snd_play_hit(sndCuzBye, 0.1)
            sprite_index = spr_to
        }
    }
} else if (sprite_index != spr_heya) {
    if (sprite_index == spr_from) sprite_index = spr_heya
    else {
        snd_play_hit(sndCuzGreet, 0.1)
        sprite_index = spr_from
    }
}