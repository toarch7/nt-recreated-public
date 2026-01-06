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

for(var _weapon_id = 1; _weapon_id <= maxwep; ++_weapon_id) {
	var _type = scr_weapon_get_type(_weapon_id)
	array_push(groups[_type + 1], _weapon_id)
}

// Special
groups[0] = [ wep_none, -1 ]