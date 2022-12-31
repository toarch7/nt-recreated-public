/// @description POST-INIT

if UberCont.weekly_run {
    crown = scrReal(UberCont.weekly_data[? "crown"])
    GameCont.crown = crown
}


if UberCont.weekly_run or!UberCont.daily_run {
    //CROWN OF DESTINY
    if crown == 8 {
        GameCont.skillpoints += 1
        GameCont.destiny = 1
    }

    //CROWN OF DEATH
    if crown == 2 {
        max_hp -= 1
        if hp > max_hp hp = max_hp

        lsthealth = hp
    }
}

if wep_type[wep] == 0 or wep == 24 or wep == 36 {
    wepangle = choose(120, - 120)
} else wepangle = 0