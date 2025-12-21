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
		if hp < max_hp && hp < _least {
			_player = id
			_least = hp
		}
	}
}
else _player = instance_find(Player, 0)

if instance_exists(_player) {
	var _distance = 32 + (64 * scr_skill_get(mut_plutonium_hunger))
	if distance_to_object(_player) < _distance || instance_exists(Portal) {
		var _direction = point_direction(x, y, _player.x, _player.y)
		
		var _x = ldrx(6, _direction)
		if place_free(x + _x, y) x += _x
		
		var _y = ldry(6, _direction)
		if place_free(x, y + _y) y += _y
	}
}

if instance_exists(_player) && place_meeting(x, y, Portal) {
	event_perform(ev_collision, _player)
}
