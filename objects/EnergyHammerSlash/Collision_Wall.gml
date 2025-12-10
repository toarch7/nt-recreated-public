if lockstep_stop
	exit

x -= hspeed
y -= vspeed

if !walled {
    snd_play(sndMeleeWall)
    walled = true
}

sleep(5)

with other {
    instance_destroy()
    instance_create(x, y, FloorExplo)
}