function scrPopulate() {
	global.rng_state[0] = global.seed + GameCont.area + GameCont.subarea + GameCont.loops
	random_set_seed(global.rng_state[0])
	
	var _difficulty = GameCont.hard,
		_area = GameCont.area,
		_subarea = GameCont.subarea,
		_loops = GameCont.loops

	var _actual_loops = _loops
	
	if global.hardmode {
		_actual_loops --
	}

	//setting area && spawning some enemies
	with Floor {
		spawnarea = GameCont.area
		
		if rng_range(RNGStates.Enemies, 0, 10 + _difficulty) < _difficulty {
			if point_distance(x, y, 10016, 10016) > 120 && !place_meeting(x, y, [ chestprop, prop]) {
				scrPopEnemies()
			}
		}

		if random(6) < 1 {
			instance_create(x + random(32), y + random(32), Detail)
		}
	}

	//COOL BONES

	with Floor {
		if spawnarea == area_desert {
			if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) {
				instance_create(x, y, Bones)
				instance_create(x, y + 16, Bones)
				
				with instance_create(x + 32, y, Bones) {
					image_xscale = -1
				}
				
				with instance_create(x + 32, y + 16, Bones) {
					image_xscale = -1
				}
			}
		}
		else if spawnarea == area_scrapyards {
			if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) {
				if random(7) < 1 instance_create(x, y, Bones)
				if random(7) < 1 instance_create(x, y + 16, Bones)
				if random(7) < 1 {
					with instance_create(x + 32, y, Bones)
						image_xscale = -1
				}
				if random(7) < 1 {
					with instance_create(x + 32, y + 16, Bones)
						image_xscale = -1
				}
			}
			with Bones
			sprite_index = sprScrapDecal
		}
		else if spawnarea == area_city {
			if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) {
				if random(7) < 1 instance_create(x, y, Bones) if random(7) < 1 instance_create(x, y + 16, Bones) if random(7) < 1 {
					with instance_create(x + 32, y, Bones)
					image_xscale = -1
				}
				if random(7) < 1 {
					with instance_create(x + 32, y + 16, Bones)
					image_xscale = -1
				}
			}
			with Bones
			sprite_index = sprIceDecal
		}
		else if spawnarea == area_caves {
			if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) {
				if rng_float(RNGStates.Props, 9) < 1 instance_create(x, y, Bones) if rng_float(RNGStates.Props, 9) < 1 instance_create(x, y + 16, Bones) if rng_float(RNGStates.Props, 9) < 1 {
					with instance_create(x + 32, y, Bones)
					image_xscale = -1
				}
				if random(9) < 1 {
					with instance_create(x + 32, y + 16, Bones)
					image_xscale = -1
				}
			}
			with Bones
			sprite_index = sprCaveDecal
		}
		if spawnarea == area_sewers {
			if !place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) && rng_float(RNGStates.Props, 10) < 1 {
				instance_create(x, y + 16, Bones)
				with instance_create(x + 32, y + 16, Bones)
				image_xscale = -1
			}
			with Bones
			sprite_index = sprSewerDecal
		}
	}

	// making sure there are enough enemies && spawning props/lil walls
	var _enemy_cap = 3 + _difficulty / 1.5
	with Floor {
		spawnarea = _area
		
		if instance_number(enemy) < _enemy_cap && !place_meeting(x, y, prop) && !place_meeting(x, y, chestprop) {
			if point_distance(x, y, 10016, 10016) > 110 {
				scrPopEnemies()
			}
		}
		
		scrPopProps()
	}

	// CoB second pass
	if scrCrownCheck(crwn_blood) {
		with Floor {
			if rng_float(RNGStates.Enemies, 10 + _difficulty) < _difficulty {
				scrPopEnemies()
			}
		}
	}

	// cursed caves enemy replacement
	if _area == area_cursed_caves {
		with LaserCrystal {
			instance_create(x, y, InvLaserCrystal)
			instance_destroy(id, false)
		}

		with Spider {
			instance_create(x, y, InvSpider)
			instance_destroy(id, false)
		}
	}

	// cluster enemy spawns
	if _loops > 0 {
		random_set_seed(global.rng_state[RNGStates.Enemies])

		with enemy {
			if random(60) < _loops {
				repeat 3 + _loops {
					instance_create(x + random(8) - 4, y + random(8) - 4, object_index)
				}

				instance_create(x, y, PortalClear)
			}
		}
	}

	instance_destroy(NOWALLSHEREPLEASE)

	// spawning chests
	if _area != area_campfire {
		scrPopChests()
	}
	
	// spawn desert boss
	if _area == area_desert {
		instance_create(x, y, WantBoss)
	}
	
	// venuz car
	if _area == area_scrapyards && _subarea == 1 {
		with instance_furthest(10016, 10016, Car) {
			instance_create(x, y, CarVenus)
			instance_change(Wind, false)
		}

		if !instance_exists(CarVenus) {
			var _floor = instance_furthest(10016, 10016, Floor)
			if instance_exists(_floor) {
				with _floor {
					instance_create(bbox_center_x, bbox_center_y, CarVenus)
				}
			}
		}
	}

	// bandits camping chests
	if _area != area_campfire && (_area < area_city || _area >= area_vault) && _area != area_hq && _area != area_crib {
		with chestprop {
			instance_create(bbox_center_x, bbox_center_y, Bandit)
		}
		with RadChest {
			instance_create(bbox_center_x, bbox_center_y, Bandit)
		}
	}

	// pizza sewers entrance
	if _area == area_sewers {
		with Floor {
			if sprite_index == sprFloor2 && (image_index == 1 || image_index == 5) {
				instance_create(x, y, PizzaEntrance)
			}
		}

		while instance_number(PizzaEntrance) > 1 {
			var _px = 10016 + rng_orandom(RNGStates.Generation, 120),
				_py = 10016 + rng_orandom(RNGStates.Generation, 120)
			
			with instance_nearest(_px, _py, PizzaEntrance) {
				instance_destroy()
			}
		}
	}

	// populate pizza sewers
	if _area == area_pizza_sewers {
		var _instance = instance_furthest(10016, 10016, enemy),
			_x = 10016,
			_y = 10016
		
		if (!instance_exists(_instance)) {
			_instance = instance_furthest(10016, 10016, Floor)
		}

		with _instance {
			_x = bbox_center_x
			_y = bbox_center_y
		}
		
		repeat(4) {
			instance_create(_x + orandom(2), _y + orandom(2), Turtle)
		}
		
		instance_create(_x, _y, Rat)
		
		instance_destroy(enemy, false)
		instance_destroy(Corpse, false)
	}

	// popo on your lawn
	if instance_exists(Player) && scrAreaCanHavePopo() {
		with Player {
			if race == Race.Rogue {
				instance_create(10016, 10016, WantPopo)
			}
		}

		repeat _loops {
			instance_create(10016, 10016, WantPopo)
		}

		if _area == area_campfire {
			repeat _loops {
				instance_create(10016, 10016, IDPDSpawn)
			}
		}
		else if !GameCont.novans {
			repeat _actual_loops {
				instance_create(10016, 10016, WantVan)
			}
		}
	}
	
	if _loops && _area == area_labs {
		with enemy {
			if distance_to_object(TechnoMancer) > 120 && point_distance(x, y, 10016, 10016) > 160 {
				instance_create(x, y, TechnoMancer)
			}
		}

		do {
			with instance_nearest(10016, 10016, TechnoMancer) {
				instance_destroy()
			}
		} until instance_number(TechnoMancer) <= 2 + GameCont.loops
		
		random_set_seed(global.rng_state[RNGStates.Enemies])
		
		with TechnoMancer {
			repeat(6) {
				instance_create(x + orandom(60), y + orandom(60), PortalClear)
			}
		}
	}
}