with(MusCont)
alarm[1] = 1

if GameCont.race == 12
	UberCont.ctot_uniq[12] ++

if instance_exists(Player) {
	if scrPlayerCountRace(Race.Rogue, true) {
		scrRaceUnlockSkin(Race.Rogue, 1)
	}
}

scrAchievementUnlock(Achievement.BOSS_CAPTAIN)

with(instance_create(x, y, LastDie)) {
    hit_id = other.hit_id
    team = other.team
}

event_inherited()