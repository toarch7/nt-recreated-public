with(MusCont)
alarm[1] = 1

if instance_exists(Player) {
    if (Player.race == 12) UberCont.ctot_uniq[12] += 1
}

if instance_exists(Player) {
    if (Player.race == 12 && !UberCont.cskingot[12]) {
        show_unlock_popup("@wROGUE B-SKIN UNLOCKED@s#FOR DEFEATING THE CAPTAIN")
        with instance_create(0, 0, UnlockScreen) {
            race = 12;
            skin = 1
        }
        UberCont.cskingot[12] = 1
        scrAchievement(21)
    }
}

scrAchievement(42)

with(instance_create(x, y, LastDie)) {
    hit_id = other.hit_id
    team = other.team
}

event_inherited()