function scrDecideWepGold() {
	var _player = instance_nearest(x, y, Player), _wep;
    if !instance_exists(_player) exit
	
    if GameCont.loops {
        do {
			_wep = rng_choose(RNGStates.WeaponDrops,
				wep_golden_plasma_gun, wep_golden_slugger, wep_golden_splinter_gun,
				wep_golden_screwdriver, wep_golden_bazooka, wep_golden_assault_rifle)
		}
		until (_player.race == Race.Steroids || !scrPlayerHasWeapon(_player, _wep))
    }
	else {
        do {
			_wep = rng_choose(RNGStates.WeaponDrops,
				wep_golden_wrench, wep_golden_machinegun, wep_golden_shotgun,
				wep_golden_crossbow, wep_golden_grenade_launcher, wep_golden_laser_pistol)
		}
		until (_player.race == Race.Steroids || !scrPlayerHasWeapon(_player, _wep))
    }
	
	if (instance_is(self, chestprop) || instance_is(self, WepPickup)) wep = _wep
	
	return _wep
}