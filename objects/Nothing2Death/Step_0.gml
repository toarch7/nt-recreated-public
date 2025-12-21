if lockstep_stop
	exit

if ((alarm[0] > 5) && (random(3) < 1)) {
    with(instance_create(((x + random(200)) - 100), ((y + random(200)) - 100), choose(Explosion, GreenExplosion, SmallExplosion)))
    hitid = other.hitid
    snd_play_hit(sndExplosionS, 0.2)
}