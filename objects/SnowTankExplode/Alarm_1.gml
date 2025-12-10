snd_play(sndExplosionL)

repeat (3) {
    instance_create(x + orandom(4), y + orandom(4), Explosion)
}

with instance_create(x, y, Corpse) {
    size = 2
    sprite_index = sprSnowTankDead
    if other.sprite_index == sprGoldTankExplode {
        sprite_index = sprGoldTankDead
    }
}

instance_destroy()

repeat 5 {
    with (instance_create(x, y, GroundFlame)) {
	    move_contact_solid(random_angle, 8 + random(16))
	}
}