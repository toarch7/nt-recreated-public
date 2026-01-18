/// @function scrPlayerGetWeapons
/// @param player
function scrPlayerGetWeapons(_player) {
	var _result = []
	
	with (_player) {
		if (scr_weapon_is_valid(wep)) array_push(_result, wep)
		if (scr_weapon_is_valid(bwep)) array_push(_result, bwep)
		if (array_length(extra_weps)) {
			return array_concat(_result, extra_weps)
		}
	}
	
	return _result
}

/// @function scrPlayerHasWeapon
/// @param player
/// @param weapon
/// @param count_duplicates=false
function scrPlayerHasWeapon(_player, _wep, _check_duplicates=false) {
	if (_check_duplicates) {
		var _weapons = scrPlayerGetWeapons(_player),
			_count = array_length(_weapons),
			_result = 0
		
		for(var i = 0; i < _count; ++i) {
			if (_weapons[i] == _wep) _result ++
		}
		return _result
	}
	
	return array_contains(scrPlayerGetWeapons(_player), _wep)
}

/// @function scrPlayerCountGoldenWeapons
/// @param player
function scrPlayerCountGoldenWeapons(_player) {
	var _weapons = scrPlayerGetWeapons(_player),
		_count = array_length(_weapons),
		_result = 0
	
	for(var i = _count - 1; i >= 0; --i) {
		if (scr_weapon_is_golden(_weapons[i])) _result ++
	}
	
	return _result
}

/// @function scrPlayerGetWeaponSignature
/// @param player
function scrPlayerGetWeaponSignature(_player) {
	var _weapons = array_filter(scrPlayerGetWeapons(_player), function(_wep) {
		return scr_weapon_is_valid(_wep)
	})
	
	if (array_length(_weapons)) {
		array_sort(_weapons, true)
		return string_crc32(string_join_ext(":", _weapons))
	}
	
	return -1
}

/// @function scrPlayerUpdateSameWeaponsFor
/// @param player
/// @description Returns `true` when signature is updated.
function scrPlayerUpdateSameWeaponsFor(_player) {
	with (_player) {
		var _signature = scrPlayerGetWeaponSignature(id)
		
		if (_signature != last_weapon_signature || last_weapon_signature == -1) {
			last_weapon_signature = _signature
			return true
		}
	}
	
	return false
}
