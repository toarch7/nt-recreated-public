/// @function scrBoltTrail
/// @param sprite=sprBoltTrail
function scrBoltTrail(_sprite = sprBoltTrail) {
	if GameCont.area == area_oasis {
		if random(1) < 0.4 {
			instance_create(x, y, Bubble)
		}
		
		return noone
	}
	
	var _x1 = x,
		_y1 = y,
		_x2 = xprevious,
		_y2 = yprevious
	
	with instance_create(x, y, BoltTrail) {
		image_angle = point_direction(_x1, _y1, _x2, _y2)
		image_xscale = point_distance(_x1, _y1, _x2, _y2)
		sprite_index = _sprite
		
		return id
	}
	
	return noone
}