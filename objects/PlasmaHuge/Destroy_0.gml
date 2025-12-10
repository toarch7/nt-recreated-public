if scr_skill_get(17) {
    snd_play_hit_big(sndPlasmaBigExplodeUpg, 0.2)
} else snd_play_hit_big(sndPlasmaBigExplode, 0.2)

var _ang = random_angle

repeat 4 {
    with scr_projectile_create(xprevious, yprevious, PlasmaBig, _ang) {
        image_angle = direction
    }
	
    _ang += 360 / 4
}

with instance_create(x, y, PortalClear) {
	image_xscale *= 1.5
	image_yscale *= 1.5
}
