function scrOnPopoKill() {
	with Player {
		if (race == Race.Rogue && scr_player_is_local(index)) {
			UberCont.ctot_uniq[race] ++
		}
	}
	
	with (Grunt) freeze += 100
	with (Inspector) freeze += 100
	with (Shielder) freeze += 100
	with (EliteGrunt) freeze += 100
	with (EliteInspector) freeze += 100
	with (EliteShielder) freeze += 100
	with (WantVan) canspawn = true
}