type = 1
image_speed = 0.4
endgame = 100

snd_play(GameCont.underwater ? sndOasisPortal : sndPortalOpen)

if instance_exists(Player) {
    with projectile {
        if (team != team_player) instance_destroy(id, 0)
	}
}

instance_create(x, y, PortalClear)
instance_create(x, y, PortalShock)

with (Player) {
	if (race != Race.Rogue) continue
	repeat (2) instance_create(other.x, other.y, IDPDSpawn)
    GameCont.popolevel -= 1.5
}

repeat (4) scrFX(x, y, PortalL, random_angle, 3)

close = false

attract_objects = function(_object_index, _attract_distance) {
	var _px = x, _py = y, _half = _attract_distance * 0.5;
	
	with (_object_index) {
		var _is_player = instance_is(self, Player),
			_distance = point_distance(x, y, _px, _py)
		
        if (_distance <= _attract_distance && !collision_line(x, y, _px, _py, Wall, 0, 0)) {
			var _spd = (_distance > _half ? 2 : 5),
				_direction = point_direction(x, y, _px, _py),
				_tx = x + ldrx(_spd, _direction),
				_ty = y + ldry(_spd, _direction)
			
			if (place_free(_tx, y)) x = _tx
			if (place_free(x, _ty)) y = _ty
			
			if (_is_player && _distance <= _half) {
				angle -= 30 * right
		        sprite_index = spr_hurt
		        image_index = 1
			}
			else if (object_index == WepPickup) {
				mp_potential_step_object(_px, _py, 1, Wall)
				image_angle -= 15 * rotspeed
			}
        }
		
		if (_is_player && _distance > _half && !roll && angle != 0) {
			angle = 0
		}
	}
}