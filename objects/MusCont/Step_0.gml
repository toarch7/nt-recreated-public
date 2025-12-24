if lockstep_stop
	exit

if (instance_exists(SpiralCont) || scrGameIsPaused()) {
    if (ambfilter > 0.2) ambfilter -= 0.1
}
else {
	if (ambfilter < 1) ambfilter += 0.1
}

audio_master_gain(UberCont.opt_volume)

if (audio_exists(song)) audio_sound_gain(song, UberCont.opt_musvol, 0)
if (audio_exists(amb)) audio_sound_gain(amb, UberCont.opt_ambvol * ambfilter, 0)