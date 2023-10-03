if net_event(ev_other, ev_user0)
	exit

if instance_exists(MenuOptions)
	exit

if sprite_index == sprGameOverResults {
    scrUnpause()
	
	with MobileUI
		instance_destroy()
	
    UberCont.want_menu = 2
    UberCont.show_results = 1 + UberCont.weekly_run
	
	draw_enable_drawevent(false)
}
else switch image_index {
    case 0:
        //MENU
        if instance_exists(GameOver) {
            image_index = 5
			draw_enable_drawevent(false)

            event_user(0)

            break
        }

        with object_index
			instance_destroy()

        with instance_create(view_xview + 52, view_yview + view_height - 48, PauseButton) {
            image_index = 4
        }

        with instance_create(view_xview + view_width - 52, view_yview + view_height - 48, PauseButton) {
            image_index = 5
        }

        // -1 means tip is seen
        if !save_get_val("etc", "saving_tip", 0)
            save_set_val("etc", "saving_tip", -1)
		
        break

    case 5:
        //QUIT
		scrUnpause()
		
        audio_stop_all()
        UberCont.want_menu = 2
		
		with MobileUI
			instance_destroy()
		
		draw_enable_drawevent(false)
		
        break

    case 1:
        // RESTART
        if instance_exists(GameOver) {
			draw_enable_drawevent(false)
            image_index = 6

            event_user(0)

            break
        }

        with object_index
			instance_destroy()
		
        with instance_create(view_xview + 52, view_yview + view_height - 48, PauseButton) {
            image_index = 4
        }
		
        with instance_create(view_xview + view_width - 56, view_yview + view_height - 48, PauseButton) {
            image_index = 6
        }
        break

    case 6:
        //RESTART
		scrUnpause()
		
        UberCont.want_restart = 2
		
		with MobileUI
			instance_destroy()
		
        break


    case 2:
        //OPTIONS
        with instance_create(0, 0, MenuOptions)
			self.category_set(OptionCategory.Main)
		
        with object_index
			instance_destroy()
		
        break
	
    case 3:
		// CONTINUE
        scrUnpause()
		
        with PauseButton
			instance_destroy()
        with BackButton
			instance_destroy()
		
        exit
        break
	
    case 4:
        // BACK
        with PauseButton
        instance_destroy()

        scrMakePauseButtons()
        break

    default:
        show_message_async("Not finished yet.")
        break
}