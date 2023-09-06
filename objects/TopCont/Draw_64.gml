if lockstep_stop
	exit

var plr = noone

with Player
if index == global.index {
    plr = id
}

if instance_exists(plr) && !instance_exists(MenuGen) && !instance_exists(Credits) && !instance_exists(Cinematic) {
    scrDrawHUD()
}

if drawcontrols && instance_exists(plr) && !(instance_exists(MenuOptions) && MenuOptions.editing_mode) && !UberCont.opt_keyboard && !UberCont.opt_gamepad {
    scrDrawMobileControls(plr)
}


if !instance_exists(Player) {
    var _x = view_width / 2
    var _y = view_height / 2 - 48
	
	if !instance_exists(Menu)
		scrGamemodePlaybuttons()
	
    if instance_exists(Menu) && UberCont.daily_run {
        var pointed = 0

        if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), view_width - 128, 0, view_width, 24) {
            if mouse_check_button_pressed(mb_left) {
                if !instance_exists(DailyList) {
                    with instance_create(0, 0, DailyList) {
                        viewtype = UberCont.weekly_run ? "weekly" : "daily"
                    }

                    snd_play(sndMenuClick)
                }
				else {
                    with DailyList
                    instance_destroy()

                    snd_play(sndMenuLoadout)
                }
            }

            pointed = 1
        }

        draw_set_color(c_white)

        draw_set_halign(fa_right)
        draw_text_nt(view_width - 24, 7, (pointed ? "@w" : "@s") + loc("RUN HISTORY"))

        if instance_exists(DailyList) {
            draw_text_nt(view_width - 24, 8 + string_height("A"), (pointed ? "@w" : "@s") + "(" + loc(string_upper(DailyList.viewtype)) + ")")
        }

        draw_set_halign(fa_left)

        draw_sprite_ext(sprLoadoutArrow, instance_exists(DailyList), view_width - 2, 24, 1, 1, 0, pointed ? c_white : make_color_rgb(125, 131, 141), 1)
    }
}


with AchievementSplash
	event_user(0)