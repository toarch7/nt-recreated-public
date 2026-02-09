function scrDarkness() {
	if (instance_exists(GenCont)) exit
	
	if (!surface_exists(dark)) dark = surface_create(view_width, view_height)
	
	surface_set_target(dark)
	draw_clear(c_white)
	
	var _player = scrPlayerFindLocal(), _xview = view_xview, _yview = view_yview
	
	if instance_exists(_player) {
		var _is_eyes = (_player.race == Race.Eyes)
	    if (_is_eyes) draw_clear(c_gray)
	}
	else draw_clear(c_gray)
	
	draw_set_color(c_gray)
	
	if GameCont.area == area_sewers or GameCont.area == area_pizza_sewers {
		var _list = global.lis_floors_visible,
			_count = ds_list_size(_list)
		
	    for (var i = _count - 1; i >= 0; --i) {
			with (_list[| i]) if (styleb) {
		        draw_circle(x + 16 - _xview, y + 16 - _yview, 32 + random(4), 0)
		    }
		}
	}
	
	with (Player) draw_circle(x - _xview, y - _yview, 130 + random(4), 0)
	with (Revive) draw_circle(x - _xview, y - _yview, 130 + random(4), 0)
	with (HyperCrystal) draw_circle(x - _xview, y - _yview, 30 + dist + random(4), 0)
	with (MeatExplosion) draw_circle(x - _xview, y - _yview, 140 + random(4), 0)
	with (Explosion) {
		draw_circle(x - _xview, y - _yview, 80 * (1 + (object_index != SmallExplosion)) + random(4), 0)
	}
	with (Portal) draw_circle(x - _xview, y - _yview, 120 + random(8), 0)
	with (IDPDSpawn) draw_circle(x - _xview, y - _yview, 60 + random(8), 0)
	with (VanSpawn) draw_circle(x - _xview, y - _yview, 120 + random(8), 0)
	with (Tangle) draw_circle(x - _xview, y - _yview, 110 + random(4), 0)
	with (Ally) draw_circle(x - _xview, y - _yview, 90 + random(4), 0)
	with (Crystal) draw_circle(x - _xview, y - _yview, 90, 0)
	with (TopDecalCave) draw_circle(x - _xview, y - _yview - 8, 120, 0)
	with (Torch) draw_circle(x - _xview, y - _yview, 90 + random(4), 0)
	with (Barrel) draw_circle(x - _xview, y - _yview, 90 + random(4), 0)
	with (Terminal) draw_circle(x - _xview, y - _yview, 60 + random(4), 0)
	with (Flame) draw_circle(x - _xview, y - _yview, 70 + random(4), 0)
	with (PopoNade) draw_circle(x - _xview, y - _yview, 70 + random(4), 0)
	with (JockRocket) draw_circle(x - _xview, y - _yview, 70 + random(4), 0)
	with (CrownPickup) draw_circle(x - _xview, y - _yview, 72, 0)
	
	draw_set_color(c_black)
	
	with (Player) {
	    if (_is_eyes) {
	        draw_circle(x - _xview, y - _yview, 80 + random(3), 0)
	    }
		else {
			draw_circle(x - _xview, y - _yview, 45 + random(3), 0)
		}
	}
	
	with (Revive) {
	    if (_is_eyes) {
	        draw_circle(x - _xview, y - _yview, 80 + random(3), 0)
	    }
		else {
			draw_circle(x - _xview, y - _yview, 45 + random(3), 0)
		}
	}
	
	with (HyperCrystal) draw_circle(x - _xview, y - _yview, 30 + dist / 10 + random(3), 0)
	with (Explosion) draw_circle(x - _xview, y - _yview, 110 + random(3), 0)
	with (Portal) draw_circle(x - _xview, y - _yview, 40 + random(6), 0)
	with (IDPDSpawn) draw_circle(x - _xview, y - _yview, 20 + random(6), 0)
	with (VanSpawn) draw_circle(x - _xview, y - _yview, 40 + random(6), 0)
	with (MeatExplosion) draw_circle(x - _xview, y - _yview, 40 + random(3), 0)
	with (Tangle) draw_circle(x - _xview, y - _yview, 20 + random(3), 0)
	with (Crystal) draw_circle(x - _xview, y - _yview, 30, 0)
	with (TopDecalCave) draw_circle(x - _xview, y - _yview - 8, 45, 0)
	with (Ally) draw_circle(x - _xview, y - _yview, 30, 0)
	with (Flame) draw_circle(x - _xview, y - _yview, 30 + random(3), 0)
	with (PopoNade) draw_circle(x - _xview, y - _yview, 30 + random(3), 0)
	with (JockRocket) draw_circle(x - _xview, y - _yview, 30 + random(3), 0)
	with (Torch) draw_circle(x - _xview, y - _yview, 30 + random(3), 0)
	with (Barrel) draw_circle(x - _xview, y - _yview, 30 + random(3), 0)
	with (Terminal) draw_circle(x - _xview, y - _yview, 20 + random(3), 0)
	with (CrownPickup) draw_circle(x - _xview, y - _yview, 32, 0)
	
	surface_reset_target()
}