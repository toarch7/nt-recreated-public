/// @description click

global.index = 0
global.hardmode = 0
global.coop = 0
global.is_server = 1

with UberCont {
    daily_run = 0
    weekly_run = 0
	
	playerinstance_reset()
}

if image_index == 1 or image_index == 2 {
	var name = scrGetUsername(),
		digits = string_length(string_digits(name)),
		a = "Seeker", b = "Throneseeker"
	
	if name != "unknown" && !((string_starts(name, a) or string_starts(name, b)) && digits == 3)
		save_set_value("etc", "suggestnickname", true)
	
	if !save_get_value("etc", "suggestnickname", false) {
		with instance_create(0, 0, MenuOptions)
			event_user(3)
		
		save_get_value("etc", "suggestnickname", true)
		
		with PlayButton
			instance_destroy()
		
		with instance_create(0, 0, NicknameInput)
			image_index = other.image_index
		
		exit
	}
}

switch image_index {
    case 1:
        if !UberCont.can_daily {
            with instance_create(0, 0, Leaderboards)
				type = "daily"
			
			//instance_create(0, 0, DailyList)
			snd_play(sndMenuScores)
			
            with object_index
                instance_destroy()
			
            exit
        }
		
        with UberCont
            daily_run = 1
		
        break

    case 2:
		if !UberCont.can_weekly {
            with instance_create(0, 0, Leaderboards)
				type = "weekly"
			
			//instance_create(0, 0, DailyList)
            snd_play(sndMenuScores)
			
            with object_index
                instance_destroy()
			
            exit
        }
		
		with UberCont {
			weekly_run = 1
            daily_run = 1
		}
		
        break

    case 3:
        global.hardmode = 1
        break
}


instance_create(0, 0, GameCont)

instance_create(0, 0, MenuGen)

with MainMenuButton instance_destroy()
with SpiralCont instance_destroy()

with object_index
	instance_destroy()

snd_play(sndMenuCharSelect)

with UberCont
	gamepad_sel = 0