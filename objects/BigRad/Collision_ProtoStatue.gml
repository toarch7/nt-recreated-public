if !speed && other.hp < other.max_hp * 0.7 {
    other.rad += 10
    snd_play(sndStatueXP)
    with instance_create(x + random_spread(3), y + random_spread(3), RadEat)
    sprite_index = sprEatBigRad
    instance_destroy()
}