if lockstep_stop
	exit

if !speed && other.hp < other.max_hp * 0.7 {
    other.rad += 10
    snd_play(sndStatueXP)
    with instance_create(x + orandom(3), y + orandom(3), RadEat)
    sprite_index = sprEatBigRad
    instance_destroy()
}