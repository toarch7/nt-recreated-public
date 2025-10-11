function scrSave() {
    with UberCont {
		var stats = true,
			save = saveData,
			savepath = game_directory + "NuclearThrone.sav"
		
        if global.cheats && file_exists(savepath) {
			var f = file_text_open_read(savepath)
			
	        var raw = file_text_read_string(f)
	        
			file_text_close(f)
			
	        var data = json_decode(raw)
			
			var options = [
				"cheats_console", "cheats_griller", "cheats_practice", "options_gamepad", "options_keyboard",
				"etc_nickname", "visual_resolution", "visual_fullscreen",
			]
			
			for(var _race_id = 0; _race_id < array_length(cpref_list); _race_id ++)
				array_push(options, "cprefs_" + cpref_list[_race_id])
			
			for(var _race_id = 0; _race_id < array_length(options); _race_id ++) {
				var opt = options[_race_id]
				
				data[? opt] = saveData[? opt]
			}
			
			stats = false
			save = data
		}

        saving = 30
		
		if stats {
	        save_set_value("data", "tot_time", tot_time)
	        save_set_value("etc", "protowep", protowep)
			
	        for (var _race_id = Race.Fish; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
	            save_set_value("ctotkill", string(_race_id), ctot_kill[_race_id])
	            save_set_value("ctotdead", string(_race_id), ctot_dead[_race_id])
	            save_set_value("ctotloop", string(_race_id), ctot_loop[_race_id])
	            save_set_value("ctottime", string(_race_id), ctot_time[_race_id])
	            save_set_value("ctotwins", string(_race_id), ctot_wins[_race_id])
	            save_set_value("ctotuniq", string(_race_id), ctot_uniq[_race_id])
	            save_set_value("ctotruns", string(_race_id), ctot_runs[_race_id])
	            save_set_value("ctotwins", string(_race_id), ctot_wins[_race_id])
	            save_set_value("ctotdays", string(_race_id), ctot_days[_race_id])
	            save_set_value("ctothard", string(_race_id), ctot_hard[_race_id])
	            save_set_value("ctotstrk", string(_race_id), ctot_strk[_race_id])
	            save_set_value("cbstkill", string(_race_id), cbst_kill[_race_id])
	            save_set_value("cbstdiff", string(_race_id), cbst_diff[_race_id])
	            save_set_value("cbstloop", string(_race_id), cbst_loop[_race_id])
	            save_set_value("cbsttime", string(_race_id), cbst_time[_race_id])
	            save_set_value("cbstarea", string(_race_id), cbst_area[_race_id])
	            save_set_value("cbstsuba", string(_race_id), cbst_suba[_race_id])
	            save_set_value("cbstrace", string(_race_id), cbst_race[_race_id])
	            save_set_value("cbststrk", string(_race_id), cbst_strk[_race_id])
	            save_set_value("cbstfast", string(_race_id), cbst_fast[_race_id])
	            save_set_value("hbstkill", string(_race_id), hbst_kill[_race_id])
	            save_set_value("hbstarea", string(_race_id), hbst_area[_race_id])
	            save_set_value("hbstsuba", string(_race_id), hbst_suba[_race_id])
	            save_set_value("hbstloop", string(_race_id), hbst_loop[_race_id])
	            save_set_value("hbstrace", string(_race_id), hbst_race[_race_id])
	            save_set_value("dbstkill", string(_race_id), dbst_kill[_race_id])
	            save_set_value("dbstarea", string(_race_id), dbst_area[_race_id])
	            save_set_value("dbstsuba", string(_race_id), dbst_suba[_race_id])
	            save_set_value("dbstloop", string(_race_id), dbst_loop[_race_id])
	            save_set_value("dbstrace", string(_race_id), dbst_race[_race_id])
	            save_set_value("cwep",  string(_race_id), cwep[_race_id])
	            save_set_value("cgot",  string(_race_id), cgot[_race_id])
	            save_set_value("cskin", string(_race_id), cskin[_race_id])
				
				var _skin_max = scrRaceGetMaxSkinCount(_race_id)
				for(var _skin_id = 0; _skin_id < _skin_max; ++_skin_id) {
					save_set_value("cskingot" + string(_race_id), _skin_id, cskingot[_race_id, _skin_id])
				}
				
				var _crown_max = crownmax + 1
	            for(var _crown_id = 1; _crown_id < crownmax; _crown_id++) {
	                save_set_value("crowngot" + string(_race_id), string(_crown_id), crowngot[_race_id, _crown_id])
	            }
	        }
			
	        var f = file_text_open_write("temp")
	        file_text_write_string(f, string(save_get_value("etc", "seed", - 1)))
	        file_text_close(f)
		}
		
		var json = json_encode(save)
		
		file_write(savepath, json)
		file_write("NuclearThrone.sav", json)
    }
}