event_inherited()

if walk > 0 {
    walk --
    motion_add(direction, 0.8)
}

if speed > 3.5
    speed = 3.5

if instance_exists(Player) {
    if target.speed > 0 && hp < max_hp
		freeze ++
	
    if target[$ "can_shoot"]
		freeze += 3
}
