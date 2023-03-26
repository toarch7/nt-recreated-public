event_inherited();

if !roll {
    fuel = 100
    angle = 0
	
    if walk > 0 {
		motion_add(direction, 0.8)
        walk--
    }

    if speed > 3
		speed = 3

    if instance_exists(target) {
        if target.speed > 0 or hp < max_hp {
			freeze ++
		}
		
        if !target.can_shoot {
			freeze += 3
		}
	}

    exit
}

fuel--
if fuel <= 0 {
    roll = 0
    fuel = 0
    //with instance_create(x, y, EliteGruntFlame)
}

if instance_exists(target) motion_add(target_direction, 0.4)

speed = 7
angle = direction - 90
instance_create(x + orandom(3), y + orandom(3), Dust)