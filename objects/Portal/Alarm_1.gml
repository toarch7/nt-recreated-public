if instance_exists(TutCont) {
	game_restart()
	exit
}

with (WepPickup) {
	if (!visible || persistent) continue
	
    if (wep == wep_chicken_sword && GameCont.area == area_desert && GameCont.subarea == 1) {
        GameCont.blackswords ++
	}
}

snd_stop(sndPortalLoop)

GameCont.is_level_ended = true

instance_activate_all()

room_restart()