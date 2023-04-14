if !visible exit

if instance_exists(PlayButton) or instance_exists(DailyList) {
    with PlayButton instance_destroy()

    with instance_create(0, 0, Logo)
    event_perform(ev_alarm, 1)

    with DailyList
    instance_destroy()

    instance_destroy()
}

if instance_exists(ResourcepackManager) {
    with ResourcepackManager {
        if mode == 4 {
            mode = 0

            if browsing mode = 1
        } else instance_destroy()
    }

    snd_play(sndClickBack)
}
else if instance_exists(MenuOptions) && !(UberCont.opt_gamepad && MenuOptions.editing_mode) {
    with MenuOptions {
        event_perform(ev_keypress, vk_backspace)
    }
}

if instance_exists(PauseButton) {
    with PauseButton {
        if image_index == 3 repeat 2 event_perform(ev_left_release, 0)
    }

    instance_destroy()
}

if instance_exists(DailyList) {
    with DailyList
    instance_destroy()
} else if instance_exists(Menu) {
    with all {
        if object_index != MusCont && object_index != UberCont && object_index != Console instance_destroy(id, 0)
    }

    with instance_create(0, 0, Logo)
    event_perform(ev_alarm, 1)

    UberCont.daily_run = 0
    UberCont.weekly_run = 0

    UberCont.playerinstances = {}

    with MusCont {
        snd_stop(song)
        snd_stop(amb)
        event_perform(ev_create, 0)
    }

    instance_create(0, 0, SpiralCont)
    instance_destroy()
}

if instance_exists(DrawStats) {
    with DrawStats
    instance_destroy()

    with instance_create(0, 0, Logo)
    event_perform(ev_alarm, 1)

    instance_destroy()
}

if instance_exists(CoopMenu) {
    with CoopMenu instance_destroy()

    if instance_exists(CoopController) {
        with CoopController {
            instance_destroy()
        }

        instance_create(0, 0, CoopMenu)
    } else {
        with instance_create(0, 0, Logo) {
            event_perform(ev_alarm, 1)

            instance_destroy()
        }

        instance_destroy()
    }
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

snd_play(sndClickBack)