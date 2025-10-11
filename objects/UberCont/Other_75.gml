if async_load[? "event_type"] == "gamepad lost" {
	if instance_exists(GameCont) && !paused && !want_pause {
		KeyCont.press_paus[global.index] = true
		scrShowUnlockPopup("@rGAMEPAD CONTROLLER#DISCONNECTED!")
	}
}