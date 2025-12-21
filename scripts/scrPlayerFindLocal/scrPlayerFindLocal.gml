function scrPlayerFindLocal() {
	if (instance_number(Player) == 1) with (Player) return id
	
	with (Player) {
		if scr_player_is_local(index) return id
	}
	
	return noone
}