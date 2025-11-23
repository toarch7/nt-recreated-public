function scrAreaCanHavePopo() {
	with GameCont {
		if area == Area.Vault || area == Area.YVCrib || (area == Area.HQ && subarea == 3) || (area == 7 && subarea == 3)
			return false
	}
	
	return true
}