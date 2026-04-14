if (!instance_is(other, enemy) && !instance_is(other, prop)) {
	if (scr_projectile_generic_flame_hit()) exit
	
	if sprite_index != sprFireLilHunter {
	    x = xprevious
	    y = yprevious
	}
}