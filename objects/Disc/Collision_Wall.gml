if lockstep_stop
	exit

move_bounce_solid(true)

if dist > 50 {
	snd_play(sndDiscDie)
    instance_create(x, y, DiscDisappear)
    instance_destroy()
	exit
}

snd_play(sndDiscBounce)

with instance_create(x, y, DiscBounce) {
	image_angle = other.image_angle
	depth = other.depth - 1
}