if instance_exists(ResourcepackManager) or global.console_active or text_input_element != undefined or erasing_progress
	exit

if !editing_mode {
	print(text_input_element)
	
    if category == OptionCategory.Main or (dispose_on_empty && ds_stack_empty(category_stack)) {
        event_user(2)
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