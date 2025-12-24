function scrPopChests() {
	
	var _tot_chests = 1,
		_weapon_chests = 0,
		_ammo_chests = 0,
		_rad_chests = 0,
		_max_subarea = GameCont.maxsubarea
	
	if GameCont.area == area_vault {
		if instance_exists(CrownObject) {
			with instance_furthest(10016, 10016, WeaponChest) {
				instance_create(x, y, ProtoChest)
				instance_destroy(id, 0)
			}
		}
		
		_tot_chests = 0
	}
	else if (GameCont.area == area_campfire || GameCont.area == area_crib
		|| (GameCont.area == area_hq && GameCont.subarea == _max_subarea)
	) {
		_tot_chests = 0
	}
	else if (GameCont.area != area_crib) {
		repeat (scr_skill_get(mut_open_mind) * 2) {
			var _kind = choose(1, 2, 3)
			if (_kind == 1) _weapon_chests ++
			if (_kind == 2) _ammo_chests ++
			if (_kind == 3) _rad_chests ++
		}
	}
	
	#region restrict chest amount
	
	if (_tot_chests > 0) {
		if instance_exists(WeaponChest) && GameCont.area != area_crib {
			do {
				with instance_nearest(10016 + orandom(250), 10016 + orandom(250), WeaponChest)
					instance_destroy(id, false)
			}
			until instance_number(WeaponChest) <= _tot_chests + _weapon_chests
		}
		
		if instance_exists(RadChest) {
			do {
				with instance_nearest(10016 + orandom(250), 10016 + orandom(250), RadChest)
					instance_destroy(id, false)
			}
			until instance_number(RadChest) <= _tot_chests + _rad_chests
		}
		
		if instance_exists(AmmoChest) {
			do {
				with instance_nearest(10016 + orandom(250), 10016 + orandom(250), AmmoChest)
					instance_destroy(id, false)
			}
			until instance_number(AmmoChest) <= _tot_chests + _ammo_chests
		}
		
		// in the case if some chests didn't spawn
		scrReplacePropWithChest(RadChest)
		scrReplacePropWithChest(WeaponChest)
		scrReplacePropWithChest(AmmoChest)
	}
	else {
		instance_destroy(chestprop, false)
		instance_destroy(RadChest, false)
	}
	
	#endregion
	
	#region rad chest permutations
	
	with RadChest {
		if scrPlayerCountRace(Race.Rogue) {
			instance_create(x, y, RogueChest)
			instance_destroy(id, 0)
			continue
		}
		
		var _noradch = GameCont.noradch
		
		if _noradch > 0 {
			instance_destroy(id, false)
			
			if _noradch >= 2 && !GameCont.horror {
				instance_create(x, y, HostileHorror)
				snd_play(sndEXPChest)
				
				GameCont.horror = true
			}
			else {
				instance_create(x, y, RadChestBig)
			}
			
			continue
		}
		
		var _player = instance_random(Player), _halfhealth = false
		
		with Player {
			if (hp < max_hp / 2) _halfhealth = true
		}
		
		if _halfhealth && rng_float(RNGStates.Chest, 2) < 1 {
			instance_create(x, y, HealthChest)
			instance_destroy(id, false)
			continue
		}
		
		var _f = instance_nearest(x - 16, y - 16, Floor)
			
		if instance_exists(_f) && _f.styleb && GameCont.area == area_desert && rng_float(RNGStates.Chest, 3) < 1 {
			instance_create(x, y, RadMaggotChest)
			instance_destroy(id, false)
		}
	}
	
	#endregion
	
	#region crowns
	
	if scrCrownCheck(crwn_life) {
		with RadChest {
			instance_create(x, y, HealthChest)
			instance_destroy(id, 0)
		}
	}
	
	if scrCrownCheck(crwn_love) {
		with chestprop {
			if object_index != ProtoChest && object_index != RogueChest {
				instance_create(x, y, AmmoChest)
				instance_destroy(id, false)
			}
		}

		with RadChest {
			instance_create(x, y, AmmoChest)
			instance_destroy(id, false)
		}
	}
	
	#endregion
	
	#region mimics
	if instance_exists(Player) && GameCont.area != area_crib {
		with AmmoChest {
			if random(11) < 1 && (GameCont.area >= area_sewers || GameCont.loops) {
				instance_create(x, y, Mimic)
				instance_destroy(id, false)
			}
		}

		with WeaponChest {
			if random(4) < GameCont.nochest {
				instance_create(x, y, BigWeaponChest)
				instance_destroy(id, false)
			}
			else if random(26) < 1 && (GameCont.area >= area_scrapyards || GameCont.loops >= 1) {
				instance_create(x, y, WepMimic)
				instance_destroy(id, false)
			}
		}

		with HealthChest {
			if random(51) < 1 && (GameCont.area >= area_sewers || GameCont.loops >= 1) {
				instance_create(x, y, SuperMimic)
				instance_destroy(id, false)
			}
		}
	}
	
	#endregion
	
	if global.hardmode && ((GameCont.loops - scrGameIsHardmode()) <= 0 && GameCont.area == area_desert && GameCont.subarea == 1) {
		with (Player) instance_create(x, y, BigWeaponChest)
	}
	
	if GameCont.area == area_cursed_caves {
		with WeaponChest {
			instance_create(x, y, CursedBigChest)
			instance_create(x, y, PortalClear)
			instance_destroy(id, false)
		}
	}
}

function scrReplacePropWithChest(_object) {
	if (instance_exists(_object) || GameCont.area == area_campfire || GameCont.area >= 100
		|| (GameCont.area == area_hq && GameCont.subarea == GameCont.maxsubarea)
	) {
		exit
	}
	
	var _distance_max = infinity, _instance = noone
	
	with prop {
		var _distance = distance_to_point(10016, 10016)
		
		if (object_index == VaultStatue || object_index == ProtoStatue || object_index == IceFlower
		|| object_index == CarVenus || instance_is(self, RadChest) || object_index == BecomeScrapBoss
		|| object_index == MeleeFake || object_index == LastIntro || object_index == VenuzCouch) {
			continue
		}
		
		if (_distance > 160 && _distance > _distance_max) {
			_distance_max = _distance
			_instance = id
		}
	}
	
	if instance_exists(_instance) {
		with _instance {
			instance_destroy(id, false)
			instance_create(x, y, _object)
		}
	}
}