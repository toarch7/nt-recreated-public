function scrLoadData() {
    //INITIALIZE STUFF BEEP BOOP
    scrRaces() var dir;
    dir = 1
    repeat(racemax) {
        //WRITE THAT SHIT
        scrLineLoad("cwep[" + string(dir) + "]")
        scrLineLoad("cgot[" + string(dir) + "]")
        dir += 1
    }

    //misc
    scrLineLoad("protowep")



}