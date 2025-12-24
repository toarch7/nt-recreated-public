if lockstep_stop
	exit

grow += 0.0002

if (sprite_index == sprSpiralProto) {
    grow += 0.0003
}

image_xscale += grow
image_yscale += grow
grow = (grow + 1) * (1 + (0.0005 * image_xscale)) - 1

var _m;

if (!instance_exists(SpiralCont)) {
	grow *= 1.5
	_m = 3
}
else {
	_m = 2.5
}

if (image_xscale > _m && (lanim < 0 || lanim > 6)) {
    instance_destroy()
}

lanim += 0.2 + random(0.3)
