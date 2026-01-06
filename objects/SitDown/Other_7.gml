if (sprite_index != spr_gosit) exit

sprite_index = spr_sit
alarm[0] = 430
	
var _sound_played = false
with (Player) if (scr_player_is_local(index)) {
	if (!_sound_played) {
		snd_play(GameCont.area == area_hq ? snd_cptn : snd_thrn)
		_sound_played = true
	}
	
	scrPlayerUpdateBestRunStats(race, true)
	
	if (race == Race.Chicken && hp <= 0) {
		scrAchievementUnlock(Achievement.IMPOSSIBLE)
	}
}

scrUnlocksArea()

scrUnlocksWinOrLoop()

alarm[2] = -1

if (GameCont.area != area_hq) {
	alarm[1] = 15
		
	if debug {
	    alarm[0] = 2
	    alarm[1] = 1
	}
}