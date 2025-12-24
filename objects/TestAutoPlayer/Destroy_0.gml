with (Player) {
	can_die = true
	can_walk = true
	can_aim = true
	can_shoot = true
	can_spec = true
	
	if (!max_hp) max_hp = 1
	if (!hp) hp = max_hp
}