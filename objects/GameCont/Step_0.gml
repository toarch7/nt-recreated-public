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

var _mult;

if (scrGameIsCustomMode()) {
	_mult = scrCustomParam("radmax") / 100
}
else _mult = 1

max_rad = max(1, level) * 60 * _mult

if (scr_ultra_get(Race.Horror, UltraSkill.Meltdown)) max_rad *= 2

var _level_max = PLAYER_LEVEL_MAX

if rad > max_rad {
	if (_level_max > 0 && level < _level_max) {
		var _level = ++level
		
		rad -= max_rad
		
		with Player {
			with instance_create(x, y, PopupText) {
				if _level < _level_max {
					mytext = loc_fmt("HUD:LevelUp", "LEVEL %!", _level)
				}
				else {
					mytext = loc("HUD:LevelUp:10", "LEVEL ULTRA!")
				}
			}
			
			with instance_create(x, y, LevelUp) {
				creator = other.id
			}
		}
		
		if _level >= _level_max {
			var _any = false
			snd_play(sndLevelUltra)
			
			with Player {
				if (scr_player_is_local(index) && race == Race.Skeleton) {
					scrAchievementUnlock(Achievement.UNSTOPPABLE)
					scrRaceUnlock(Race.Skeleton)
				}
				
				if (scr_ultra_get_from_race(race) <= 0) {
					_any = true
				}
			}
			
			if (_any) ultrapoints ++
			
			scrAchievementUnlock(Achievement.ULTRA_TIME)
		}
		else {
			if (!scrGameIsCustomMode() || scrCustomParam("skill_choices", 0)) {
				skillpoints ++
			}
			snd_play(sndLevelUp)
		}
	}
	else if (level >= _level_max) {
		rad = max_rad
	}
}

if (wantdestinyskill && room == romGame) {
	wantdestinyskill = false
	skillpoints ++
}