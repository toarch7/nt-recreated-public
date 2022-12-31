/*if async_load[? "id"] != run_save_index exit

if run_state == 1 {
	if !async_load[? "status"] {
		show_debug_message("Game save failed! Time: " + string(current_time))
	} else show_debug_message("Game saved. Time: " + string(current_time))
	
	run_state = 0
}*/