function scrDrawCharStats() {
    if (UberCont.cgot[select] == 1) {
        unlock = race_prog[select]
        unlockmax = maxraceprogress

        statx = view_xview + 110
        staty = view_yview + 52
        line = 0
        draw_stat_header(UberCont.race_name[select])
        draw_stat("kills", string(UberCont.ctot_kill[select]))
        draw_stat("loops", string(UberCont.ctot_loop[select]))
        draw_stat("runs", string(UberCont.ctot_runs[select]))
        draw_stat("deaths", string(UberCont.ctot_dead[select]))
        draw_stat("wins", string(UberCont.ctot_wins[select]))
        draw_stat("time", baked_tottime[select])
        draw_stat("unlocks", (scrAddZero(round(((unlock / unlockmax) * 100)), 2) + "%"))
        if ((select == 1) && (UberCont.ctot_uniq[1] > 0)) draw_stat("ROLLS", string(UberCont.ctot_uniq[1]))
        else if ((select == 2) && (UberCont.ctot_uniq[2] > 0)) draw_stat("DEFLECTS", string(UberCont.ctot_uniq[2]))
        else if ((select == 3) && (UberCont.ctot_uniq[3] > 0)) draw_stat("TELEKINESIS", baked_telekinesis)
        else if ((select == 4) && (UberCont.ctot_uniq[4] > 0)) draw_stat("EXPLODED", string(UberCont.ctot_uniq[4]))
        else if ((select == 5) && (UberCont.ctot_uniq[5] > 0)) draw_stat("SNARE KILLS", string(UberCont.ctot_uniq[5]))
        else if ((select == 6) && (UberCont.ctot_uniq[6] > 0)) draw_stat("CUZ TIME", baked_cuztime)
        else if ((select == 7) && (UberCont.ctot_uniq[7] > 0)) draw_stat("FIRING", (string((((UberCont.ctot_uniq[7] / 30) / UberCont.ctot_time[7]) * 100)) + "%"))
        else if ((select == 8) && (UberCont.ctot_uniq[8] > 0)) draw_stat("EATEN", string(UberCont.ctot_uniq[8]))
        else if ((select == 9) && (UberCont.ctot_uniq[9] > 0)) draw_stat("HEADLESS", baked_chicken)
        else if ((select == 10) && (UberCont.ctot_uniq[10] > 0)) draw_stat("MOST ALLIES", string(UberCont.ctot_uniq[10]))
        else if ((select == 11) && (UberCont.ctot_uniq[11] > 0)) draw_stat("BEAM TIME", baked_horror)
        else if ((select == 12) && (UberCont.ctot_uniq[12] > 0)) draw_stat("IDPD KILLS", string(UberCont.ctot_uniq[12]))
        else if ((select == 13) && (UberCont.ctot_uniq[13] > 0)) draw_stat("DAMAGED", string(UberCont.ctot_uniq[13]))
        else if ((select == 14) && (UberCont.ctot_uniq[14] > 0)) draw_stat("LUCK STREAK", string(UberCont.ctot_uniq[14]))
        else if ((select == 15) && (UberCont.ctot_uniq[15] > 0)) draw_stat("GAS VOLUMES", string(UberCont.ctot_uniq[15] / 3) + "M³")
        if (UberCont.ctot_runs[select] > 0) {
            draw_stat_header("")
            draw_stat_header("BEST RUN")
            draw_stat("area", area_get_name(UberCont.cbst_area[select], UberCont.cbst_suba[select], UberCont.cbst_loop[select]))
            draw_stat("kills", string(UberCont.cbst_kill[select]))
            statx = ((view_xview + view_width) - 70)
            staty = (view_yview + 52)
            line = 0
            if (UberCont.ctot_wins[select] > 0) {
                draw_stat("FASTEST", baked_fastest[select])
                draw_stat_header("")
            }
            if (UberCont.cbst_strk[select] > 0) {
                draw_stat_header("STREAKS")
                draw_stat("current", string(UberCont.ctot_strk[select]))
                draw_stat("best", string(UberCont.cbst_strk[select]))
                draw_stat_header("")
            }
        }
        if (UberCont.ctot_days[select] > 0) {
            draw_stat_header("DAILY")
            draw_stat("area", area_get_name(UberCont.dbst_area[select], UberCont.dbst_suba[select], UberCont.dbst_loop[select]))
            draw_stat("kills", string(UberCont.dbst_kill[select]))
            draw_stat("runs", string(UberCont.ctot_days[select]))
            draw_stat_header("")
        }
        if ((UberCont.hardgot == 1) && (UberCont.ctot_hard[select] > 0)) {
            draw_stat_header("HARD")
            draw_stat("area", area_get_name(UberCont.hbst_area[select], UberCont.hbst_suba[select], UberCont.hbst_loop[select]))
            draw_stat("kills", string(UberCont.hbst_kill[select]))
            draw_stat("runs", string(UberCont.ctot_hard[select]))
            draw_stat_header("")
        }
    }
}