if lockstep_stop
	exit

var _player;

if instance_number(Player) > 1 {
	_player = noone
	
	with Player {
		if (index == global.index) _player = id
	}
}
else {
	_player = instance_find(Player, 0)
}

with (GameCont) scrDrawMiscHUD()

if instance_exists(_player) && !instance_exists(Credits) && !instance_exists(Cinematic) {
    scrDrawPlayerHUD(_player)
}

if drawcontrols && instance_exists(_player) && !(instance_exists(MenuOptions) && MenuOptions.editing_mode) && !UberCont.opt_keyboard && !UberCont.opt_gamepad {
    scrDrawMobileControls(_player)
}

if !instance_exists(Player) {
    var _x = view_xview_center
    var _y = view_yview_center - 48
	
	if (!instance_exists(Menu)) scrDrawGameModeIndication()
	
    if instance_exists(Menu) && scrGameIsEventRun() {
        var _pointed = false

        if point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), view_width - 128, 0, view_width, 24) {
            if mouse_check_button_pressed(mb_left) {
                if !instance_exists(DailyList) {
                    with instance_create(0, 0, DailyList) {
                        viewtype = scrGameIsWeeklyRun() ? "weekly" : "daily"
                    }

                    snd_play(sndClick)
                }
				else {
                    with DailyList
                    instance_destroy()

                    snd_play(sndMenuLoadout)
                }
            }

            _pointed = true
        }

        draw_set_color(c_white)

        draw_set_halign(fa_right)
        draw_text_nt(view_width - 24, 7, (_pointed ? "@w" : "@s") + loc("RUN HISTORY"))

        if instance_exists(DailyList) {
            draw_text_nt(view_width - 24, 8 + string_height("A"),
				(_pointed ? "@w" : "@s") + "(" + loc(string_upper(DailyList.viewtype)) + ")")
        }

        draw_set_halign(fa_left)

        draw_sprite_ext(sprLoadoutArrow, instance_exists(DailyList), view_width - 2, 24,
			1, 1, 0, _pointed ? c_white : make_color_rgb(125, 131, 141), 1)
    }
}

with (AchievementSplash) event_user(0)
