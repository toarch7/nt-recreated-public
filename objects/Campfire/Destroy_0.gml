instance_create(x, y, Explosion)

if (corpse) {
	instance_create(x, y, CampfireOff)
	corpse = false
}

event_inherited()