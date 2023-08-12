function scrInit() {
    saveData = undefined

    if file_exists(game_directory + "NuclearThrone.sav") {
        var f = file_text_open_read(game_directory + "NuclearThrone.sav")
        var raw = file_text_read_string(f)
        file_text_close(f)

        saveData = json_decode(raw)
	}
	else saveData = ds_map_create()

    if saveData < 0 or is_undefined(saveData) {
        show_message_async("Your save data has corrupted. Please do not close the game while saving icon is on-screen.")
        saveData = ds_map_create()
    }

    //If there's some PC savefile fields, convert it to mobile
    if !is_undefined(saveData[? "VLAMBEER DRM 2013-NOW"]) && !is_undefined(saveData[? "stats"]) {
        var pcSave = saveData
        saveData = ds_map_create()

        var stats = pcSave[? "stats"]

        var time = 0

        for (var key = ds_map_find_first(stats); !is_undefined(stats[? key]); key = ds_map_find_next(stats, key)) {
            var cId = string_replace(key, "charData_", "")

            if key == "tot_time" {
                time = saveData[? "tot_time"]
                continue
            }

            var stat = stats[? key]

            var crowns = stat[? "crowns"]

            //le frog pistole
            if stat[? "cgld"] == 201 {
                stat[? "cgld"] = 255
            }

            saveData[? "cgot_" + cId] = stat[? "cgot"] ?? 0
            saveData[? "cwep_" + cId] = clamp(stat[? "cgld"] ?? 1, 1, 255)
            saveData[? "cskingot_" + cId] = stat[? "cbgt"] ?? 0
            saveData[? "cskin_" + cId] = stat[? "startskin"] ?? 0
            saveData[? "ccrown_" + cId] = stat[? "startcrown"] ?? 1

            var s = "["
            for (var i = 0; i < ds_list_size(crowns); i++) {
                saveData[? "crowngot" + cId + "_" + string(i)] = crowns[| i]
            }

            save_set_val("ctotkill", string(cId), stat[? "ctot_kill"])
            save_set_val("ctotdead", string(cId), stat[? "ctot_dead"])
            save_set_val("ctotloop", string(cId), stat[? "ctot_loop"])
            save_set_val("ctottime", string(cId), stat[? "ctot_time"])
            save_set_val("ctotwins", string(cId), stat[? "ctot_wins"])
            save_set_val("ctotuniq", string(cId), stat[? "ctot_uniq"])
            save_set_val("ctotruns", string(cId), stat[? "ctot_runs"])
            save_set_val("ctotwins", string(cId), stat[? "ctot_wins"])
            save_set_val("ctotdays", string(cId), stat[? "ctot_days"])
            save_set_val("ctothard", string(cId), stat[? "ctot_hard"])
            save_set_val("ctotstrk", string(cId), stat[? "ctot_strk"])
            save_set_val("cbstkill", string(cId), stat[? "cbst_kill"])
            save_set_val("cbstdiff", string(cId), stat[? "cbst_diff"])
            save_set_val("cbstloop", string(cId), stat[? "cbst_loop"])
            save_set_val("cbsttime", string(cId), stat[? "cbst_time"])
            save_set_val("cbstarea", string(cId), stat[? "cbst_area"])
            save_set_val("cbstsuba", string(cId), stat[? "cbst_suba"])
            save_set_val("cbstrace", string(cId), stat[? "cbst_race"])
            save_set_val("cbststrk", string(cId), stat[? "cbst_strk"])
            save_set_val("cbstfast", string(cId), stat[? "cbst_fast"])
            save_set_val("hbstkill", string(cId), stat[? "hbst_kill"])
            save_set_val("hbstarea", string(cId), stat[? "hbst_area"])
            save_set_val("hbstsuba", string(cId), stat[? "hbst_suba"])
            save_set_val("hbstloop", string(cId), stat[? "hbst_loop"])
            save_set_val("hbstrace", string(cId), stat[? "hbst_race"])
            save_set_val("dbstkill", string(cId), stat[? "dbst_kill"])
            save_set_val("dbstarea", string(cId), stat[? "dbst_area"])
            save_set_val("dbstsuba", string(cId), stat[? "dbst_suba"])
            save_set_val("dbstloop", string(cId), stat[? "dbst_loop"])
            save_set_val("dbstrace", string(cId), stat[? "dbst_race"])

            //time += stat[? "ctot_time"]
        }

        var data = pcSave[? "data"]

        saveData[? "etc_hard"] = data[? "hardgot"]
        saveData[? "game_tutorial"] = data[? "showtutorial"]

        saveData[? "data_tot_time"] = time

        ds_map_destroy(pcSave)

        show_message_async("Everything but settings is converted successfully.")
    }

    //Load
	
    scrRaces()
    scrCrowns()

    ini_open(game_directory + "configs.ini")
	
    opt_online = ini_read_real("Options", "OnlineFeatures", 1)
    opt_updates = ini_read_real("Options", "UpdateChecker", 1)
	
    ini_write_real("Options", "OnlineFeatures", opt_online)
    ini_write_real("Options", "UpdateChecker", opt_updates)

   

    ini_close()

    if file_exists("temp") {
        var f = file_text_open_read("temp")
        save_set_val("etc", "seed", file_text_read_string(f))
        file_text_close(f)
    }
	
    protowep = save_get_val("etc", "protowep", 56)
	
	
	
    save_set_val("cgot", "0", 1)
    save_set_val("cgot", "1", 1)
    save_set_val("cgot", "2", 1)

    if save_get_val("etc", "name", "unnamed") == "unnamed" {
        save_set_val("etc", "name", "Seeker" + string(scrAddZero(irandom(999), 2)))
    }

    cgot = array_create(16, 0)

    cgot[0] = 1

    tot_time = save_get_val("data", "tot_time", 0)
    tot_kill_daily = 0
    tot_kill_weekly = 0

    for (var i = 1; i < array_length(race_name); i++) {
        cgot[i] = save_get_val("cgot", string(i), 0)
        cskin[i] = save_get_val("cskin", string(i), 0)
        cskingot[i] = save_get_val("cskingot", string(i), 0)
        ctot_kill[i] = save_get_val("ctotkill", string(i), 0)
        ctot_dead[i] = save_get_val("ctotdead", string(i), 0)
        ctot_loop[i] = save_get_val("ctotloop", string(i), 0)
        ctot_time[i] = save_get_val("ctottime", string(i), 0)
        ctot_wins[i] = save_get_val("ctotwins", string(i), 0)
        ctot_uniq[i] = save_get_val("ctotuniq", string(i), 0)
        ctot_runs[i] = save_get_val("ctotruns", string(i), 0)
        ctot_wins[i] = save_get_val("ctotwins", string(i), 0)
        ctot_days[i] = save_get_val("ctotdays", string(i), 0)
        ctot_hard[i] = save_get_val("ctothard", string(i), 0)
        ctot_strk[i] = save_get_val("ctotstrk", string(i), 0)
        cbst_kill[i] = save_get_val("cbstkill", string(i), 0)
        cbst_diff[i] = save_get_val("cbstdiff", string(i), 0)
        cbst_loop[i] = save_get_val("cbstloop", string(i), 0)
        cbst_time[i] = save_get_val("cbsttime", string(i), 0)
        cbst_area[i] = save_get_val("cbstarea", string(i), 0)
        cbst_suba[i] = save_get_val("cbstsuba", string(i), 0)
        cbst_race[i] = save_get_val("cbstrace", string(i), 0)
        cbst_strk[i] = save_get_val("cbststrk", string(i), 0)
        cbst_fast[i] = save_get_val("cbstfast", string(i), 0)
        hbst_kill[i] = save_get_val("hbstkill", string(i), 0)
        hbst_area[i] = save_get_val("hbstarea", string(i), 0)
        hbst_suba[i] = save_get_val("hbstsuba", string(i), 0)
        hbst_loop[i] = save_get_val("hbstloop", string(i), 0)
        hbst_race[i] = save_get_val("hbstrace", string(i), 0)
        dbst_kill[i] = save_get_val("dbstkill", string(i), 0)
        dbst_area[i] = save_get_val("dbstarea", string(i), 0)
        dbst_suba[i] = save_get_val("dbstsuba", string(i), 0)
        dbst_loop[i] = save_get_val("dbstloop", string(i), 0)
        dbst_race[i] = save_get_val("dbstrace", string(i), 0)

        cwep[i] = save_get_val("cwep", string(i), race_swep[i])
        //cbgt[i] = save_get_val("cbgt", string(i), 0)
        //cgld[i] = save_get_val("cgld", string(i), 0)
        for (var c = 1; c <= crownmax; c++) {
            crowngot[i, c] = save_get_val("crowngot" + string(i), string(c), 0)
        }

        crowngot[i, 0] = 1
        crowngot[i, 1] = 1
    }
	
    hardgot = save_get_val("etc", "hard", 0)
	
    /*
	
	cwep - second sweapon
	ccrown - character's choosen crown
	crowngot - is crown unlocked for character
	cskin - character's choosen skin
	cskingot - is character's b-skin unlocked
	
	*/
	
	scrOptionsUpdate()
	
	with UberCont {
		if global.desktop {
			if window_get_fullscreen() != opt_fullscreen
				window_set_fullscreen(opt_fullscreen)
			
			display_reset(0, opt_vsync)
			
			opt_assist = 0
		}
		else {
			display_reset(0, 0)
		}
	}
	
    scrAchievements()
    scrLoadLoadout()
	
    scrInitStats()
	
}