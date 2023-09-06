if lockstep_stop
	exit

image_yscale = image_xscale
if image_xscale <= 0.7 instance_destroy()


if !irandom(1) {
    with instance_create(x + orandom(8), y + orandom(8), PlasmaTrail) {
        sprite_index = sprPopoPlasmaTrail
    }
}