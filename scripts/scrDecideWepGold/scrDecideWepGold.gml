function scrDecideWepGold(argument0) {
	var p = instance_nearest(x, y, Player)
	
    if !instance_exists(p) {
        exit
    }

    if GameCont.race == 8 {
        argument0 += 1
    }

    if GameCont.loops {
        do wep = rng_choose(3, 98, 99, 100, 101, 102, 103)
        until((wep != p.wep and wep != p.bwep) or p.race == 7)
    } else {
        do wep = rng_choose(3, 40, 41, 42, 43, 44, 45)
        until((wep != p.wep and wep != p.bwep) or p.race == 7)
    }



}