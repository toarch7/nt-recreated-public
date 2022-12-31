if hitable {
    instance_change(BecomeNothing, 1)

    snd_stop(sndBecomeNothingStartup)
    snd_play(sndThroneHitAwake)
    snd_stop(sndNothingSielence)

    with MusCont {
        snd_stop(song)
        audio_sound_set_track_position(amb, irandom(audio_sound_length(amb)))
    }

    flame = sprThroneFlameEnd
    flameanim = 0

    with instance_create(x - 81, y - 38, BulletHit) {
        sprite_index = sprThroneFlameEnd;
        image_angle = 0
    }
    with instance_create(x + 81, y - 38, BulletHit) {
        sprite_index = sprThroneFlameEnd;
        image_angle = 0
    }
    with instance_create(x - 81, y + 18, BulletHit) {
        sprite_index = sprThroneFlameEnd;
        image_angle = 0
    }
    with instance_create(x + 81, y + 18, BulletHit) {
        sprite_index = sprThroneFlameEnd;
        image_angle = 0
    }
}

if other.typ {
    instance_destroy(other.id, 1)
}