/// @description Exit

if !ingame {
    camera_set_pos(0, 0)
	
    with instance_create(0, 0, Logo)
		event_perform(ev_alarm, 1)
	
    with BackButton
		instance_destroy()
	
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
}

with BackButton
	instance_destroy()

instance_destroy()