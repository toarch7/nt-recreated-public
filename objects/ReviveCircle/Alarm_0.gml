with Corpse {
    if distance_to_object(other) <= 2 {
        if !place_meeting(x, y, Wall) {
            instance_create(x, y, ReviveFX)
            instance_change(Freak, true)

            depth = -2

            snd_play_hit(sndNecromancerRevive, 0.2)

            givekill = 0
        } else instance_destroy()
    }
}

instance_destroy()