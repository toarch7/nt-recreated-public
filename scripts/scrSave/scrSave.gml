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
				"cheats_console", "cheats_griller", "options_gamepad", "options_keyboard",
				"etc_nickname", "visual_resolution", "visual_fullscreen"
			]
			
			for(var i = 0; i < array_length(cpref_list); i ++)
				array_push(options, "cprefs_" + cpref_list[i])
			
			for(var i = 0; i < array_length(options); i ++) {
				var opt = options[i]
				
				data[? opt] = saveData[? opt]
			}
			
			stats = false
			save = data
		}

        saving = 30
		
		if stats {
	        save_set_value("cgot", "0", 1)
	        save_set_value("cgot", "1", 1)
	        save_set_value("cgot", "2", 1)
			
	        save_set_value("data", "tot_time", tot_time)
			
	        save_set_value("etc", "protowep", protowep)
			
	        for (var i = 1; i <= 15; i++) {
	            save_set_value("ctotkill", string(i), ctot_kill[i])
	            save_set_value("ctotdead", string(i), ctot_dead[i])
	            save_set_value("ctotloop", string(i), ctot_loop[i])
	            save_set_value("ctottime", string(i), ctot_time[i])
	            save_set_value("ctotwins", string(i), ctot_wins[i])
	            save_set_value("ctotuniq", string(i), ctot_uniq[i])
	            save_set_value("ctotruns", string(i), ctot_runs[i])
	            save_set_value("ctotwins", string(i), ctot_wins[i])
	            save_set_value("ctotdays", string(i), ctot_days[i])
	            save_set_value("ctothard", string(i), ctot_hard[i])
	            save_set_value("ctotstrk", string(i), ctot_strk[i])
	            save_set_value("cbstkill", string(i), cbst_kill[i])
	            save_set_value("cbstdiff", string(i), cbst_diff[i])
	            save_set_value("cbstloop", string(i), cbst_loop[i])
	            save_set_value("cbsttime", string(i), cbst_time[i])
	            save_set_value("cbstarea", string(i), cbst_area[i])
	            save_set_value("cbstsuba", string(i), cbst_suba[i])
	            save_set_value("cbstrace", string(i), cbst_race[i])
	            save_set_value("cbststrk", string(i), cbst_strk[i])
	            save_set_value("cbstfast", string(i), cbst_fast[i])
	            save_set_value("hbstkill", string(i), hbst_kill[i])
	            save_set_value("hbstarea", string(i), hbst_area[i])
	            save_set_value("hbstsuba", string(i), hbst_suba[i])
	            save_set_value("hbstloop", string(i), hbst_loop[i])
	            save_set_value("hbstrace", string(i), hbst_race[i])
	            save_set_value("dbstkill", string(i), dbst_kill[i])
	            save_set_value("dbstarea", string(i), dbst_area[i])
	            save_set_value("dbstsuba", string(i), dbst_suba[i])
	            save_set_value("dbstloop", string(i), dbst_loop[i])
	            save_set_value("dbstrace", string(i), dbst_race[i])
	            save_set_value("cskingot", string(i), cskingot[i])
	            save_set_value("cwep", string(i), cwep[i])
	            save_set_value("cgot", string(i), cgot[i])
				
	            for (var c = 1; c <= crownmax; c++) {
	                save_set_value("crowngot" + string(i), string(c), crowngot[i, c])
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