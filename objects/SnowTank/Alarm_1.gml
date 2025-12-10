alarm[1] = 40 + random(30)
rest = 0

scrTarget()

if instance_exists(target) {
    if scrTargetIsVisible(target, 240) {
        if !ammo && random(6) < 1 && distance_to_object(target) > 64 {
            if instance_exists(target) {
				gunangle = mcr_target_direction
			}
			snd_play(sndSnowTankAim)
            alarm[2] = 40
            ammo = 16
        }
		
        direction = mcr_target_direction + (70 + random(40)) * choose(1, -1)
    }
	else motion_add(random_angle, 0.5)
}
else motion_add(random_angle, 0.5)