function scrOptionsUpdate() {
	
    with UberCont {
        var res = self[$ "opt_resolution"],
			scaling = self[$ "opt_scaling"],
			vsync = self[$ "opt_vsync"]
		
		var mobile = !global.desktop,
			desktop = global.desktop
		
        opt_volume = save_get_val_s("volume", "master", 1)
        opt_musvol = save_get_val_s("volume", "music", 1)
        opt_ambvol = save_get_val_s("volume", "ambient", 1)
        opt_sndvol = save_get_val_s("volume", "sfx", 1)
		opt_3Dsound = save_get_val_s("volume", "3dsound", 1)
		opt_pauseonpause = save_get_val_s("volume", "pauseonpause", 0)
        
		opt_crosshair = save_get_val_s("options", "crosshair", 0)
        opt_gamepad = save_get_val_s("options", "gamepad", 0)
        opt_lefthanded = save_get_val_s("options", "lefthanded", 0)
		opt_keyboard = save_get_val_s("options", "keyboard", desktop)
        opt_assist = save_get_val_s("controls", "assist", mobile)
        opt_aimbot = save_get_val_s("controls", "aimbot", 0)
        opt_pausebutton = save_get_val_s("options", "pausebutton", mobile)
        opt_volumecontrol = save_get_val_s("options", "volumecontrol", mobile)
		
		opt_fullscreen = save_get_val_s("options", "fullscreen", 1)
		opt_vsync = save_get_val_s("options", "vsync", 0)
		opt_cursor = save_get_val_s("options", "cursor", 0)
		opt_mouselock = save_get_val_s("options", "mouselock", 0)
        opt_autopause = save_get_val_s("options", "autopause", 1)
		opt_achievs = save_get_val_s("options", "achievements", 1)
		
        opt_outlines = save_get_val_s("controls", "outlines", 1)
        opt_assist = save_get_val_s("controls", "assist", 1)
        opt_sideart = save_get_val_s("options", "sideart", 1)
        opt_color = save_get_val_s("options", "color", 0)
		
        opt_simplify = save_get_val_s("visual", "simplify", 0)
        opt_prtcls = save_get_val_s("visual", "particles", 0)
        opt_bloom = save_get_val_s("visual", "bloom", 1)
        opt_walls = save_get_val_s("visual", "walls", 1)
        opt_timer = save_get_val_s("visual", "timer", 1)
        opt_bossintro = save_get_val_s("visual", "bossintro", 0)
        opt_resolution = save_get_val_s("visual", "resolution", 1)
        opt_shake = save_get_val_s("visual", "screenshake", 1)
        opt_freezeframes = save_get_val_s("visual", "freezeframes", 0)
        opt_scaling = save_get_val_s("visual", "scaling", 1)
        opt_hud = save_get_val_s("visual", "hud", 1)
		
		opt_firemode = save_get_val_s("controls", "firemode", 0)
        opt_controls_scale = save_get_val_s("controls", "scale", 0.5)
		
        opt_language = save_get_val_s("etc", "language", "null")
		opt_nickname = save_get_val_s("etc", "name", "null")
		
		opt_cheats = save_get_val_s("cheats", "unlocked", 0)
		opt_console = save_get_val_s("cheats", "console", 0)
		opt_griller = save_get_val_s("cheats", "griller", 0)
		
		opt_gamepad_type = save_get_val_s("options", "gamepad_type", 0)
		
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
		
        if res != undefined && (res != opt_resolution or scaling != opt_scaling)
            scrSetViewSize(0)
		
        if os_type == os_android && (instance_exists(GameCont) or instance_exists(Player))
            SetVolumeControl(opt_volumecontrol)
		
		showtutorial = save_get_val_s("game", "tutorial", 1)
		
		if scrValidateUsername(undefined, opt_nickname, true) {
			save_set_val("etc", "nickname", "null")
			opt_nickname = "null"
		}
		
		if !opt_cheats {
			opt_console = false
			opt_griller = false
		}
		
		if opt_gamepad {
			gamepad_set_color(0, global.player_color)
		}
		
		global.cheats = opt_console or opt_griller
		
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
		
		scrKeymapsSetup()
		
		scrOptionsLoadKeymaps()
    }
}