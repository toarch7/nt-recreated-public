scrUltras()
p = 0
selected = 0
race = 0
if instance_exists(Player) race = Player.race

with Player {
    if race == 14 && is_me && !UberCont.cgot[14] {
        UberCont.cgot[14] = 1
        show_unlock_popup("@wSKELETON UNLOCKED@s#FOR REACHING LEVEL ULTRA")
        with instance_create(x, y, UnlockScreen) {
            race = 14;
            skin = 0
        }
        scrAchievement(26)
    }
}

selectindex = -1