if lockstep_stop
	exit

if (!walled) {
    snd_play(sndMeleeWall)
    walled = true
}

sleep(5)

scrWallDestroy(other.id)