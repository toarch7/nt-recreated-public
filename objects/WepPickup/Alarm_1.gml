if !(instance_exists(creator) && visible) exit

with creator {
    if (wep && bwep) break
	
    if !wep {
        wep = other.wep
        reload = 0
    }
	else {
        bwep = other.wep
        breload = 0
    }

    repeat (4) instance_create(other.x + orandom(6), other.y + orandom(6), Dust)
    
    repeat (2) scrSwapWeps()
    
	swapanim = 2
	
	with instance_create(x, y, AnimParticle) {
		sprite_index = sprChickenB
		creator = other.id
	}

    instance_destroy(other.id, true)
}

snd_play(sndChickenReturn)