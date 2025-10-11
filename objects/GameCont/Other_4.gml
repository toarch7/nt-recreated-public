scrRngStatesReset()

novans = false
	
if (area == area_palace && subarea == 3) || (area == area_hq && subarea == 3)
|| loops == 0 || area == area_vault || area == area_campfire || area == area_crib {
	novans = true
}

if area == area_vault crownvisits ++
if area == area_jungle junglevisits ++

underwater = (area == area_oasis)