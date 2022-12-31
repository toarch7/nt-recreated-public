if !speed && other.hp < other.max_hp * 0.7 {
    other.rad++snd_play(sndStatueXP)

    instance_create(x + random_spread(3), y + random_spread(3), RadEat)

    instance_destroy()
}