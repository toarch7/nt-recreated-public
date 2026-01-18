if (hammerhead && hammering > 6) {
	hammering = 12
	hammerhead --
	
	snd_play_hit(hammerhead ? sndHammerHeadProc : sndHammerHeadEnd, 0.1)
	
	instance_create(other.x + 8, other.y + 8, Hammerhead)
	
	scrWallDestroy(other.id)
	
	exit
}

if (hammerhead) hammering += timescale * 2

if !roll && race != Race.Frog {
	var _iteration = 0, _px = x, _py = y;
	
	if (instance_exists(Floor)) while (place_meeting(x, y, Wall)) {
		if ((++_iteration) > 100) {
			scrWallDestroy(other.id)
			x = _px
			y = _py
			break
		}
		
		var _floor = noone,
			_fx = x,
			_fy = y,
			_distance_max = infinity,
			_wx, _wy;
		
		with (other) {
			_wx = bbox_center_x
			_wy = bbox_center_y
		}
		
		with (Floor) {
			var _distance = point_distance(bbox_center_x, bbox_center_y, _wx, _wy)
			if (_distance < _distance_max) {
				_distance_max = _distance
				_fx = bbox_center_x
				_fy = bbox_center_y
				_floor = id
			}
		}
		
		if (!instance_exists(_floor)) break
		
		var _direction = point_direction(x, y, _fx, _fy),
			_x = x + ldrx(1, _direction),
			_y = y + ldry(1, _direction)
		
		x = _x
		y = _y
		
		if (!place_meeting(x, y, Wall)) break
	}
	
	move_contact_solid(direction, clamp(speed, 1, maxspeed))
	
	if place_meeting(x + hspeed, y, Wall) {
		hspeed /= 2
		
		if place_meeting(x + hspeed, y, Wall) {
			hspeed = 0
		}
	}
	
	if place_meeting(x, y + vspeed, Wall) {
		vspeed /= 2
		
		if place_meeting(x, y + vspeed, Wall) {
			vspeed = 0
		}
	}
	
	x += hspeed
	y += vspeed
}
else {
	move_bounce_solid(true)
	
	if (race != Race.Frog) {
		angle += ((720 - abs(angle)) * right * 0.7)
	}
	
	x += hspeed
	y += vspeed
}