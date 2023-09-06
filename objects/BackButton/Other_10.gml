/// @description click!

if instance_exists(PlayButton) or instance_exists(DailyList) {
    with PlayButton
		instance_destroy()

    with instance_create(0, 0, Logo)
		event_perform(ev_alarm, 1)

    with DailyList
		instance_destroy()

    instance_destroy()
}

if instance_exists(Credits) && !instance_exists(GameCont) {
	with Credits
		instance_destroy()
	
	with Logo
		instance_destroy()
	
	with instance_create(0, 0, MenuOptions)
		self.category_set(OptionCategory.Game)
}


if instance_exists(DailyList) {
    with DailyList
		instance_destroy()
}
else if instance_exists(Menu) {
	if !Menu.loadout {
	    with all {
	        if object_index != MusCont && object_index != UberCont && object_index != Console
				instance_destroy(id, 0)
	    }
		
		camera_set_pos(0, 0)
		
	    with instance_create(0, 0, Logo)
			event_perform(ev_alarm, 1)
		
	    UberCont.daily_run = 0
	    UberCont.weekly_run = 0
		
		playerinstance_reset(global.index)
		
	    with MusCont {
	        snd_stop(song)
	        snd_stop(amb)
			
	        event_perform(ev_create, 0)
	    }
		
	    instance_create(0, 0, SpiralCont)
		
	    instance_destroy()
	}
	else {
		with Menu {
			loadout = false
			gpadmode = false
		}
	}
}
else if instance_exists(ResourcepackManager) {
    with ResourcepackManager
        instance_destroy()
	
    snd_play(sndClickBack)
}
else if instance_exists(MenuOptions) && !(UberCont.opt_gamepad && MenuOptions.editing_mode) {
    with MenuOptions {
		back_pressed = true
        event_perform(ev_keypress, vk_backspace)
    }
	
	with CoopMenu
		instance_destroy()
}
else if instance_exists(CoopMenu) {
    with CoopMenu
		instance_destroy()

    if instance_exists(CoopController) {
        with CoopController
            instance_destroy()

        instance_create(0, 0, CoopMenu)
    }
	else {
        with instance_create(0, 0, Logo) {
            event_perform(ev_alarm, 1)
            instance_destroy()
        }

        instance_destroy()
    }
}

if instance_exists(PauseButton) {
    with PauseButton {
        if image_index == 3 {
			repeat 2
				event_perform(ev_left_release, 0)
		}
    }

    instance_destroy()
}

if instance_exists(DrawStats) {
    with DrawStats
		instance_destroy()
	
    with instance_create(0, 0, Logo)
		event_perform(ev_alarm, 1)
	
	instance_destroy()
}

if instance_exists(AchievementsMenu) {
    with AchievementsMenu
		instance_destroy()
	
    with instance_create(0, 0, Logo)
		event_perform(ev_alarm, 1)
	
    instance_destroy()
}

if instance_exists(DrawStats) or instance_exists(StatChar) {
    with DrawStats
		instance_destroy()

    with StatChar
		instance_destroy()
	
    instance_destroy()
}

with UberCont
	gamepad_sel = 0

snd_play(sndClickBack)