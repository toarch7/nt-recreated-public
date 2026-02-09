if lockstep_stop
	exit

if (!scrGameIsGenerationScreen() && !instance_exists(GameOver)) {
    if instance_exists(Cinematic) {
        with (Cinematic) {
            view_xview = round(lerp(view_xview, (x - view_width / 2), 0.1))
            view_yview = round(lerp(view_yview, (y - view_height / 2), 0.1))
        }
		
        camera_set_view_pos(view_camera, view_xview, view_yview)
		
        exit
    }
	
	var _dir = 0,
		_dis = 0,
		_dir2 = 0,
		_dis2 = 0,
		_poi = noone,
		_viewdist = 4
	
    /**/ if instance_exists(Portal) _poi = Portal
    else if instance_exists(BecomeNothing) _poi = BecomeNothing
    else if instance_exists(BecomeNothing) _poi = Nothing2Appear
    else if instance_exists(NothingDeath) _poi = NothingDeath
    else if instance_exists(Nothing2Death) _poi = Nothing2Death
    else if instance_exists(SitDown) _poi = SitDown
	
	if instance_exists(TutCont) && instance_exists(WeaponChest) {
		_poi = WeaponChest
	}

    with Player if (index == global.index) {
        if scr_weapon_is_melee(wep) {
			_viewdist = 8
		}
		else if scr_weapon_get_type(wep) == Ammo.Bolts {
			_viewdist = 3
		}
		
	    if instance_exists(_poi) {
	        var _instance = instance_nearest(x, y, _poi)
	        _dis = point_distance(x, y, _instance.x, _instance.y) / 6
	        _dir = point_direction(x, y, _instance.x, _instance.y)
			
	        if (_poi == Portal || instance_is(_poi, WeaponChest)) {
	            _dis = min(_dis, 72)
	        }
	    }
		
	    if !UberCont.localcoop {
	        _dir2 = KeyCont.dir_fire[index]
			
	        if UberCont.opt_gamepad {
	            var gpx = gamepad_axis_value(0, gp_axisrh)
	            var gpy = gamepad_axis_value(0, gp_axisrv)
	            _dis2 = (point_distance(0, 0, gpx, gpy) * 72) / _viewdist
	        }
			else if UberCont.opt_keyboard {
	            //_dis2 = point_distance(x, y, mouse_x, mouse_y) / _viewdist
				_dis2 = KeyCont.dis_fire[index] / _viewdist
	        }
			else if instance_exists(JoystickAttack) && !save_get_value("contorls", "aimbot", 0) {
	            _dir2 = KeyCont.dir_fire[index]
	            _dis2 = JoystickAttack.vdis / _viewdist
	        }
	    }
		
		var _sx = ldrx(_dis, _dir) + ldrx(_dis2, _dir2),
			_sy = ldry(_dis, _dir) + ldry(_dis2, _dir2)
		
		if (UberCont.opt_shake > 0) {
			var _shake = other.shake * UberCont.opt_shake
			_sx += orandom(_shake)
			_sy += orandom(_shake)
		}
		
		if (bleed) {
			var _any = false
			
			with (ChickenHead) if (index == other.index) {
				_any = true
				view_xview = lerp(view_xview, x - view_width * 0.5, 0.5)
				view_yview = lerp(view_yview, y - view_height * 0.5, 0.5)
				break
			}
			
			if (!_any) break
		}
		
        view_xview = round(lerp(view_xview, x - view_width * 0.5 + other.viewx2 + _sx, 0.4))
        view_yview = round(lerp(view_yview, y - view_height * 0.5 + other.viewy2 + _sy, 0.4))
	}
}

viewx2 = round(viewx2 - viewx2 * 0.4)
viewy2 = round(viewy2 - viewy2 * 0.4)

if UberCont.opt_shake <= 0 {
    shake = 0
    viewx2 = 0
    viewy2 = 0
}

if shake > 10 {
    shake *= power(0.8, timescale)
}
else if shake > 0 {
    shake -= timescale
    if shake <= 0 {
        shake = 0
    }
}