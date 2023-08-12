if instance_exists(ResourcepackManager) or global.console_active or text_input_element != undefined or erasing_progress
	exit

if !editing_mode {
    if category == OptionCategory.Main {
        if !ingame {
            camera_set_pos(0, 0)

            with instance_create(0, 0, Logo)
            event_perform(ev_alarm, 1)

            with BackButton
            instance_destroy()

            scrOptionsUpdate()

            scrSave()

            instance_destroy(id, 0)
            //game_restart()
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
    }
	else {
		self.category_set(
			!ds_stack_empty(category_stack)
				? ds_stack_pop(category_stack)
				: OptionCategory.Main
			, false)
    }

    snd_play(sndClickBack)
}
else {
    with MobileUI
		instance_destroy()
	
    editing_mode = false
	
	self.category_set(OptionCategory.Controls, false)

    scrSave()

    snd_play(sndClickBack)
}

if rp_warning {
    rp_warning = 0
    category = 0
}

press = 0

slider = undefined

await_input = false
await_keybind = undefined

if !ingame
    audio_resume_all()