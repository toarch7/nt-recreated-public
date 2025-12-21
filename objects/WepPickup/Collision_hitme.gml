if (speed > 4 && mask_index != mskWepPickup && scr_can_hit(other.id)) {
	var _level = (instance_is(creator, Player) ? GameCont.level : 0)
	
	if (!scr_hit(other.id, 22 + 2 * _level)) exit
	
	instance_create(x, y, ThrowHit)
	
	// pierce through
	if (instance_is(creator, Player) && creator.race == Race.Chicken && scr_skill_get(mut_throne_butt)) {
		speed *= 0.8
	}
	else {
		friction = 0.5
		motion_add(point_direction(other.x, other.y, x, y), speed * 1.5)
		speed /= 3
		speed ++
	}
}