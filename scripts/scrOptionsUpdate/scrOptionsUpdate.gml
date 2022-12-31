function scrOptionsUpdate() {
    with UberCont {
        var res = opt_resolution

        opt_gamepad = save_get_val("options", "gamepad", 0)
        opt_firemode = save_get_val("controls", "firemode", 0)
        opt_musvol = save_get_val("options", "music", 1)
        opt_sfxvol = save_get_val("options", "sfx", 1)
        opt_ambvol = save_get_val("options", "sfx", 1)
        opt_sndvol = save_get_val("options", "sound", 1)
        opt_simplify = save_get_val("visual", "simplify", 0)
        opt_prtcls = save_get_val("visual", "particles", 0)
        opt_bloom = save_get_val("visual", "bloom", 1)
        opt_walls = save_get_val("visual", "walls", 1)
        opt_timer = save_get_val("visual", "timer", 1)
        opt_shake = save_get_val("visual", "screenshake", 1)
        opt_assist = save_get_val("controls", "assist", 1)
        // opt_enhancements = save_get_val("controls", "enhancements", 1)
        opt_hud = save_get_val("visual", "hud", 1)
        opt_resolution = save_get_val("visual", "resolution", 1)
        opt_bossintro = save_get_val("visual", "bossintro", 0)
        opt_activecam = save_get_val("visual", "activecam", 1)
        opt_pausebutton = save_get_val("options", "pausebutton", !global.pc_build)
        opt_sideart = save_get_val("options", "sideart", 1)
        opt_controls_scale = save_get_val("controls", "scale", 0.5)
        opt_language = save_get_val("etc", "language", "en")

        scrVolume()

        if res != opt_resolution {
            scrSetViewSize(0)
        }

        if os_type == os_android {
            SetVolumeControl(save_get_val("controls", "volumecontrol", 1))
        }

        scrLanguageSet(opt_language)
    }
}