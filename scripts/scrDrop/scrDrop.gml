global.party_gun_special_drop = false

/// @function scrDrop(ammo,weapon)
/// @param ammo
/// @param weapon
function scrDrop(_pickup_chance, _weapon_chance) {
    var _player = instance_nearest(x, y, Player)
	
	if (_player == noone) exit
	
    //roll
	var _seed = variable_struct_exists(self, "dropseed") ? dropseed : rng_next_int(RNGStates.Pickups)
	
    random_set_seed(_seed)
	
	var _need = 0,
		_confiscate = false,
		_anything_dropped = false,
		_max_hp = _player.max_hp,
		_hp = _player.hp,
		_paw_chance = 0
	
    if (scrCrownCheck(crwn_guns)) {
		_weapon_chance += 9
	}
	
    if (scr_skill_get(mut_rabbit_paw)) {
		_paw_chance = 1 + scr_skill_get(mut_rabbit_paw) * 0.6
	}
	
	with (_player) {
		if scr_ultra_get(Race.Fish, UltraSkill.Confiscate) && random(1) < 0.2 {
			_confiscate = true
		}
		
		var _slot = wep, _first = true
		
		repeat (2) {
			if scr_weapon_is_valid(_slot) {
				var _type = scr_weapon_get_type(_slot),
					_cap = scrAmmoGetTypeCapacity(_type)
				
				if (ammo[_type] < _cap * 0.2) _need += 0.75
				else if (ammo[_type] > _cap * 0.6) _need += 0.1
				else _need += 0.5
			}
			else if (!_first) _need += 0.5
			
			_first = false
			_slot = bwep
		}
	}
	
	if scrCrownCheck(Crown.Risk) {
		_pickup_chance *= (_hp >= _max_hp) ? 1.5 : 0.5
	}
	
	if (_paw_chance != 0) _need += _paw_chance
	
    if _pickup_chance > 0 && random(100) < _pickup_chance {
		var _advantage = (scrGameIsHardmode() ? 1.5 : 2)
		
		// Health
        if random(_max_hp) > _hp && random(3) < _advantage && !scrCrownCheck(crwn_life) {
			var _object = (_confiscate ? HealthChest : HPPickup)
			instance_create(x + orandom(2), y + orandom(2), _object)
			_anything_dropped = true
		}
		// Ammo
        else if !scrCrownCheck(crwn_guns) {
			var _object = (_confiscate ? AmmoChest : AmmoPickup)
			instance_create(x + orandom(2), y + orandom(2), _object)
			_anything_dropped = true
		}
		
		if (_paw_chance != 0 && _anything_dropped) instance_create(x, y, RabbitPaw)
	}
	// Drop weapons
	else if _weapon_chance > 0 {
        if random(100) < _weapon_chance {
            //drop weps
			if _confiscate {
				instance_create(x + orandom(2), y + orandom(2), WeaponChest)
			}
			else {
				var _wep = scrDecideWep(0)
				scrWeaponPickupCreate(x + orandom(2), y + orandom(2), _wep, true)
			}
			
			_anything_dropped = true
        }
    }

    if UberCont.birthday && !_anything_dropped && random(1) <= 0.05 {
        if !global.party_gun_special_drop {
			scrWeaponPickupCreate(x + orandom(2), y + orandom(2), wep_party_gun, true)
            global.party_gun_special_drop = true
			_anything_dropped = true
        }
    }
	
	return _anything_dropped
}