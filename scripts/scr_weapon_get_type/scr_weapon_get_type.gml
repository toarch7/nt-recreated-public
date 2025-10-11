function scr_weapon_is_valid(_weapon_id) {
	return is_numeric(_weapon_id) && _weapon_id > 0 && _weapon_id <= maxwep
}

function scr_weapon_get_name(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_name[_weapon]
	
	return "WEAPON" + string(_weapon)
}

function scr_weapon_get_type(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_type[_weapon]
	
	return Ammo.None
}

function scr_weapon_get_cost(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_cost[_weapon]
	
	return -1
}

function scr_weapon_get_load(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_load[_weapon]
	
	return -1
}

function scr_weapon_get_sprite(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_sprt[_weapon]
	
	return -1
}

function scr_weapon_get_loadout_sprite(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_lout[_weapon]
	
	return -1
}

function scr_weapon_is_golden(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_gold[_weapon]
	
	return -1
}

function scr_weapon_is_melee(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_mele[_weapon]
	
	return -1
}

function scr_weapon_is_disabling_aim_assist(_weapon) {
	if scr_weapon_is_valid(_weapon)
		return wep_naim[_weapon]
	
	return false
}