function scrControlAutoSnare(){
	with Player {
		if (index != global.index) continue
		
		if ((race == Race.Plant && scr_player_pref(my_player, "plant")
			&& (KeyCont.release_fire[index] || KeyCont.press_fire[index]))
		) {
			var _x = x + ldrx(426 / 2, gunangle),
				_y = y + ldry(240 / 2, gunangle),
				
				_enemy = collision_line(x, y, _x, _y, enemy, true, false)
			
			if (instance_exists(_enemy) && !collision_line(x, y, _enemy.x, _enemy.y, Wall, true, false)) {
				var _gunangle_last = gunangle,
					_need = true
				
				with _enemy {
					if (place_meeting(x, y, Tangle)) _need = false
				}
				
				if (instance_exists_var(TangleSeed, "creator", id)) {
					_need = false
				}
				
				if (_need) {
					gunangle = point_direction(x, y, _enemy.x, _enemy.y)
					KeyCont.press_spec[index] = true
					scrPowers() // fixme: this is bad for multiplayer
					gunangle = _gunangle_last
				}
			}
		}
		
		break
	}
}