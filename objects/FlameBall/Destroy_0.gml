audio_stop_sound(snd)
snd_play_hit_big(sndFlameCannonEnd, 0.3)
instance_create(x, y, PortalClear)

repeat(20) {
    with(instance_create(x, y, Flame)) {
        hitid = other.hitid
        motion_add(random_angle, (6 + random(2)))
        team = other.team
    }
}