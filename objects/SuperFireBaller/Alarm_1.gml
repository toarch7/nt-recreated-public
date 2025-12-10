alarm[1] = 20 + random(10)

if (sprite_index != spr_hurt) sprite_index = spr_idle

scrTarget()

if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if random(5) < 4 {
            direction = mcr_target_direction + 180
			
			for(var _speed = 3; _speed <= 5; ++_speed) {
				scr_projectile_create(x, y, Fireball, direction + orandom(6), _speed)
			}
			
            snd_play(sndSuperFireballerFire)
            sprite_index = spr_fire
            image_index = 0
            alarm[1] = 8
        }
		else direction = mcr_target_direction + orandom(10)
    }
	else motion_add(random_angle, 1)
}
else motion_add(random_angle, 0.5)