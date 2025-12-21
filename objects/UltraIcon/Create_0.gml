scrUltras()
p = 0
selected = 0
race = Race.CoopUltra

for(var i = 0; i < player_count; ++i) {
	var _pinst = scr_playerinstance_find(i)
	
	if (is_struct(_pinst) && _pinst.get_race()) {
		race = _pinst.get_race()
		
		if (race == Race.Skeleton && _pinst.is_local()) {
			scrRaceUnlock(Race.Skeleton)
		}
		
		break
	}
}

scr_network_instance()