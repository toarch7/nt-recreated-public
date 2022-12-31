function scrKeyContInit() {
    //0 = nothing 1 = pressed 2 = hold = 3 = release //SO ON HOLD is both 1 and 2 AND NOT HELD IS BOTH 3 and 0

    p = 0
    repeat(players) {
        key_nort[p] = 0 //up
        key_sout[p] = 0 //down
        key_east[p] = 0 //right
        key_west[p] = 0 //left

        key_fire[p] = 0 //fire
        key_spec[p] = 0 //special
        key_pick[p] = 0 //pick stuff up
        key_swap[p] = 0 //swap wep

        //key_back[p] = 0//back from pause, temp gamepad stuff
        //key_paus[p] = 0//pause

        p += 1
    }



}