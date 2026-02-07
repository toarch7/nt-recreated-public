/// @description click

global.index = 0
global.is_server = true

with (UberCont) {
	coop = false
	hardmode = false
	
	if (!(scrGameIsEventRun() || scrGameIsCustomMode())) {
		protowep = save_get_value("etc", "protowep", wep_rusty_revolver)
	}
	else {
		protowep = wep_rusty_revolver
	}
}

scrGameCustomModeReset()

with UberCont {
    daily_run = false
    weekly_run = false
	scr_playerinstance_reset()
}

var _image = floor(num)

// if chose either Daily or Weekly 
if _image == 1 || _image == 2 {
	var _name = scrSavedataGetUsername(),
		_digits = string_length(string_digits(_name)),
		_suggest = false
	
	if (!save_get_value("etc", "suggestnickname", false)) {
		// see if the player has changed their username
		if ((_name == "unknown" || _name == "null" || _name == "undefined")
			|| (_digits == 3 && (string_starts_with(_name, "Seeker") || string_starts_with(_name, "Throneseeker")))
		) {
			if (_name == "null") {
				var _number = string(string_pad_zeroes(irandom(999), 2))
				save_set_value("etc", "name", "Seeker" + _number)
			}
			
			_suggest = true
		}
		
		save_set_value("etc", "suggestnickname", true)
	}
	
	// if not, suggest changing
	if (_suggest) {
		save_get_value("etc", "suggestnickname", true)
		
		with (instance_create(0, 0, MenuOptions)) {
			event_user(3)
		}
		
		with (instance_create(0, 0, NicknameInput)) {
			image_index = _image
		}
	}
	// otherwise if either daily or weekly is not avilable, show leaderboards instead
	else if (_image == 1 && !UberCont.can_daily) || (_image == 2 && !UberCont.can_weekly) {
		with instance_create(0, 0, Leaderboards) {
			type = _image == 2 ? "weekly" : "daily"
		}
		
		snd_play(sndMenuScores)
	}
	// proceed to daily run menu
	else {
		UberCont.daily_run = true
		
		// mark it weekly if required
		if _image == 2 {
			UberCont.weekly_run = true
		}
	}
}
// enable hardmode
else if _image == 3 {
	UberCont.hardmode = true
}
else if _image == 4 {
	instance_destroy(PlayButton)
	instance_destroy(MainMenuButton)
	
	scrCustomModeLoadPresets()
	
	with (UberCont) {
		custom_options = custom_mode_slots[custom_mode_slot_index]
		print("whar the fuck", custom_mode_slot_index, custom_options)
		custom = true
	}
	
	with instance_create(0, 0, MenuOptions) {
		scrOptionsMenuChangeCategory(OptionCategory.CustomMode, false)
		dispose_on_empty = true
	}
}

instance_destroy(PlayButton)
instance_destroy(MainMenuButton)

if !(instance_exists(Leaderboards)
	|| instance_exists(NicknameInput)
	|| instance_exists(MenuOptions)
) {
	instance_destroy(SpiralCont)
	instance_create(0, 0, GameCont)
	instance_create(0, 0, MenuGen)
	snd_play(sndMenuCharSelect)
}

with UberCont {
	gamepad_sel = 0
}

snd_play(sndClick)