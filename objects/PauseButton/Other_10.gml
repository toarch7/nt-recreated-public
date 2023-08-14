if net_event(ev_mouse, ev_left_press)
	exit

if instance_exists(MenuOptions) exit

if sprite_index == sprGameOverResults {
    instance_activate_all()
	
    UberCont.paused = 0
    UberCont.want_menu = 2
    UberCont.show_results = 1
	
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
        instance_activate_all()
		
        audio_resume_all()
        audio_stop_all()
		
        UberCont.paused = 0
        UberCont.want_menu = 2
		
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
        audio_resume_all()
        audio_stop_all()
		instance_activate_all()
        UberCont.want_restart = 2
        break


    case 2:
        //OPTIONS
        instance_create(0, 0, MenuOptions)
        with object_index
        instance_destroy()
        break
	
    case 3:
		// CONTINUE
        scrUnpause()
		
        with JoystickMove event_perform(ev_create, 0)
        with ButtonActive event_perform(ev_create, 0)
        with ButtonAct event_perform(ev_create, 0)
        with ButtonSwap event_perform(ev_create, 0)
		
        with PauseButton instance_destroy()
        with BackButton instance_destroy()
		
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