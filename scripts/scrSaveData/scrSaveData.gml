function scrSaveData() {
    //IDENTIFY STATS
    file_text_write_string(txt, "DATA")
    file_text_writeln(txt)

    //INITIALIZE STUFF BEEP BOOP
    scrRaces() var dir;
    dir = 1
    repeat(racemax) {
        //WRITE THAT SHIT
        scrLineSave(cwep[dir])
        scrLineSave(cgot[dir])
        dir += 1
    }

    //misc
    scrLineSave(protowep)



}