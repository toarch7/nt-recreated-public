alarm[1] = 20 + random(10)

if (sprite_index != spr_hurt) sprite_index = spr_idle

scrTarget()

if (!instance_exists(target)) {
	scrWalkRandom(0.5, 0)
	exit
}

if (scrTargetIsVisible(target)) {
    if (random(5) >= 4) {
		scrWalk(mcr_target_direction + orandom(10), 0)
		exit
	}
    
	scrWalk(mcr_target_direction + 180, 0)
	
	for(var _speed = 3; _speed <= 5; ++_speed) {
		scr_projectile_create(x, y, Fireball, direction + orandom(6) + 180, _speed)
	}
	
    snd_play(sndSuperFireballerFire)
    sprite_index = spr_fire
    image_index = 0
    alarm[1] = 8
}
else scrWalkRandom(1)