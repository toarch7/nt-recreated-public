repeat (5) {
	with (instance_create(x + orandom(3), y + orandom(3), Explosion)) {
		hitid = other.hitid
	}
}
repeat (3) {
	with (instance_create(x + orandom(3), y + orandom(3), SmallExplosion)) {
		hitid = other.hitid
	}
}

if (GameCont.area == area_crib) {
	with (NewCarPlz) alarm[1] = 150
	instance_create(xstart, ystart, NewCarPlz)
}

repeat (6) {
    with instance_create(x, y, GroundFlame) {
        move_contact_solid(random_angle, 4 + random(16))
    }
}

corpse = false

event_inherited()

snd_play(sndExplosionCar)
snd_stop(sndCarLoop)