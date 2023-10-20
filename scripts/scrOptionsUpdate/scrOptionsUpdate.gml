function scrOptionsUpdate() {
	
    with UberCont {
        var res = self[$ "opt_resolution"],
			scaling = self[$ "opt_scaling"],
			vsync = self[$ "opt_vsync"]
		
		var mobile = !global.desktop,
			desktop = global.desktop
		
        opt_volume = save_get_option("volume", "master", 1)
        opt_musvol = save_get_option("volume", "music", 1)
        opt_ambvol = save_get_option("volume", "ambient", 1)
        opt_sndvol = save_get_option("volume", "sfx", 1)
		opt_3Dsound = save_get_option("volume", "3dsound", 1)
		opt_pauseonpause = save_get_option("volume", "pauseonpause", 0)
        
		opt_crosshair = save_get_option("options", "crosshair", 0)
        opt_gamepad = save_get_option("options", "gamepad", 0)
        opt_lefthanded = save_get_option("options", "lefthanded", 0)
		opt_keyboard = save_get_option("options", "keyboard", desktop)
        opt_assist = save_get_option("controls", "assist", mobile)
        opt_aimbot = save_get_option("controls", "aimbot", 0)
        opt_stickregions = save_get_option("controls", "stickregions", false)
        opt_hiddensticks = save_get_option("controls", "hiddensticks", false)
        opt_pausebutton = save_get_option("options", "pausebutton", mobile)
        opt_volumecontrol = save_get_option("options", "volumecontrol", mobile)
        opt_fixsight = save_get_option("controls", "fixsight", 0)
		
		
		opt_fullscreen = save_get_option("options", "fullscreen", 1)
		opt_vsync = save_get_option("options", "vsync", 0)
		opt_cursor = save_get_option("options", "cursor", 0)
		opt_mouselock = save_get_option("options", "mouselock", 0)
        opt_autopause = save_get_option("options", "autopause", 1)
		opt_achievs = save_get_option("options", "achievements", 1)
		
        opt_outlines = save_get_option("controls", "outlines", 1)
        opt_assist = save_get_option("controls", "assist", 1)
        opt_sideart = save_get_option("options", "sideart", 1)
        opt_color = save_get_option("options", "color", 0)
		
        opt_simplify = save_get_option("visual", "simplify", 0)
        opt_prtcls = save_get_option("visual", "particles", 0)
        opt_bloom = save_get_option("visual", "bloom", 1)
        opt_walls = save_get_option("visual", "walls", 1)
        opt_timer = save_get_option("visual", "timer", 1)
        opt_bossintro = save_get_option("visual", "bossintro", 0)
        opt_resolution = save_get_option("visual", "resolution", 1)
        opt_shake = save_get_option("visual", "screenshake", 1)
        opt_freezeframes = save_get_option("visual", "freezeframes", 0)
        opt_scaling = save_get_option("visual", "scaling", 1)
        opt_hud = save_get_option("visual", "hud", 1)
		
        opt_controls_scale = save_get_option("controls", "scale", 0.5)
		opt_wepstick = save_get_option("controls", "wepstick", 0)
		opt_splitfire = save_get_option("controls", "splitfire", 0)
		
        opt_language = save_get_option("etc", "language", "null")
		opt_nickname = save_get_option("etc", "name", "null")
		
		opt_cheats = save_get_option("cheats", "unlocked", 0)
		opt_console = save_get_option("cheats", "console", 0)
		opt_griller = save_get_option("cheats", "griller", 0)
		
		opt_remote_ip = save_get_option("coop", "lastip", "127.0.0.1")
		opt_remote_port = save_get_option("coop", "lastport", 25256)
		
		opt_gamepad_type = save_get_option("options", "gamepad_type", 0)
		
		cpref_list = [ "eyes", "melting", "plant", "yv", "steroids", "horror", "rogue", "skeleton" ]
		
		cpref_eyes = save_get_option("cprefs", "eyes", 1)
		cpref_melting = save_get_option("cprefs", "melting", 1)
		cpref_plant = save_get_option("cprefs", "plant", 0)
		cpref_yv = save_get_option("cprefs", "yv", 1)
		cpref_steroids = save_get_option("cprefs", "steroids", 1)
		cpref_horror = save_get_option("cprefs", "horror", 1)
		cpref_rogue = save_get_option("cprefs", "rogue", 1)
		cpref_skeleton = save_get_option("cprefs", "skeleton", 0)
		
		
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
		
        scrLanguageSet(opt_language)
		
        if res != undefined && (res != opt_resolution or scaling != opt_scaling) {
            scrSetViewSize(false)
		}
		
		showtutorial = save_get_option("game", "tutorial", 1)
		
		if scrValidateUsername(undefined, opt_nickname, true) {
			save_set_value("etc", "nickname", "null")
			opt_nickname = "null"
		}
		
		if file_exists(game_directory + "/icheat.txt")
			opt_cheats = true
		
		if !opt_cheats {
			opt_console = false
			opt_griller = false
		}
		
		if opt_gamepad {
			gamepad_set_color(0, global.player_color)
		}
		
		global.cheats = (opt_console or opt_griller)
		
		audio_falloff_set_model(opt_3Dsound ? audio_falloff_linear_distance : audio_falloff_none)
		//apparentlythat didn't work maybe im stupid
		
		//
		globalvar gamepad_types, gamepad_icon_small, gamepad_icon_big;
		
		global.gamepad_types = [
			"Xbox", "PS4", "Switch"
		]
		
		if opt_gamepad_type < 0 or opt_gamepad_type >= array_length(global.gamepad_types)
			opt_gamepad_type = 0
		
		var pad = global.gamepad_types[opt_gamepad_type]
		
		global.gamepad_icon_small = asset_get_index("spr" + pad + "Small")
		global.gamepad_icon_big = asset_get_index("spr" + pad + "Big")
		
		//if os_type == os_android && !instance_exists(GameCont)
		//	SetVolumeControl(opt_volumecontrol)
		
		var type = save_get_value("etc", "last_os", -1)
		
		if os_type != type {
			if os_type == os_android {
				opt_keyboard = save_set_value("options", "keyboard", false)
			}
		}
		
		save_set_value("etc", "last_os", os_type)
		
		scrKeymapsSetup()
		
		scrOptionsLoadKeymaps()
		
		if is_struct(playerinstance)
			playerinstance.update_prefs()
		
		try {
			opt_remote_port = real(opt_remote_port)
		}
		catch(e) {
			opt_remote_port = NETWORK_PORT
		}
    }
}