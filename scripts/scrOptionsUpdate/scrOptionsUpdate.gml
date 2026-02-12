function scrOptionsUpdate() {
	
    with UberCont {
        var res = self[$ "opt_resolution"],
			scaling = self[$ "opt_scaling"],
			cursor = self[$ "opt_cursor"],
			crosshair = self[$ "opt_crosshair"],
			vsync = self[$ "opt_vsync"]
		
		var mobile = is_mobile,
			desktop = is_desktop
		
        opt_volume = save_get_option("volume", "master", true)
        opt_musvol = save_get_option("volume", "music", true)
        opt_ambvol = save_get_option("volume", "ambient", true)
        opt_sndvol = save_get_option("volume", "sfx", true)
		opt_3Dsound = save_get_option("volume", "3dsound", true)
        
		opt_crosshair = save_get_option("options", "crosshair", false)
        opt_gamepad = save_get_option("options", "gamepad", false)
        opt_lefthanded = save_get_option("options", "lefthanded", false)
		opt_keyboard = save_get_option("options", "keyboard", desktop)
        opt_assist = save_get_option("controls", "assist", mobile)
        opt_aimbot = save_get_option("controls", "aimbot", false)
        opt_stickregions = save_get_option("controls", "stickregions", false)
        opt_hiddensticks = save_get_option("controls", "hiddensticks", false)
        opt_pausebutton = save_get_option("options", "pausebutton", mobile)
        opt_volumecontrol = save_get_option("options", "volumecontrol", mobile)
        opt_fixsight = save_get_option("controls", "fixsight", false)
		
		opt_fullscreen = save_get_option("options", "fullscreen", true)
		opt_vsync = save_get_option("options", "vsync", false)
		opt_cursor = save_get_option("options", "cursor", false)
		opt_mouselock = save_get_option("options", "mouselock", false)
        opt_autopause = save_get_option("options", "autopause", true)
		opt_achievs = save_get_option("options", "achievements", true)
		
        opt_outlines = save_get_option("controls", "outlines", true)
        opt_assist = save_get_option("controls", "assist", true)
        opt_sideart = save_get_option("options", "sideart", true)
        opt_color = save_get_option("options", "color", false)
		
        opt_simplify = save_get_option("visual", "simplify", false)
        opt_prtcls = save_get_option("visual", "particles", false)
        opt_bloom = save_get_option("visual", "bloom", true)
        opt_showtimer = save_get_option("visual", "timer", false)
        opt_showarea = save_get_option("visual", "area", false)
        opt_activecam = save_get_option("visual", "camera", true)
        opt_bossintro = save_get_option("visual", "bossintro", true)
        opt_resolution = save_get_option("visual", "resolution", true)
        opt_shake = save_get_option("visual", "screenshake", true)
        opt_freeze = save_get_option("visual", "freezeframes", true)
        opt_scaling = save_get_option("visual", "scaling", true)
        opt_hud = save_get_option("visual", "hud", true)
		
        opt_controls_scale = save_get_option("controls", "scale", 0.5)
		opt_splitfire = save_get_option("controls", "splitfire", false)
		
		if (opt_aimbot) opt_splitfire = false
		
		var _language_last = self[$ "opt_language"]
        opt_language = save_get_option("etc", "language", "null")
		opt_nickname = save_get_option("etc", "name", "null")
		
		opt_cheats = save_get_option("cheats", "unlocked", false)
		opt_console = save_get_option("cheats", "console", false)
		opt_griller = save_get_option("cheats", "griller", false)
		opt_practice = save_get_option("cheats", "practice", false)
		
		opt_remote_ip = save_get_option("coop", "lastip", "127.0.0.1")
		opt_remote_port = save_get_option("coop", "lastport", 25256)
		
		opt_gamepad_type = save_get_option("options", "gamepad_type", false)
		
		cpref_list = [ "eyes", "melting", "plant", "yv", "steroids", "horror", "rogue", "skeleton" ]
		
		cpref_eyes = save_get_option("cprefs", "eyes", true)
		cpref_melting = save_get_option("cprefs", "melting", true)
		cpref_plant = save_get_option("cprefs", "plant", false)
		cpref_yv = save_get_option("cprefs", "yv", true)
		cpref_steroids = save_get_option("cprefs", "steroids", true)
		cpref_horror = save_get_option("cprefs", "horror", true)
		cpref_rogue = save_get_option("cprefs", "rogue", true)
		cpref_skeleton = save_get_option("cprefs", "skeleton", false)
		
		
		// Update variables
		
        scrVolume()
		
		global.player_color = 0
		
		if is_string(opt_color)
			global.player_color = base_convert(opt_color, 16, 10)
		
		opt_healthcol = global.player_color
		opt_cursorcol = global.player_color
		
		if !opt_healthcol
			opt_healthcol = make_color_rgb(252, 56, 0)
		
		if !opt_cursorcol
			opt_cursorcol = c_white
		
		if opt_stickregions
			opt_hiddensticks = true
		
        if (_language_last != opt_language) {
			var _last_font = draw_get_font()
			
			scrLanguageSet(opt_language)
			draw_reset_font()
			
			with (MenuOptions) event_user(10)
		}
		
        if res != undefined && (res != opt_resolution || scaling != opt_scaling) {
            scrSetViewSize(false)
		}
		
		showtutorial = save_get_option("game", "tutorial", true)
		
		if scrValidateUsername(undefined, opt_nickname, true) {
			save_set_value("etc", "nickname", "null")
			opt_nickname = "null"
		}
		
		if file_exists(game_directory + "icheat.txt")
			opt_cheats = true
		
		if !opt_cheats {
			opt_console = false
			opt_griller = false
			opt_practice = false
		}
		
		if opt_gamepad {
			gamepad_set_color(0, global.player_color)
		}
		
		global.cheats = (opt_console || opt_griller || opt_practice)
		
		audio_falloff_set_model(opt_3Dsound ? audio_falloff_linear_distance : audio_falloff_none)
		//apparentlythat didn't work maybe im stupid
		
		//
		globalvar gamepad_types, gamepad_icon_small, gamepad_icon_big;
		
		global.gamepad_types = [
			"XBONE", "PS4", "Switch", "SteamDeck"
		]
		
		if opt_gamepad_type < 0 || opt_gamepad_type >= array_length(global.gamepad_types) {
			opt_gamepad_type = 0
		}
		
		var pad = global.gamepad_types[opt_gamepad_type]
		
		global.gamepad_icon_small = asset_get_index("spr" + pad + "Small")
		global.gamepad_icon_big = asset_get_index("spr" + pad + "Big")
		
		if (!sprite_exists(global.gamepad_icon_small)) global.gamepad_icon_small = sprXBONESmall
		if (!sprite_exists(global.gamepad_icon_big)) global.gamepad_icon_big = sprXBONEBig
		
		//
		var type = save_get_value("etc", "last_os", -1)
		
		if os_type != type {
			if os_type == os_android {
				opt_keyboard = save_set_value("options", "keyboard", false)
			}
		}
		
		save_set_value("etc", "last_os", os_type)
		
		if is_desktop && (opt_cursor != cursor or opt_crosshair != crosshair)
			scrOptionsUpdateNativeCursor()
		
		scrKeymapsSetup()
		
		scrOptionsLoadKeymaps()
		
		if is_struct(my_player) {
			my_player.update_cprefs()
		}
		
		try {
			opt_remote_port = real(opt_remote_port)
		}
		catch(e) {
			opt_remote_port = NETWORK_PORT
		}
    }
}

function scrOptionsUpdateNativeCursor() {
	if !is_desktop
		exit
	
	with UberCont {
		if native_cursor_inst != -1 {
			native_cursor_destroy(native_cursor_inst)
			native_cursor_inst = -1
		}
		
		if opt_cursor {
			native_cursor_inst = native_cursor_create_from_sprite_ext(sprCrosshair, opt_crosshair % sprite_get_number(sprCrosshair), 4, 4, opt_cursorcol, 1)
			native_cursor_set(native_cursor_inst)
			
			window_set_cursor(cr_arrow)
		}
		else window_set_cursor(cr_none)
	}
}

function scrOptionsEraseSettings() {
	with (MenuOptions) {
	    array_foreach(options, function(_categories) {
			array_foreach(_categories, function(_opt) {
				if (is_string(_opt[$ "key"]) && _opt.key != "game_tutorial") {
					ds_map_delete(UberCont.saveData, _opt.key)
				}
			})
	    })
		
		save_set_value("etc", "resourcepack_disclaimer", false)
		scrOptionsUpdate()
		scrSave()
		
	    snd_play(sndClick)
	    snd_play(sndMutant0Cnfm)
		
	    event_perform(ev_create, 0)
	}
}