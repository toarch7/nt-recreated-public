/// @function scrLightningCreate
/// @param x
/// @param y
/// @param direction
/// @param length
function scrLightningCreate(_x, _y, _direction, _length) {
	with instance_create(
		x + ldrx(8, _direction),
		y + ldry(8, _direction),
		LightningSpawn
	) {
		image_angle = _direction
	}
	
	static __propagate_lightning = function(_ammo) {
		var _oldx, _oldy, _dst = 8 + random(4), _target_object;
		
		if team == team_player _target_object = enemy
		else if (team == team_enemy || team == team_popo) _target_object = Player
		else _target_object = hitme
		
		var _target = instance_nearest(x + ldrx(80, direction), y + ldry(80, direction), _target_object)
		
		_oldx = x
		_oldy = y
		
		speed = 4
		direction = image_angle + orandom(15)
		
		if instance_exists(_target) {
		    if point_distance(x, y, _target.x, _target.y) < 120 {
		        motion_add(point_direction(x, y, _target.x, _target.y), 1)
		    }
		}
		
		//
		x += lengthdir_x(_dst, direction)
		y += lengthdir_y(_dst, direction)
		
		var _wall = instance_place(x, y, Wall)
		
		if instance_exists(_wall) && !instance_is(_wall, InvisiWall) {
		    x = xprevious
		    y = yprevious
			direction += 180
		}
		
		//
		speed = 0
		image_angle = direction
		image_xscale = point_distance(x, y, _oldx, _oldy) * -0.5
		image_index += 0.4 / _ammo
	
		with scr_projectile_create(x, y, Lightning, direction) {
		    image_index = other.image_index
			return id
		}
		
		return noone
	}
	
	var _count = _length,
		_first = scr_projectile_create(_x, _y, Lightning),
		_projectile = _first
	
	with _projectile {
		visible = false
		image_angle = _direction
	}
	
	do {
		with _projectile {
			_projectile = __propagate_lightning(_count)
		}
		
		_count --
	}
	until (!instance_exists(_projectile) || _count <= 0)
	
	with _projectile {
		var _xs = image_xscale * 0.5,
			_ys = image_yscale * 0.5
		
		instance_create(
			x + ldrx(_xs, image_angle),
			y + ldry(_ys, image_angle),
			LightningHit)
	}
	
	return _first
}