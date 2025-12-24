if lockstep_stop
	exit

if (!(instance_exists(GenCont) || !instance_exists(Player) || instance_exists(SitDown)
	|| instance_exists(Credits) || instance_exists(Cinematic) || instance_exists(GameOver) || room == romInit)
) {
	tottimer += timescale
    timer += timescale

	if timer >= 30 {
	    timer = 0
	    seconds ++
		
		if seconds >= 60 {
		    minutes ++
			seconds = 0
		}
	}
}

if area != area_hq && area != area_oasis && area != area_pizza_sewers {
    hqarea = area
    hqsubarea = subarea
}

timer_string = string_pad_zeroes(minutes, 1)
	+ ":" + string_pad_zeroes(seconds, 1)
	+ "." + string_pad_zeroes(round(timer / 30 * 100), 1)

max_rad = level * 60

if (scr_ultra_get(Race.Horror, UltraSkill.Meltdown)) max_rad *= 2

if rad > max_rad {
	if level < PLAYER_LEVEL_MAX {
		var _level = ++level
		
		rad -= max_rad
		
		with Player {
			with instance_create(x, y, PopupText) {
				if _level < PLAYER_LEVEL_MAX {
					mytext = string_replace(loc("LEVEL %!"), "%", _level)
				}
				else mytext = loc("LEVEL ULTRA!")
			}
			
			with instance_create(x, y, LevelUp)
				creator = other.id
		}
		
		if _level >= PLAYER_LEVEL_MAX {
			ultrapoints ++
			snd_play(sndLevelUltra)
			
			with Player {
				if scr_player_is_local(index) && race == Race.Skeleton {
					scrAchievementUnlock(Achievement.UNSTOPPABLE)
					scrRaceUnlock(Race.Skeleton)
				}
			}
			
			scrAchievementUnlock(Achievement.ULTRA_TIME)
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