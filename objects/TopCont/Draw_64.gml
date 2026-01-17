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
		
		/// @loc:token [R:MainMenu] RunHistory "RUN HISTORY"
        draw_text_nt(view_width - 32, 7,
			(_pointed ? "@w" : "@s") + loc("R:MainMenu:RunHistory", "RUN HISTORY"))

        if (instance_exists(DailyList)) {
			var _viewtype = DailyList.viewtype
			
			/// @loc:token [R:MainMenu] RunHistory:daily "DAILY"
			/// @loc:token [R:MainMenu] RunHistory:weekly "WEEKLY"
			var _viewtype_string = loc(
				"R:MainMenu", "RunHistory" + string_lower(_viewtype), string_upper(_viewtype))
			
            draw_text_nt(view_width - 32, 8 + font_get_string_height("A"),
				(_pointed ? "@w" : "@s") + "(" + _viewtype_string + ")")
        }

        draw_set_halign(fa_left)

        draw_sprite_ext(sprLoadoutArrow, instance_exists(DailyList), view_width - 16, 16,
			1, 1, 0, _pointed ? c_white : make_color_rgb(125, 131, 141), 1)
    }
}

with (AchievementSplash) event_user(0)
