if fire > 0 {
    alarm[2] = 2

    with instance_create(x, y, FiredMaggot) {
        motion_add(other.gunangle + random(2) - 1, 5)
    }

    fire--snd_play_hit_big(sndFlyFire, 0.3)
}