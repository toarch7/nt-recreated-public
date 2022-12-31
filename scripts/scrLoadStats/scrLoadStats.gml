function scrLoadStats() {
    //INITIALIZE STUFF BEEP BOOP
    scrRaces()
    dir = 1
    repeat(racemax) {
        //WRITE THAT SHIT
        /*scrLineLoad("ctot_kill["+string(dir)+"]")
	scrLineLoad("ctot_time["+string(dir)+"]")
	scrLineLoad("ctot_dead["+string(dir)+"]")
	scrLineLoad("ctot_loop["+string(dir)+"]")
	scrLineLoad("cbst_kill["+string(dir)+"]")
	scrLineLoad("cbst_time["+string(dir)+"]")
	scrLineLoad("cbst_diff["+string(dir)+"]")
	scrLineLoad("cbst_loop["+string(dir)+"]")*/

        ctot_kill[dir] = 1
        ctot_time[dir] = 1
        ctot_dead[dir] = 1
        cbst_loop[dir] = 1
        cbst_kill[dir] = 1
        cbst_time[dir] = 1
        cbst_diff[dir] = 1

        dir += 1
    }

    tot_time = 0



}