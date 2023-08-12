if instance_exists(TutCont) {
	game_restart(); exit
}

with WepPickup {
    if wep == 46 && GameCont.area == 1 && GameCont.subarea == 1
        GameCont.blacksword = 1
}

snd_stop(sndPortalLoop)

GameCont.level_end = 1
instance_activate_all()

room_restart()