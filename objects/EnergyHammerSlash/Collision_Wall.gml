if lockstep_stop
	exit

x -= hspeed
y -= vspeed

if walled = 0 {
    walled = 1
    snd_play(sndMeleeWall)
}
sleep(5)
with other {
    instance_destroy()
    instance_create(x, y, FloorExplo)
}