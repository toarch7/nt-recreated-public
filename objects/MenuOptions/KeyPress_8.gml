if scr_network_handle_event(ev_keypress, vk_backspace)
	exit

if instance_exists(ResourcepackManager) or global.console_active
or text_input_element != undefined or erasing_progress
	exit

if (!editing_mode) {
    if category == OptionCategory.Main or (dispose_on_empty && ds_stack_empty(category_stack)) {
        event_user(2)
    }
	else if instance_exists(CustomModeMenu) {
		last_change = current_frame + 3
		instance_destroy(CustomModeMenu)
	}
	else {
		scrOptionsMenuChangeCategory(
			!ds_stack_empty(category_stack)
				? ds_stack_pop(category_stack)
				: OptionCategory.Main
			, false)
	}
	
    snd_play(sndClickBack)
}
else {
	instance_destroy(MobileUI)
	
    editing_mode = false
	
	scrOptionsMenuChangeCategory(OptionCategory.Controls, false)

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