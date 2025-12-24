scrTarget()

if (alarm[2] > 0 || !intro) {
	alarm[1] = 1
	exit
}

alarm[1] = 10 + irandom(30)

if (!can_shoot || !instance_exists(target)) {
	scrWalk(random_angle, 1, 10, 30)
	alarm[1] = walk + irandom(10) + 10
	if (!can_shoot) alarm[1] *= 0.5
	
	if (scrTargetIsVisible(target, 90)) {
		gunangle = mcr_target_direction
	}
	else {
		gunangle = direction
	}
	
	exit
}

var _distance = distance_to_point(target.x, target.y)

gunangle = mcr_target_direction

if (scrTargetIsVisible(target)) {
	// Blast
	if (_distance <= 64 && wep != wep_golden_shotgun && (target.speed < 1 || random(2) < 1)) {
		self.change_weapon(wep_golden_shotgun)
		instance_create(x, y, HitWarning)
		ammo = 1
		
		alarm[4] = irandom_range(30, 40)
		alarm[2] = 10
	}
	else if ((_distance <= 110 || random(3) < 1) && wep != wep_golden_revolver) {
		self.change_weapon(wep_golden_revolver)
		ammo = 5
		
		alarm[4] = 25 + irandom(15)
		alarm[2] = 5
	}
	else {
		self.change_weapon(wep_minigun)
		minigun_side = choose(1, -1)
		ammo = 90
		gunangle -= ammo / 2 * minigun_side + orandom(10)
		alarm[4] = 180 + irandom(40)
		alarm[2] = 4
	}
}
else {
	var _wall = collision_line(x, y, target.x, target.y, Wall, false, false)
	
	if (instance_exists(_wall) && distance_to_point(_wall.x, _wall.y) < 64) {
		mp_potential_step_object(target.x, target.y, 4, Wall)
		scrWalk(direction, 4, 10, 20)
		gunangle = direction
		alarm[1] = walk
	}
	else {
		self.change_weapon(wep_golden_bazooka)
		can_shoot = false
		ammo = 1
	}
	
	alarm[4] = 60
	alarm[2] = 7
}

if (alarm[4] != -1) {
	alarm[1] = irandom_range(5, 15)
	walk = 0
}