enum Ammo {
	None,
	Bullets,
	Shells,
	Bolts,
	Explosives,
	Energy,
	NUM_AMMO_TYPES
}

function scrAmmoInit() {
	typ_name = array_create(Ammo.NUM_AMMO_TYPES, "N/A")
    typ_ammo = array_create(Ammo.NUM_AMMO_TYPES, 0)
    typ_amax = array_create(Ammo.NUM_AMMO_TYPES, 0)
	
	typ_name[Ammo.None] = "NONE"
	typ_name[Ammo.Bullets] = "BULLETS"
	typ_name[Ammo.Shells] = "SHELLS"
	typ_name[Ammo.Bolts] = "BOLTS"
	typ_name[Ammo.Explosives] = "EXPLOSIVES"
	typ_name[Ammo.Energy] = "ENERGY"
	
	scrAmmoUpdateTypeStats()
}

function scrPlayerAmmoInit() {
	ammo = array_create(Ammo.NUM_AMMO_TYPES, 0)
	ammo[Ammo.None] = 999
}

/// @function scrAmmoDecideType
/// @param {Id.Instance} player
/// @param prioritize_primary_weapon=true
function scrAmmoDecideType(_player, _prioritize_primary = false) {
	if !instance_exists(_player) || _player.race == Race.BigDog || (_player.wep == 0 && _player.bwep == 0) {
		return irandom_range(Ammo.Bullets, Ammo.NUM_AMMO_TYPES - 1)
	}
	
	with _player {
		var _atype = scr_weapon_get_type(wep),
			_btype = scr_weapon_get_type(bwep),
			_extra_count = array_length(extra_weps)
		
		if (_extra_count > 0 && random(1) > (1 / (_extra_count + 1))) {
			_btype = scr_weapon_get_type(extra_weps[irandom(_extra_count - 1)])
		}
		
		if (_prioritize_primary || !bwep) {
			if (_atype != Ammo.None && ammo[_atype] < typ_amax[_atype]) {
				return _atype
			}
			
			if (_btype != Ammo.None && ammo[_btype] < typ_amax[_btype]) {
				return (_atype != Ammo.None) ? choose(_atype, _btype) : _btype
			}
		}
		else {
			var _type = choose(_atype, _btype)
			
			if (_type != Ammo.None && ammo[_type] < typ_amax[_type]) {
				return _type
			}
		}
	}
	
	return irandom_range(Ammo.Bullets, Ammo.NUM_AMMO_TYPES - 1)
}

/// @function scrAmmoDecideTypeMystery
/// @param {Id.Instance} player
function scrAmmoDecideTypeMystery(_player) {
	var _ammo_type;
	
	do {
		_ammo_type = irandom_range(Ammo.Bullets, Ammo.NUM_AMMO_TYPES - 1)
	}
	until !(instance_exists(_player)
		&& (scr_weapon_get_type(_player.wep) == _ammo_type
		|| scr_weapon_get_type(_player.bwep) == _ammo_type))
	
	return _ammo_type
}

/// @function scrAmmoGetPickupAmount
/// @param {Enum.Ammo} ammo_type
function scrAmmoGetPickupAmount(_type) {
	if _type >= Ammo.Bullets && _type < Ammo.NUM_AMMO_TYPES {
		return typ_ammo[_type]
	}
	
	return 0
}

/// @function scrAmmoGetTypeCapacity
/// @param {Enum.Ammo} ammo_type
function scrAmmoGetTypeCapacity(_type) {
	if _type >= Ammo.Bullets && _type < Ammo.NUM_AMMO_TYPES {
		return typ_amax[_type]
	}
	
	return 0
}

function scrAmmoUpdateTypeStats() {
	typ_ammo[Ammo.Bullets] = 32
	typ_ammo[Ammo.Shells] = 8
	typ_ammo[Ammo.Bolts] = 7
	typ_ammo[Ammo.Explosives] = 6
	typ_ammo[Ammo.Energy] = 10
	
	typ_amax[Ammo.None] = 1000
	typ_amax[Ammo.Bullets] = 255
	typ_amax[Ammo.Shells] = 55
	typ_amax[Ammo.Bolts] = 55
	typ_amax[Ammo.Explosives] = 55
	typ_amax[Ammo.Energy] = 55
	
	//
	if (!instance_exists(Player)) exit
	
    var _fish_players = scrPlayerCountRace(Race.Fish)
	
    if _fish_players > 0 {
        typ_ammo[Ammo.Bullets] += 8 * _fish_players
        typ_ammo[Ammo.Shells] += 2 * _fish_players
        typ_ammo[Ammo.Bolts] += 2 * _fish_players
        typ_ammo[Ammo.Explosives] += 2 * _fish_players
        typ_ammo[Ammo.Energy] += 3 * _fish_players
    }
	
    var _back_muscle = scr_skill_get(mut_back_muscle)
	
	if _back_muscle != 0 {
		typ_amax[Ammo.Bullets] += 300 * _back_muscle
		for(var i = Ammo.Shells; i < Ammo.NUM_AMMO_TYPES; ++i) {
			typ_amax[i] += 44 * _back_muscle
		}
	}
	
	var _haste = scrCrownCheck(crwn_haste)
	
	if _haste != 0 {
		typ_ammo[Ammo.Bullets] += _haste
        typ_ammo[Ammo.Shells] += _haste
        typ_ammo[Ammo.Bolts] += _haste
        typ_ammo[Ammo.Explosives] += _haste
        typ_ammo[Ammo.Energy] += _haste
	}
}

