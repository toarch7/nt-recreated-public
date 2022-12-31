audio_stop_sound(snd)
snd_play_hit_big(sndFlameCannonEnd, 0.3)
instance_create(x, y, PortalClear)

ang = random(360)
repeat(20) {
    with(instance_create(x, y, Flame)) {
        hit_id = other.hit_id
        motion_add(random(360), (6 + random(2)))
        team = other.team
    }
}