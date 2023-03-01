if close
	exit

other.inframes = 30
other.depth = depth - 1
other.mask_index = mskNone

if endgame > 30 {
	alarm[1] = 90
	
	var p = other.id
	
	if other.race == 8 && other.ultra {
	    with WepPickup if visible {
	        if string_starts(UberCont.wep_name[wep], "GOLD") {
	            repeat 4 {
	                if random(p.max_hp) > p.hp && GameCont.crown != 2 {
	                    instance_create(other.x, other.y, HPPickup)
	                }
					else instance_create(other.x, other.y, AmmoPickup)
	            }
	        }
        
	        with instance_create(x, y, RobotEat) {
				image_xscale = choose(1, -1)
				creator = other.id
			}
        
	        with Player if race == 8 {
	            if random(max_hp) > hp && GameCont.crown != 2 {
	                instance_create(x, y, HPPickup)
	            }
				else instance_create(x, y, AmmoPickup)
            
	            if skill_get(5) {
	                snd_play(sndRobotEatUpg)
	                instance_create(x, y, AmmoPickup)
	            }
				else snd_play(sndRobotEat)
            
	            if ultra == 2 && random(1) <= 0.4 {
	                if random(max_hp) > hp && random(3) < 2 {
	                    if GameCont.crown != crwn_love {
	                        instance_create(x, y, HealthChest)
	                    }
						else instance_create(x, y, AmmoChest)
	                }
					else if GameCont.crown != crwn_love {
	                    instance_create(x, y, choose(WeaponChest, AmmoChest))
	                }
					else instance_create(x, y, AmmoChest)
	            }
	        }
	    }
	}
	
	snd_play(sndPortalClose)
	endgame = 30
}

