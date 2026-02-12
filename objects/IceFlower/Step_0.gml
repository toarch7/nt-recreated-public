if lockstep_stop
	exit

if (feed >= 4) {
    with (GameCont) {
		area = area_jungle
	    subarea = 0
	}
	
    with (enemy) hp = 0
    
    instance_create(x, y, Portal)
	
    with Player {
        if scr_skill_get(mut_last_wish) {
            scr_skill_set(mut_last_wish, false)
            GameCont.skillpoints ++
        }
    }

    instance_destroy()
}

depth = 0