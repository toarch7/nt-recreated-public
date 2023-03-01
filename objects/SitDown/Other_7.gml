if (sprite_index && sprite_index != spr_sit) or alarm[2] {
    sprite_index = spr_sit
    alarm[0] = 430

    var s = GameCont.area == 106 ? Player.snd_cptn : Player.snd_thrn,
		race = GameCont.race
	
    snd_play(s)
	
    UberCont.ctot_wins[race]++
	UberCont.ctot_strk[race]++

    if UberCont.ctot_strk[race] > UberCont.cbst_strk[race] {
        UberCont.cbst_strk[race] = UberCont.ctot_strk[race]
    }

    if GameCont.tottimer < UberCont.cbst_fast[race] {
        UberCont.cbst_fast[race] = GameCont.tottimer
    }

    if sprite_index == sprMutant9HeadlessSit {
        scrAchievement(28)
    }

    with GameCont {
        var pinst = playerinstance_get(global.index)
        var _race = pinst.race

        if !UberCont.crowngot[_race, crown] && crown > 1 {
            UberCont.crowngot[_race, crown] = 1
            UberCont.race_crown[_race, crown] = 1
            show_unlock_popup(crown_name[crown] + "#UNLOCKED FOR " + race_name[_race])
            scrAchievement(22)
        }
    }

    alarm[2] = -1

    if GameCont.area != 106 {
        alarm[1] = 15

        if debug {
            alarm[0] = 2
            alarm[1] = 1
        }
    }
}