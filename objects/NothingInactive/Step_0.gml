if !hitable && distance_to_object(Player) <= 24 {
    hitable = 1
    image_speed = 0.4
    snd_play(sndBecomeNothingStartup)
    snd_loop(sndNothingSielence)

    flame = sprThroneFlameStart
    alarm[0] = 3 / 0.4

    flameanim = 0
}

x = xstart
y = ystart