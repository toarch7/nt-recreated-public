with(instance_nearest(x, y, Corpse)) {
    mask_index = mskBandit
    if (place_meeting(x, y, other) && ((sprite_index != mskNone) && place_free(x, y))) {
        snd_play_hit_big(sndFreakPopoRevive, 0.1)
        with instance_create(x, y, ReviveFX)
        sprite_index = sprPopoRevive

        instance_change(PopoFreak, 1)

        depth = -2

        GameCont.kills -= 1
    }
}
snd_play_hit_big(sndNecromancerRevive, 0.2)
instance_destroy()