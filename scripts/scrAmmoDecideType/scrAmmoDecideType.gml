function scrAmmoInit() {
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
			_btype = scr_weapon_get_type(bwep)
		
		if (_prioritize_primary || !bwep) {
			if (_atype != Ammo.None && ammo[_atype] < typ_amax[_atype]) {
				return _atype
			}
			
			if (_btype != Ammo.None && ammo[_btype] < typ_amax[_btype]) {
				return choose(_atype, _btype)
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

/// @function scrAmmoGetTypeAmount
/// @param {Enum.Ammo} ammo_type
function scrAmmoGetTypeAmount(_type) {
	if _type >= Ammo.Bullets && _type < Ammo.NUM_AMMO_TYPES {
		return typ_ammo[_type]
	}
	
	return 0
}