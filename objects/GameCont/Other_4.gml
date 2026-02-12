novans = false

if (area == area_palace && subarea == maxsubarea) || (area == area_hq && subarea == maxsubarea)
|| loops == 0 || area == area_vault || area == area_campfire || area == area_crib {
	novans = true
}

if area == area_vault crownvisits ++
if area == area_jungle junglevisits ++

underwater = (area == area_oasis)

is_level_ended = false

scrAmmoUpdateTypeStats()