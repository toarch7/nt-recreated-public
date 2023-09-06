if lockstep_stop
	exit

if instance_exists(GenCont) && instance_exists(LevCont) && instance_exists(SpiralCont) {
    if ambfilter > 0.2
		ambfilter -= 0.1
}
else if ambfilter < 1
	ambfilter += 0.1

audio_master_gain(UberCont.opt_volume)

audio_sound_gain(song, UberCont.opt_musvol, 0)
audio_sound_gain(amb, UberCont.opt_ambvol * ambfilter, 0)