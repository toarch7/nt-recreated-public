if instance_exists(MenuOptions) exit

snd_play(sndClick)

if sprite_index == sprGameOverResults {
    instance_activate_all()
    UberCont.paused = 0
    UberCont.want_menu2 = 1
    UberCont.show_results = 1
} else switch image_index {
    case 0:
        //MENU
        if instance_exists(GameOver) {
            image_index = 5

            event_perform(ev_mouse, ev_left_release)

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

        // -1 means the tip was seen
        if !save_get_val("etc", "saving_tip", 0) {
            save_set_val("etc", "saving_tip", - 1)
        }
        break

    case 5:
        //QUIT
        audio_resume_all()
        audio_stop_all()
        instance_activate_all()
        UberCont.paused = 0
        UberCont.want_menu2 = 1
        break

    case 1:
        // RESTART
        if instance_exists(GameOver) {
            image_index = 6

            event_perform(ev_mouse, ev_left_release)

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
        UberCont.want_restart = 1
        break


    case 2:
        //OPTIONS
        instance_create(0, 0, MenuOptions)
        with object_index
        instance_destroy()
        break

    case 3:
        //CONTINUE
        if instance_exists(CoopController) {
            buffer_seek(global.buffer, buffer_seek_start, 0)
            buffer_write(global.buffer, buffer_u8, event.unpause)
            buffer_send(global.buffer)
        }

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
        show_message_async("Not done yet.")
        break
}