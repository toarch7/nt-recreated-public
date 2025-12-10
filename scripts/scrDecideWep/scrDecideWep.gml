/// @function scrDecideWep
/// @param tier_extra=0
/// @param curse=false
function scrDecideWep(_extra, _curse = false) {
	var _seed = variable_struct_exists(self, "dropseed") ? dropseed : rng_next_int(RNGStates.WeaponDrops),
		_target = instance_nearest(x, y, Player),
		_tier_max = GameCont.hard + _extra,
		_hardmode = scrGameIsHardmode(),
		_tier_min = -1
	
	random_set_seed(_seed)
	
	if (_hardmode) _tier_max = (_tier_max - 13) / 3
	
    if (_curse) _tier_min = median(3, 1, ceil(_tier_max + _extra))
    
	var _robots = scrPlayerCountRace(Race.Robot)
	
	if _robots {
		_tier_max += _robots
		
		if scrUltraCheck(Race.Robot, UltraSkill.RefinedTaste) {
			_tier_min = 6
		}
	}
	
	var _iteration = 0
	while ((++_iteration) < 1_000) {
		var _wep = irandom_range(1, maxwep - 1)
		
		if (scr_weapon_is_valid(_wep) && scr_weapon_get_area(_wep) >= 0
			&& scr_weapon_get_area(_wep) >= _tier_min && scr_weapon_get_area(_wep) < _tier_max
		) {
			if instance_exists(_target) && _target.race != Race.Steroids && (_target.wep == _wep || _target.bwep == _wep) {
				continue
			}
			
			if instance_exists(TutCont) {
				if scr_weapon_get_type(_wep) == Ammo.None || scr_weapon_get_type(_wep) == Ammo.Explosives {
					continue
				}
			}
			
			if ((_wep == wep_super_disc_gun && !_curse)
				|| ((_wep == wep_golden_disc_gun || _wep == wep_golden_nuke_launcher) && !_hardmode)
				|| (_wep == wep_gun_gun && !scrCrownCheck(crwn_guns))
			) {
				continue
			}
			
			break
		}
	}
	
	if (variable_struct_exists(self, "wep") && !instance_is(self, Player)) wep = _wep
	
    return _wep
}