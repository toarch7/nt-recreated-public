if lockstep_stop
	exit

if scr_race_is_unlocked(num) {
    snd_play(sndClick)
	
    with StatChar {
        selected = (id == other.id)
    }
	
    DrawStats.select = num
}
else {
	snd_play(sndNoSelect)
}