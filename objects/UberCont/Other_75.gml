if async_load[? "event_type"] == "gamepad lost" {
	if instance_exists(GameCont) && !paused && !want_pause {
		KeyCont.press_paus[global.index] = true
		event_perform(ev_step, 0)
		
		show_unlock_popup("@rA GAMEPAD#WAS DISCONNECTED!")
	}
}