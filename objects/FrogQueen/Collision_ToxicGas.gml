if lockstep_stop
	exit

if hp < max_hp {
	with instance_create(bbox_center_x, bbox_top - 16, AnimParticle) {
		depth = other.depth - 1
		sprite_index = sprFrogHeal
	}
	
    instance_destroy(other)
    hp ++
}