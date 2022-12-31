function scrSaveStats() {
    //IDENTIFY STATS

    //INITIALIZE STUFF BEEP BOOP
    scrRaces() var dir;
    dir = 1
    repeat(racemax) {
        //WRITE THAT SHIT
        save_set_val("ctotkill", string(dir), 0)
        save_set_val("ctotdead", string(dir), 0)
        save_set_val("ctotloop", string(dir), 0)
        save_set_val("ctottime", string(dir), 0)
        save_set_val("cbstkill", string(dir), 0)
        save_set_val("cbstdiff", string(dir), 0)
        save_set_val("cbstloop", string(dir), 0)
        save_set_val("cbsttime", string(dir), 0)
        dir += 1
    }



}