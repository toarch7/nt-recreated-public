function scrBloodAmmoRefill(_wep) {
	var _type = scr_weapon_get_type(_wep)
	
	scrPlayerGiveAmmo(id, _type, scr_weapon_get_cost(_wep))
	
	var _hitid = HitId.None
	
	/**/ if (_wep == wep_blood_launcher) _hitid = HitId.BloodLauncher
	else if (_wep == wep_blood_launcher) _hitid = HitId.BloodCannon
	
	scr_hit_self(1, _hitid)
}