function scrAreaCanHavePopo() {
	with GameCont {
		if area == area_vault || area == area_crib || (area == area_hq && subarea == 3) || (area == 7 && subarea == 3)
			return false
	}
	
	return true
}