function scr_weapon_is_valid(_weapon) {
	gml_pragma("forceinline")
	return is_numeric(_weapon) && _weapon > 0 && _weapon <= maxwep
}

function scr_weapon_get_name(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_name[_weapon] : ("WEAPON" + string(_weapon))
}

function scr_weapon_get_type(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_type[_weapon] : Ammo.None
}

function scr_weapon_get_cost(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_cost[_weapon] : -1
}

function scr_weapon_get_rads(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_rads[_weapon] : -1
}

function scr_weapon_get_area(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_area[_weapon] : -1
}

function scr_weapon_get_load(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_load[_weapon] : -1
}

function scr_weapon_get_sprite(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_sprt[_weapon] : -1
}

function scr_weapon_get_loadout_sprite(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_lout[_weapon] : -1
}

function scr_weapon_is_auto(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_auto[_weapon] : false
}

function scr_weapon_is_golden(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_gold[_weapon] : false
}

function scr_weapon_is_melee(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_mele[_weapon] : false
}

function scr_weapon_has_assist_disabled(_weapon) {
	gml_pragma("forceinline")
	return scr_weapon_is_valid(_weapon) ? wep_naim[_weapon] : false
}

function scr_weapon_is_hyper(_weapon) {
	return _weapon == wep_hyper_launcher || _weapon == wep_hyper_rifle || _weapon == wep_hyper_slugger
}