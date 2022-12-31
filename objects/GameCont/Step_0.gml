if !instance_exists(GenCont) && instance_exists(Player) && !instance_exists(SitDown) && !instance_exists(Credits) {
    timer++tottimer++
}

if timer >= 30 {
    timer = 0
    seconds++
}

if seconds >= 60 {
    minutes++seconds = 0
}

if area != 106 && area != 100 && area != 102 {
    hqarea = area
    hqsubarea = subarea
}

var max_rads = (GameCont.level * 60) * ((race == 11 && ultra == 3) + 1)
if instance_exists(GameCont) && GameCont.rad > max_rads {
    with Player
    if is_me {
        if GameCont.level < 9 {
            snd_play(sndLevelUp)
            GameCont.rad -= max_rads
            GameCont.level += 1
            with instance_create(x, y, PopupText)
            mytext = loc_sfmt("LEVEL %!", GameCont.level)
            instance_create(x, y, LevelUp)
            GameCont.skillpoints += 1
        } else if !GameCont.ultrapoints && !ultra && !GameCont.coopultra {
            GameCont.rad -= max_rads
            GameCont.level = 10

            snd_play(sndLevelUltra)

            GameCont.ultrapoints += 1

            scrAchievement(23)

            with instance_create(x, y, PopupText)
            mytext = loc("LEVEL ULTRA!")

            instance_create(x, y, LevelUp)

            if race == 14 && is_me {
                if !UberCont.cgot[14] {
                    UberCont.cgot[14] = 1
                    show_unlock_popup("@wSKELETON UNLOCKED@s#FOR REACHING LEVEL ULTRA")
                    with instance_create(x, y, UnlockScreen) {
                        race = 14;
                        skin = 0
                    }
                }
                scrAchievement(26)
            }
        } else GameCont.rad = max_rads
    }
}