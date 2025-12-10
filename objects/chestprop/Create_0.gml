if instance_exists(MenuGen) {
	instance_destroy(id, 0); exit
}

friction = 0.4
image_speed = 0

//motion_add(random_angle, 2)

dropseed = rng_next_int(RNGStates.WeaponDrops)

spr_dead = -1

spr_shadow = shd24
spr_shadow_x = 0
spr_shadow_y = -1