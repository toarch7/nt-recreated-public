if lockstep_stop
	exit

if image_index < 1 {
	image_index += random(0.04)
}
else {
	image_index += 0.4
}

var _player = noone,
	_least = infinity

if instance_number(Player) > 1 {
	with Player {
		if !scr_weapon_is_valid(wep) continue
		
		var _t1 = scr_weapon_get_type(wep),
			_t2 = scr_weapon_get_type(bwep),
			_x1 = _t1 ? ammo[_t1] : 999,
			_x2 = _t2 ? ammo[_t2] : 999
		
		var _ammo_score;
		if scr_weapon_is_valid(bwep) {
			_ammo_score = (_x1 + _x2) * 0.5
		}
		else _ammo_score = _x1
		
		if _ammo_score < _least {
			_least = _ammo_score
			_player = id
		}
	}
}
else {
	_player = instance_find(Player, 0)
}

if instance_exists(_player) {
	var _distance = 32 + (64 * scr_skill_get(mut_plutonium_hunger))
	if distance_to_object(_player) < _distance || instance_exists(Portal) {
		var _direction = point_direction(x, y, _player.x, _player.y)
		
		var _x = ldrx(6, _direction)
		if place_free(x + _x, y) x += _x
		
		var _y = ldry(6, _direction)
		if place_free(x, y + _y) y += _y
	}
	
	if place_meeting(x, y, Portal) {
		with _player {
			with other {
				event_perform(ev_collision, Player)
			}
			break
		}
	}
}
