ammo -= 1

alarm[0] = time
image_xscale /= 2
image_yscale /= 2

if instance_exists(creator) {
    x = creator.x + lengthdir_x(16, creator.gunangle)
    y = creator.y + lengthdir_y(16, creator.gunangle)
	
	snd_play(scr_skill_get(mut_laser_brain) ? sndLaserCannonUpg : sndLaserCannon)
	
    with scr_projectile_create(x, y, Laser, creator.gunangle) {
        event_perform(ev_alarm, 0)
    }
	
	with (creator) scr_weapon_post(gunangle, 3, 2, 5)
}

if (ammo <= 0) instance_destroy()