function scrOnBanditKill() {
	with Player {
		if (race == Race.Rebel
			&& scr_player_is_local(index)
			&& !scr_race_is_skin_unlocked(race, SkinLetter.C)
		) {
			if ((++ UberCont.tot_banditkills) >= 1000) {
				scrRaceUnlockSkin(Race.Rebel, SkinLetter.C)
			}
			break
		}
	}
}