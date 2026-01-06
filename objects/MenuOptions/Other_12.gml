/// @description Exit

if !ingame {
    scr_camera_set_position(0, 0)
	
	var _handled = false
	
	if (instance_exists(NicknameInput)) {
		with NicknameInput {
			if ((index == 1 && UberCont.can_daily) || (index == 2 && UberCont.can_weekly)) {
				call_after(1, function() {
					with instance_create(0, 0, PlayButton) {
						num = other.index
						event_user(0)
					}
				})
				
				_handled = true
			}
			
			instance_destroy()
		}
	}
	
	if !_handled {
	    with instance_create(0, 0, Logo)
			event_perform(ev_alarm, 1)
		
	    with BackButton
			instance_destroy()
	}
	
    scrOptionsUpdate()
	
    scrSave()
	
    instance_destroy(id, 0)
}
else {
	with PauseButton
		instance_destroy()
	
    scrMakePauseButtons()
	
	with UberCont
		splatindex = 0
	
	with BackButton
		instance_destroy()
}

instance_destroy()