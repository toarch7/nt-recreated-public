if lockstep_stop
	exit

if !speed && other.hp < other.max_hp * 0.7 {
    other.rad++snd_play(sndStatueXP)

    instance_create(x + orandom(3), y + orandom(3), RadEat)

    instance_destroy()
}