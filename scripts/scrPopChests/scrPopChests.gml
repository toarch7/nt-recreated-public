function scrPopChests() {
    random_set_seed(rng_next_int(RNGSlot.Chest))

    var dir = 0
    var gol = 1
    var wgol = 0
    var agol = 0
    var rgol = 0

    if instance_exists(Player) && GameCont.area != 107 {
        if skill_get(28) {
            dir = choose(1, 2, 3)
			
            if dir == 1
				wgol = GameCont.openminds
            if dir == 2
				agol = GameCont.openminds
            if dir == 3
				rgol = GameCont.openminds
        }
    }

    if GameCont.area == 100 {
        if instance_exists(Crown) {
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
            instance_destroy()
        }
		until instance_number(WeaponChest) <= gol + wgol
    }

    if instance_exists(RadChest) {
        do {
            with instance_nearest(10016 + orandom(250), 10016 + orandom(250), RadChest)
            instance_destroy()
        }
		until instance_number(RadChest) <= gol + rgol
    }
	
    if instance_exists(AmmoChest) {
        do {
            with instance_nearest(10016 + orandom(250), 10016 + orandom(250), AmmoChest)
            instance_destroy()
        }
		until instance_number(AmmoChest) <= gol + agol
    }
	
	if gol > 0 {
		scrReplacePropWithChest(RadChest)
		scrReplacePropWithChest(WeaponChest)
		scrReplacePropWithChest(AmmoChest)
	}
	
	#endregion

    with ChestOpen
		instance_destroy()
	
    with FXChestOpen
		instance_destroy()
	
	var rogue = false
	
	with Player {
		if race == 12
			rogue = true
	}
	
	#region rad chest permutations
	with RadChest {
	    if rogue {
	        instance_create(x, y, RogueChest)
	        instance_destroy(id, 0)
		
			continue
	    }
		
	    if GameCont.noradch > 1 {
	        if !GameCont.horror {
	            instance_create(x, y, HostileHorror)
	            snd_play(sndEXPChest)
			
	            GameCont.horror = 1
	        }
		
	        instance_destroy(id, 0)
	    }
		else if GameCont.noradch {
			instance_change(RadChestBig, 1)
		}
	
	    if GameCont.horror
	        instance_change(RadChestBig, 1)
		
		var p = instance_random(Player)
		
	    if p.hp < p.max_hp / 2 && rng_random(6, 2) < 1 {
	        instance_create(x, y, HealthChest)
	        instance_destroy(id, 0)
	    }
	
	    if instance_nearest(x - 16, y - 16, Floor).styleb == 1 && GameCont.area == 1 && rng_random(6, 3) < 1 {
			instance_change(RadMaggotChest, true)
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
		if object_index == VaultStatue or object_index == ProtoStatue or object_index == JungleFlower
		or object_index == CarVenus or instance_is(self, RadChest) or object_index == BecomeScrapBoss
		or object_index == MeleeFake or object_index == LastIntro
			continue
		
		if dis > furthest
			inst = id
	}
	
	if instance_exists(inst) {
		with inst {
			instance_destroy(id, 0)
			instance_create(x, y, obj)
		}
	}
}