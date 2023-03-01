event_inherited()

if walk > 0 {
    walk -= 1
    motion_add(direction, 0.8)
}

if speed > 3.5 speed = 3.5

if instance_exists(target) {
    if target.speed > 0 or hp < max_hp {
		freeze += 1
	}
	
    if !target.can_shoot {
		freeze += 3
	}
}