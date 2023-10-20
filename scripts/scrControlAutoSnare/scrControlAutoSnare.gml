function scrControlAutoSnare(){
	with Player {
		if index != global.index
			continue
		
		if race == 5 && player_pref(playerinstance, "plant") && (KeyCont.release_fire[index] or KeyCont.press_fire[index]) {
			var _x = x + ldrx(426 / 2, gunangle),
				_y = y + ldry(240 / 2, gunangle)
			
			var e = collision_line(x, y, _x, _y, enemy, true, false)
			
			if instance_exists(e) && !collision_line(x, y, e.x, e.y, Wall, true, false) {
				var g = gunangle,
					need = true
				
				with e {
					if place_meeting(x, y, Tangle)
						need = false
				}
				
				if instance_exists_var(TangleSeed, "creator", id)
					need = false
				
				if need {
					gunangle = point_direction(x, y, e.x, e.y)
					
					KeyCont.press_spec[index] = true
					scrPowers()
					
					gunangle = g
				}
			}
		}
	}
}