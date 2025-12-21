if (sprite_index == spr_disappear) exit

if (!instance_exists(creator)) {
	sprite_index = spr_disappear
	image_speed = 0.6
	image_index = 0
	
	exit
}

with (creator) {
	if scr_ultra_get(Race.Crystal, UltraSkill.Juggernaut) {
		if (speed != 0) {
			other.walk += 0.4 * timescale
		}
		
		other.x = x
		other.y = y
		continue
	}
	
	depth = -4
	x = other.x
	y = other.y
	speed = 0
}

time += 1.6 * timescale

if (scr_skill_get(mut_throne_butt)) {
	time += timescale
	teleporting = true
	
	var _index = creator.index,
		_distance = KeyCont.dis_fire[_index],
		_direction = KeyCont.dir_fire[_index],
		_meeting = false,
		_floor = noone
	
	teleport_x = creator.x + ldrx(_distance, _direction)
	teleport_y = creator.y + ldry(_distance, _direction)
	
	_floor = instance_nearest(teleport_x - 16, teleport_y - 16, Floor)
	
	if (instance_exists(_floor)) {
		with (Player) {
			var _tx = other.teleport_x, _ty = other.teleport_y
			
			_meeting = place_meeting(_tx, _ty, _floor)
			
			if (_meeting && place_meeting(_tx, _ty, Wall)) {
				var _iteration = 0
				while (place_meeting(_tx, _ty, Wall) && ((++_iteration) < 20)) {
					var _wall = instance_nearest(_tx, _ty, Wall)
					if (!instance_exists(_wall)) break
					
					var _direction = point_direction(_wall.x, _wall.y, _tx, _ty)
					_tx += ldrx(1, _direction)
					_ty += ldry(1, _direction)
				}
				
				if (_iteration >= 20) _floor = noone
				
				other.teleport_x = _tx
				other.teleport_y = _ty
			}
		}
	
		if (instance_exists(_floor) && !_meeting) {
			if (!is_keyboard(_index)) {
				teleport_x = clamp(teleport_x, _floor.bbox_left + 10, _floor.bbox_right - 10)
				teleport_y = clamp(teleport_y, _floor.bbox_top + 10, _floor.bbox_bottom - 10)
			}
			else teleporting = false
		}
	}
	else teleporting = false
}
else teleporting = false

hold = instance_exists(creator) && KeyCont.hold_spec[creator.index]

if time >= 60 && sprite_index == spr_idle {
	sprite_index = spr_disappear
	image_speed = 0.6
	image_index = 0
	
	if (teleporting) event_user(1)
}
else if (!hold && !scr_skill_get(mut_throne_butt)) {
	sprite_index = spr_disappear
	image_speed = 0.6
	image_index = 0
}