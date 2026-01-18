if lockstep_stop
	exit

if (!num || UberCont.ctot_time[num] > 0) {
	with (StatChar) selected = (id == other.id)
    with (DrawStats) select = other.num
    snd_play(sndClick)
}
else {
	snd_play(sndNoSelect)
}