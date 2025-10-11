if scr_network_handle_event(ev_other, ev_user0)
	exit

if instance_exists(MenuOptions)
	exit

image_index = floor(image_index)

// quit to leaderboards
if sprite_index == sprGameOverResult {
    with UberCont {
		scrGameQuitToMenu(true)
	}
	
	exit
}

// confirmation for `Menu` and `Retry` options
if image_index == 0 || image_index == 1 {
	var _confirm_index = (image_index == 1) ? 6 : 5
	
	if !instance_exists(GameOver) {
		var _left = view_xview + 52,
			_right = view_xview + view_width - 52,
			_bottom = view_yview + view_height - 48
		
	    instance_destroy(PauseButton)
		
	    with instance_create(_right, _bottom, PauseButton) image_index = _confirm_index
		with instance_create(_left, _bottom, PauseButton) image_index = 4 /* Back */
		
	    // setting flag to -1 marks it as seen
	    if save_get_value("etc", "saving_tip", 0) != -1 {
	        save_set_value("etc", "saving_tip", -1)
		}
	}
	// needs no confirmation if it's gameover screen
	else {
		image_index = _confirm_index
	}
}

// `Quit` & `Retry`
if image_index == 5 || image_index == 6 {
	with UberCont {
		scrGameUnpause()
		
		if other.image_index == 5 {
			show_leaderboards_menu = scrGameIsEventRun()
			show_weekly_results_menu = scrGameIsWeeklyRun()
			want_menu = 1
		}
		else {
			want_restart = 1
		}
	}
	
	instance_destroy(PauseButton)
}

// `Options`
if image_index == 2 {
	with instance_create(0, 0, MenuOptions) {
		scrOptionsMenuChangeCategory(OptionCategory.Main)
	}
	
	instance_destroy(PauseButton)
}

// `Continue`
if image_index == 3 {
	instance_destroy(PauseButton)
	instance_destroy(BackButton)
	
	with MenuOptions {
		event_user(2)
	}
	
	scrGameUnpause()
}

// `Back`
if image_index == 4 {
	instance_destroy(PauseButton)
	scrMakePauseButtons()
}