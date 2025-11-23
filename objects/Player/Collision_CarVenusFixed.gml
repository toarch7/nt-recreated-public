if lockstep_stop
	exit

if KeyCont.press_pick[index] && is_me {
    with instance_create(x, y, Portal) type = 1
	
    with enemy hp = 0
	
	with GameCont {
	    if area == Area.YVCrib || instance_exists(YungCuz) {
	        area = lastarea
	        subarea = lastsubarea - 1
	    }
		else {
	        area = Area.VenusMansion
	        subarea = 0
	    }
	}
	
	snd_play(sndUseCar)
    snd_stop(sndCarLoop)
	
    instance_destroy(other.id, false)
}