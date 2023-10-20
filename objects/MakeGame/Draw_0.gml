if lockstep_stop
	exit

if disclaimer {
	
	draw_set_halign(fa_center)
    draw_set_valign(fa_center)
	
	var str = (get_timer() / 33333) % 60 > 30 ? "@r!!!" : "@s!!!"
	
	draw_set_font(fntM1)
    draw_text_nt(view_width / 2, view_height / 2, str + " " + loc("DISCLAIMER") + " " + str + loc("@w###THIS IS AN UNOFFICIAL FAN-MADE RECREATION,#NOT AFFILIATED WITH @yVLAMBEER@w.##IT IS DISTRIBUTED FREELY ON ITCH.IO#AND IS OPEN SOURCE ON GITHUB.##IF YOU PAID OR SEE ADS, IT'S RECOMMENDED TO#UNINSTALL THE APPLICATION FOR YOUR OWN SAFETY."))
	
	disclaimer ++
	
	if disclaimer >= 90 {
		str = loc("CLICK TO CONTINUE")
		
		if disclaimer == 90 {
			snd_play(sndHover)
			str = "@w" + str
		}
		else str = "@s" + str
		
		draw_text_nt(view_width / 2, view_height - 56 + (disclaimer == 90) * 2, str)
		
		if mouse_ui_clicked() or keyboard_check_pressed(vk_anykey) {
			save_set_value("etc", "disclaimer", 1)
			event_perform(ev_alarm, 0)
		}
	}
	
	exit
}

if loading {
	camera_set_pos(0, 0)
	
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
        }
		else {
            draw_set_color(c_uidark)
            pos++
        }
		
        draw_text_nt(xx + 48, yy + 32 + posy, "@s" + loc("NO") + "@w")
        draw_text_shadow(xx - 64, yy + 32 + posy, loc("YES"))
		
		draw_gamepad_button(gp_face2, 0, xx + 28, yy + 36 + posy)
		draw_gamepad_button(gp_face1, 0, xx - 42, yy + 36 + posy)

        draw_set_color(c_white)

        draw_set_halign(fa_left)
        draw_set_valign(fa_top)

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
            if point_in_circle(mx, my, xx + 48, yy + 28, 16) or p == -1 {
                // yesn't
                file_delete("gamestate.dat")

                game_restart()
            }
			else if point_in_circle(mx, my, xx - 48, yy + 28, 16) or p == 1 {
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