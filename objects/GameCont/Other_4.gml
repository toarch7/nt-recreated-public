scrRngStatesReset()

novans = false
	
if (area == Area.Palace && subarea == 3) || (area == Area.HQ && subarea == 3)
|| loops == 0 || area == Area.Vault || area == Area.Campfire || area == Area.YVCrib {
	novans = true
}

if area == Area.Vault crownvisits ++
if area == Area.Jungle junglevisits ++

underwater = (area == Area.Oasis)