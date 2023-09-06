if lockstep_stop
	exit

if UberCont.cgot[num] {
    snd_play(sndClick)
	
    with StatChar {
        selected = (id == other.id)
    }
	
    DrawStats.select = num
}

if !UberCont.cgot[num] {
	with Menu {
	    hint = "locked#" + race_lock[other.num]
	    alarm[11] = 90
	}
}