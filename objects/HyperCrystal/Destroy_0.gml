scrDrop(0, 5)
with(MusCont)
alarm[1] = 1

event_inherited()

if instance_exists(Player) {
    if scrPlayerCountRace(Race.Horror, true) {
		scrRaceUnlockSkin(Race.Horror, true)
    }
	
	scrAchievementUnlock(Achievement.BOSS_HYPERCRYSTAL)
}

repeat(3) {
	scrDrop(100, 0)
}