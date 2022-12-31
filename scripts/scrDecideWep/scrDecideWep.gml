function scrDecideWep(extra) {
    if instance_exists(Player) {
        var bottom = -1,
            __cursed = 0,
            target

        if other[$ "curse"] {
            bottom = median(3, 1, ceil((GameCont.hard - global.hardmode * 13) / (1 + global.hardmode * 2)) + extra)
            __cursed = 1
        }

        target = instance_nearest(x, y, Player)

        with Player {
            if race == 8 {
                extra += 1

                if ultra_get(1) { // refined taste
                    bottom = median(6, 1, ceil((GameCont.hard - global.hardmode * 13) / (1 + global.hardmode * 2)) + extra)
                }
            }
        }

        var h = ceil((GameCont.hard - global.hardmode * 13) / (1 + global.hardmode * 2)) + extra

        var wep_name = UberCont.wep_name
        var wep_area = UberCont.wep_area
        var wep_type = UberCont.wep_type

        do {
            var fine = 0

            wep = round(rng_random(3, maxwep - 1) + 1)

            if !is_string(wep_name[wep]) or(wep_area[wep] < 0) or(wep_area[wep] < bottom) or(wep_area[wep] > h) {
                continue
            }

            if (target.wep == wep or target.bwep == wep) && (target.race != 7 && !(target.wep == wep && target.bwep == wep)) {
                continue
            }

            if wep == wep_super_disc_gun && !__cursed {
                continue
            }

            if instance_exists(TutorialCont) && (wep_type[wep] == 0 or wep_type[wep] == 4) {
                continue
            }

            if !global.hardmode && (wep == wep_golden_disc_gun or wep == wep_golden_nuke_launcher) {
                continue
            }

            if wep == wep_gun_gun && crown_current == crwn_guns {
                continue
            }

            fine = 1
        } until fine
    } else wep = round(rng_random(3, maxwep - 1) + 1)

    return wep
}