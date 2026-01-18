function scrFrogGasStat() {
	var _n = 0;
	switch (floor(image_index)) {
		case 0: _n = 0.8 break
		case 1: _n = 0.5 break
		case 2: _n = 0.85 break
		case 3: _n = 0.4 break
		case 4: _n = 0.825 break
	}
	UberCont.ctot_uniq[Race.Frog] += _n
}