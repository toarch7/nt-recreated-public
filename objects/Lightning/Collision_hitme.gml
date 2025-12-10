if scr_projectile_generic_hit(false) {
	instance_create(x, y, Smoke)
	snd_play(sndLightningHit)
}