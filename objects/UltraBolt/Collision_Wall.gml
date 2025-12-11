if wallbreak > 0 {
	var _wall = other.id,
		_x2 = x + hspeed,
		_y2 = y + vspeed
	
	while instance_exists(_wall) {
		scrWallDestroy(_wall)
		
		if (can_decrement_this_frame) {
			_wall = collision_rectangle(
				_x2 - 2, _y2 - 2, _x2 + 2, _y2 + 2, Wall, true, false)
			
			can_decrement_this_frame = false
			wallbreak --
		}
	}
}

if (!wallbreak) event_inherited()