/// @description click

global.index = 0
global.hardmode = false
global.is_server = true
global.coop = false

with UberCont {
    daily_run = false
    weekly_run = false
	scr_playerinstance_reset()
}

var _image = floor(image_index)

// if chose either Daily or Weekly 
if _image == 1 || _image == 2 {
	var _name = scrSavedataGetUsername(),
		_digits = string_length(string_digits(_name))
	
	// see if the player has changed their username
	if !(_name == "unknown" || _name == "null" || _name == "undefined")
	&& !(_digits == 3 && (string_starts_with(_name, "Seeker") || string_starts_with(_name, "Throneseeker"))) {
		
		save_set_value("etc", "suggestnickname", true)
	}
	
	// if not, suggest changing
	if !save_get_value("etc", "suggestnickname", false) {
		with instance_create(0, 0, MenuOptions) event_user(3)
		save_get_value("etc", "suggestnickname", true)
		
		with instance_create(0, 0, NicknameInput) {
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
		if _image == 3 {
			UberCont.weekly_run = true
		}
	}
}
// enable hardmode
else if _image == 3 {
	global.hardmode = true
}

instance_destroy(PlayButton)
instance_destroy(MainMenuButton)
instance_destroy(SpiralCont)

if !(instance_exists(Leaderboards) || instance_exists(NicknameInput)) {
	instance_create(0, 0, GameCont)
	instance_create(0, 0, MenuGen)
	snd_play(sndMenuCharSelect)
}

with UberCont {
	gamepad_sel = 0
}