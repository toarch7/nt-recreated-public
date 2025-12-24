function scrPopulate() {
	static __props = [ prop, chestprop ]
	
	var _difficulty = GameCont.hard,
		_area = GameCont.area,
		_subarea = GameCont.subarea,
		_max_subarea = scrAreaGetMaxSubareas(_area),
		_has_boss = (_subarea == _max_subarea),
		_loops = GameCont.loops,
		
		_actual_loops = _loops - scrGameIsHardmode(),
		_coblood = scrCrownCheck(crwn_blood),
		
		_spawndist = 120
	
	with (Floor) {
		spawnarea = _area
		
		if (random(10 + _difficulty) < _difficulty
			&& point_distance(x, y, 10016, 10016) > _spawndist
			&& !place_meeting(x, y, __props)
		) {
			scrPopEnemies()
		}
		
		if (random(6) < 1) {
			instance_create(
				random_range(bbox_left, bbox_right),
				random_range(bbox_top, bbox_bottom), Detail)
		}
	}
	
	if (_area == area_city && _has_boss) _spawndist = 150
	
	random_set_seed(rng_next_int(RNGStates.Generation))
	
	#region Bone decals
	with (Floor)
	{
		if (spawnarea == area_desert) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y)) {
				instance_create(x, y, Bones)
				instance_create(x, y + 16, Bones)
				
				with (instance_create(x + 32, y, Bones))
					image_xscale = -1
				
				with (instance_create(x + 32, y + 16, Bones))
					image_xscale = -1
			}
		}
		else if (spawnarea == area_campfire) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y))
			{
				instance_create(x, y, Bones)
				instance_create(x, y + 16, Bones)
				
				with (instance_create(x + 32, y, Bones))
					image_xscale = -1
				
				with (instance_create(x + 32, y + 16, Bones))
					image_xscale = -1
			}
			
			with (Bones) sprite_index = sprNightBones
		}
		else if (spawnarea == area_scrapyards) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y)) {
				if (random(7) < 1) instance_create(x, y, Bones)
				if (random(7) < 1) instance_create(x, y + 16, Bones)
				
				if (random(7) < 1) {
					with (instance_create(x + 32, y, Bones)) image_xscale = -1
				}
				
				if (random(7) < 1) {
					with (instance_create(x + 32, y + 16, Bones)) image_xscale = -1
				}
			}
			
			with (Bones)
				sprite_index = sprScrapDecal
		}
		else if (spawnarea == area_city) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y)) {
				if (random(7) < 1) instance_create(x, y, Bones)
				if (random(7) < 1) instance_create(x, y + 16, Bones)
				
				if (random(7) < 1) {
					with (instance_create(x + 32, y, Bones)) image_xscale = -1
				}
				
				if (random(7) < 1) {
					with (instance_create(x + 32, y + 16, Bones)) image_xscale = -1
				}
			}
			
			with (Bones)
				sprite_index = sprIceDecal
		}
		else if (spawnarea == area_caves) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y)) {
				if (random(9) < 1) instance_create(x, y, Bones)
				if (random(9) < 1) instance_create(x, y + 16, Bones)
				
				if (random(9) < 1) {
					with (instance_create(x + 32, y, Bones)) image_xscale = -1
				}
				
				if (random(9) < 1) {
					with (instance_create(x + 32, y + 16, Bones)) image_xscale = -1
				}
			}
			
			with (Bones) sprite_index = sprCaveDecal
		}
		else if (spawnarea == area_cursed_caves) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y)) {
				if (random(9) < 1) instance_create(x, y, Bones)
				if (random(9) < 1) instance_create(x, y + 16, Bones)
				
				if (random(9) < 1) {
					with (instance_create(x + 32, y, Bones)) image_xscale = -1
				}
				
				if (random(9) < 1) {
					with (instance_create(x + 32, y + 16, Bones)) image_xscale = -1
				}
			}
			
			with (Bones) sprite_index = sprInvCaveDecal
		}
		else if (spawnarea == area_oasis) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y)) {
				if (random(9) < 1) instance_create(x, y, Bones)
				if (random(9) < 1) instance_create(x, y + 16, Bones)
				
				if (random(9) < 1) {
					with (instance_create(x + 32, y, Bones)) image_xscale = -1
				}
				
				if (random(9) < 1) {
					with (instance_create(x + 32, y + 16, Bones)) image_xscale = -1
				}
			}
			
			with (Bones) sprite_index = sprCoral
		}
		else if (spawnarea == area_sewers) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) && random(10) < 1) {
				instance_create(x, y + 16, Bones)
				
				with (instance_create(x + 32, y + 16, Bones)) image_xscale = -1
			}
			
			with (Bones) sprite_index = sprSewerDecal
		}
		else if (spawnarea == area_sewers) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) && random(10) < 1) {
				instance_create(x, y + 16, Bones)
				
				with (instance_create(x + 32, y + 16, Bones)) image_xscale = -1
			}
			
			with (Bones) sprite_index = sprPizzaSewerDecal
		}
		else if (spawnarea == area_jungle) {
			if (!place_free(x - 32, y) && !place_free(x + 32, y) && place_free(x, y) && random(10) < 1)
			{
				instance_create(x, y + 16, Bones)
				
				with (instance_create(x + 32, y + 16, Bones)) image_xscale = -1
			}
			
			with (Bones) sprite_index = sprJungleDecal
		}
	}
	#endregion
	
	#region Enemy & prop spawning
	
	// Enemies
	var _enemy_cap = 3 + (_difficulty / 1.5)
	random_set_seed(rng_next_int(RNGStates.Enemies))
	with (Floor) {
		if (instance_number(enemy) < _enemy_cap
			&& point_distance(x, y, 10016, 10016) > _spawndist
			&& !place_meeting(x, y, __props)
		) {
			scrPopEnemies()
		}
		
		if (_coblood && random(8 + _difficulty) < _difficulty
			&& point_distance(x, y, 10016, 10016) > _spawndist
			&& !place_meeting(x, y, __props)
		) {
			scrPopEnemies()
		}
	}
	
	// Spawn props
	random_set_seed(rng_next_int(RNGStates.Props))
	with (Floor) scrPopProps()
	
	// Y.V. Mansion car
	if (_area == area_scrapyards && _subarea == 1) {
		var _f = noone, _distance_max = -infinity
		with (Floor) {
			var _distance = point_distance(x, y, 10016, 10016)
			if (_distance > _distance_max && !place_meeting(x, y, __props)) {
				_distance_max = _distance
				_f = id
			}
		}
		with (_f) instance_create(bbox_center_x, bbox_center_y, CarVenus)
	}
	
	#endregion
	
	instance_destroy(NOWALLSHEREPLEASE)
	
	#region Chests
	random_set_seed(rng_next_int(RNGStates.Chest))
	scrPopChests()
	
	// Bandits camping near chests
	if ((_area < area_city || _area > area_vault) && _area != area_mansion && _area != area_hq) {
		with (chestprop) {
			if (place_free(x, y)) instance_create(x, y, Bandit)
		}
		
		with (RadChest) {
			if (place_free(x, y)) instance_create(x, y, Bandit)
		}
	}
	#endregion
	
	#region Pizza Sewers & Entrance
	random_set_seed(rng_next_int(RNGStates.Generation))
	if (_area == area_sewers) {
		with (Floor) {
			if (sprite_index == sprFloor2 && (image_index == 1 || image_index == 5)) {
				if (!place_meeting(x, y, __props)) instance_create(x, y, PizzaEntrance)
			}
		}
		
		while (instance_number(PizzaEntrance) > 1) {
			with (instance_nearest(
				10016 + orandom(120),
				10016 + orandom(120),
				PizzaEntrance)
			) {
				instance_destroy()
			}
		}
	}
	else if (_area == area_pizza_sewers) {
		instance_destroy(enemy, false)
		
		with (instance_furthest(10016, 10016, Floor)) {
			var _x = bbox_center_x, _y = bbox_center_y
			
			repeat (4) instance_create(_x + orandom(2), _y + orandom(2), Turtle)
			
			instance_create(_x, _y, Rat)
		}
	}
	#endregion
	
	random_set_seed(rng_next_int(RNGStates.Enemies))
	#region Popo & enemy clusters
	if (scrAreaCanHavePopo()) {
		if (scrPlayerCountRace(Race.Rogue)) {
			instance_create(10016, 10016, WantPopo)
		}
		
		repeat (_loops) {
			instance_create(10016, 10016, WantPopo)
		}
		
		if (!GameCont.novans) {
			repeat (_actual_loops) instance_create(10016, 10016, WantVan)
		}
	}
	
	if (_loops > 0 && _area != area_pizza_sewers) with (enemy) {
		if (random(60) > _loops || object_index == Mimic
			|| object_index == SuperMimic || object_index == WepMimic
			|| object_index == MaggotSpawn
		) {
			continue
		}
		
		var _cluster_object = object_index
		
		/**/ if (_cluster_object == GoldScorpion) _cluster_object = Scorpion
		else if (_cluster_object == GoldSnowTank) _cluster_object = SnowTank
		else if (_cluster_object == LightningCrystal) _cluster_object = LaserCrystal
		else if (_cluster_object == BuffGator) _cluster_object = Gator
		
		repeat (3 + _loops) {
			instance_create(x + orandom(4), y + orandom(4), _cluster_object)
		}
		
		if (distance_to_point(10016, 10016) < 128) {
			with (instance_create(x, y, PortalClear)) {
				image_xscale *= 0.6
				image_yscale *= 0.6
			}
		}
	}
	#endregion
	
	#region Bosses (some of them)
	
	// Big Bandit
	if (_area == area_desert && !instance_exists(TutCont)) {
		instance_create(x, y, WantBoss)
	}
	
	if (_has_boss) {
		// Big Dog
		if (_area == area_scrapyards) {
			with (instance_furthest(10016, 10016, Floor)) {
			    var _fx = bbox_center_x,
					_fy = bbox_center_y,
					_distance = point_distance(10016, 10016, _fx, _fy),
					_direction = point_direction(10016, 10016, _fx, _fy),
					_x = 10016 + lengthdir_x(_distance * 0.75, _direction),
					_y = 10016 + lengthdir_y(_distance * 0.75, _direction)
				
				with (instance_nearest(_x, _y, Floor)) {
				    with (instance_create(bbox_center_x, bbox_center_y, BecomeScrapBoss)) {
				        xprevious = x
				        yprevious = y
				    }
				}
			}
		}
		
		// Lil Hunter
		if (_area == area_city) instance_create(x, y, WantLH)
		
		// Frog Queen
		if (_loops > 0 && _area == area_sewers) {
			with (instance_furthest(10016, 10016, enemy)) {
				instance_create(x, y, FrogQueen)
			}
		}
		
		if (_loops > 0 && (_area == area_caves || _area == area_cursed_caves)) {
			with (instance_furthest(10016, 10016, enemy)) {
				instance_create(x, y, HyperCrystal)
			}
		}
		
		if (_loops > 0 && _area == area_labs) {
			with (enemy) {
				if (distance_to_object(TechnoMancer) > 120 && point_distance(x, y, 10016, 10016) > 160) {
					instance_create(x, y, TechnoMancer)
				}
			}
		
			do {
				with (instance_nearest(10016, 10016, TechnoMancer)) {
					instance_destroy(id, false)
				}
			}
			until (instance_number(TechnoMancer) <= (2 + _loops))
		}

		with (TechnoMancer) repeat (6) {
			instance_create(x + orandom(60), y + orandom(60), PortalClear)
		}
	}
	#endregion
}
