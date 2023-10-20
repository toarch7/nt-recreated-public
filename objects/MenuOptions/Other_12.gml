/// @description Exit

if !ingame {
    camera_set_pos(0, 0)
	
	var handled = false
	
	if instance_exists(NicknameInput) {
		with NicknameInput {
			if (index == 1 && UberCont.can_daily )
			or (index == 2 && UberCont.can_weekly) {
				with instance_create(0, 0, PlayButton) {
					image_index = other.index
					event_user(0)
				}
				
				handled = true
			}
			
			instance_destroy()
		}
	}
	
	if !handled {
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
		splat_index = 0
	
	with BackButton
		instance_destroy()
}

instance_destroy()