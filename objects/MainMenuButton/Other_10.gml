/// @description click

if instance_exists(Logo) or !available
	exit

switch image_index {
	// Play option
    case 0:
		snd_play(sndClick)
        global.is_server = true
		
        instance_destroy(MainMenuButton)
        instance_create(0, 0, BackButton)
		scr_playerinstances_reset_all()
		
        var _play_buttons = [ 0 ]
		
        if !UberCont.showtutorial {
	        if os_is_network_connected() {
	            array_push(_play_buttons, 1, 2)
			}
		
	        if UberCont.hardgot {
				array_push(_play_buttons, 3)
			}
		}
		
		var _button_count = array_length(_play_buttons),
			_ypos = view_yview_center - _button_count * 12
		
        for (var i = 0; i < _button_count; i++) {
            with instance_create(view_xview_center, _ypos, PlayButton) {
				var _button_index = _play_buttons[i]
                image_index = _button_index
				
				// Daily & Weekly
				if _button_index == 1 || _button_index == 2 {
					if global.cheats {
						available = false
					}
					
	                if _button_index == 1 && !UberCont.can_daily
					|| _button_index == 2 && !UberCont.can_weekly
						image_blend = c_uidark
				}
            }

            _ypos += 24
        }
		
        if instance_number(PlayButton) == 1 {
			with PlayButton event_user(0)
        }
		
        break
	
	// Co-op
    case 1:
        instance_create(0, 0, CoopMenu)
        instance_create(0, 0, BackButton)

        with MainMenuButton
			instance_destroy()
		
		snd_play(sndClick)
		
        break
	
	// Options
    case 2:
        
        with instance_create(0, 0, MenuOptions) {
			scrOptionsMenuChangeCategory(OptionCategory.Main)
			
			x = view_xview + view_width / 2
			y = view_yview + view_height / 2
		}
		
        UberCont.checksettings = 1
        save_set_value("etc", "checksettings", 1)
		
		snd_play(sndClick)
		snd_play(sndMenuOptions)
		instance_destroy(MainMenuButton)
		
        break
	
	// Stats
    case 3:
        instance_create(0, 0, BackButton)
        instance_create(0, 0, DrawStats)
        instance_destroy(MainMenuButton)
		snd_play(sndMenuStats)
		
        break

	// Quit
    case 4:
		snd_play(sndClick)
        game_restart()
        game_end()
        break
}

if (!instance_exists(Player)) my_player.reset_session_data()

with UberCont {
	gamepad_sel = 0
}