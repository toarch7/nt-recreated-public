if lockstep_stop
	exit

if !instance_exists(GenCont) && instance_exists(Player) &&
!instance_exists(SitDown) && !instance_exists(Credits) &&
!instance_exists(Cinematic) && !instance_exists(GameOver) {
	tottimer ++
    timer ++
}

if timer >= 30 {
    timer = 0
    seconds ++
}

if seconds >= 60 {
    minutes ++
	seconds = 0
}

if area != 106 && area != 100 && area != 102 {
    hqarea = area
    hqsubarea = subarea
}

time = scrAddZero(minutes, 1) + ":" + scrAddZero(seconds, 1) + "." + scrAddZero(round(timer / 30 * 100), 1)

max_rad = GameCont.level * 60

if race == 11 && ultra == 3
	max_rad *= 2

if rad > max_rad {
	if level < 10 {
		level ++
		
		rad -= max_rad
		
		with Player {
			with instance_create(x, y, PopupText) {
				if GameCont.level < 10 {
					mytext = string_replace(loc("LEVEL %!"), "%", GameCont.level)
				}
				else mytext = loc("LEVEL ULTRA!")
			}
			
			with instance_create(x, y, LevelUp)
				creator = other.id
		}
		
		if level >= 10 {
			ultrapoints ++
			snd_play(sndLevelUltra)
			
			if race == 14 {
				if !UberCont.cgot[14] {
					show_unlock_popup("@wSKELETON UNLOCKED@s#FOR REACHING LEVEL ULTRA")
					
					with instance_create(x, y, UnlockScreen)
	                    race = 14
					
					UberCont.cgot[14] = 1
				}
				
				scrAchievement(26)
			}
			
			scrAchievement(23)
		}
		else {
			skillpoints ++
			snd_play(sndLevelUp)
		}
	}
	else if level >= 10 {
		rad = max_rad
	}
}