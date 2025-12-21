repeat (3) {
	with (instance_create(x + orandom(3), y + orandom(3), Explosion)) hitid = other.hitid
}

repeat (6) {
    instance_create(x + orandom(24), y + orandom(24), GroundFlame)
}

corpse = false

event_inherited()

snd_play(sndExplosionCar)