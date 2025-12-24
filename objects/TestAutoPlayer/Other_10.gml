with (Player) {
	can_die = false
	can_walk = false
	can_aim = false
	can_shoot = false
	can_spec = false
	
	if (instance_exists(LevCont)) {
		with (choose(
			instance_random(SkillIcon),
			instance_random(CrownIcon),
			instance_random(UltraIcon))
		) {
			if (instance_is(self, UltraIcon)) other.ultra = true
			repeat (2) event_perform(ev_mouse, ev_left_press)
		}
	}
	
	if (place_meeting(x, y, Portal)) {
		with (instance_nearest(x, y, Portal)) event_perform(ev_alarm, 1)
	}
	
	var _goal_objects = [
			Portal, CrownPickup, AmmoPickup, HPPickup, BigGenerator,
			NothingInactive, WepPickup, enemy, becomenemy, IceFlower,
			RadChest, GiantWeaponChest, GiantAmmoChest, CarVenusFixed,
			BecomeScrapBoss, LastIntro, LastExecute
		],
		_goal_count = array_length(_goal_objects)
	
	with (SitDown) {
		if (GameCont.area == area_hq) {
			GameCont.area = area_labs
			GameCont.subarea = 0
		}
		else {
			GameCont.area = 0
			GameCont.subarea = 0
		}
		
		with (instance_create(x, y, Portal)) event_perform(ev_alarm, 1)
		
		instance_destroy()
	}
	
	with (ProtoStatue) {
		if (charged) array_insert(_goal_objects, 0, id)
	}
	
	if (instance_exists(YungVenuzCouch)) {
		array_insert(_goal_objects, 0, VenuzTV)
	}
	
	if (race == Race.Steroids) {
		KeyCont.hold_spec[index] = scr_weapon_is_valid(bwep)
	}
	else if (!(race == Race.Chicken || race == Race.Robot) || (random(1) < 0.05 && instance_exists(WepPickup))) {
		if (random(1) < 0.05) KeyCont.press_spec[index] = true
		if ((current_frame % 360) < 90) KeyCont.hold_spec[index] = true
		if (random(1) < 0.05) {
			KeyCont.release_spec[index] = true
			KeyCont.press_pick[index] = true
		}
	}
	
	if (KeyCont.press_spec[index] || KeyCont.hold_spec[index] || KeyCont.release_spec[index]) {
		scrPowers()
	}
	
	for(var i = 0; i < _goal_count; ++i) {
		var _goal_object = _goal_objects[i], _instance;
		
		if (is_numeric(_goal_object) && object_exists(_goal_object)) {
			_instance = instance_nearest(x, y, _goal_object)
		}
		else if (instance_exists(_goal_object)) {
			_instance = _goal_object
			_goal_object = _instance.object_index
		}
		else {
			_instance = noone
		}
		
		if (!instance_exists(_instance)) continue
		
		var _walk_x = x,
			_walk_y = y,
			_interact = false
		
		if (object_is_ancestor(_goal_object, chestprop)) {
			_walk_x = _instance.x
			_walk_y = _instance.y
		}
		else if (_goal_object == IceFlower || _goal_object == CarVenusFixed) {
			_walk_x = _instance.x
			_walk_y = _instance.y
			_interact = true
		}
		else if (_goal_object == WepPickup) {
			if (scr_weapon_is_valid(wep)
				&& scr_weapon_is_valid(bwep)
				&& array_length(extra_weps) >= max_extra_weps
			) {
				continue
			}
			if (_instance.speed > 0) continue
			_walk_x = _instance.x
			_walk_y = _instance.y
			if (place_meeting(x, y, _instance)) {
				_interact = true
			}
		}
		else if (object_is_ancestor(_goal_object, hitme)) {
			var _target_distance = distance_to_point(_instance.x, _instance.y),
				_goal_distance = 100
			
			if (scr_weapon_is_valid(wep) && scr_weapon_is_valid(bwep)) {
				if (!scrCheckCanShoot(wep) && scrCheckCanShoot(bwep)) || (breload > 0 && reload <= 0) {
					scrSwapWeps()
				}
				
				var _t = scr_weapon_get_type(wep),
					_t2 = scr_weapon_get_type(wep)
				
				if (ammo[_t] < scr_weapon_get_cost(wep)
					&& ammo[_t2] < scr_weapon_get_cost(bwep)
				) {
					ammo[_t] = scrAmmoGetTypeCapacity(_t)
					ammo[_t2] = scrAmmoGetTypeCapacity(_t)
				}
			}
			
			if (scr_weapon_is_valid(wep)) {
				var _t = scr_weapon_get_type(wep)
				if (ammo[_t] < scr_weapon_get_cost(wep)) {
					if (scrCheckAmmo(bwep) && scrCheckRads(bwep)) {
						scrSwapWeps()
					}
					else {
						scrPlayerGiveAmmo(id, _t, scr_weapon_get_cost(wep))
					}
				}
				
				if (scr_weapon_is_melee(wep)) {
					if (_target_distance > _goal_distance && scrCheckCanShoot(bwep)) {
						scrSwapWeps()
					}
					else {
						_goal_distance *= 0.5
					}
				}
			}
			else if (!scr_weapon_is_valid(bwep)) {
				wep = scrDecideWep(1)
			}
			else scrSwapWeps()
			
			if (scrTargetIsVisible(_instance, _goal_distance)) {
				var _fire = true
				
				if (reload) {
					if (scr_weapon_is_valid(bwep) && !breload) {
						scrSwapWeps()
					}
					else _fire = false
				}
				
				if (_fire) {
					can_shoot = true
					KeyCont.press_fire[index] = true
					KeyCont.hold_fire[index] = true
					scrPlayerFiring()
				}
			}
			else {
				_walk_x = _instance.x
				_walk_y = _instance.y
				
				if (_goal_object == NothingInactive) {
					_walk_x -= 53
				}
			}
			
			gunangle = point_direction(x, y, _instance.x, _instance.y)
			
			if (speed > maxspeed) speed = maxspeed
		}
		else {
			_walk_x = _instance.x
			_walk_y = _instance.y
		}
		
		if (!(_walk_x == x && _walk_y == y)) {
			var _dir = point_direction(x, y, _walk_x, _walk_y)
			hspeed += ldrx(maxspeed, _dir)
			vspeed += ldry(maxspeed, _dir)
			if (race == Race.Frog) speed *= 2
			x += hspeed * 0.2
			y += vspeed * 0.2
			xprevious = x
			yprevious = y
			
			mp_potential_step_object(_walk_x, _walk_y, maxspeed, Wall)
			
			draw_set_color(c_blue)
			
			draw_line(
				x - view_xview,
				y - view_yview,
				_walk_x - view_xview,
				_walk_y - view_yview)
			
			with (_instance) draw_circle(x - view_xview, y - view_yview, 16, true)
			
			draw_set_color(c_white)
		}
		
		var _wall = instance_nearest(x, y, Wall)
		if (instance_exists(_wall) && place_meeting(x + hspeed, y + vspeed, _wall)) {
			scrWallDestroy(_wall)
		}
		
		if (instance_exists(_instance)) {
			if (_interact) {
				KeyCont.press_pick[index] = true
				with (_instance) with (other.id) {
					event_perform(ev_collision, _goal_object)
				}
			}
			break
		}
	}
	
	if (!instance_exists(_instance)) {
		var _dx = 10, _dy = 10, _widest = 0
		draw_set_color(c_white)
		with (all) {
			if !(object_is_ancestor(object_index, hitme) || object_is_ancestor(object_index, becomenemy)) {
				continue
			}
			var _str = $"{x} {y} {object_get_name(object_index)}"
			draw_text_shadow_scale(_dx, _dy, _str, 0.5)
			_dy += string_height(_str) * 0.5
			var _w = string_width(_str)
			if (_widest < _w) {
				_widest += _w
			}
			if (_dy >= (gui_h - 10)) {
				_dx += _widest
				_widest = 0
				_dy = 10
			}
		}
		if ((current_frame % 90) < timescale) print("No target found!")
	}
}