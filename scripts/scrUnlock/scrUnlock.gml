function scrUnlock() {
    dir = 0
    totkills = 0
    totdeaths = 0
	
	var plr = instance_is(self, Player) ? id : instance_exists_var(Player, "is_me", 1)
	
    loops = GameCont.loops - global.hardmode
	
    repeat(UberCont.racemax) {
        totkills += UberCont.ctot_kill[dir]
        totdeaths += UberCont.ctot_dead[dir]
        dir += 1
    }
	
    //EYES:
    if GameCont.area == 2 && !UberCont.cgot[3] {
        UberCont.cgot[3] = 1
        show_unlock_popup("@wEYES UNLOCKED#@sFOR REACHIN THE SEWERS")
        with instance_create(0, 0, UnlockScreen) {
            race = 3
        }
        scrAchievement(1)
    }

    //MELTING:
    if !plr.hp && !UberCont.cgot[4] {
        UberCont.cgot[4] = 1
		
        show_unlock_popup("@wMELTING UNLOCKED#@sFOR DYING")
        
		with instance_create(0, 0, UnlockScreen) {
            race = 4
        }
		
        scrAchievement(0)
    }

    //PLANT:
    if GameCont.area == 3 && !UberCont.cgot[5] {
        UberCont.cgot[5] = 1
        show_unlock_popup("@wPLANT UNLOCKED#@sFOR REACHING THE SCRAPYARD")
        with instance_create(0, 0, UnlockScreen) {
            race = 5
        }
        scrAchievement(2)
    }

    //ROBOT:
    if GameCont.area == 5 && !UberCont.cgot[8] {
        UberCont.cgot[8] = 1
        show_unlock_popup("@wROBOT UNLOCKED#@sFOR REACHING THE FROZEN CITY")
        with instance_create(0, 0, UnlockScreen) {
            race = 8
        }
        scrAchievement(5)
    }

    //YV:
    if GameCont.area == 103 && !UberCont.cgot[6] {
        UberCont.cgot[6] = 1
        show_unlock_popup("@wYUNG VENUZ UNLOCKED#@sWELCOME 2 VENUZ")
        with instance_create(0, 0, UnlockScreen) {
            race = 6
        }
        scrAchievement(3)
    }

    //STEROIDS:
    if GameCont.area == 6 && !UberCont.cgot[7] {
        UberCont.cgot[7] = 1
        show_unlock_popup("@wSTEROIDS UNLOCKED#@sFOR REACHING THE LABS")
        with instance_create(0, 0, UnlockScreen) {
            race = 7
        }
        scrAchievement(4)
    }

    //REBEL:
    if loops >= 1 && GameCont.area && !UberCont.cgot[10] {
        UberCont.cgot[10] = 1
        show_unlock_popup("@wREBEL UNLOCKED#@sFOR LOOPING PAST THE NUCLEAR THRONE")
        with instance_create(0, 0, UnlockScreen) {
            race = 10
        }
        scrAchievement(7)
    }

    //CHICKEN:
    if GameCont.area == 105 && !UberCont.cgot[9] {
        UberCont.cgot[9] = 1
        show_unlock_popup("@wCHICKEN UNLOCKED#@sFOR REACHING THE JUNGLES")
        with instance_create(0, 0, UnlockScreen) {
            race = 9
        }
        scrAchievement(6)
    }

    var p = noone
	
    with Player {
	    if is_me {
	        p = id
	    }
	}
	
    scrGoldenWeaponStoring(p)

    if !UberCont.cskingot[@GameCont.race] {
        if race == 2 && GameCont.area == 104 {
            UberCont.cskingot[2] = 1
            show_unlock_popup("@w" + race_name[race] + " B-SKIN UNLOCKED#@sFOR REACHING CURSED CRYSTAL CAVES")
            with instance_create(0, 0, UnlockScreen) {
                race = 2;
                skin = 1
            }
            scrAchievement(11)
        }

        if race == 3 && GameCont.area == 102 {
            UberCont.cskingot[3] = 1
            show_unlock_popup("@w" + race_name[race] + " B-SKIN UNLOCKED#@sFOR REACHING PIZZA SEWERS")
            with instance_create(0, 0, UnlockScreen) {
                race = 3;
                skin = 1
            }
            scrAchievement(13)
        }

        if race == 4 && (loops or instance_exists(SitDown)) && !skill_get(1) && !skill_get(27) {
            UberCont.cskingot[4] = 1
            show_unlock_popup("@w" + race_name[race] + " B-SKIN UNLOCKED#@sFOR DEFEATING THE THRONE WITHOUT#RHINO SKIN AND STRONG SPIRIT")
            with instance_create(0, 0, UnlockScreen) {
                race = 4;
                skin = 1
            }
            scrAchievement(12)
        }

        if race == 5 && !UberCont.cskingot[5] && (loops or instance_exists(SitDown)) && GameCont.tottimer <= 18000 {
            UberCont.cskingot[5] = 1
            show_unlock_popup("@w" + race_name[race] + " B-SKIN UNLOCKED#@sFOR DEFEATING THE THRONE#IN UNDER 10 MINUTES")
            with instance_create(0, 0, UnlockScreen) {
                race = 5;
                skin = 1
            }
            scrAchievement(14)
        }
    }

    if !instance_exists(SitDown) {
        if !UberCont.cskingot[6] {
            var can = 1
			
            for (var i = 1; i <= 12; i++) {
                if string_copy(wep_name[UberCont.cwep[i]], 0, 4) != "GOLD" {
                    can = 0
                    break
                }
            }

            if can {
                UberCont.cskingot[6] = 1
				
                show_unlock_popup("@wY.V. B-SKIN UNLOCKED#@sFOR UNLOCKING GOLDEN WEAPON WITH EVERY CHARACTER")
                
				with instance_create(0, 0, UnlockScreen) {
                    race = 6
                    skin = 1
                }
				
                scrAchievement(15)
            }
        }

        if !UberCont.cskingot[1] {
            can = 1
            for (i = 1; i <= 12; i++) {
                if !UberCont.ctot_loop[i] {
                    can = 0;
                    break
                }
            }

            if can {
                UberCont.cskingot[1] = 1
                show_unlock_popup("@wFISH B-SKIN UNLOCKED#@sFOR LOOPING WITH EVERY CHARACTER")
                with instance_create(0, 0, UnlockScreen) {
                    race = 1;
                    skin = 1
                }
                scrAchievement(10)
            }
        }
    }
	
	if loops >= 3 && !UberCont.opt_cheats {
		save_set_val("cheats", "unlocked", true)
		opt_cheats = true
		
		show_unlock_popup("@wCHEATS UNLOCKED#@sCHECK OUT MENU SETTINGS")
		
		scrSave()
	}
}

function scrGoldenWeaponStoring(p) {
	if !instance_exists(p)
		exit
	
	if p.race == 14 or p.race == 15
		exit
	
	with p {
		var cwep = UberCont.cwep[race],
			store = -1
		
        if wep_gold[wep] && race_swep[race] != wep && cwep != wep {
			store = wep
        }
		else if wep_gold[bwep] && race_swep[race] != bwep && cwep != bwep {
			store = bwep
		}
		
		if store != -1 {
			var pinst = playerinstance_get()
			
            snd_play(sndGoldWeaponLock)
			scrAchievement(24)
			
            save_set_val("cwep", string(race), store)
            save_set_val("cswep", string(race), true)
			UberCont.cwep[race] = store
			pinst.cwep = store
			
			scrSave()
			
            show_unlock_popup("@y" + loc(wep_name[store]) + loc("#@sSTORED"))

            if store == wep_golden_disc_gun
			or store == wep_golden_nuke_launcher
                scrAchievement(25)
		}
    }
}