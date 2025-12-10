if other.object_index == ProtoStatue {
    with instance_create(x, y, Rad) {
		motion_add(other.direction, other.speed)
	}
	
    instance_destroy()
}
else if scr_projectile_generic_hit(true, false) {
	with (other) {
		if (team == team_enemy) raddrop ++
	}
}