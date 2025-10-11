function scrGameRestart(_quit_to_menu = false) {
	if scrGameIsLockstep() scrGameUnlockstep()
	
	if scrGameIsPaused() {
		scrGameUnpause()
		call_after(1, method({_quit_to_menu}, function() {
			scrGameRestart(_quit_to_menu)
		}))
		
		exit
	}
	
	with UberCont {
		continued_run = false
		
		file_delete("gamestate.dat")
		
		scrCleanupSessionInstances()
		
		if _quit_to_menu {
			global.custom_seed = 0
			want_quit_to_menu = true
			break
		}
		
		with GameCont {
			crown = global.crownpick
			skillpoints = 0
		}
		
		instance_create(0, 0, GameCont)
		
		instance_destroy(MusCont)
		instance_create(0, 0, MusCont)
		
		scrCreatePlayers(global.index)
		
		with GameCont {
			area = area_desert
			subarea = 0
		}
		
		instance_create(x, y, GenCont)
		instance_destroy(WepPickup)
	}
	
	audio_stop_all()
	room_restart()
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
