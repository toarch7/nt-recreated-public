/// @description Populate groups

for(var i = 0; i < group_count; ++i) {
	if (i > 0) {
		group_names[i] = loc("Ammo:Type", i - 1, typ_name[i - 1])
	}
	else {
		group_names[i] = loc("CustomMode.Weapon:Special", "SPECIAL")
	}
	
	groups[i] = []
}

var _current_weapon_key = get_weapon_key(),
	_current_weapon = scrCustomParam(_current_weapon_key)

for(var _weapon_id = 1; _weapon_id <= maxwep; ++_weapon_id) {
	var _type = scr_weapon_get_type(_weapon_id)
	
	if (scr_weapon_get_area(_weapon_id) > 0
		|| _weapon_id == wep_revolver || _weapon_id == wep_rusty_revolver
		|| _weapon_id == wep_chicken_sword || _weapon_id == wep_black_sword
		|| _weapon_id == wep_golden_revolver || _weapon_id == wep_ion_cannon
		|| _weapon_id == wep_sentry_gun || _weapon_id == wep_party_gun
		|| _weapon_id == wep_guitar
	) {
		var _group_index = _type + 1
		
		if (scr_weapon_is_melee(_weapon_id) || _weapon_id == wep_jackhammer) {
			_group_index = 1 // Melee
		}
		
		array_push(groups[_group_index], _weapon_id)
	}
}

array_foreach(groups, function(_group) {
	array_sort(_group, function(a, b) {
		var _x = loc("Weapons", a, "Name", scr_weapon_get_name(a)),
			_y = loc("Weapons", b, "Name", scr_weapon_get_name(b)),
			_u = scr_weapon_get_area(a),
			_v = scr_weapon_get_area(b)
		
		if (_u < 0) _u = 1000 + a
		if (_v < 0) _v = 1000 + b
		
		if (scr_weapon_is_golden(a)) _u += 500
		if (scr_weapon_is_golden(b)) _v += 500
		
		return sign(_u - _v)
	})
})

if (scr_weapon_is_valid(_current_weapon)) {
	var _type = scr_weapon_get_type(_weapon_id),
		_group = groups[_type + 1]
	
	if (!array_contains(_group, _current_weapon)) {
		array_push(_group, _current_weapon)
	}
}

// Special
groups[0] = [ -1, wep_none ]