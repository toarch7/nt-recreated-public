function scrSaveStats() {
    //IDENTIFY STATS

    //INITIALIZE STUFF BEEP BOOP
    scrRaces() var dir;
    dir = 1
    repeat(racemax) {
        //WRITE THAT SHIT
        save_set_value("ctotkill", string(dir), 0)
        save_set_value("ctotdead", string(dir), 0)
        save_set_value("ctotloop", string(dir), 0)
        save_set_value("ctottime", string(dir), 0)
        save_set_value("cbstkill", string(dir), 0)
        save_set_value("cbstdiff", string(dir), 0)
        save_set_value("cbstloop", string(dir), 0)
        save_set_value("cbsttime", string(dir), 0)
        dir += 1
    }



}