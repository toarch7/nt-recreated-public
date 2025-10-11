/// TODO: ideally this savedata should be made full compatible with base NT
function scrInit() {
	var _fix_inconsistent_weapon_ids = false,
		_fix_binary_skin_system = false
	
	#region Load savedata file
    saveData = undefined

    if file_exists(game_directory + "NuclearThrone.sav") {
        var f = file_text_open_read(game_directory + "NuclearThrone.sav")
        var raw = file_text_read_string(f)
        file_text_close(f)

        saveData = json_decode(raw)
	}
	else saveData = ds_map_create()
	
    if saveData < 0 || is_undefined(saveData) {
        show_message_async("Your save data has corrupted. Please do not close the game while saving icon is on-screen.")
        saveData = ds_map_create()
    }

    // If there's some PC savefile fields, try to convert it into NTM's supported formated
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

            save_set_value("ctotkill", string(cId), stat[? "ctot_kill"])
            save_set_value("ctotdead", string(cId), stat[? "ctot_dead"])
            save_set_value("ctotloop", string(cId), stat[? "ctot_loop"])
            save_set_value("ctottime", string(cId), stat[? "ctot_time"])
            save_set_value("ctotwins", string(cId), stat[? "ctot_wins"])
            save_set_value("ctotuniq", string(cId), stat[? "ctot_uniq"])
            save_set_value("ctotruns", string(cId), stat[? "ctot_runs"])
            save_set_value("ctotwins", string(cId), stat[? "ctot_wins"])
            save_set_value("ctotdays", string(cId), stat[? "ctot_days"])
            save_set_value("ctothard", string(cId), stat[? "ctot_hard"])
            save_set_value("ctotstrk", string(cId), stat[? "ctot_strk"])
            save_set_value("cbstkill", string(cId), stat[? "cbst_kill"])
            save_set_value("cbstdiff", string(cId), stat[? "cbst_diff"])
            save_set_value("cbstloop", string(cId), stat[? "cbst_loop"])
            save_set_value("cbsttime", string(cId), stat[? "cbst_time"])
            save_set_value("cbstarea", string(cId), stat[? "cbst_area"])
            save_set_value("cbstsuba", string(cId), stat[? "cbst_suba"])
            save_set_value("cbstrace", string(cId), stat[? "cbst_race"])
            save_set_value("cbststrk", string(cId), stat[? "cbst_strk"])
            save_set_value("cbstfast", string(cId), stat[? "cbst_fast"])
            save_set_value("hbstkill", string(cId), stat[? "hbst_kill"])
            save_set_value("hbstarea", string(cId), stat[? "hbst_area"])
            save_set_value("hbstsuba", string(cId), stat[? "hbst_suba"])
            save_set_value("hbstloop", string(cId), stat[? "hbst_loop"])
            save_set_value("hbstrace", string(cId), stat[? "hbst_race"])
            save_set_value("dbstkill", string(cId), stat[? "dbst_kill"])
            save_set_value("dbstarea", string(cId), stat[? "dbst_area"])
            save_set_value("dbstsuba", string(cId), stat[? "dbst_suba"])
            save_set_value("dbstloop", string(cId), stat[? "dbst_loop"])
            save_set_value("dbstrace", string(cId), stat[? "dbst_race"])

            //time += stat[? "ctot_time"]
        }

        var data = pcSave[? "data"]

        saveData[? "etc_hard"] = data[? "hardgot"]
        saveData[? "game_tutorial"] = data[? "showtutorial"]

        saveData[? "data_tot_time"] = time

        ds_map_destroy(pcSave)

        show_message_async("All of your Nuclear Throne progress was converted successfully!")
    }
	
	#endregion
	
	#region Also load auxiliary configuration files
	
    ini_open(game_directory + "configs.ini")
    opt_online = ini_read_real("Options", "OnlineFeatures", 1)
    opt_updates = ini_read_real("Options", "UpdateChecker", 1)
    ini_write_real("Options", "OnlineFeatures", opt_online)
    ini_write_real("Options", "UpdateChecker", opt_updates)
    ini_close()
	
    if file_exists("temp") {
        var f = file_text_open_read("temp")
        save_set_value("etc", "seed", file_text_read_string(f))
        file_text_close(f)
    }
	
	#endregion
	
	#region Register some of the content
	
    scrRaces()
    scrCrowns()
	scrWeapons()
	scrUltras()
	
	#endregion
	
	#region Setup conversion flags
	
	var _last_loaded_version = save_get_value("etc", "versioncheck", GAME_BUILD)
	
	if _last_loaded_version != GAME_BUILD {
		// Build 3000 - major game code refactoring
		if _last_loaded_version < 3000 {
			_fix_inconsistent_weapon_ids = true
			_fix_binary_skin_system = true
		}
	}
	
	#endregion
	
    protowep = save_get_value("etc", "protowep", 56)
	
	if _fix_inconsistent_weapon_ids && protowep == 255 {
		save_set_value("etc", "protowep", wep_golden_frog_pistol)
		protowep = wep_golden_frog_pistol
	}
	
    save_set_value("cgot", Race.Random, true)
    save_set_value("cgot", Race.Fish, true)
    save_set_value("cgot", Race.Crystal, true)

    if save_get_value("etc", "name") == "unnamed" {
        save_set_value("etc", "name", "Seeker" + string(string_pad_zeroes(irandom(999), 2)))
    }
	
    cgot = array_create(Race.NUM_ALL_RACE_TYPES, 0)
	
    tot_time = save_get_value("data", "tot_time", 0)
    tot_kill_daily = 0
    tot_kill_weekly = 0
	
    /* Memo:
		$"cgot_{RACE_ID}"               - character unlocked
		$"cwep_{RACE_ID}"               - secondary (golden) sweapon
		$"crowngot{RACE_ID}_{CROWN_ID}" - is the crown unlocked for character;
		$"ccrown_{RACE_ID}"             - character's choosen crown
		$"cskingot{RACE_ID}_{SKIN_ID}"  - is b-skin (or c-skin) unlocked
		$"cskin_{RACE_ID}"              - character's choosen skin
	*/
	
    for (var _race_id = Race.Random; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
		var _race_str = string(_race_id)
		
		if _fix_binary_skin_system {
			var _got_bskin = save_get_value("cskingot", _race_str, false)
			save_set_value("cskingot" + _race_str, 1, _got_bskin)
			save_delete_value("cskingot", _race_str)
		}
		
        cgot[_race_id] = save_get_value("cgot", _race_str, false)
		cskin[_race_id] = save_get_value("cskin", _race_str, false)
        ctot_kill[_race_id] = save_get_value("ctotkill", _race_str, 0)
        ctot_dead[_race_id] = save_get_value("ctotdead", _race_str, 0)
        ctot_loop[_race_id] = save_get_value("ctotloop", _race_str, 0)
        ctot_time[_race_id] = save_get_value("ctottime", _race_str, 0)
        ctot_wins[_race_id] = save_get_value("ctotwins", _race_str, 0)
        ctot_uniq[_race_id] = save_get_value("ctotuniq", _race_str, 0)
        ctot_runs[_race_id] = save_get_value("ctotruns", _race_str, 0)
        ctot_wins[_race_id] = save_get_value("ctotwins", _race_str, 0)
        ctot_days[_race_id] = save_get_value("ctotdays", _race_str, 0)
        ctot_hard[_race_id] = save_get_value("ctothard", _race_str, 0)
        ctot_strk[_race_id] = save_get_value("ctotstrk", _race_str, 0)
        cbst_kill[_race_id] = save_get_value("cbstkill", _race_str, 0)
        cbst_diff[_race_id] = save_get_value("cbstdiff", _race_str, 0)
        cbst_loop[_race_id] = save_get_value("cbstloop", _race_str, 0)
        cbst_time[_race_id] = save_get_value("cbsttime", _race_str, 0)
        cbst_area[_race_id] = save_get_value("cbstarea", _race_str, 0)
        cbst_suba[_race_id] = save_get_value("cbstsuba", _race_str, 0)
        cbst_race[_race_id] = save_get_value("cbstrace", _race_str, 0)
        cbst_strk[_race_id] = save_get_value("cbststrk", _race_str, 0)
        cbst_fast[_race_id] = save_get_value("cbstfast", _race_str, 0)
        hbst_kill[_race_id] = save_get_value("hbstkill", _race_str, 0)
        hbst_area[_race_id] = save_get_value("hbstarea", _race_str, 0)
        hbst_suba[_race_id] = save_get_value("hbstsuba", _race_str, 0)
        hbst_loop[_race_id] = save_get_value("hbstloop", _race_str, 0)
        hbst_race[_race_id] = save_get_value("hbstrace", _race_str, 0)
        dbst_kill[_race_id] = save_get_value("dbstkill", _race_str, 0)
        dbst_area[_race_id] = save_get_value("dbstarea", _race_str, 0)
        dbst_suba[_race_id] = save_get_value("dbstsuba", _race_str, 0)
        dbst_loop[_race_id] = save_get_value("dbstloop", _race_str, 0)
        dbst_race[_race_id] = save_get_value("dbstrace", _race_str, 0)
		
        cwep[_race_id] = save_get_value("cwep", _race_str, scrRaceGetStarterWeapon(_race_id))
		
		if cwep[_race_id] == 255 && _fix_inconsistent_weapon_ids {
			save_set_value("cwep", _race_str, wep_golden_frog_pistol)
			cwep[_race_id] = wep_golden_frog_pistol
		}
		
		var _max_skins = scrRaceGetMaxSkinCount(_race_id)
		for(var _skin_id = 0; _skin_id < _max_skins; ++_skin_id) {
			var _cskingot_key = "cskingot" + _race_str
			
			cskingot[_race_id, _skin_id] = save_get_value(_cskingot_key, _skin_id, (_skin_id == 0))
		}
		
		var _max_crowns = crownmax + 1
        for (var _crown_id = 1; _crown_id < _max_crowns; ++_crown_id) {
			var _crowngot_key = "crowngot" + _race_str
            crowngot[_race_id, _crown_id] = save_get_value(_crowngot_key, _crown_id, false)
        }

        crowngot[_race_id, crwn_random] = true
        crowngot[_race_id, crwn_none] = true
    }
	
    hardgot = save_get_value("etc", "hard", 0)
	
	scrOptionsUpdate()
	
    scrAchievements()
	
    scrInitStats()
	
    scrLoadoutMenuInit()
}

function scrInitPostGamestart() {
	
	with UberCont {
		if is_desktop {
			call_after(5, function() {
				if window_get_fullscreen() != opt_fullscreen {
					scr_window_set_fullscreen(opt_fullscreen)
				}
			})
			
			display_reset(0, opt_vsync)
			
			opt_assist = 0
		}
		else {
			display_reset(0, 0)
		}
	}
}