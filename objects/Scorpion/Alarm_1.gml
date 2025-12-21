alarm[1] = 30 + random(10)

scrTarget()

if (!instance_exists(target)) {
	scrWalkRandom(0.4, 10, 20)
	if (hspeed != 0) right = sign(hspeed)
	alarm[1] = walk + irandom_range(10, 30)
	exit
}

if instance_exists(target) {
    var _target_direction = mcr_target_direction
	
	scrWalk(_target_direction + orandom(60) + 180, 0, 10, 20)
	if (hspeed != 0) right = sign(hspeed)
	
	speed = 0.4
	
	if scrTargetIsVisible(target, 210) && random(2) < 1 {
        alarm[1] = 30 + random(5)
        alarm[2] = 1
        gunangle = _target_direction
		if (target.x != x) right = sign(target.x - x)
        snd_play(sndScorpionFireStart)
        ammo = 10
    }
	
	if point_distance(x, y, target.x, target.y) < 64 {
        direction = _target_direction + orandom(10)
		if point_distance(x, y, target.x, target.y) > 32 {
			direction += 180
		}
        walk = 40
    }
}
else if (random(10) < 1) {
	scrWalkRandom(0.4, 10, 20)
	if (hspeed != 0) right = sign(hspeed)
}
