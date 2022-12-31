if loading {
    try {
        var xx = view_width / 2
        var yy = view_height / 2

        var mx = device_mouse_x_to_gui(0)
        var my = device_mouse_y_to_gui(0)

        scrDrawRoadmap(xx, yy, round(pos), cont)
        scrDrawHUD(player)

        draw_set_halign(fa_center)

        draw_text_nt(xx, yy - 54, loc("@sCONTINUE?@w"))

        yy += 4

        if pos >= cont.waypoints {
            if posy == 8 snd_play(sndCrownAppear)

            if posy >= 0 posy -= 8
        } else {
            draw_set_color(c_dkgray)
            pos++
        }

        draw_text_nt(xx + 48, yy + 32 + posy, "@s" + loc("NO") + (UberCont.opt_gamepad ? " [O]" : "") + "@w")
        draw_text_shadow(xx - 48, yy + 32 + posy, loc("YES") + (UberCont.opt_gamepad ? " [X]" : ""))

        draw_set_color(c_white)

        draw_set_halign(fa_left)

        with cont {
            var s = skills
            skills = other.skills

            scrGameContDrawGUI()

            skills = s
        }

        if loading < 15 {
            loading++

            draw_set_alpha(1 - loading / 15)
            draw_set_color(c_black)
            draw_rectangle(0, 0, view_width, view_height, 0)
            draw_set_color(c_white)
            draw_set_alpha(1)
        }

        var p = gamepad_button_check_pressed(0, gp_face1) - gamepad_button_check_pressed(0, gp_face2)

        if mouse_check_button_released(mb_left) or p != 0 {
            if point_in_circle(mx, my, xx + 48, yy + 40, 16) or p == -1 {
                // yesn't
                file_delete("gamestate.dat")
                room_goto(romGame)

                UberCont.playerinstances = {}
                UberCont.daily_run = 0
                UberCont.weekly_run = 0
                global.hardmode = 0

                instance_destroy()
            } else if point_in_circle(mx, my, xx - 48, yy + 40, 16) or p == 1 {
                // yes
                room_goto(romGame)
                instance_destroy()
            }
        }
    } catch (e) {
        print_error("Failed to load gamestate:\n" + e.longMessage, 1)

        if file_exists("m_gamestate.dat") {
            file_delete("m_gamestate.dat")
        }

        file_rename("gamestate.dat", "m_gamestate.dat")

        game_restart()
    }
}