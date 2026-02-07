function scrPopEnemies() {
	static __spawn = function() {
		if (argument_count == 0) return noone
		return instance_create(bbox_center_x + orandom(2), bbox_center_y + orandom(2), argument[irandom(argument_count - 1)])
	}
	
    // this script is being executed from within Floor object context...
	if (distance_to_point(10016, 10016) < 160 || place_meeting(x, y, Wall)) exit

    random_set_seed(rng_next_int(RNGStates.Enemies))
	
	var _loops = GameCont.loops,
		_loop_rand = random(_loops),
		_subarea = GameCont.subarea,
		_is_last = (_subarea == GameCont.maxsubarea)
	
	switch (spawnarea) {
		case area_desert:
			if (instance_exists(TutCont)) break
			if (random(2) < _loop_rand) {
				__spawn(Scorpion, Scorpion, Bandit, Bandit,
					Maggot, JungleFly, JungleFly, MeleeBandit, Sniper)
			}
			else if (styleb) {
				__spawn(MaggotSpawn, BigMaggot, BigMaggot, Maggot)
			}
			else if (random(7) < 1) {
				__spawn(MaggotSpawn, Scorpion)
			}
			else if (random(30) < 1) {
				__spawn(Barrel)
				
				repeat (3) {
					__spawn(Bandit)
				}
			}
			else {
				__spawn(Bandit, Bandit, Bandit,
					Bandit, Bandit, Bandit, Maggot, Scorpion)
			}
			break
		case area_sewers:
			if (random(2) < _loop_rand) {
				__spawn(Ratking, Ratking, BuffGator, LaserCrystal, Rat, Exploder, Exploder, SuperFireBaller)
			}
			else if (styleb) {
				__spawn(Rat, Rat, Gator, Gator, Exploder)
			}
			else if (random(9) < 1) {
				__spawn(Exploder, Ratking, Exploder, Ratking, Exploder, Ratking, MeleeFake)
			}
			else {
				__spawn(Rat, Rat, Rat, Rat, Rat, Rat, Rat, Bandit)
			}
			break
	    case area_scrapyards:
	        if ((random(5) < 4) && (!_is_last || (random(2) < 1))) {
	            if (random(2) < _loop_rand) {
	                __spawn(Sniper, Sniper, MeleeFake, MeleeFake, Salamander, SnowBot, Raven, BuffGator, Raven)
	            }
	            else if (styleb && random(3) < 1) {
	                __spawn(Salamander)
	            }
	            else if (random(4) < 1) {
	                __spawn(MeleeBandit, Sniper, MeleeFake, Sniper, MeleeFake, Sniper, Sniper, Exploder)
	            }
	            else if (random(10) < 1) {
	                if (random(8) < 1) {
	                    __spawn(Car)
	                }
	                __spawn(Raven, Raven)
	                __spawn(Raven, Raven)
	            }
	            else if (random(20) < 1) {
	                __spawn(Salamander)
	            }
	            else if (random(4) < 3) {
	                __spawn(Raven, Raven, Bandit)
	            }
	        }
	        break
	    case area_caves:
	        if (random(2) < _loop_rand) {
	            __spawn(LaserCrystal, LaserCrystal, LaserCrystal, RhinoFreak, LightningCrystal, BuffGator, ExploFreak, Spider, Spider)
	        } else {
	            __spawn(Spider, Spider, Spider, Spider, LaserCrystal)
	        }
	        break
	    case area_city:
	        if (random(2) < _loop_rand) {
	            __spawn(SnowTank, SnowTank, DogGuardian, ExploGuardian, SnowBot, SnowBot, SnowBot, Wolf, Necromancer)
	        } else if (random(3) < 2) {
	            __spawn(SnowBot, SnowBot, SnowBot, SnowTank, Wolf, Wolf)
	        }
	        break
	    case area_labs:
	        if (random(2) < _loop_rand) {
	            __spawn(Ratking, RhinoFreak, ExploFreak,
					Necromancer, RhinoFreak, LaserCrystal, BecomeTurret)
	        }
	        else if (random(14) < 1) {
	            repeat (10) {
	                __spawn(Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak,
						Freak, ExploFreak, ExploFreak, RhinoFreak, Freak, Freak, Freak)
	            }
	        }
	        else if (random(8) < 1) {
	            __spawn(Necromancer, Necromancer, Necromancer, ExploFreak, RhinoFreak,
					Necromancer, Necromancer, BecomeTurret, BecomeTurret, BecomeTurret, Necromancer)
	        }
	        break
	    case area_palace:
	        if (_is_last || random(2) > 1) break
			if (random(2) < _loop_rand) {
	            __spawn(ExploGuardian, DogGuardian, Sniper, DogGuardian, ExploGuardian, ExploFreak, JungleBandit, JungleBandit)
	        }
	        else if (random(4) < 1) {
	            __spawn(ExploGuardian, DogGuardian, Guardian, Guardian, Guardian, Guardian)
	        }
	        else if (random(16) < 1) {
	            __spawn(IDPDSpawn)
	        }
	        break
	    case area_oasis:
	        if (random(4) < 1) {
	            __spawn(Crab)
	        }
	        else if (random(3) < 1) {
	            repeat(3) {
	                __spawn(BoneFish)
	            }
	        }
	        break
	    case area_pizza_sewers:
	        __spawn(Turtle)
	        break
	    case area_mansion:
	        if (random(5) < 1) {
	            __spawn(FireBaller, Jock, FireBaller, Jock, FireBaller, SuperFireBaller)
	        }
	        else if (random(4) < 1) {
	            if (random(5) < 1) {
	                __spawn(GoldBarrel)
	            }
	            repeat(3) {
	                __spawn(Molefish, Molefish, Molefish, Molefish, Molesarge)
	            }
	        }
	        break
	    case area_cursed_caves:
	        if (random(5) < 4) {
	            __spawn(InvSpider, InvSpider, InvSpider, InvSpider, InvLaserCrystal, InvLaserCrystal)
	        }
	        break
	    case area_jungle:
	        if (random(8) < 1) {
	            __spawn(JungleFly)
	        }
	        else if (random(30) < 1) {
	            __spawn(Barrel)
	            __spawn(JungleBandit)
	            __spawn(JungleBandit)
	            __spawn(JungleBandit)
	        }
	        else {
	            __spawn(JungleBandit, JungleBandit, JungleBandit, JungleBandit,
					JungleBandit, JungleBandit, Maggot, JungleAssassinHide, JungleAssassinHide)
	        }
	        break
	    case area_hq:
	        if (_is_last) break
			if (random(12) < 1 || !instance_exists(enemy)) {
	            if (random(7) < 1) {
	                __spawn(EliteGrunt, EliteShielder, EliteInspector)
	            }
	            else if (random(4) < 1) {
	                repeat(5) {
	                    __spawn(Grunt)
	                }
	            }
	            else if (random(3) < 1) {
	                __spawn(Grunt, Shielder, Inspector)
	            }
	        }
	        break
	}
}