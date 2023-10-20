if sprite_index == spr_disappear {
    if instance_exists(creator) && skill_get(5) {
        with creator {
            repeat 6 + irandom(3) {
                with instance_create(x, y, AnimParticle) {
                    sprite_index = sprCrystalTBTrail

                    if other.bskin {
                        sprite_index = sprCrystalBTBTrail
                    }

                    image_speed = 0.4

                    motion_add(random_angle, 3 + random(2))

                    friction = 0.4

                    depth = -7
                }
            }

            var flor = instance_nearest(mouse_x, mouse_y, Floor)
			
			if flor {
	            x = flor.x + flor.sprite_width / 2
	            y = flor.y + flor.sprite_height / 2
			}
			
            xprevious = x
            yprevious = y
        }
    }

    with creator {
        canshield = ceil(other.time / 3)
    }

    instance_destroy()
} else {
    image_index = 3
    image_speed = 0
}