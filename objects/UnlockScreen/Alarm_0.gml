/// @param Show up
visible = true
snd_play(sndCharUnlock)
with (TopCont) drawcontrols = false
snd_play(scr_race_get_sound(race, "Cnfm"))
alarm[1] = 20

var _chiev_race = scrRaceGetUnlockAchievement(race),
	_chiev_skin = scrRaceGetSkinUnlockAchievement(race, bskin)

with (AchievementSplash) {
	if (achievement_id == _chiev_race || achievement_id == _chiev_skin) {
		instance_destroy()
	}
}