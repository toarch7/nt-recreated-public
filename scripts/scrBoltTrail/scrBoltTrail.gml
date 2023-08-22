function scrBoltTrail(sprite = sprBoltTrail) {
	if GameCont.area == 101 {
		instance_create(x, y, Bubble)
		
		// no
		return noone
	}
	else {
		with instance_create(x, y, BoltTrail) {
		    image_angle = point_direction(other.x, other.y, other.xprevious, other.yprevious)
		    image_xscale = point_distance(other.x, other.y, other.xprevious, other.yprevious)
			
			sprite_index = sprite
			
			return id
		}
	}
}