function scrDecideWepGold(argument0) {
    if !instance_exists(Player) {
        exit
    }

    if GameCont.race == 8 {
        argument0 += 1
    }

    if GameCont.loops {
        do wep = rng_choose(3, 98, 99, 100, 101, 102, 103)
        until((wep != Player.wep and wep != Player.bwep) or GameCont.race = 7)
    } else {
        do wep = rng_choose(3, 40, 41, 42, 43, 44, 45)
        until((wep != Player.wep and wep != Player.bwep) or GameCont.race = 7)
    }



}