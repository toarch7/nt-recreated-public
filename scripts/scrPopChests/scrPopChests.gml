function scrPopChests() {
	random_set_seed(rng_next_int(RNGStates.Chest))

	var dir = 0
	var gol = 1
	var wgol = 0
	var agol = 0
	var rgol = 0

	if instance_exists(Player) && GameCont.area != 107 {
		if scr_skill_get(mut_open_mind) {
			dir = choose(1, 2, 3)
			
			if dir == 1 wgol = GameCont.openminds
			if dir == 2 agol = GameCont.openminds
			if dir == 3 rgol = GameCont.openminds
		}
	}

	if GameCont.area == 100 {
		if instance_exists(CrownObject) {
			with instance_furthest(10016, 10016, WeaponChest) {
				instance_create(x, y, ProtoChest)
				instance_destroy(id, 0)
			}
		}

		gol = 0
		wgol = 0
		agol = 0
		rgol = 0
	}

	if (GameCont.area == 0) or ((GameCont.area == 107) or (GameCont.area == 106) && GameCont.subarea == 3) {
		gol = 0
		wgol = 0
		agol = 0
		rgol = 0
	}

	if (GameCont.area == 106 or GameCont.area == 7) && GameCont.subarea == 3 {
		rgol = 0
	}
	
	#region restrict chest amount
	
	if instance_exists(WeaponChest) && GameCont.area != 107 {
		do {
			with instance_nearest(10016 + orandom(250), 10016 + orandom(250), WeaponChest)
				instance_destroy(id, 0)
		}
		until instance_number(WeaponChest) <= gol + wgol
	}

	if instance_exists(RadChest) {
		do {
			with instance_nearest(10016 + orandom(250), 10016 + orandom(250), RadChest)
				instance_destroy(id, 0)
		}
		until instance_number(RadChest) <= gol + rgol
	}
	
	if instance_exists(AmmoChest) {
		do {
			with instance_nearest(10016 + orandom(250), 10016 + orandom(250), AmmoChest)
				instance_destroy(id, 0)
		}
		until instance_number(AmmoChest) <= gol + agol
	}
	
	if (gol) > 0 {
		scrReplacePropWithChest(RadChest)
		scrReplacePropWithChest(WeaponChest)
		scrReplacePropWithChest(AmmoChest)
	}
	
	#endregion
	
	instance_destroy(ChestOpen)
	instance_destroy(FXChestOpen)
	
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
	
	if GameCont.crown == 3 {
		with RadChest {
			instance_create(x, y, HealthChest)
			instance_destroy(id, 0)
		}
	}
	
	if GameCont.crown == 9 {
		with chestprop {
			if object_index != ProtoChest && object_index != RogueChest {
				instance_create(x, y, AmmoChest)
				instance_destroy(id, 0)
			}
		}

		with RadChest {
			instance_create(x, y, AmmoChest)
			instance_destroy(id, 0)
		}

		with WeaponChest {
			instance_create(x, y, AmmoChest)
			instance_destroy(id, 0)
		}
	}
	
	#endregion
	
	if instance_exists(Player) {
		with AmmoChest {
			if random(11) < 1 && (GameCont.area >= 2 or GameCont.loops) && GameCont.area != 107 {
				instance_create(x, y, Mimic)
				image_speed = 0.4
				instance_change(Wind, Player)
			}
		}

		with WeaponChest {
			if random(4) < GameCont.nochest && GameCont.area != 107 {
				curse = 0
				instance_change(BigWeaponChest, Player)
				event_perform(0, 0)
				exit
			}
		}

		with HealthChest {
			if random(51) < 1 && (GameCont.area >= 2 or GameCont.loops >= 1) {
				instance_create(x, y, SuperMimic)
				image_speed = 0.4
				instance_change(Wind, Player)
			}
		}
	}
	
	if global.hardmode && ((GameCont.loops - global.hardmode) <= 0 && GameCont.area == 1 && GameCont.subarea == 1) {
		with Player {
			instance_create(x, y, BigWeaponChest)
		}
	}
	
	if GameCont.area == 104 {
		with WeaponChest {
			instance_create(x, y, CursedBigChest)
			instance_create(x, y, PortalClear)
			instance_destroy(id, 0)
		}

		with BigWeaponChest {
			instance_create(x, y, CursedBigChest)
			instance_create(x, y, PortalClear)
			instance_destroy(id, 0)
		}
	}
}

function scrReplacePropWithChest(obj) {
	if instance_exists(obj) or GameCont.area == 0 or (GameCont.area == 7 && GameCont.subarea == 3) or GameCont.area >= 100
		exit
	
	var furthest = 0,
		inst = noone
	
	with prop {
		var dis = distance_to_point(10016, 10016)
		
		// man that's a lot
		if object_index == VaultStatue or object_index == ProtoStatue or object_index == IceFlower
		or object_index == CarVenus or instance_is(self, RadChest) or object_index == BecomeScrapBoss
		or object_index == MeleeFake or object_index == LastIntro
			continue
		
		if dis > 160 && dis > furthest
			inst = id
	}
	
	if instance_exists(inst) {
		with inst {
			instance_destroy(id, 0)
			instance_create(x, y, obj)
		}
	}
}