function scrGamepadUIControl() {
    gamepad_v = gamepad_button_check_pressed(0, gpad.padd) - gamepad_button_check_pressed(0, gpad.padu)
    gamepad_h = gamepad_button_check_pressed(0, gpad.padr) - gamepad_button_check_pressed(0, gpad.padl)

    if instance_exists(MainMenuButton) {
        gamepad_sel += gamepad_v

        if gamepad_sel < 0 || gamepad_sel >= instance_number(MainMenuButton) - 1 {
            gamepad_sel = gamepad_v ? 0 : (instance_number(MainMenuButton) - 2)
        }

        var button = instance_find(MainMenuButton, gamepad_sel)

        if instance_exists(button) {
            with button {
                light = 1

                if gamepad_button_check_pressed(0, gp_face1) {
                    event_perform(ev_mouse, ev_left_release)
                }
            }

            with MainMenuButton
            gpadsel = button == id
        }

        if gamepad_v != 0 {
            snd_play(sndMenuSelect)
        }
    } else if instance_exists(PlayButton) {
        gamepad_sel += gamepad_v

        if gamepad_sel < 0 || gamepad_sel >= instance_number(PlayButton) {
            gamepad_sel = gamepad_v ? 0 : (instance_number(PlayButton) - 1)
        }

        var button = instance_find(PlayButton, gamepad_sel)

        if instance_exists(button) {
            with button {
                light = 1

                if gamepad_button_check_pressed(0, gpad.face1) {
                    event_perform(ev_mouse, ev_left_release)
                }
            }
        }

        if gamepad_v != 0 {
            snd_play(sndMenuSelect)
        }

        with PlayButton
        gpadsel = button == id
    } else if instance_exists(CharSelect) {
        gamepad_sel += gamepad_h

        if gamepad_sel < 0 || gamepad_sel >= instance_number(CharSelect) {
            gamepad_sel = gamepad_h ? 0 : (instance_number(CharSelect) - 1)
        }

        var button = instance_find(CharSelect, gamepad_sel)

        if instance_exists(button) {
            if gamepad_h != 0 {
                with CharSelect {
                    if !selected && id == button {
                        event_perform(ev_mouse, ev_left_press)
                    }
                }
            }

            with CharSelect {
                if gamepad_button_check_pressed(0, gpad.face1) && selected {
                    event_perform(ev_mouse, ev_left_press)
                }
            }
        }
    } else if instance_exists(StatChar) {
        gamepad_sel += gamepad_h

        if gamepad_sel < 0 || gamepad_sel >= instance_number(CharSelect) {
            gamepad_sel = gamepad_h ? 0 : (instance_number(CharSelect) - 1)
        }

        button = instance_find(StatChar, gamepad_sel)

        if instance_exists(button) {
            if gamepad_h != 0 {
                with StatChar {
                    if num == UberCont.gamepad_sel && id == button {
                        event_perform(ev_mouse, ev_left_press)
                    }
                }
            }
        }
    } else if instance_exists(PauseButton) {
        gamepad_sel += gamepad_v

        if gamepad_sel < 0 || gamepad_sel >= instance_number(PauseButton) {
            gamepad_sel = gamepad_v ? 0 : (instance_number(PauseButton) - 1)
        }

        button = instance_find(PauseButton, gamepad_sel)

        if instance_exists(button) {
            if gamepad_v != 0 {
                with PauseButton {
                    clicked = 0

                    if id == button {
                        clicked = 1
                    }
                }
            }

            with button {
                if gamepad_button_check_pressed(0, gpad.face1) {
                    event_perform(ev_mouse, ev_left_release)
                }
            }
        }
    } else if instance_exists(SkillIcon) {
        gamepad_sel += gamepad_h

        if gamepad_sel < 0 || gamepad_sel >= instance_number(SkillIcon) {
            gamepad_sel = gamepad_h ? 0 : (instance_number(SkillIcon) - 1)
        }

        button = instance_find(SkillIcon, gamepad_sel)

        if instance_exists(button) {
            if gamepad_h != 0 {
                with button
                if !selected {
                    event_perform(ev_mouse, ev_left_press)
                }
            }

            with button {
                if gamepad_button_check_pressed(0, gpad.face1) {
                    event_perform(ev_mouse, ev_left_press)
                }
            }
        }
    } else if instance_exists(CrownIcon) {
        gamepad_sel += gamepad_h

        if gamepad_sel < 0 || gamepad_sel >= instance_number(CrownIcon) {
            gamepad_sel = gamepad_h ? 0 : (instance_number(CrownIcon) - 1)
        }

        button = instance_find(CrownIcon, gamepad_sel)

        if instance_exists(button) {
            if gamepad_h != 0 {
                with button
                if !selected {
                    event_perform(ev_mouse, ev_left_press)
                }
            }

            with button {
                if gamepad_button_check_pressed(0, gpad.face1) {
                    event_perform(ev_mouse, ev_left_press)
                }
            }
        }
    } else if instance_exists(UltraIcon) {
        gamepad_sel += gamepad_h

        if gamepad_sel < 0 || gamepad_sel >= instance_number(UltraIcon) {
            gamepad_sel = gamepad_h ? 0 : (instance_number(UltraIcon) - 1)
        }

        button = instance_find(UltraIcon, gamepad_sel)

        if instance_exists(button) {
            if gamepad_h != 0 {
                with button
                if !selected {
                    event_perform(ev_mouse, ev_left_press)
                }
            }

            with button {
                if gamepad_button_check_pressed(0, gpad.face1) {
                    event_perform(ev_mouse, ev_left_press)
                }
            }
        }
    } else gamepad_sel = 0

}