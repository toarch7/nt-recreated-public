if lockstep_stop
	exit

if endgame > 30 {
    snd_play(sndPortalClose)
    endgame = 30
}