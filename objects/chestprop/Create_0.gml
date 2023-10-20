if instance_exists(MenuGen) {
	instance_destroy(id, 0); exit
}

friction = 0.4
image_speed = 0

//motion_add(random_angle, 2)

dropseed = rng_next_int(RNGSlot.Drops)

spr_dead = -1