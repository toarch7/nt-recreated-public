function scrSave() {
    with UberCont {
        if opt_console exit

        saving = 30

        //show_debug_message(json_encode(saveData))

        save_set_val("cgot", "0", 1)
        save_set_val("cgot", "1", 1)
        save_set_val("cgot", "2", 1)

        save_set_val("data", "tot_time", tot_time)

        save_set_val("etc", "protowep", protowep)

        for (var i = 1; i <= 15; i++) {
            save_set_val("ctotkill", string(i), ctot_kill[i])
            save_set_val("ctotdead", string(i), ctot_dead[i])
            save_set_val("ctotloop", string(i), ctot_loop[i])
            save_set_val("ctottime", string(i), ctot_time[i])
            save_set_val("ctotwins", string(i), ctot_wins[i])
            save_set_val("ctotuniq", string(i), ctot_uniq[i])
            save_set_val("ctotruns", string(i), ctot_runs[i])
            save_set_val("ctotwins", string(i), ctot_wins[i])
            save_set_val("ctotdays", string(i), ctot_days[i])
            save_set_val("ctothard", string(i), ctot_hard[i])
            save_set_val("ctotstrk", string(i), ctot_strk[i])
            save_set_val("cbstkill", string(i), cbst_kill[i])
            save_set_val("cbstdiff", string(i), cbst_diff[i])
            save_set_val("cbstloop", string(i), cbst_loop[i])
            save_set_val("cbsttime", string(i), cbst_time[i])
            save_set_val("cbstarea", string(i), cbst_area[i])
            save_set_val("cbstsuba", string(i), cbst_suba[i])
            save_set_val("cbstrace", string(i), cbst_race[i])
            save_set_val("cbststrk", string(i), cbst_strk[i])
            save_set_val("cbstfast", string(i), cbst_fast[i])
            save_set_val("hbstkill", string(i), hbst_kill[i])
            save_set_val("hbstarea", string(i), hbst_area[i])
            save_set_val("hbstsuba", string(i), hbst_suba[i])
            save_set_val("hbstloop", string(i), hbst_loop[i])
            save_set_val("hbstrace", string(i), hbst_race[i])
            save_set_val("dbstkill", string(i), dbst_kill[i])
            save_set_val("dbstarea", string(i), dbst_area[i])
            save_set_val("dbstsuba", string(i), dbst_suba[i])
            save_set_val("dbstloop", string(i), dbst_loop[i])
            save_set_val("dbstrace", string(i), dbst_race[i])
            save_set_val("cskingot", string(i), cskingot[i])
            save_set_val("cwep", string(i), cwep[i])
            save_set_val("cgot", string(i), cgot[i])

            for (var c = 1; c <= crownmax; c++) {
                save_set_val("crowngot" + string(i), string(c), crowngot[i, c])
            }
        }

        var f = file_text_open_write("temp")
        file_text_write_string(f, string(save_get_val("etc", "seed", - 1)))
        file_text_close(f)

        // also write in data/data/ dir
        //var f = file_text_open_write("NuclearThrone.sav")
        //file_text_write_string(f, json_encode(saveData))
        //file_text_close(f)

        var f = file_text_open_write(game_directory + "NuclearThrone.sav")
        file_text_write_string(f, json_encode(saveData))
        file_text_close(f)
    }
}