snd_stop(snd)

snd_play(sndExplosionL)

instance_create(x, y, Explosion)

var _dir = random_angle

repeat 3 {
    with instance_create(
		x + ldrx(16, _dir),
		y + ldry(16, _dir),
		SmallExplosion
	) {
        team = other.team
        hitid = other.hitid
    }

    _dir += 360 / 3
}