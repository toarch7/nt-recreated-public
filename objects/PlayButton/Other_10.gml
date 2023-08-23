/// @description click

if !available
	exit

global.index = 0
global.hardmode = 0
global.coop = 0
global.is_server = 1

with UberCont {
    daily_run = 0
    weekly_run = 0
	
	playerinstance_reset()
}

switch image_index {
    case 1:
        if !UberCont.can_daily {
            instance_create(0, 0, DailyList)
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
            instance_create(0, 0, DailyList)
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