if lockstep_stop
	exit

scrFirstFrameAnim(0.4)

var _least_strikes = 100,
	_player = noone

with (Player) {
	if (race == Race.Rogue && rogue_ammo < _least_strikes) {
		_least_strikes = rogue_ammo
		_player = id
	}
}

if (instance_exists(_player)) {
	var _distance = 32 + scr_skill_get(mut_plutonium_hunger) * 64
	
	if (point_distance(x, y, _player.x, _player.y) < _distance || instance_exists(Portal)) {
		var _direction = point_direction(x, y, _player.x, _player.y),
			_x = ldrx(6, _direction),
			_y = ldry(6, _direction)
		
		if (place_free(x + _x, y)) x += _x
		if (place_free(x, y + _y)) y += _y
	}
	
	if (place_meeting(x, y, Portal)) {
		if (instance_exists(_player)) {
			x = _player.x
			y = _player.y
		}
		
	    with (_player) with (other) {
			event_perform(ev_collision, _player)
		}
	}
}

