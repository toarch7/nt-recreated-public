function scrPlayerGunReloadFX(_weapon) {
	var _type = scr_weapon_get_type(_weapon),
		_cost = scr_weapon_get_cost(_weapon)
	
	if (ammo[_type] < _cost && _type != Ammo.None) scrEmpty()
		
	/**/ if _type == Ammo.None snd_play(sndMeleeFlip)
	else if _type == Ammo.Bolts snd_play(sndCrossReload)
	
	var _name = scr_weapon_get_name(_weapon),
		_is_plasma = string_starts_with(_name, "PLASMA"),
		_is_lightning = string_starts_with(_name, "LIGHTNING"),
		_is_grenade = string_starts_with(_name, "GRENADE"),
		_lb = scr_skill_get(mut_laser_brain)
	
	if (_weapon == wep_toxic_launcher || _weapon == wep_hyper_launcher || _weapon == wep_nuke_launcher
		|| _weapon == wep_golden_nuke_launcher || _weapon == wep_cluster_launcher
	) {
		_is_grenade = true
	}
	
	if (_is_plasma) snd_play(_lb ? sndPlasmaReloadUpg : sndPlasmaReload)
		
	if (_is_lightning) snd_play(sndLightningReload)
	
	if (_is_grenade) snd_play(sndNadeReload)
	
	if _type == Ammo.Shells {
		var _shotgun_shoulders = scr_skill_get(mut_shotgun_shoulders)
		repeat(_cost) {
			with (scrBulletShotShellFX(Shell, 20)) {
				sprite_index = (_shotgun_shoulders ? sprShotShellBig : sprShotShell)
			}
		}
		
		wkick = -min(5, _cost)
		
		snd_play(sndShotReload)
	}
}