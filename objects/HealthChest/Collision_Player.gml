if lockstep_stop
	exit

if !instance_exists(GenCont) {
	if scrChestOpened() exit
	
	var p = instance_nearest(x, y, Player)

	with other {
	    if headloses > 0 {
	        headloses --
	        max_hp ++
	    }
	}
	
	instance_create(x, y, FXChestOpen)
	
	snd_play(scr_skill_get(mut_second_stomach) ? sndHealthChestBig : sndHealthChest)
	
	with (p) instance_create(x, y, HealFX)
	scrPlayerHeal(p, num, true)
	
	instance_destroy()
}

