function scrPopProps() {
    if (place_meeting(x, y, hitme) || place_meeting(x, y, chestprop)) exit
	
	var _area = GameCont.area,
		_subarea = GameCont.subarea,
		_loops = GameCont.loops,
		_is_last = (_subarea == GameCont.maxsubarea),
		_spawn_distance = point_distance(
			bbox_center_x, bbox_center_y, 10016, 10016)
	
	// Small walls
    if random(5) < 1 && _spawn_distance > 100 && !place_meeting(x, y, NOWALLSHEREPLEASE)
		&& !(_area == area_hq || _area == area_vault || (_area == area_campfire && _loops == 0) || _area == area_crib || _area == area_labs)
		&& (_area != area_pizza_sewers || (random(3) < 1) && !(_area == area_scrapyards && _is_last) && !(_area == area_palace && _is_last)
		&& (_area != area_city || random(3) < 1) && _area != area_pizza_sewers
	) {
        var _small_x = (random_range(bbox_left, bbox_right) div 16) * 16,
			_small_y = (random_range(bbox_top, bbox_bottom) div 16) * 16

        if !place_meeting(_small_x, _small_y, hitme) {
            instance_create(_small_x, _small_y, Wall)
            instance_create(x, y, NOWALLSHEREPLEASE)
            if random(4) < 1 && _spawn_distance > 64 && spawnarea == 3 && _small_x == x && _small_y == y && !place_meeting(_small_x, _small_y, chestprop) {
                instance_create(_small_x, _small_y, Trap)
            }
        }
		
		exit
    }
	
	var _unlikeliness = 10
	/**/ if (_area == area_jungle) _unlikeliness = 2
	else if (_area == area_campfire) _unlikeliness = 7
	
	if (random(_unlikeliness) > 1) exit
	
    if spawnarea == area_desert {
        if random(60) < 1 {
            instance_create(x + 16, y + 16, BigSkull)
        }
		else if styleb && random(5) < 1 {
            instance_create(x + 16, y + 16, BonePile)
        }
		else {
            instance_create(x + 16, y + 16, choose(Cactus, Cactus, TopDecalDesert, Cactus))
        }
    }
	else if spawnarea == area_hq {
        if !styleb && !_is_last {
            instance_create(x + 16, y + 16, PlantPot)
        }

        if !_is_last || random(6) < 1 {
            repeat 3 {
                instance_create(x + 16, y + 16, TopPot)
            }
        }
    }
	else if spawnarea == area_sewers && _spawn_distance > 96 {
        instance_create(x + 16, y + 16, choose(Pipe, Pipe, ToxicBarrel, Pipe, Pipe, ToxicBarrel, TopDecalSewers))
    }
	else if spawnarea == area_campfire {
        instance_create(x + 16, y + 16, choose(NightCactus, NightCactus, NightBonePile, TopDecalNightDesert))
    }
	else if (spawnarea == area_caves) {
        if styleb && random(5) < 1 {
            instance_create(x + 16, y + 16, BonePile)
        }
		else {
            instance_create(x + 16, y + 16, choose(Crystal, Crystal, TopDecalCave, Cocoon))
        }
    }
	else if (spawnarea == area_cursed_caves) {
        if styleb && random(5) < 1 {
            instance_create(x + 16, y + 16, BonePile)
        }
		else {
            instance_create(x + 16, y + 16, TopDecalCave)
        }
    }
	else if spawnarea == area_scrapyards {
        instance_create(x + 16, y + 16, choose(Tires, Car, Tires, Car, Car, Tires, TopDecalScrapyard))
    }
	else if spawnarea == area_city && _spawn_distance > 32 {
        if random(35) < 1 {
            instance_create(x + 16, y + 16, choose(SnowMan, SodaMachine))
        }
		else if random(3) < 1 {
            if random(2) < 1 {
                with instance_nearest(x, y, Wall) {
                    instance_create(x + 8, y + 8, TopDecalCity)
                }
            }
			else {
				instance_create(x + 16 + orandom(4), y + 16 + orandom(4), StreetLight)
			}
		}
		else if _spawn_distance > 128 {
			instance_create(x + 16, y + 16, choose(Hydrant, Car))
		}
	}
	else if spawnarea == area_labs && random(4) < 1 {
        instance_create(x + 16, y + 16, choose(Tube, Tube, Tube, Tube, MutantTube))
    }
	else if spawnarea == area_palace && !_is_last {
        instance_create(x + 16, y + 16, choose(Pillar, SmallGenerator, TopDecalPalace))
    }
	else if spawnarea == area_vault {
        instance_create(x + 16, y + 16, Torch)
    }
	else if spawnarea == area_oasis {
        if random(40) < 1 {
            instance_create(x + 16, y + 16, Anchor)
        }
		else if _spawn_distance > 96 {
            instance_create(x + 16, y + 16, choose(WaterPlant, WaterPlant, LightBeam, LightBeam, OasisBarrel, WaterMine, WaterMine))
        }
    }
	else if spawnarea == area_mansion && _spawn_distance > 64 {
        instance_create(x + 16, y + 16, choose(MoneyPile, MoneyPile, MoneyPile, YVStatue, GoldBarrel, MoneyPile))
    }
	else if spawnarea == area_pizza_sewers {
        instance_create(x + 16, y + 16, choose(PizzaBox, PizzaBox, TopDecalSewers))
    }
	else if spawnarea == area_jungle {
        if random(30) < 1 {
            instance_create(x + 16, y + 16, choose(BigFlower, BigFlower, TopDecalJungle))
        }
		else {
            instance_create(x + 16, y + 16, Bush)
        }
    }
}