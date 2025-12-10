if scr_skill_get(mut_laser_brain) {
    snd_play_hit(sndPlasmaBigExplodeUpg, 0.2)
}
else snd_play_hit(sndPlasmaBigExplode, 0.2)

var _ang = random_angle

repeat 10 {
    with scr_projectile_create(xprevious, yprevious, PlasmaBall, _ang, 2) {
        image_angle = direction
    }
	
    _ang += 360 / 10
}

instance_create(x, y, PortalClear)