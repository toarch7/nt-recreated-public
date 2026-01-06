function scrGameRestart(_quit_to_menu = false) {
	if scrGameIsLockstep() scrGameUnlockstep()
	
	if scrGameIsPaused() {
		scrGameUnpause()
		
		call_after(1, method({ _quit_to_menu }, function() {
			scrGameRestart(_quit_to_menu)
		}))
		
		exit
	}
	
	with (Player) if (scr_player_is_local(index)) {
		scrPlayerUpdateBestRunStats(race, true)
	}
	
	audio_resume_all()
	audio_stop_all()
	
	with UberCont {
		continued_run = false
		file_delete(savegame_file)
		scrCleanupSessionInstances()
		
		if _quit_to_menu {
			global.custom_seed = 0
			global.crownpick = crwn_none
			want_quit_to_menu = true
			room_restart()
			break
		}
		
		instance_destroy(MusCont)
		
		instance_create(0, 0, MusCont)
		
		print("Restart")
		scrRunStart()
	}
}

/// @function scrGameQuitToMenu
/// @param show_leaderboards
function scrGameQuitToMenu(_show_results) {
	with UberCont {
		if _show_results {
			show_leaderboards_menu = true
			
			if weekly_run {
				show_weekly_results_menu = true
			}
		}
		
		scrGameRestart(true)
	}
}
