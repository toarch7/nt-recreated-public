if lockstep_stop
	exit

if instance_exists(DragonBurst) timeout = 0
else {
    timeout += 1
    if timeout > 1 {
        snd_stop(sndDragonLoop)
        snd_play(sndDragonStop)
        instance_destroy()
    }
}