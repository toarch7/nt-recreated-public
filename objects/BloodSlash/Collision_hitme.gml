if scr_projectile_generic_hit(false) {
	if instance_exists(other) {
		var _x, _y;
		
		with other {
			_x = bbox_center_x
			_y = bbox_center_y
		}
		
		instance_create(_x, _y, MeatExplosion)
	}
	
	hit = true
}