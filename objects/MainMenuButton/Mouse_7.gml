if hover > 4 exit

if instance_exists(Logo) or!available exit

switch image_index {
    case 0:
        global.is_server = 1

        with MainMenuButton {
            instance_destroy()
        }

        instance_create(0, 0, BackButton)

        var buttons = [0]
        if os_is_network_connected() {
            array_push(buttons, 1, 2)
        }

        if UberCont.hardgot array_push(buttons, 3)

        var n = array_length(buttons)

        var posy = view_yview + view_height / 2 - round(n / 2) * 24

        if UberCont.showtutorial {
            buttons = [0]
            n = array_length(buttons)

            with UberCont {
                daily_run = 0
                weekly_run = 0

                playerinstances[$ string(global.index)] = new PlayerInstance(global.index, 0, 0)
            }
        }

        for (var i = 0; i < n; i++) {
            with instance_create(view_xview + view_width / 2, posy, PlayButton) {
                image_index = buttons[i]

                if image_index == 1 && !UberCont.can_daily available = 0
                if image_index == 2 && !UberCont.can_weekly available = 0
            }

            posy += 24
        }

        var index = i
        with PlayButton {
            hover = (index + index) * 4
            index--
        }

        if n <= 1 {
            with UberCont playerinstances[$ string(global.index)] = new PlayerInstance(global.index, 0, 0)

            with MainMenuButton instance_destroy()
            with SpiralCont instance_destroy()

            if instance_exists(GameCont) {
                with GameCont instance_destroy()
            }

            instance_create(0, 0, GameCont)
            instance_create(0, 0, MenuGen)

            with PlayButton instance_destroy()
        }
        break

    case 1:
        instance_create(0, 0, CoopMenu)
        instance_create(0, 0, BackButton)

        with MainMenuButton instance_destroy()
        break

    case 2:
        with MainMenuButton instance_destroy()
        instance_create(view_xview + view_width / 2, view_yview + view_height / 2, MenuOptions)
        UberCont.checksettings = 1
        save_set_val("etc", "checksettings", 1)
        break

    case 3:
        instance_create(0, 0, BackButton)
        instance_create(0, 0, DrawStats)
        with MainMenuButton instance_destroy()
        break

    case 4:
        game_restart()
        game_end()
        break

    case 5:
        instance_create(0, 0, BackButton)
        instance_create(0, 0, AchievementsMenu)
        with MainMenuButton instance_destroy()
        break
}

snd_play(sndClick)