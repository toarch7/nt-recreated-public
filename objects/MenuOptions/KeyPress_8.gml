if instance_exists(ResourcepackManager) exit

if !editing_mode {
    if category == 0 {
        if !instance_exists(GameCont) {
            view_xview = 0
            view_yview = 0

            with instance_create(0, 0, Logo)
            event_perform(ev_alarm, 1)

            with BackButton
            instance_destroy()

            scrOptionsUpdate()

            scrSave()

            instance_destroy(id, 0)
            //game_restart()
        } else if !instance_exists(PauseButton) {
            if !UberCont.daily_run {
                with instance_create(view_xview + 54, view_yview + view_height - 32, PauseButton) {
                    image_index = 1
                }
            }

            with instance_create(view_xview + 45, view_yview + view_height - 64, PauseButton) image_index = 0
            with instance_create(view_xview + view_width - 72, view_yview + view_height - 64, PauseButton) image_index = 2
            with instance_create(view_xview + view_width - 72, view_yview + view_height - 32, PauseButton) image_index = 3

            with PauseButton {
                hover = 4
                visible = 1
                depth--
            }
        }

        with BackButton
        instance_destroy()

        instance_destroy()
    } else {
        wait = 1
        category = 0
    }

    snd_play(sndClickBack)
} else {
    with MobileUI
    instance_destroy()

    editing_mode = 0

    scrSave()
}

if rp_warning {
    rp_warning = 0
    category = 0
}

erasing_progress = 0
press = 0

//scrOptionsUpdate()
with UberCont {
    display_reset(0, opt_resolution)
}

if !ingame {
    audio_resume_all()
}