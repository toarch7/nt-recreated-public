if instance_exists(TutCont) {
	game_restart()
	exit
}

with WepPickup {
	if (!visible | persistent) continue
	
    if wep == Wep.ChickenSword && GameCont.area == Area.Desert && GameCont.subarea == 1 {
        GameCont.give_blacksword ++
	}
}

snd_stop(sndPortalLoop)

GameCont.is_level_ended = true

instance_activate_all()

room_restart()