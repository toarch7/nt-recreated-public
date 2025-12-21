if lockstep_stop
	exit

if KeyCont.press_pick[index] && is_me && other.can_hq && other.drawspr = sprVanDeactivate {
    if GameCont.triedhq {
        with (other) hp = 0
		exit
	}
	
	snd_play(sndUseVan)
	
	with GameCont {
		if area == area_hq {
			hqarea = hqarea
			hqsubarea = hqsubarea
		}
		else {
			area = area_hq
			subarea = 0
		}
		triedhq = true
	}
	
	with (enemy) hp = 0
	instance_destroy(other)
	
	nexthurt = current_frame + 5
	
	with instance_create(x, y, Portal) type = 2
	
	mask_index = mskNone
}