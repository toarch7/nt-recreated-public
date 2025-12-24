if lockstep_stop
	exit

x = xstart + lengthdir_x(dist * image_xscale, angle)
y = ystart + lengthdir_y(dist * image_yscale, angle)
angle += turnspeed

dist += grow

grow += 0.0005
image_xscale += grow / 1.5
image_yscale += grow / 1.5
grow = (grow + 1) * (1 + 0.001 * image_xscale) - 1

if !instance_exists(SpiralCont) {
	grow *= 1.5
}
else {
    if (SpiralCont.type == SpiralType.Proto) {
		grow *= image_xscale * 0.1 + 1
	}
}

grow *= image_xscale * 0.05 + 1

if ((x < view_xview - 16 || x > (view_xview + view_width + 16))
	|| (y < view_yview - 16 || y > (view_yview + view_height + 16))
) {
	instance_destroy()
}

if (!sound && image_xscale > 1.3) {
	var _snd = choose(sndPortalFlyby1, sndPortalFlyby2, sndPortalFlyby3, sndPortalFlyby4)
    snd_play_pitchvol(_snd, 0.1, UberCont.opt_ambvol)
    sound = true
}

image_angle += rotspeed