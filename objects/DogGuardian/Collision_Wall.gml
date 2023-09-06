if lockstep_stop
	exit

move_bounce_solid(1)
bounced = 1

if leap {
    snd_play_hit_big(sndDogGuardianBounce, 0.2)
}