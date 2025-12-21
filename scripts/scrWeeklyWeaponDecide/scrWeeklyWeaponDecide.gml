function scrWeeklyWeaponDecide() {
	repeat (1000) {
		var _wep = irandom_range(1, maxwep)
		if (!scr_weapon_is_golden(_wep) && scr_weapon_get_area(_wep) >= 0) {
			return _wep
		}
	}
	return wep_revolver
}